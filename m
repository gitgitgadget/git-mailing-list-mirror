From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v2] tg-patch: use pretty_tree
Date: Tue,  5 Oct 2010 21:04:46 +0200
Message-ID: <1286305486-28607-1-git-send-email-bert.wesarg@googlemail.com>
References: <AANLkTikXT=rzOJTTcNOsWkXctKOM3FzQ9ycVtOprLHGh@mail.gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 21:04:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Cor-0005JO-SN
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 21:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab0JETEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 15:04:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42921 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0JETEv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 15:04:51 -0400
Received: by fxm4 with SMTP id 4so669295fxm.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=v0dRBx/SDujB3SGVZhf139K/mYogkkGUNT9C0kRXegk=;
        b=XidcCGmeGWIi55XZ2KgYRSzubNa7S1LAq/raw8ThrYqfgtriA8w7WKNrGQ/Mg6HYe+
         CuPEQfIEtt0sd5F91sOKBFSN5Dz66RogmiL2oLYvGTJxiHkEsHHOrHoDDNviw+UOXtnB
         ILYv/pTQ4WjitdfKeIoI+OcnFUR7IveYTn8AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lN8nTPKqBU7C6XoiqXII1y0aiD4uQNV+svEcHR1ljRoUXacRh/SxBLM32ns0r9C7VU
         iewSTJyaM3qoSO+H9uQukp0xgBdzIlITPVheQRBG2RYCzrdWSNHCYPwENVAtf73vgYsP
         oWx9rL0bmRugV6XTQlFymu91/uImDJ0MXRsO4=
Received: by 10.223.13.133 with SMTP id c5mr8367310faa.51.1286305489749;
        Tue, 05 Oct 2010 12:04:49 -0700 (PDT)
Received: from localhost (p5B0F75F8.dip.t-dialin.net [91.15.117.248])
        by mx.google.com with ESMTPS id a16sm3116117fai.1.2010.10.05.12.04.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 12:04:47 -0700 (PDT)
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <AANLkTikXT=rzOJTTcNOsWkXctKOM3FzQ9ycVtOprLHGh@mail.gmail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158223>

This applies the same treatment to tg-patch like tg-files got in v2.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Basing the decision whether to use the ui diff or the porcelain diff-tree
is probably very unorthodox, but also makes sense, doesn't it?

Changes:
 v2:
  * apply suggestions from Uwe made to tg-files here too
  * the running pager decides whether we use the ui diff or the porcelain
    diff-tree

 tg-patch.sh |   67 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 7bafdfe..e88985a 100644 tg-patch.sh
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -4,24 +4,18 @@
 # GPLv2
 
 name=
-
 topic=
-diff_opts=
-diff_committed_only=yes	# will be unset for index/worktree
-
+topic_for_pretty_tree=
 
 ## Parse options
 
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
-	-i)
-		topic='(i)'
-		diff_opts="$diff_opts --cached";
-		diff_committed_only=;;
-	-w)
-		topic='(w)'
-		diff_committed_only=;;
+	-i|-w)
+		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
+		topic="(${arg#-})"
+		topic_for_pretty_tree="$arg";;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
@@ -32,8 +26,8 @@ while [ -n "$1" ]; do
 done
 
 
-[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
-	die "-i/-w are mutually exclusive with NAME"
+[ -n "$name" -a -n "$topic" ] &&
+	die "$topic are mutually exclusive with NAME"
 
 [ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
@@ -46,22 +40,37 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 
 setup_pager
 
-cat_file "$topic:.topmsg"
-echo
-[ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
-
-# Evil obnoxious hack to work around the lack of git diff --exclude
-git_is_stupid="$(mktemp -t tg-patch-changes.XXXXXX)"
-git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"$name"} -- |
-	fgrep -vx ".topdeps" |
-	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
-if [ -s "$git_is_stupid" ]; then
-	cd "$root_dir"
-	cat "$git_is_stupid" | xargs git diff -a --patch-with-stat $diff_opts "$base_rev" ${diff_committed_only:+"$name"} --
-else
-	echo "No changes."
-fi
-rm "$git_is_stupid"
+# put out the commit message
+# and put an empty line out, if the last one in the message was not an empty line
+# and put out "---" if the commit message does not have one yet
+cat_file "$topic:.topmsg" |
+	awk '
+/^---/ {
+    has_3dash=1;
+}
+       {
+    need_empty = 1;
+    if ($0 == "")
+        need_empty = 0;
+    print;
+}
+END    {
+    if (need_empty)
+        print "";
+    if (!has_3dash)
+        print "---";
+}
+'
+
+b_tree=$(pretty_tree "$name" -b)
+t_tree=$(pretty_tree "$name" $topic_for_pretty_tree)
+
+# use the ui diff command when the pager is active
+diff_command=diff
+[ "x$GIT_PAGER_IN_USE" = "x1" ] ||
+	diff_command=diff-tree
+
+git $diff_command -p --stat $b_tree $t_tree
 
 echo '-- '
 echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topdeps" | paste -s -d' '))"
-- 
tg: (aaf1181..) bw/tg-patch-pretty_tree (depends on: bw/files)
