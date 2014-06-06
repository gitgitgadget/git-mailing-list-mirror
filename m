From: Brett Randall <javabrett@gmail.com>
Subject: git-svn, different merge-parent selected in independent clones
 following SVN merge
Date: Fri, 6 Jun 2014 19:06:16 +1000
Message-ID: <CALeEUB4k+Uc+Yr4-ronuHcG0YUcxJgy-N=mffxAF6jGMr0x9ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 11:33:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsq6R-0006rs-VD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 11:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbaFFJGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 05:06:18 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62091 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbaFFJGR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 05:06:17 -0400
Received: by mail-ie0-f178.google.com with SMTP id rl12so2045871iec.23
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=eZkpjUT2OwEMDCDKoLxGjpfV2xvuUFsd9iNw7bTTioE=;
        b=nUw/aFvJhhwlmdxkJ/hCbc9BbRVI1jO5dI6elUSi4PvQxNuvV/jO3fC4ROdqp+3a1J
         2CeZARvE1D2pPsaN/h30w9Ns6D1WsIHV2RtDgRdB3NJLST6nCb+ZA46sGNLOtRwu8OU6
         SAYet1ptPQuMvZrBeWptlld6o7cx/CRCybl+cQczVZ91VvkM5Jv0JnI+1NuwToBaBUUT
         I6aRyvTUZucagalw0tccfek2C+YHDQOx3x89XjN4n6FlPAtq6R3stIdvIHBaUqAziGgs
         aOoW/ep7KnJeKIMGZF7CyzyuqWrkvHRIFdzJdCALkRsyNpZYM/lJ0ASbxgVDoScJ+LEy
         xkMg==
X-Received: by 10.50.109.202 with SMTP id hu10mr4258204igb.1.1402045576396;
 Fri, 06 Jun 2014 02:06:16 -0700 (PDT)
Received: by 10.64.138.200 with HTTP; Fri, 6 Jun 2014 02:06:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250896>

Hi,

git version 1.8.3.2

I've used git-svn on a few repositories for a long time. In what is a
testament to the consistency and stability of git-svn, despite often
maintaining separate git-svn clones on different machines, I've never
once seen a different commit-sha in independent clones for the same
SVN revision. That is until just now. Two of three clones have the
same commit-sha, the third has a different sha for the same SVN
revision (and as expected for all subsequent commits). All of the
tree-shas are identical. I never mix/push/pull local commits between
these independent clones.

The commit where the commit-sha diverged on the one clone is an SVN
commit that involved a branch merge. The difference in this clone is
that git-svn selected a different parent commit for one of the two
parents of the merge (the other parent is the same). For that commit,
the two clones that agreed had:

commit de2dbe2e045f626cff8e282da1660c239b926765
tree f57a4d8b88262e1f1cd79f98c7d2f5ae82751636
parent f058fd2e05a2ef54c6bf056a3d2a46d17735253d
parent e2722a1a24b490dbc8d7375b64050f1a0c010018

and the one that did not had:

commit a3cfdff262b6afe8b22acd92f01554294f98c851
tree f57a4d8b88262e1f1cd79f98c7d2f5ae82751636
parent f058fd2e05a2ef54c6bf056a3d2a46d17735253d
parent be09b04a3fa582ba12420e0a9b9c3233b41b600d

(tree and one parent same, other parent and therefore new commit sha differ)

On investigation, I found that commit be09b0 is actually an ancestor
of e2722a, and the parent commit of e2722a is another (SVN) merge
commit, with be09b0 as one of the parents.

My best guess is that this can happen when git-svn rebase-ing
trunk/master, when the associated branch isn't fully fetched. I often
run "git svn fetch" on these clones, which fetches all branches,
before "git svn rebase" but there's a chance that I've occasionally
run "git svn rebase" on master (trunk) on its own, which only fetches
trunk.

So my questions are:

1) Does that sound like the most likely way this would happen - seeing
an SVN merge hit trunk during an git svn rebase on master, when the
merged branch was not completely git svn fetch-ed? And on the other
agreeing clones, the better parent commit had already been picked-up
as part of a git svn fetch?

2) If so, is there any reasonable way to prevent this ... I guess
making sure (perhaps via an alias) that svn rebases occur only via git
svn fetch followed by git svn rebase -l .

Thanks
Brett
