From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 05/12] tg-path: use pretty_tree and diff-tree to generate the patch
Date: Wed, 20 Oct 2010 22:17:50 +0200
Message-ID: <d1c407c33f446a6e5c7329ba521871732a136fa6.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
 <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
 <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:19:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f7n-0005GB-0h
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab0JTUSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab0JTUSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:22 -0400
Received: by fxm4 with SMTP id 4so3063004fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=juqePA5U8XKi8PsTA10iOBKDc8+o/3StHk6y7Q+b2rc=;
        b=Z60NZCFzzCDMuwyB62hsVGVMtXUQT1NlhvtQkfbOueg8Ws0VR0WHBMpCMXcVTXPLy0
         Do1Kxe6szsv5CpGyCXwhUN512/U05S2utXPcFxmqImumaFO/eCKodMgfpXiP/pY9LDqF
         XpAqJWdfML1nmrbqWcliS1F+LOFdyYY2vgeUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EzSe20W3ZGkTKLNbdB8rVL6275EeSPK6jJcNRG3uuZtU/9dXTQMvfQ9jlti9j3BKlq
         3BvCms/GC7Pp8ab3J96/4I93/Ssr857I9vR4EyEbfCUJXk3IGnfssOipZO6ZrafXXD8X
         dId109kb4eP1Phgz1MrZ/TIpmUiOvUnLtacMI=
Received: by 10.103.121.20 with SMTP id y20mr6645498mum.5.1287605900829;
        Wed, 20 Oct 2010 13:18:20 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id b15sm402687fah.28.2010.10.20.13.18.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <d9fc8653e6e4c7eb7197a0fb92cd3b8c6e058187.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159432>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-patch.sh |   54 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 85346ec..9def6e5 100644
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
@@ -49,20 +41,36 @@ fi
 
 setup_pager
 
-cat_file "$name:.topmsg" $head_from
-echo
-[ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
-
-# Evil obnoxious hack to work around the lack of git diff --exclude
-git_is_stupid="$(get_temp tg-patch-changes)"
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
 
 echo '-- '
-- 
1.7.3.1.1069.g89486
