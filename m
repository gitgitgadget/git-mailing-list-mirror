Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D099C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 14:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjHKOWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbjHKOWw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 10:22:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278171994
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5657a28f920so338919a12.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691763771; x=1692368571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6XCOps560VIDBWJOSArm5fzckKfi48lDwWiMBh4Dh4=;
        b=ikM7XBQLBw86JNa8XmNg4f+53Q85wcSGfM/xn+ychdmEhLMjdn5cY4Qm25VRa6kAnG
         N+YK9yhAiktiLsVdX5MZqfD5ao0SvOstxDuVixL1wyPzZzx8+iU92Nm97rvxdWtxbJsR
         Sx5HQZUyd/8mQpw6fQDsyu/lIXVzlcF/GBuGBurVqNGWQPjTvT5wG08QZqzf2MuEPV1f
         2MPmmsSaXvw/LU1H5Gq+pYs6ab+M2gUfN3RE7HzyYS5pkZWGcuQEOavYEhmHdurK4NPV
         OJMJ2LGUNHemo6o6bOpN22iGfBz9bsmisR4tz5sEb+5KKjXUU8nMZtVcR+qrjj8iHo62
         tCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691763771; x=1692368571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6XCOps560VIDBWJOSArm5fzckKfi48lDwWiMBh4Dh4=;
        b=V2SHYIf/NuaFHy4S152A+zmxc39DbsS8mlxvW4eY2bkYuWEX5JCq92L8b4GuEIIG5/
         FzqySWxwg29WdsdJiwygEnyqOWnJDkYqOghhjomAI20b/IIrGaNSNCKDIE8AbC8k5950
         zrvwbKpiTQHWYZ4b+Z6zKX/c5nP0RL8fcWQ0PyFfgh2TlGniy4XyFHGhGY4KcH0Qq4uN
         VCrruYa8M2ngwofsmPtB3bxi6EQX0NSyGhSvpAWMzhB4x2oagmfBOMByYZT7vksoctTg
         5LVMd3ffgrVWB+MM3UAZcZU+jewJPO3RVJz+A5eOQeXSlcDi8UNXpqLKKuVnMYuwVndH
         ss8A==
X-Gm-Message-State: AOJu0YwvLIqGMDkBAW0AXnqjcenTnwxOKUtFcc8Cqy7LybZvtP/oyuiY
        bxSTRFQ9O8CWEmcJNgJt78gFVn3JtqtNxzKq
X-Google-Smtp-Source: AGHT+IFhVa8T7iJnpJTxtgVLnjqqGIr0/cXYZQSOXR6tqdi/nnz/jLFPOMSsyu8vk0A6eFwM44+aWQ==
X-Received: by 2002:a17:90a:e409:b0:268:1e95:4e25 with SMTP id hv9-20020a17090ae40900b002681e954e25mr1348963pjb.17.1691763771271;
        Fri, 11 Aug 2023 07:22:51 -0700 (PDT)
Received: from cheska.. ([120.231.214.68])
        by smtp.googlemail.com with ESMTPSA id p2-20020a17090a284200b00264044cca0fsm10000329pjf.1.2023.08.11.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 07:22:50 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com
Subject: [PATCH v5 2/3] attr.c: read attributes in a sparse directory
Date:   Fri, 11 Aug 2023 10:22:10 -0400
Message-Id: <20230811142211.4547-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230811142211.4547-1-cheskaqiqi@gmail.com>
References: <20230718232916.31660-1-cheskaqiqi@gmail.com>
 <20230811142211.4547-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, git check-attr was unable to read the attributes from
a .gitattributes file within a sparse directory. The original comment
was operating under the assumption that users are only interested in
files or directories inside the cones. Therefore, in the original code,
in the case of a cone-mode sparse-checkout, we didn't load the
.gitattributes file.

However, this behavior can lead to missing attributes for files inside
sparse directories, causing inconsistencies in file handling.

To resolve this, revise 'git check-attr' to allow attribute reading for
files in sparse directories from the corresponding .gitattributes files:

1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
to check if a path falls within a sparse directory.

2.If path is inside a sparse directory, employ the value of
index_name_pos_sparse() to find the sparse directory containing path and
path relative to sparse directory. Proceed to read attributes from the
tree OID of the sparse directory using read_attr_from_blob().

3.If path is not inside a sparse directory，ensure that attributes are
fetched from the index blob with read_blob_data_from_index().

