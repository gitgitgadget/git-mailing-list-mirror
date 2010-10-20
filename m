From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 02/12] cat_file: take -i/-w parameters
Date: Wed, 20 Oct 2010 22:17:47 +0200
Message-ID: <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f78-00051g-8T
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab0JTUSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34340 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0JTUSP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:15 -0400
Received: by gxk21 with SMTP id 21so1893468gxk.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=DHXdH7NX1iXAM3sGmdyQxAHI4DpHqOOEQ0sG+O9+mHg=;
        b=EyDg/74wv8YPISBZc9TJw0Qq49XGV5FdIB2A6SW3KK+cqhA45osSlti6W9V0x28jCY
         r2bqLKp/L/poDcie0ygks6lBt58QSvFMJY0eYvLQaEXzgbaAgl3YFKW/CV12U3Yk8gFn
         pQZc9/B30ULqh/qShsQbGxfnPoR4qLtIfiSbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nnxo17V/Mtw0KqeaOvUCgzYsJye0KZI13NYPraVGpAP6xjQZmyZBIrVB390+8Kd/IT
         vz001qFhbqTC1KtGyP2biNDRotLh9RacX03icD6rPqkvNnR2onu1O3hcO/JY9alkf0PJ
         Awlb3dfjsCW3/+eJuhrFtR6ln2naNbkq4X3ro=
Received: by 10.102.247.14 with SMTP id u14mr204346muh.110.1287605894226;
        Wed, 20 Oct 2010 13:18:14 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id z25sm406840fam.2.2010.10.20.13.18.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159425>

This changes the way how cat_file selects the source of the file. It
accepts an optional parameter which is either -i or -w and will react on this
instead of the branch name. tg-patch is updated accordingly and can now
accepts the current branch name as argument with -i or -w given.

cat_file was also broken for the worktree case when we are not in the top level.

Also, tg-patch allowed to be on the top-base branch, but -i and -w doesn't
make sense there too.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 hooks/pre-commit.sh |    2 +-
 tg-patch.sh         |   25 ++++++++++++++-----------
 tg.sh               |   23 ++++++++++++++---------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index c52a268..9519560 100644
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -97,7 +97,7 @@ BEGIN      { in_hunk = 0; }
 # check for repetitions of deps
 depdir="$(get_temp tg-depdir -d)" ||
 	die "Can't check for multiple occurrences of deps"
-cat_file "(i):.topdeps" |
+cat_file "$head_:.topdeps" -i |
 	while read dep; do
 		[ ! -d "$depdir/$dep" ] ||
 			die "Multiple occurrences of the same dep: $dep"
diff --git a/tg-patch.sh b/tg-patch.sh
index 68efcf0..85346ec 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -5,7 +5,7 @@
 
 name=
 
-topic=
+head_from=
 diff_opts=
 diff_committed_only=yes	# will be unset for index/worktree
 
@@ -16,11 +16,13 @@ while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
 	-i)
-		topic='(i)'
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from=-i
 		diff_opts="$diff_opts --cached";
 		diff_committed_only=;;
 	-w)
-		topic='(w)'
+		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
+		head_from=-w
 		diff_committed_only=;;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
@@ -31,22 +33,23 @@ while [ -n "$1" ]; do
 	esac
 done
 
+head="$(git symbolic-ref HEAD)"
+head="${head#refs/heads/}"
 
-[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
-	die "-i/-w are mutually exclusive with NAME"
-
-[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
+[ -n "$name" ] ||
+	name="$head"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
-# if not index/worktree, topic is current branch
-[ -z "$topic" ] && topic="$name"
+if [ -n "$head_from" ] && [ "$name" != "$head" ]; then
+	die "$head_from makes only sense for the current branch"
+fi
 
 
 
 setup_pager
 
-cat_file "$topic:.topmsg"
+cat_file "$name:.topmsg" $head_from
 echo
 [ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
 
@@ -63,7 +66,7 @@ else
 fi
 
 echo '-- '
-echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topdeps" | paste -s -d' '))"
+echo "tg: ($base_rev..) $name (depends on: $(cat_file "$name:.topdeps" $head_from | paste -s -d' '))"
 branch_contains "$name" "$base_rev" ||
 	echo "tg: The patch is out-of-date wrt. the base! Run \`$tg update\`."
 
diff --git a/tg.sh b/tg.sh
index 3805eeb..650ee59 100644
--- a/tg.sh
+++ b/tg.sh
@@ -18,21 +18,26 @@ die()
 	exit 1
 }
 
-# cat_file "topic:file"
-# Like `git cat-file blob $1`, but topics '(i)' and '(w)' means index and worktree
+# cat_file TOPIC:PATH [FROM]
+# cat the file PATH from branch TOPIC when FROM is empty.
+# FROM can be -i or -w, than the file will be from the index or worktree,
+# respectively. The caller should than ensure that HEAD is TOPIC, to make sense.
 cat_file()
 {
-	arg="$1"
-	case "$arg" in
-	'(w):'*)
-		cat "${arg#(w):}"
+	path="$1"
+	case "${2-}" in
+	-w)
+		cat "$root_dir/${path#*:}"
 		;;
-	'(i):'*)
+	-i)
 		# ':file' means cat from index
-		git cat-file blob "${arg#(i)}"
+		git cat-file blob ":${path#*:}"
+		;;
+	'')
+		git cat-file blob "$path"
 		;;
 	*)
-		git cat-file blob "$arg"
+		die "Wrong argument to cat_file: '$2'"
 		;;
 	esac
 }
-- 
1.7.3.1.1069.g89486
