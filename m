From: Avishay Lavie <some.avish@gmail.com>
Subject: git-svn with svn.pushmergeinfo incorrectly creates self-referencing
 svn:mergeinfo properties
Date: Thu, 1 Mar 2012 17:05:20 +0200
Message-ID: <CAHkK2bokWzhtaB9CEEG3Uths1DXHAzj7QzH0V3p0FGvE_ua2hQ@mail.gmail.com>
References: <CAHkK2bpg3AYtue=uPVXFMqkyjL5xuZNhfJ6vy-pj2T8Q88ysqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 16:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S37Zj-0007WB-S2
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 16:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293Ab2CAPFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 10:05:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36715 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab2CAPFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 10:05:42 -0500
Received: by wgbdr13 with SMTP id dr13so664987wgb.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 07:05:40 -0800 (PST)
Received-SPF: pass (google.com: domain of some.avish@gmail.com designates 10.180.85.35 as permitted sender) client-ip=10.180.85.35;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of some.avish@gmail.com designates 10.180.85.35 as permitted sender) smtp.mail=some.avish@gmail.com; dkim=pass header.i=some.avish@gmail.com
Received: from mr.google.com ([10.180.85.35])
        by 10.180.85.35 with SMTP id e3mr3293474wiz.6.1330614340956 (num_hops = 1);
        Thu, 01 Mar 2012 07:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=YrnvzxWsFjyNpwld8OGOfXoum63gjsr7zpk24eW041c=;
        b=Xs4rB52Lol+eYDrI7aVB3apk5q7xc/FURNoLbG3E1qK4jN0mNfLgYrCXnouH4KOspK
         zPt7ICLTHoh8gYWvgoKxxsE8qq+8jgY7TGH+V+s+Gut890t91ZFEvwjkdeQnGYrBq1LN
         RyO8EvR58PoFUxH/0i+7fIhekNUupP3/0sknw=
Received: by 10.180.85.35 with SMTP id e3mr2636102wiz.6.1330614340907; Thu, 01
 Mar 2012 07:05:40 -0800 (PST)
Received: by 10.216.12.9 with HTTP; Thu, 1 Mar 2012 07:05:20 -0800 (PST)
In-Reply-To: <CAHkK2bpg3AYtue=uPVXFMqkyjL5xuZNhfJ6vy-pj2T8Q88ysqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191932>

Hello,

I'm using git-svn from git 1.7.8.msysgit.0 with svn.pushmergeinfo set.
So far, it works beautifully and really closes the gap for developers
to be able to work with git-svn, including merging/reintegrating SVN
branches.
However, there seem to be a subtle bug in git-svn's behavior, where
the svn:mergeinfo property on a branch references commits from the
same branch, effectively saying "this branch was merged onto itself".
SVN then gets confused at this in subtle ways which ultimately cause
it to fail.

The following workflow reproduces the issue:

1. Work on some branch (git checkout my-branch)
2. Merge trunk into your branch (git merge trunk && git svn dcommit)
3. Reintegrate the branch back to trunk (git checkout master && git
merge my-branch && git svn dcommit)
4. Someone else reintegrates a different branch into trunk using a
regular SVN client (non-git).
5. A third someone merges trunk into their branch using a regular SVN client.
6. That third someone now tries to merge trunk into their branch
again, using SVN.

What we noticed happens is the following:
* Step #2 adds svn:mergeinfo on your branch to represent the commits
merged in from trunk (this is normal and desired).
* Step #3 copies these references from the svn:mergeinfo on the merged
branch back into the svn:mergeinfo property on trunk, so we end up
with trunk's mergeinfo referencing its own commits (this is the buggy
behavior -- when reintegrating with SVN, this part doesn't happen).
* In step #4, SVN detects the self-referencing mergeinfo property on
trunk and removes it, leaving only mergeinfo for the other branches
(this is also desirable behavior on SVN's part, since a branch
shouldn't include any mergeinfo references to itself).
* In step #5, SVN tries to apply the changes made on trunk to the
target branch, including the previous merge which removed some
mergeinfo references. This removes the same trunk commits from the
mergeinfo property on the target branch, leaving "holes" in mergeinfo
property for trunk on that branch.
* In step #6, SVN detects that the mergeinfo property for trunk on the
target branch has holes in it, and tries to merge those revisions from
trunk again. This causes tree conflicts and other noise which fails
the merge.

As I see it, the bug here is the creation of self-referencing
mergeinfo properties in step #3; SVN doesn't exhibit this behavior and
this is what causes the problems later on.
I think a general solution is to never add an svn:mergeinfo line
referencing the branch being dcommitted into.

Can anyone confirm this is indeed a bug, suggest a fix or workaround
and/or point me at the relevant code?

Thank you,

Avish
