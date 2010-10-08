From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 01/10] cat_file: take -i/-w parameters
Date: Fri,  8 Oct 2010 09:57:59 +0200
Message-ID: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qM-0001uz-2J
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab0JHH6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0JHH6M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:12 -0400
Received: by bwz15 with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=fuIuVXzQMOBU4B4mR6fd3neirOunODlvq7YfdDl1XQ0=;
        b=SRRmnbjPv4jNfD5MnUEyVU6+6mW/yIC8LEDfAESYXp3Scen/fpUcfyYAc5NJsB1dhw
         8uD6wjRSSW/KxS8JcK7ItyHOPBZfSh8IRfRKXVtGBhaEr59PtllANUlLOkAcjhMfUSyS
         UXsN0j1O0IfGgdyD9c0xMoZyrTo5eni3mgn+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xzSz9l4lUerd6lm6QXLj3DRl9gHgjQBerRY4bUfE7rtR6IyUmasS+BgidXO47xFile
         NGQy+YbXL7YIqB8ph6SpTn6JiQ+VM83yYVznDKhUbz3e6QOZCpspjDF+4K47gkw+v9WS
         2oyGq4/2TW9f94bPs/WPOW4hD6Vly1a17FER8=
Received: by 10.204.126.153 with SMTP id c25mr1707061bks.27.1286524691004;
        Fri, 08 Oct 2010 00:58:11 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id d27sm2392756bku.10.2010.10.08.00.58.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158482>

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
 tg-patch.sh |   25 ++++++++++++++-----------
 tg.sh       |   27 +++++++++++++++------------
 2 files changed, 29 insertions(+), 23 deletions(-)

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
index 3718702..4d7d4ef 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -18,24 +18,27 @@ die()
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
-		arg=$(echo "$arg" | tail --bytes=+5)
-		cat "$arg"
-		return
+	path="$1"
+	case "${2-}" in
+	-w)
+		cat "$root_dir/${path#*:}"
 		;;
-	'(i):'*)
+	-i)
 		# ':file' means cat from index
-		arg=$(echo "$arg" | tail --bytes=+5)
-		git cat-file blob ":$arg"
+		git cat-file blob ":${path#*:}"
+		;;
+	'')
+		git cat-file blob "$path"
 		;;
 	*)
-		git cat-file blob "$arg"
+		die "Wrong argument to cat_file: '$2'"
+		;;
 	esac
 }
 
-- 
1.7.1.1067.g5aeb7