Change the test 'check-attr with pathspec outside sparse definition' to
'test_expect_success' to reflect that the attributes inside a sparse
directory can now be read. Ensure that the sparse index case works
correctly for git check-attr to illustrate the successful handling of
attributes within sparse directories.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 attr.c                                   | 57 ++++++++++++++++--------
 t/t1092-sparse-checkout-compatibility.sh | 10 ++++-
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/attr.c b/attr.c
index 7d39ac4a29..1d34e48ea2 100644
--- a/attr.c
+++ b/attr.c
@@ -808,35 +808,56 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
 static struct attr_stack *read_attr_from_index(struct index_state *istate,
 					       const char *path, unsigned flags)
 {
+	struct attr_stack *stack = NULL;
 	char *buf;
 	unsigned long size;
+	int sparse_dir_pos = -1;
 
 	if (!istate)
 		return NULL;
 
 	/*
-	 * The .gitattributes file only applies to files within its
-	 * parent directory. In the case of cone-mode sparse-checkout,
-	 * the .gitattributes file is sparse if and only if all paths
-	 * within that directory are also sparse. Thus, don't load the
-	 * .gitattributes file since it will not matter.
-	 *
-	 * In the case of a sparse index, it is critical that we don't go
-	 * looking for a .gitattributes file, as doing so would cause the
-	 * index to expand.
+	 * When handling sparse-checkouts, .gitattributes files
+	 * may reside within a sparse directory. We distinguish
+	 * whether a path exists directly in the index or not by
+	 * evaluating if 'pos' is negative.
+	 * If 'pos' is negative, the path is not directly present
+	 * in the index and is likely within a sparse directory.
+	 * For paths not in the index, The absolute value of 'pos'
+	 * minus 1 gives us the position where the path would be
+	 * inserted in lexicographic order within the index.
+	 * We then subtract another 1 from this value
+	 * (sparse_dir_pos = -pos - 2) to find the position of the
+	 * last index entry which is lexicographically smaller than
+	 * the path. This would be the sparse directory containing
+	 * the path. By identifying the sparse directory containing
+	 * the path, we can correctly read the attributes specified
+	 * in the .gitattributes file from the tree object of the
+	 * sparse directory.
 	 */
-	if (!path_in_cone_mode_sparse_checkout(path, istate))
-		return NULL;
+	if (!path_in_cone_mode_sparse_checkout(path, istate)) {
+		int pos = index_name_pos_sparse(istate, path, strlen(path));
 
-	buf = read_blob_data_from_index(istate, path, &size);
-	if (!buf)
-		return NULL;
-	if (size >= ATTR_MAX_FILE_SIZE) {
-		warning(_("ignoring overly large gitattributes blob '%s'"), path);
-		return NULL;
+		if (pos < 0)
+			sparse_dir_pos = -pos - 2;
 	}
 
-	return read_attr_from_buf(buf, path, flags);
+	if (sparse_dir_pos >= 0 &&
+	    S_ISSPARSEDIR(istate->cache[sparse_dir_pos]->ce_mode) &&
+	    !strncmp(istate->cache[sparse_dir_pos]->name, path, ce_namelen(istate->cache[sparse_dir_pos]))) {
+		const char *relative_path = path + ce_namelen(istate->cache[sparse_dir_pos]);
+		stack = read_attr_from_blob(istate, &istate->cache[sparse_dir_pos]->oid, relative_path, flags);
+	} else {
+		buf = read_blob_data_from_index(istate, path, &size);
+		if (!buf)
+			return NULL;
+		if (size >= ATTR_MAX_FILE_SIZE) {
+			warning(_("ignoring overly large gitattributes blob '%s'"), path);
+			return NULL;
+		}
+		stack = read_attr_from_buf(buf, path, flags);
+	}
+	return stack;
 }
 
 static struct attr_stack *read_attr(struct index_state *istate,
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2d7fa65d81..dc84b3e2e1 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2271,7 +2271,7 @@ test_expect_success 'check-attr with pathspec inside sparse definition' '
 	test_all_match git check-attr -a --cached -- deep/a
 '
 
-test_expect_failure 'check-attr with pathspec outside sparse definition' '
+test_expect_success 'check-attr with pathspec outside sparse definition' '
 	init_repos &&
 
 	echo "a -crlf myAttr" >>.gitattributes &&
@@ -2288,6 +2288,14 @@ test_expect_failure 'check-attr with pathspec outside sparse definition' '
 	test_all_match git check-attr -a --cached -- folder1/a
 '
 
+# NEEDSWORK: The 'diff --check' test is left as 'test_expect_failure' due
+# to an underlying issue in oneway_diff() within diff-lib.c.
+# 'do_oneway_diff()' is not called as expected for paths that could match
+# inside of a sparse directory. Specifically, the 'ce_path_match()' function
+# fails to recognize files inside a sparse directory (e.g., when 'folder1/'
+# is a sparse directory, 'folder1/a' cannot be recognized). The goal is to
+# proceed with 'do_oneway_diff()' if the pathspec could match inside of a
+# sparse directory.
 test_expect_failure 'diff --check with pathspec outside sparse definition' '
 	init_repos &&
 
-- 
2.39.0

