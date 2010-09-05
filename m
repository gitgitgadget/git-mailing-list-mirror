From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 05/15] read_tree_recursive: Avoid missing blobs and trees in a sparse repository
Date: Sat,  4 Sep 2010 18:13:57 -0600
Message-ID: <1283645647-1891-6-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2re-0008IQ-Fo
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab0IEANJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57812 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0IEAND (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:03 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so971230pzk.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dkNUgkxgxdYkeMG1RqQ/nBxB373TVf39foxVqLBWaNo=;
        b=kNx3wjyzbOY1isL/ZUlzhxpvSqEwJ/J7Xo3CBNCeyEqmddkgUz4e4meTwr98xwA4Qf
         Yw3bxpLWGDVZiB9DgjBpTA9trKT2KuJ8yZ7MmooXoblgjCNytmLxnePzqySn+SO/dEtp
         fKvqqsIVjsei+9XcwtQzgzsCtOxIwhm2yzmx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OOu2pyUt0rTBJaTK62K9LPN9FYcBWc9YQyRpb5UxtczZoz7BZXbzf1x1cjNgHlCgNL
         n1fo5J+p/piNiOdZfukniLa4vtbWEZxCfrlD1ZgCSf2XXh3WNXTtKr7ME+2xqTghiBm6
         /UajYsdR8qf4gTAQd+nLRHrSrv15U+RNz3LiY=
Received: by 10.114.92.20 with SMTP id p20mr1405281wab.65.1283645583100;
        Sat, 04 Sep 2010 17:13:03 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.01
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155391>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5720-sparse-repository-basics.sh |    2 +-
 tree.c                              |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/t5720-sparse-repository-basics.sh b/t/t5720-sparse-repository-basics.sh
index b946c23..b11c5ab 100755
--- a/t/t5720-sparse-repository-basics.sh
+++ b/t/t5720-sparse-repository-basics.sh
@@ -81,7 +81,7 @@ known_objects=$(git $srcgit rev-list --objects master \
 		| cut -b -40)
 for i in $(git $srcgit rev-list HEAD | xargs git name-rev | cut -b 42-); do
 	git $srcgit ls-tree -rt $i | grep -F "$known_objects" >expect &&
-	test_expect_failure "plumbing: ls-tree -rt $i works" "
+	test_expect_success "plumbing: ls-tree -rt $i works" "
 		git ls-tree -rt $i 2>error >output &&
 		test_cmp output expect
 	"
diff --git a/tree.c b/tree.c
index 5ab90af..5f9e37a 100644
--- a/tree.c
+++ b/tree.c
@@ -119,6 +119,11 @@ int read_tree_recursive(struct tree *tree,
 		default:
 			return -1;
 		}
+
+		if (git_sparse_pathspecs &&
+		    sha1_object_info(entry.sha1, NULL) <= 0)
+			continue;
+
 		if (S_ISDIR(entry.mode)) {
 			int retval;
 			char *newbase;
-- 
1.7.2.2.140.gd06af
