From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH v3 03/12] pretty_tree: globalize and respect -i/-w options
Date: Wed, 20 Oct 2010 22:17:48 +0200
Message-ID: <b00fdc4e3060b7cf9f1ed25caff16799df09e414.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
 <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:18:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8f78-00051g-UD
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab0JTUST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:18:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52724 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab0JTUSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:18:18 -0400
Received: by gwaa12 with SMTP id a12so42351gwa.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Ae5/Z3IUnlaQkHpHC28ysst/g57FLsaA+04zEd+NOLg=;
        b=Bi97wkBTHnpGShjSu5+BdoxZBb6aUjf5yBA5c15GA+z4xW2QS1SLhguMRnV3jMZpCf
         05TtIktYrck2ZrYBGP+huqkTB1b5sOBt0KTysWU+nXxkf8k0++BC06EqYPTK+oarNE0O
         667e0nfMKghnwFQQUxosSJRsn6TJdVKe+488A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VXTikX4TjuKbzTW9eljfKxNyXd6U733uM+y28p6sYR4Q4FooNTWY8ZEcZQLVNRlNhq
         AXz6GTpbdizQ0r5X9vsiV0GDzDrnkSucHbHhi/qjvkskTx7sPKFJCIrV1QlO9W/U5uod
         1CzV/LDJ+zKnf/VIKCsjdtNs1QY+AnqCQf2jo=
Received: by 10.103.213.11 with SMTP id p11mr6379446muq.98.1287605897422;
        Wed, 20 Oct 2010 13:18:17 -0700 (PDT)
Received: from localhost (drsd-4db3cc42.pool.mediaWays.net [77.179.204.66])
        by mx.google.com with ESMTPS id s18sm406778fax.10.2010.10.20.13.18.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:18:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.1069.g89486
In-Reply-To: <38d2d7e3ba54cea256bc111f50bcb8d35e7d520d.1287605587.git.bert.wesarg@googlemail.com>
In-Reply-To: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
References: <52df5d1de969f474d93c4dce320edc657bb866dc.1287605587.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159427>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-export.sh |   13 ++-----------
 tg.sh        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 921e933..486ec94 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -62,15 +62,6 @@ playground="$(get_temp tg-export -d)"
 
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
@@ -111,7 +102,7 @@ collapsed_commit()
 			echo "TopGit-driven merge of branches:"
 			echo
 			cut -f 2 "$playground/$name^parents"
-		} | git commit-tree "$(pretty_tree "refs/top-bases/$name")" \
+		} | git commit-tree "$(pretty_tree "$name" -b)" \
 			$(for p in $parent; do echo -p $p; done))"
 	fi
 
@@ -226,7 +217,7 @@ linearize()
 	else
 		retmerge=0;
 
-		git merge-recursive "$(pretty_tree "refs/top-bases/$_dep")" -- HEAD "$(pretty_tree "refs/heads/$_dep")" || retmerge="$?";
+		git merge-recursive "$(pretty_tree "$_dep" -b)" -- HEAD "$(pretty_tree "refs/heads/$_dep")" || retmerge="$?";
 
 		if test "x$retmerge" != "x0"; then
 			git rerere;
diff --git a/tg.sh b/tg.sh
index 650ee59..81cbf7d 100644
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
1.7.3.1.1069.g89486
