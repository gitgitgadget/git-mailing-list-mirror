From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 01/11] cat_file: take -i/-w parameters
Date: Sat,  9 Oct 2010 22:56:52 +0200
Message-ID: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gTw-0008Cd-Un
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760512Ab0JIU5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:57:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757112Ab0JIU5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:57:19 -0400
Received: by ewy20 with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vAUPqzJwqOYFQi3ec2Cn6haL5BFJ+OGV2gl0yCOVA2o=;
        b=fa95Bf+r6aBU59jnfrDBwZLnIerji724okRMn8PWpVcA0cjyLlboDyH6ak1oIkmtcz
         sn7kPUpbiVvf91oURCBYnPa7heVJt1r1oAismKxYFVebL+aNxuAbXqicXnfogsEePytC
         ih9zGJrQB/Yt6w4fc9aGnBRNo9vqeVASMbO2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lOzyf9ofoooqZadytK/J6a40z3YNTiC5uJnqaPUwlkuMTa5RddLzbPG20Bl7q/TUPE
         smnyUvHk4vEaw+QyHV6w4v4sFb/9OZ8/clp359d/xWFxuQM7VfSf11z2IGRxN5EkDmDJ
         FH0imL55gOuCnzKd83GDJdW0/yWIO3i4W3+D0=
Received: by 10.14.37.10 with SMTP id x10mr2455082eea.31.1286657838530;
        Sat, 09 Oct 2010 13:57:18 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id q54sm3989670eeh.6.2010.10.09.13.57.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:57:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158611>

This changes the way how cat_file selects the source of the file. It
accepts an optional parameter which is either -i or -w and will react on this
instead of the branch name. tg-patch is updated accordingly and can now
accepts the current branch name as argument with -i or -w given.

cat_file was also broken for the worktree case when we are not in the top level.

Also, tg-patch allowed to be on the top-base branch, but -i and -w doesn't
make sense there too.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

I will probably never understand why TopGit accepts to be on a top-base branch.
I will probably never understand why TopGit not changes the cwd to the top level.
I will probably never understand why TopGit does not use the git-sh-setup.sh.
---
 hooks/pre-commit.sh |    2 +-
 tg-patch.sh         |   25 ++++++++++++++-----------
 tg.sh               |   23 ++++++++++++++---------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
index 4f2f16f..f740997 100644 hooks/pre-commit.sh
--- a/hooks/pre-commit.sh
+++ b/hooks/pre-commit.sh
@@ -98,7 +98,7 @@ BEGIN      { in_hunk = 0; }
 depdir="$(mktemp -t -d tg-depdir.XXXXXX)" ||
 	die "Can't check for multiple occurrences of deps"
 trap "rm -rf '$depdir'" 0
-cat_file "(i):.topdeps" |
+cat_file "$head_:.topdeps" -i |
 	while read dep; do
 		[ ! -d "$depdir/$dep" ] ||
 			die "Multiple occurrences of the same dep: $dep"
diff --git a/tg-patch.sh b/tg-patch.sh
index 7bafdfe..5b7386a 100644 tg-patch.sh
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
 
@@ -64,7 +67,7 @@ fi
 rm "$git_is_stupid"
 
 echo '-- '
-echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topdeps" | paste -s -d' '))"
+echo "tg: ($base_rev..) $name (depends on: $(cat_file "$name:.topdeps" $head_from | paste -s -d' '))"
 branch_contains "$name" "$base_rev" ||
 	echo "tg: The patch is out-of-date wrt. the base! Run \`$tg update\`."
 
diff --git a/tg.sh b/tg.sh
index 8264a3b..4d7d4ef 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -18,21 +18,26 @@ die()
 	exit 1
 }
 
-# cat_file "topic:file"
-# Like `git cat-file blob $1`, but topics '(i)' and '(w)' means index and worktree
+# cat_file TOPIC:PATH FROM
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
1.7.1.1067.g5aeb7
