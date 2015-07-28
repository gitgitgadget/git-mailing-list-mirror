From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 19:48:23 +0200
Message-ID: <vpq3808p40o.fsf@anie.imag.fr>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
	<xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK8zT-00049H-Ao
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 19:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbbG1Rsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 13:48:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51539 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751874AbbG1Rsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 13:48:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SHmLhA024621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 19:48:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6SHmN8L003507;
	Tue, 28 Jul 2015 19:48:23 +0200
In-Reply-To: <xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 28 Jul 2015 09:30:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 Jul 2015 19:48:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6SHmLhA024621
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438710503.02785@LB0VC7w/cV3GyOqlAK+lvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274799>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Actually, is there any reason why we do not allow a simple escaping like
>>
>> \# this is a line starting with #
>> \\ this is a line starting with \
>> # this is a comment
>
> What are we trying to achieve?

What I would like would be a simple way to:

1) Allow any commit message to be typed. If I want to talk about #include
   in my commit message, I should have an easy way to do so.

2) Allow commands that pop an editor on an existing message to preserve
   the original message, whatever it is. Well, actually Git even strips
   # lines even if it doesn't pop the editor.

Currently, I can for example:

$ git commit -m "#include" -a
[detached HEAD 0f36ec9] #include
 1 file changed, 1 insertion(+), 1 deletion(-)
$ GIT_EDITOR=touch git commit --amend
Aborting commit due to empty commit message.

A simple escaping scheme like the above can solve both points:

1) If I want to talk about #include in my commit message, I can spell it
   \#include and Git would remove the \. The same way, if I want to tell
   my shell about a " inside a string, I can write "double-quote:\"."
   and get a litteral double-quote.

2) A command that pops an editor could add the escaping where needed,
   pop the editor, and then unescape. A command like "pick" in "rebase
   -i" could escape the message, and feed it to "git commit" which would
   unescape it.

> Munging the original "# I want this line intact" to any other form
> like " # I want this..." is as bad as losing it.

It would modify it only when shown in the text editor. The object
database would contain unescaped message, hence "git log" would show it
unescaped for example.

backslash-escaping special characters seems very natural to me, and I
guess it would be for most computer-scientists. If I have problem with a
special character, the first thing I would try would be to add a
backslash in front of it.

> If the user wants whatever she types in the resulting commit
> literally, there is the "--cleanup=<choice>" option, no?

$ GIT_EDITOR=touch git commit --cleanup=verbatim
[detached HEAD 1b136a7] # Please enter the commit message for your changes. Lines starting # with '#' will be kept; you may remove them yourself if you want 
to. # An empty message aborts the commit. # HEAD detached from 5e70007 # Changes to be committed: #     modified:   foo.txt # # Changes not staged for commit
: #     modified:   foo.txt # # Untracked files: #      last-synchro.txt #                                                                                  
 1 file changed, 1 insertion(+), 1 deletion(-)

You really don't want that in day-to-day use.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
