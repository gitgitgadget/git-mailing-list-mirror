From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] tg-patch: use pretty_tree
Date: Mon,  4 Oct 2010 22:09:41 +0200
Message-ID: <1286222981-28358-1-git-send-email-bert.wesarg@googlemail.com>
References: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:09:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2rM7-0006Bh-GX
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab0JDUJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:09:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32793 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756920Ab0JDUJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:09:46 -0400
Received: by bwz11 with SMTP id 11so3951160bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nCjzxnSFtHk7hSIAVhWQ1kiSyzdG53bhQWLqYhkBW58=;
        b=UFZkl3b5RE36NVT3uGrwGCYjnInlaMEZDKNEX/khTVN6Y/A2W+7Fl6o2uH8JYjSxA3
         nfFvnz54tO80GLAVPSTByU1u6wophAsBWz1GFaqQzxr+dyRvCpp8IVusmADHcCvUbS2z
         ZUgqHNUxwdxhstZoNJplwG5p/PBPkZK9QOiko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oLNDvxgBPE4MEYiVD6R+1Q5Qx7IUY161ghaOWPmtYzcpcqzS8S0rCIMDQHUsAGxg1G
         t6S1NYBSOkA5lhjd7+rJYu5E2+HxXg92ECb3wwOKo9gDZKGaA0/RBJXdIjC2fPhfLGJC
         mvnCKrrTnH6ykzlTzSEMi22dwMQEy187iH+Qs=
Received: by 10.204.57.9 with SMTP id a9mr7523312bkh.104.1286222985472;
        Mon, 04 Oct 2010 13:09:45 -0700 (PDT)
Received: from localhost (p5B0F7A6E.dip.t-dialin.net [91.15.122.110])
        by mx.google.com with ESMTPS id f10sm4126115bkl.5.2010.10.04.13.09.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 13:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <1286216867-14701-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158107>

This applies the same treatment to tg-patch like tg-files got in v2.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 tg-patch.sh |   56 ++++++++++++++++++++++++++++++++------------------------
 1 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index 7bafdfe..0ebef7a 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -4,11 +4,8 @@
 # GPLv2
 
 name=
-
 topic=
-diff_opts=
-diff_committed_only=yes	# will be unset for index/worktree
-
+topic_for_pretty_tree=
 
 ## Parse options
 
@@ -16,12 +13,13 @@ while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
 	-i)
+		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
 		topic='(i)'
-		diff_opts="$diff_opts --cached";
-		diff_committed_only=;;
+		topic_for_pretty_tree=-i;;
 	-w)
+		[ -z "$topic" ] || die "-i and -w are mutually exclusive"
 		topic='(w)'
-		diff_committed_only=;;
+		topic_for_pretty_tree=-w;;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
@@ -32,7 +30,7 @@ while [ -n "$1" ]; do
 done
 
 
-[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
+[ -n "$name" -a -n "$topic" ] &&
 	die "-i/-w are mutually exclusive with NAME"
 
 [ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
@@ -46,22 +44,32 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 
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
+git diff-tree -p --stat -r $b_tree $t_tree
 
 echo '-- '
 echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topdeps" | paste -s -d' '))"
-- 
tg: (c9ca19b..) bw/tg-patch-pretty_tree (depends on: bw/files)
