From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Teach '--with-tree' option to check-attr
Date: Fri, 23 Sep 2011 03:25:29 -0400
Message-ID: <1316762729-11211-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 09:25:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R708m-00047I-JJ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 09:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193Ab1IWHZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 03:25:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41974 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1IWHZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 03:25:39 -0400
Received: by gxk6 with SMTP id 6so2506422gxk.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fvKKfShD84hs3PwOkqMfuZwAK7tBSQ4bOpH+09wbxD0=;
        b=LJ+4x5EvxrM1Y5xxNdsQULzSekDIg1p9DKVH99c/+At5wyB67Wm4aEr9iB1e3ZyyyF
         GyzGpbK3PyBSZqTAyxSWiIdAFluOY/R+vRWuArrM/xs4iT37yTCOnb+RgAtVzozWOINA
         voB5RZ+bW5W/YTIqw6IIBhrwrwlShq91xFXy0=
Received: by 10.236.185.4 with SMTP id t4mr19606181yhm.121.1316762738575;
        Fri, 23 Sep 2011 00:25:38 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id r30sm6834056yhj.20.2011.09.23.00.25.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 00:25:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.5.g12a2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181948>

Jakub Narebski writes:

> Nb. the ability to read gitattributes from given commit would be
> useful also for gitweb (the `encoding` gitattribute, etc.).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
2011/9/22 Jakub Narebski <jnareb@gmail.com>:

> Unfortunately it doesn't seem to be there mechanism to query about
> state of gitattributes at given commit.
>
> There is a slight problem from the UI point of view of git-check-attr,
> namely that there are _three_ pieces of information: a place to read
> .gitattributes from (working tree, index, commit), list of attributes
> to check (or --all) and list of files (list of paths). You can use
> "--" to separate _two_ pieces of information.
>
> Nb. the ability to read gitattributes from given commit would be
> useful also for gitweb (the `encoding` gitattribute, etc.).

How's this? Builds on top of js/check-attr-cached.

 Documentation/git-check-attr.txt |    4 ++++
 builtin/check-attr.c             |   33 ++++++++++++++++++++++++++++++++-
 t/t0003-attributes.sh            |    7 +++++++
 3 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 5abdbaa51c..06e5d95e0b 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -27,6 +27,10 @@ OPTIONS
 --cached::
 	Consider `.gitattributes` in the index only, ignoring the working tree.
 
+--with-tree=<tree-ish>::
+	Consider .gitattributes in <tree-ish> only, ignoring the working tree
+	and index.
+
 --stdin::
 	Read file names from stdin instead of from the command-line.
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index ded0d836d3..fe926d3c97 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -3,10 +3,13 @@
 #include "attr.h"
 #include "quote.h"
 #include "parse-options.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
 
 static int all_attrs;
 static int cached_attrs;
 static int stdin_paths;
+static const char *with_tree;
 static const char * const check_attr_usage[] = {
 "git check-attr [-a | --all | attr...] [--] pathname...",
 "git check-attr --stdin [-a | --all | attr...] < <list-of-paths>",
@@ -18,6 +21,7 @@ static int null_term_line;
 static const struct option check_attr_options[] = {
 	OPT_BOOLEAN('a', "all", &all_attrs, "report all attributes set on file"),
 	OPT_BOOLEAN(0,  "cached", &cached_attrs, "use .gitattributes only from the index"),
+	OPT_STRING(0,  "with-tree", &with_tree, "tree-ish", "use .gitattributes only from <tree-ish>"),
 	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
 		"input paths are terminated by a null character"),
@@ -101,8 +105,35 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		die("invalid cache");
 	}
 
-	if (cached_attrs)
+	if (cached_attrs && with_tree)
+		error_with_usage("Cannot use --cached and --with-tree together");
+
+	if (cached_attrs) {
 		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
+	} else if (with_tree) {
+		unsigned char sha1[20];
+		struct tree *tree;
+		struct unpack_trees_options opts;
+		struct tree_desc t;
+
+		if (get_sha1(with_tree, sha1))
+			die("Not a valid object name");
+
+		tree = parse_tree_indirect(sha1);
+		if (tree == NULL)
+			die("Not a tree object");
+
+		memset(&opts, 0, sizeof(opts));
+		opts.index_only = 1;
+		opts.head_idx = -1;
+		opts.src_index = &the_index;
+		opts.dst_index = &the_index;
+		opts.fn = oneway_merge;
+		init_tree_desc(&t, tree->buffer, tree->size);
+		if (unpack_trees(1, &t, &opts))
+			return -1;
+		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
+	}
 
 	doubledash = -1;
 	for (i = 0; doubledash < 0 && i < argc; i++) {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 46b0736b35..36ac3a02da 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -140,6 +140,7 @@ test_expect_success 'root subdir attribute test' '
 '
 
 test_expect_success 'setup bare' '
+	git commit -m ".gitattributes for testing --with-tree below" &&
 	git clone --bare . bare.git &&
 	cd bare.git
 '
@@ -163,6 +164,12 @@ test_expect_success 'bare repository: check that --cached honors index' '
 	test_cmp ../specified-all actual
 '
 
+test_expect_success 'bare repository: check --with-tree' '
+	git check-attr --with-tree=HEAD --stdin --all < ../stdin-all |
+		sort > actual &&
+	test_cmp ../specified-all actual
+'
+
 test_expect_success 'bare repository: test info/attributes' '
 	(
 		echo "f	test=f"
-- 
1.7.7.rc2.5.g12a2f
