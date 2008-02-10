From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternative approach to the git config NULL value checking patches..
Date: Sun, 10 Feb 2008 14:29:01 -0800
Message-ID: <7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org>
	<7vir0wfqrz.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKgY-0002Ku-DM
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYBJW3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbYBJW3b
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:29:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbYBJW3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:29:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 217812829;
	Sun, 10 Feb 2008 17:29:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 26D962827;
	Sun, 10 Feb 2008 17:29:19 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 10 Feb 2008 14:08:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73427>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 10 Feb 2008, Junio C Hamano wrote:
> ...
>> will now need to be changed to:
>> 
>> 	if (value == config_true)
>>         	Ah we have true;
>> 	else if (!*value)
>>         	Ok this is false;
>
> And that was done by my patch. 
>
>> still need to be fixed to:
>> 
>> 	if (value == config_true)
>>         	die("oops '%s' is not a bool", var);
>> 	else if (!strcmp(value, "somevalue")
>> 		Ok let's use somevalue;
>
> And this is different from checking against NULL exactly how?

Exactly.  My answer to your question is: "It is not different
from checking against NULL at all."

The first one (i.e. you needed to do so in your patch) shows
that the codepath that is already doing the right thing needs to
be modified.  If we do not introduce config_true, we do not even
have to.  You need additional change to correctly functioning
codepaths that you should not have to do.

The second one shows that even if we introduce config_true, such
an already broken codepath needs to be fixed to check with
either NULL or config_true anyway.  The need for fix the
codepath has not been reduced.  Changing the rule does not help
for this class of codepath.

But as you seem to imply, it might make sense to equate

	[some-random-section]
        	some-random-variable

to

	[some-random-section]
        	some-random-variable = ""

for variables that cannot possibly have any meaningful "bool"
semantics.  This third class of variables is a possible benefit
your patch brings in.  The code can be lax for these variables.

However, it would make things inconsistent ("this variable is
bool and the above two forms mean completely opposite things,
while that variable is not bool and they mean the same thing").
I am just having a hard time convincing myself that this little
detail does not matter.
