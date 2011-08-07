From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH] filter-branch: Export variable `workdir' for --commit-filter
Date: Sun, 7 Aug 2011 02:44:43 -0000
Message-ID: <f06dd070abcc485e98c054ec3ee298f9-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 05:58:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpuVd-0001tR-Pa
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 05:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684Ab1HGDxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 23:53:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45895 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab1HGDxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 23:53:39 -0400
Received: by eyx24 with SMTP id 24so2043498eyx.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 20:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id;
        bh=AzsTbx7BAnmrvlrPVmbCTUgf6kgULKsp7jeTDx51qwI=;
        b=ibatYayqGqFhsBdMvxgvPeUYy/LaTCLhnPB8NSmr7iFSMCFWHT5Z7bKOe+VOiw6hf1
         2EeH8ugct8JE8UKJnuQa7t3+03r+k9u2D5eH0dHPsXKnlj80Vkdtd+dImidF0vtdbVfG
         LBfMTSkf5Wcq9KwPZyfFHwxt3y+CiICVSXjIM=
Received: by 10.14.47.197 with SMTP id t45mr1093011eeb.36.1312689218219;
        Sat, 06 Aug 2011 20:53:38 -0700 (PDT)
Received: from gmail.com (tor-exit-router40-readme.formlessnetworking.net [199.48.147.40])
        by mx.google.com with ESMTPS id d44sm1904458eeb.56.2011.08.06.20.53.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 20:53:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178896>

According to `git help filter-branch':

       --commit-filter <command>
           ...
           You can use the _map_ convenience function in this filter,
           and other convenience functions, too...
           ...

However, it turns out that `map' hasn't been usable because it depends
on the variable `workdir', which is not propogated to the environment
of the shell that runs the commit-filter <command> because the
shell is created via a simple-command rather than a compound-command
subshell:

 @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
                 $(git write-tree) $parentstr < ../message > ../map/$commit ||
                         die "could not write rewritten commit"

One solution is simply to export `workdir'. However, it seems rather
heavy-handed to export `workdir' to the environments of all commands,
so instead this commit exports `workdir' for only the duration of the
shell command in question:

 workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
                 $(git write-tree) $parentstr < ../message > ../map/$commit ||
                         die "could not write rewritten commit"

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 962a93b..6b5f225 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -363,7 +363,7 @@ while read commit parents; do
 	sed -e '1,/^$/d' <../commit | \
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
-	@SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
+	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		$(git write-tree) $parentstr < ../message > ../map/$commit ||
 			die "could not write rewritten commit"
 done <../revs
-- 
1.7.6.134.gcf13f6
