X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdl_merge(): fix and simplify conflict handling
Date: Tue, 05 Dec 2006 14:54:39 -0800
Message-ID: <7v3b7ueyxc.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
	<7vejri20mf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4575B32F.5060108@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
	<Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac22glzz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvekqf0yh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612052320320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 22:54:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612052320320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 5 Dec 2006 23:24:41 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33384>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrjBU-0002Fu-No for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937026AbWLEWym (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937030AbWLEWym
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:54:42 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60383 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937026AbWLEWyl (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 17:54:41 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205225440.EFPT97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 5 Dec
 2006 17:54:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vAuq1V00V1kojtg0000000; Tue, 05 Dec 2006
 17:54:50 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Speaking about a builtin merge: I like the fact that git-apply also works 
> outside of git repositories. It makes life easier to have a sane patcher 
> around.

Well, git-apply is designed as a better "patch", so it is
natural that it works in a non-git directory [*1*].

I am not sure what you mean by a builtin merge that works
outside the context of git.  Do you mean a pure RCS merge
replacement that takes three files and spits out the result in
one of them?  If so that would probably deserve to be a separate
command, because I do not think of a use for such a thing inside
git.  We've done merge-recursive.c already so it would not need
an external 'merge'.  If somebody is so inclined to to do the
"merge-resolve" strategy, I think the right way is to make a
single program that does what git-merge-index and merge-one-file
does without fork nor exec, so it would not need an external
'merge' either.

> Now, I'd like the same with git-diff, and an RCS merge replacement...

Yes, back when I was actively hacking git-diff, I dreamt about a
variant that takes two or more (non-git managed) directories and
does an equivalent of diff-tree with -M/-C/.../-c/--cc.  It
would be cool and useful.

I understand your aversion to new commands, but I do not think
you can avoid it if what you mean is an RCS merge replacement.

The diff that works on "two or more directories without anything
git" could be just a new option to "git diff", though.

But I am not going to do it myself; it's usually a lot faster
for me to just do "git init-db; git add . " on an extracted
tarball.

[Footnote]

*1* ... and that is one of the reasons why it does not even try
to read the index unless it is told to do so.

And we should not make it "detect we are in git repository" and
default to --index either.  Often running without --index is
useful inside a git repository.  I would say roughly 50% of the
time I use the command with --index and the rest without, so
"more often" argument unfortunately does not apply to "apply".

I wish it were "2% without --index, 98% with --index".  Then we
could easily say "add '--no-index if you do not want to".


