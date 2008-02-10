From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Sun, 10 Feb 2008 13:25:04 -0800
Message-ID: <7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJgs-0000xN-4R
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 22:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbYBJVZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 16:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755405AbYBJVZp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 16:25:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbYBJVZo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 16:25:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D1BC614BF;
	Sun, 10 Feb 2008 16:25:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 957C714A5;
	Sun, 10 Feb 2008 16:25:26 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 10 Feb 2008 12:32:39 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73418>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It may be a bit odd, but it automatically means that codepaths that simply 
> don't want to care about the subtle difference between "true" and "empty" 
> will just automatically work, because to them the two cases will look 
> identical, because the strings will compare the same - they have the same 
> data, just different addresses.

I should have mentioned the reason why I did not suggest doing
it this way in my [Janitor] message.

It is not "suttle difference between true and empty".  Empty
means false, and with this approach, it switches the meaning of
valueless form of config to quite the opposite.

In addition to fixing existing breakages, a piece of code that
knew NULL is true and empty is false and coded accordingly, i.e.

	if (!value)
        	Ah we have true;
	else if (!*value)
        	Ok this is false;
	else if (!strcmp(value, "something special")
        	Ok, this is not bool but special;
	else
        	return git_config_bool(var, value);

will now need to be changed to:

	if (value == config_true)
        	Ah we have true;
	else if (!*value)
        	Ok this is false;
	else if (!strcmp(value, "something special")
        	Ok, this is not bool but special;
	else
        	return git_config_bool(var, value);

if you do this.  And the code that was already broken:

	if (!strcmp(value, "somevalue")
		Ok let's use somevalue;
	else if (!strcmp(value, "someothervalue")
		Ok let's use someothervalue;
	else
        	die("oops we do not understand '%s'", value);

still need to be fixed to:

	if (value == config_true)
        	die("oops '%s' is not a bool", var);
	else if (!strcmp(value, "somevalue")
		Ok let's use somevalue;
	else if (!strcmp(value, "someothervalue")
		Ok let's use someothervalue;
	else
        	die("oops we do not understand '%s'", value);

So it does not buy us anything.  That is why I did not suggest
doing it that way.

> This also means that code (notably the value regexp parsing) that does 
> something like
>
> 	value ? value : ""
>
> just automatically can go away, and just use 'value' directly.

Yes, but that's broken already, isn't it?
