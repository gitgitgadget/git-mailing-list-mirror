From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git status oddity
Date: Sat, 12 Apr 2008 14:16:43 -0700
Message-ID: <7vabjyhiys.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0804120843m2dd2ec3k69a3ba2809f1e955@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sat Apr 12 23:17:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkn6Q-0000wo-KZ
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 23:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbYDLVQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 17:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYDLVQy
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 17:16:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbYDLVQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 17:16:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C25E51F90;
	Sat, 12 Apr 2008 17:16:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 07C781F86; Sat, 12 Apr 2008 17:16:46 -0400 (EDT)
In-Reply-To: <bd6139dc0804120843m2dd2ec3k69a3ba2809f1e955@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat, 12 Apr 2008 17:43:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79383>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> ... when I change files in the same directory I commit all
> those in one go. As such I am a great fan of 'git diff .' and 'git
> commit .'

The command in such a work flow for "What has been changed here" is not
"git status", but is "git diff <diff args> HEAD .", if "git commit ." is
how you make your commits.  --name-status, --name-only or --stat may be
a good option to give in that command line.

As "git status" is a Porcelain just like "git commit" is, its output
format is not holy.  It is not meant to be parsed by scripts and we are
free to change its behaviour for human users typing at it and reading from
it, provided if the change is worth making.  However, for this particular
case, I doubt changing the existing "git status" that is a preview of the
next commit is necessary nor has much merit.

Not because I think your workflow is minority (I don't), but simply
because "git status" is not what you need in this case (you may think it
is what you "want", but notice that I said what you "need").

This is because "git status <paths>" these days is much less useful than
it was originally, after we made --only the default mode for "git commit".

It used to be that the default for "git commit" was --include.  If you say
"git commit foo" when you have some changes already staged, the commit
will include what has already been staged plus the latest contents you
have in "foo".  With such a system, "git status foo" _was_ a very useful
way to remind yourself what changes _other than_ you are naming from the
command line are going to be committed.  It still is the default when you
are recording a merge commit, as the typical use case is that most of the
paths have already been resolved, you fixed up the conflicted ones in your
work tree, and you say "git commit <these I fixed up>".  You do not want
to record a new commit that ignores what is staged in this case.

These days, --only is the default mode of operation.  "git commit foo"
commits _only_ the changes made to what you named from the command line,
disregarding what you have already staged in the index so far.  Because
you are already naming what you want to commit, the value in reminding
what others will also be committed, as there is none, has diminished
greatly, compared to the days when --include was the default.  It still
has value that reminds you what you meant by the dot in "git commit ."
(which is essentially what "git diff --name-only HEAD ." is).  It also
has value that reminds you what you may need/want to commit after making
this commit in this directory.  But it has less information than the old
days, because you already know "what will be committed" will not include
what you did not name from the command line (in your _particular_ use
case, "the current directory"), and "what could be committed" will only
consists of the rest (in your _particular_ use case, "outside the current
directory").

We could special case and make it not report anything that will be left in
the work tree that is different from the resulting commit when --only is
in effect, which is what you seem to "want".  But even that should not be
the default but be an option, as that mode is robbing from users (other
than yourself) the information "what other changes I may still need to
commit after this".  But if you are going to give that option and say
"git status --commit-only ." there is already existing tool to ask the
question you are asking in a more direct way.
