From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH] pull --all: fix error message when current branch is not tracking remote branch
Date: Tue,  2 Mar 2010 21:52:21 +0000
Message-ID: <1267566741-5784-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 22:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nma17-00071p-Ot
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 22:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab0CBVwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 16:52:33 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49118 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0CBVwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 16:52:32 -0500
Received: by bwz1 with SMTP id 1so192588bwz.21
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=6ayrx4iYJJp/HP5DzgFNgaTbjx718QjCEh8sZcaI0Ec=;
        b=UtBKB+aXwK27w16Y8/JRNYOSGW//aK0TtxTb7oR18doHyUFblUyFW7j0YB3f3CRUIb
         OR4ddnbts5I8JxPHysrOrZYvD8UwnHLYzSL2GkD6wOIS7quzRlWQc06xI9e1uTjiX22s
         gIrSREC3eD9wnii6WWtF0pSAqDJTWUhpwWEIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WuyAe5yRiIJKKpsPV2LkB2wiZWLy+Jb88w3JFezTYMdIv46D+z9Q54PgrYCiGRjDgD
         ABJXWCIgK+jT7m8IoARuGwDnH1xKd6V77LUlKJ7Iv5rHrtMb6j7IdMjO9WOWQFK0D/oD
         raxdKeOQd+5WM8o97/eZFZNoit/O3XZUn2g8U=
Received: by 10.204.33.216 with SMTP id i24mr238746bkd.154.1267566749914;
        Tue, 02 Mar 2010 13:52:29 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 13sm3265389bwz.15.2010.03.02.13.52.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 13:52:28 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.1705.g687ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141419>

If current branch doesn't track remote branch, "git pull --all" produces
a confusing message:

  You asked to pull from the remote '--all', but did not specify
  a branch. Because this is not the default configured remote
  for your current branch, you must specify a branch on the command line.

To fix this, simply move up check if current branch is configured to track
remote branch.

This patch applies on top of branch 'next' of git.git repository.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 git-pull.sh             |   20 ++++++++++----------
 t/t5521-pull-options.sh |    5 +++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 38331a8..df16ea0 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -147,16 +147,6 @@ error_on_no_merge_candidates () {
 		echo "among the refs that you just fetched."
 		echo "Generally this means that you provided a wildcard refspec which had no"
 		echo "matches on the remote end."
-	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
-		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch. Because this is not the default configured remote"
-		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the command"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' in"
@@ -179,6 +169,16 @@ error_on_no_merge_candidates () {
 		echo "    fetch = <refspec>"
 		echo
 		echo "See git-config(1) for details."
+	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
+		echo "You asked to pull from the remote '$1', but did not specify"
+		echo "a branch. Because this is not the default configured remote"
+		echo "for your current branch, you must specify a branch on the command line."
+	elif [ -z "$curr_branch" ]; then
+		echo "You are not currently on a branch, so I cannot use any"
+		echo "'branch.<branchname>.merge' in your configuration file."
+		echo "Please specify which remote branch you want to use on the command"
+		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
+		echo "See git-pull(1) for details."
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 1b06691..64ba39f 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -87,6 +87,11 @@ test_expect_success 'git pull --all' '
 		merge = refs/heads/master
 	EOF
 	git pull --all
+	) &&
+	(cd clonedmulti &&
+	git checkout -b side &&
+	test_must_fail git pull --all 2>err &&
+	grep "You asked me to pull without telling me which branch" err
 	)
 '
 
-- 
1.7.0.1.1704.g1a7f8
