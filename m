From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Sun, 10 Feb 2008 16:40:46 -0800
Message-ID: <7vhcggcokx.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
	<7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org>
	<7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
	<alpine.LFD.1.00.0802101538030.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 01:41:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOMk8-0000Ai-Ha
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 01:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbYBKAlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 19:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754847AbYBKAlX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 19:41:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbYBKAlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 19:41:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9156A2A76;
	Sun, 10 Feb 2008 19:41:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 764DD2A3F;
	Sun, 10 Feb 2008 19:40:58 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802101538030.2920@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 10 Feb 2008 15:41:23 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73443>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And here's an example of this kind of effect. I'm not actually suggesting 
> you apply this patch, but tell me it isn't simpler done this way?

Yes, that is a good example of simplification.

> So this is where it *does* make a difference whether we use NULL or 
> config_bool, and where config_bool is simply better: it allows a config 
> routine to simply never care..

But that applies only to "originally bool but now has additional
states" kind of variables.

For a variable that is never about boolean, if the original code
said:

	if (!strcmp(var, "section.variable"))
        	foo = xstrdup(value);

it is wrong (would strdup NULL), and the correct fix would be:

	if (!strcmp(var, "section.variable")) {
		if (!value)
			die("missing value for '%s'", var);
        	foo = xstrdup(value);
	}

It does not make much of a difference if that "if (!value)"
becomes "if (value == config_true)".  If you omit that check, as
your "user.name" example shows, foo may get an empty string or a
string "true", neither of which is what the user intended to
say.
