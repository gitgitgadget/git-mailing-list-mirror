From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 04/11] tg-path: use pretty_tree and diff-tree to generate the patch
Date: Sat,  9 Oct 2010 22:56:55 +0200
Message-ID: <ec70ec8e15013f663bba7f62885abe6881a1512a.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
 <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
 <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:58:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gUZ-0008Nt-Cg
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760602Ab0JIU6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:58:01 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760545Ab0JIU6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:58:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=YsW8YyCy2PxcK+4nTXrDO+jvY2EMrtcHFKx5PYv+e4I=;
        b=OVXGYFbDssO+xSlVNxOhBnWlaiyXKRK4wBs8LeMekpsg896MdJS7+NIe2QnAP2yy/3
         pljpWiavtMeFCv38KmeTnt8AwLGEz/3JLC/8yMefNXdF/MlvkDbDngLd9+DpvPol3XyS
         G/6I2fTzUXMLXc/IVb7GRIVIId7ZzO0HfSmpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ViO2wAvYObo9mDQLggMbVs2oFj/ku/hMmvyOowWwr2SzDgZ/1THiYte/ydV73jrOtM
         J8mIaJzJE6kx+w+dz+oGeFWfwZ0z8lYPDejiNYS6c0hHm1eib7DOK+Uw8N5sDcwE8t+e
         L5nvbIkt3w+P5QVlybASdtn/+Eun1USx+iCFM=
Received: by 10.14.47.79 with SMTP id s55mr2454526eeb.45.1286657879848;
        Sat, 09 Oct 2010 13:57:59 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id z55sm7830789eeh.15.2010.10.09.13.57.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:57:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <6e000c8cf21fac6cd4cf8608c8dc021b039e6f83.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158614>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-patch.sh |   55 +++++++++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 5b7386a..9def6e5 100644 tg-patch.sh
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -6,8 +6,6 @@
 name=
 
 head_from=
-diff_opts=
-diff_committed_only=yes	# will be unset for index/worktree
 
 
 ## Parse options
@@ -15,15 +13,9 @@ diff_committed_only=yes	# will be unset for index/worktree
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
-	-i)
+	-i|-w)
 		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
-		head_from=-i
-		diff_opts="$diff_opts --cached";
-		diff_committed_only=;;
-	-w)
-		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
-		head_from=-w
-		diff_committed_only=;;
+		head_from="$arg";;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
@@ -49,22 +41,37 @@ fi
 
 setup_pager
 
-cat_file "$name:.topmsg" $head_from
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
+
+# put out the commit message
+# and put an empty line out, if the last one in the message was not an empty line
+# and put out "---" if the commit message does not have one yet
+cat_file "$name:.topmsg" $head_from |
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
+t_tree=$(pretty_tree "$name" $head_from)
+
+if [ $b_tree = $t_tree ]; then
 	echo "No changes."
+else
+	git diff-tree -p --stat $b_tree $t_tree
 fi
-rm "$git_is_stupid"
 
 echo '-- '
 echo "tg: ($base_rev..) $name (depends on: $(cat_file "$name:.topdeps" $head_from | paste -s -d' '))"
-- 
1.7.1.1067.g5aeb7
