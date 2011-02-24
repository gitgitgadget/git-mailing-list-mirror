From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: git-svn dcommit losing/detaching head when commit message empty
Date: Thu, 24 Feb 2011 01:27:25 +0000
Message-ID: <AANLkTi=A-UG2aOcwwNbjoBK4pYDtKp=0nFmcwrgVv0f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 02:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsPzQ-0000EZ-50
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 02:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193Ab1BXB12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 20:27:28 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:55142 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab1BXB10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 20:27:26 -0500
Received: by gwb15 with SMTP id 15so33070gwb.10
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 17:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=i2aJHRqe5lEvbIEB6nrZ/JQjzKgjItk4SU8OseecPwY=;
        b=hJExE0WMepgeEHOGZXu9FnN3N/Evg5JUGEgdT8QEYTY+fuj2stSzfy5pqhLsgMPRGV
         Ob3vC1beBfwVmNCypRrZntX7FW36B3C8JINRT4PMLafUTA2fb3wM5qYRCFjRgWPb2xRw
         FfygE8yHthgIceN/JRKN2pAMX/VlbJp339n8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uTdWI/ErANdlyJYPg+S+22OSO3I753l1R5BTlYCzqTr8nJJB03zZXJH3iWiIdVnj+B
         PUYQX/afLQuaCvVNiMiK03HutIA17xw56INvOA7lwclQS3/jm2bK78io+ees34Uz/5iH
         OZFnEKEhBpwsCg/rD0vxoHPvuFBz+JgY8o7Ac=
Received: by 10.147.170.14 with SMTP id x14mr348106yao.36.1298510845309; Wed,
 23 Feb 2011 17:27:25 -0800 (PST)
Received: by 10.146.187.22 with HTTP; Wed, 23 Feb 2011 17:27:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167763>

Hi,

I have just encountered a small problem with git-svn dcommit, which
while not fatal, were quite worrying as
it resulted in a detached head(?) for a while. This is with
git-1.7.4-1.fc14.x86_64 .

What happened is that I was trying to cherry-pick from one svn branch
(of commits from somebody else using genuine svn)
into another svn branch and then do some fix-ups before dcommit to
push into another svn branch.

When dcommit'ing, it bombed out in the middle because one of the older
cherry-picks has no/empty svn commit message. So it
results into this message:

-------------------
A repository hook failed: 'pre-commit' hook failed with error output:
Please enter a commit message which details what has changed during this commit.
 at /usr/libexec/git-core/git-svn line 576
-------------------

That's fair enough and obvious enough, but then at that point, the
index is at the pre-bomb, and the working directory is post-bomb, I
think, and neither is HEAD of
my working branch. This is quite worrying - I think if I had done 'git
gc --prune=now --aggressive' at this point I would have lost my work?
Luckily I had a "git log" display before, so I did "git checkout -b
preserving_work sha1_of_working_branch_head" to keep it.

So I did git rebase -i to edit the original commit messages to add
something to them. (which arguably git-svn should do automatically? or
empty messages really frowned upon? I always commit with at least a
trivial message, but as I said, I was cherry-picking others' commits,
whose development habits I have no control over)

After I fixed that and continue as I intended, then there is another
bomb-out, when git-svn complains about a git commit message of mine
(with minor edit):
-------------
Running
perl -pi -e 's(sometag="original")(sometag="replacement")' directory/*
-------------
being empty. On hind-sight, it is probably not a good idea to have
perl regular expression code within a commit message (git-svn itself
being in perl), but complaining about a non-empty commit message (and
seem to be a valid one, no strange utf8/chinese characters, etc) being
empty seems to be a bug.

Hope this helps. BTW, git-svn is a great tool, and thanks a lot for
that - I wouldn't use anything else (including the "authentic" svn
client) to interact with svn repositories these days.

Hin-Tak
