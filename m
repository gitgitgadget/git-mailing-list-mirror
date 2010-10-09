From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 02/11] pretty_tree: globalize and respect -i/-w options
Date: Sat,  9 Oct 2010 22:56:53 +0200
Message-ID: <456834d2977615d5f5c41ca3947fb45cd82bfd87.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:57:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4gU7-0008GP-Rd
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760520Ab0JIU53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:57:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52677 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab0JIU53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:57:29 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so129207ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Cx5iYWP3uPr4eE/XmmajiqbkmVpPBZCb/31bK/GJJRE=;
        b=VHhlpJARtzxFnRUEq6ra3mwT8o3DazwtXjgLMMF/Fv/98SjQQayUSaXksyYTwaBAR0
         hybH/y3XHjbMHFB6TJ70dXZFS2uXJX/jJdEJa6i1bObib56QvxL8Ek+XeoNBJ08FC8jT
         vciY0Hi0fPqVjiDxObid8vFOUo3rkx2MsFFFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZIq1HPBgJnyiaCpuSH/XK7fBgdop3f45uZVfps08ll89dvxkydmxAV5/gqrCZ3JK+f
         7tDF2MVpz/f/ohp6UNXk0Y+7KE0Y25/u//VbydNDaH0NlDlBgk+YFJZk98vWyZygqsO3
         9pSkk9rilzmc9Y6DP7aAoRToA3WBaV3rdYGwo=
Received: by 10.213.33.84 with SMTP id g20mr927310ebd.4.1286657848457;
        Sat, 09 Oct 2010 13:57:28 -0700 (PDT)
Received: from localhost ([46.115.90.142])
        by mx.google.com with ESMTPS id u9sm7829792eeh.11.2010.10.09.13.57.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 13:57:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
In-Reply-To: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
References: <e72a55b5f6ca2b805892fd6e214a4f72bf865124.1286657607.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158612>

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
