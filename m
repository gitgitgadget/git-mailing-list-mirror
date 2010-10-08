From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 04/10] tg-path: use pretty_tree and diff-tree to generate the patch
Date: Fri,  8 Oct 2010 09:58:02 +0200
Message-ID: <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qp-00020q-45
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab0JHH6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab0JHH6T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:19 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=YsW8YyCy2PxcK+4nTXrDO+jvY2EMrtcHFKx5PYv+e4I=;
        b=g++jNx0i3lYD5nG7zCgfeBn6yPAiBYrQoGqoEsOAsPEOLUqcOUuHtQAUs+nWnaFNJR
         DFj+Os5wk8cgaeuAYkrlfff0IYx+pLqnZCek3M60Q1FKiUjiOEV/Vt8tC4M6IyAyl1wa
         2VQAnShyMk8W4Pm9jUoKqLVeMLwroaS4kzDPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kTxz7TEBHs+REs3YwZjgz9BI2P3IoufJSW8yC8D0KnZMdaLRLJqUYEuym55pdTKE0q
         hbyPrVUYqZwhIN4Gotr6WYG5836DBeJeNTtkT2J8mFpiDTScG5sT5WKJ+O/iqRholZvq
         7SY1KfGF5TjLlzYhKMQkyMDdOi5FcaFEYGKsY=
Received: by 10.204.176.144 with SMTP id be16mr1696012bkb.53.1286524698951;
        Fri, 08 Oct 2010 00:58:18 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id a25sm469476bks.20.2010.10.08.00.58.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158486>

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
