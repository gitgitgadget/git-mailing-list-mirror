From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 02/10] pretty_tree: globalize and respect -i/-w options
Date: Fri,  8 Oct 2010 09:58:00 +0200
Message-ID: <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
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
	id 1P47qo-00020q-28
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab0JHH6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab0JHH6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:14 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Cx5iYWP3uPr4eE/XmmajiqbkmVpPBZCb/31bK/GJJRE=;
        b=Fz6y16N7gYqp5XGA5tBQnKNVDqIjM5JiMhyaGzKwSbYYPpHgT00CcqV/PCH1cuzLy8
         Uusb/smJhByzlAOYPua9Qaz85D073zOVsutZTCtTVar7jOmccM+6SEupa7ofMqS67tt0
         b26I2B8DUVdn6pm4fU5FPiRNr2lvNZWDX5N+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sj6P2zJLVz4QIFIMGgPjuYs0KqrjBdMgRu7JPnpggfmGOkNh29R4MWXTONrCvrbinf
         Y/ABDDBaISYeLbWziq1jmrUyIG6bBn3BZAMXqQkgWFzAAbUU/OdFIJlMn3iEsMQqrp/O
         r++HnmS3pzzuLYdqWr6MyM6TRXI98ton/A46w=
Received: by 10.204.47.38 with SMTP id l38mr1674928bkf.154.1286524693590;
        Fri, 08 Oct 2010 00:58:13 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id o12sm1167207bkb.9.2010.10.08.00.58.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158483>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-export.sh |   13 ++-----------
 tg.sh        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 6d82d55..5c707ce 100644 tg-export.sh
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -63,15 +63,6 @@ trap 'rm -rf "$playground"' EXIT
 
 ## Collapse driver
 
-# pretty_tree NAME
-# Output tree ID of a cleaned-up tree without tg's artifacts.
-pretty_tree()
-{
-	git ls-tree --full-tree "$1" \
-	| awk -F '	' '$2 !~ /^.top/' \
-	| git mktree
-}
-
 create_tg_commit()
 {
 	name="$1"
@@ -112,7 +103,7 @@ collapsed_commit()
 			echo "TopGit-driven merge of branches:"
 			echo
 			cut -f 2 "$playground/$name^parents"
-		} | git commit-tree "$(pretty_tree "refs/top-bases/$name")" \
+		} | git commit-tree "$(pretty_tree "$name" -b)" \
 			$(for p in $parent; do echo -p $p; done))"
 	fi
 
@@ -227,7 +218,7 @@ linearize()
 	else
 		retmerge=0;
 
-		git merge-recursive "$(pretty_tree "refs/top-bases/$_dep")" -- HEAD "$(pretty_tree "refs/heads/$_dep")" || retmerge="$?";
+		git merge-recursive "$(pretty_tree "$_dep" -b)" -- HEAD "$(pretty_tree "refs/heads/$_dep")" || retmerge="$?";
 
 		if test "x$retmerge" != "x0"; then
 			git rerere;
diff --git a/tg.sh b/tg.sh
index 4d7d4ef..308ed28 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -42,6 +42,53 @@ cat_file()
 	esac
 }
 
+# get tree for the committed topic
+get_tree_()
+{
+	echo "$1"
+}
+
+# get tree for the base
+get_tree_b()
+{
+	echo "refs/top-bases/$1"
+}
+
+# get tree for the index
+get_tree_i()
+{
+	git write-tree
+}
+
+# get tree for the worktree
+get_tree_w()
+{
+	i_tree=$(git write-tree)
+	(
+		# the file for --index-output needs to sit next to the
+		# current index file
+		: ${GIT_INDEX_FILE:="$git_dir/index"}
+		TMP_INDEX="$(mktemp "${GIT_INDEX_FILE}-tg.XXXXXX")"
+		git read-tree -m $i_tree --index-output="$TMP_INDEX" &&
+		GIT_INDEX_FILE="$TMP_INDEX" &&
+		export GIT_INDEX_FILE &&
+		git diff --name-only -z HEAD |
+			git update-index -z --add --remove --stdin &&
+		git write-tree &&
+		rm -f "$TMP_INDEX"
+	)
+}
+
+# pretty_tree NAME [-b | -i | -w]
+# Output tree ID of a cleaned-up tree without tg's artifacts.
+# NAME will be ignored for -i and -w, but needs to be present
+pretty_tree()
+{
+	git ls-tree --full-tree "$(get_tree_${2#-} "$1")" |
+		awk -F '	' '$2 !~ /^.top/' |
+		git mktree
+}
+
 # setup_hook NAME
 setup_hook()
 {
-- 
1.7.1.1067.g5aeb7
