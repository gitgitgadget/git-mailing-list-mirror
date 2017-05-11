Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACB2201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756232AbdEKWEk (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:40 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34504 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdEKWEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:38 -0400
Received: by mail-pg0-f45.google.com with SMTP id u28so20780573pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJALVxUIusVtIYM7OHsgkbS+dqdt3mFusgxe8lqSPBo=;
        b=cbwYUMTBfcho/xuGGeyQ5TFDJK595a9/BDu5tqV0ipg7aG2DV54BDMJGF4UVb0C48J
         lyr+fp63hdCUAgYyJUvFFGi5NjYRO9/ADseArVpbg4bbIw149sma+S93flIFzrBawf5k
         nDADqDC0yluR7SoaPz3GyzTPZzFWzdPnpFS86tYMRgnp9iwA0Eb+5+5PSBdY5rgytYsv
         mdriaAtwHWOdn1Zv1dwM/E9sqVUAzkF0l7Vuhrx5E7o/32mPaw3n0XgkWyaFU1V3EOZI
         Rdk3hbmhBWU2cTyjRlOmdCayhBYyjOf0kHY3al+FdkiWfLQRuVYxKPXz47yi2aWhkBmF
         KxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJALVxUIusVtIYM7OHsgkbS+dqdt3mFusgxe8lqSPBo=;
        b=np8pm38KKKawemGrFY3S5lOEV1NjpI9sLi5T1gN59DZlKOSjTqSetdNqMVCMyeYyAh
         jSICBdDiPPBSXftvfvI+KQSZssjVdXUudbTX5Cfi5SLielRptWHd7BW1aIxvA70nezKI
         fpU93+4aubch38s3LfNQ8blcb1wxMfWsE5GeGZfxFkUiGZG9zFh0wRYDHnPf6KVeacOh
         ZJPcW0r+g0CFmVdvQvjfsC8MdX3SKYXFccLtrRi0iAlebXdRhXpZKDa8I9e0gqgoE4Xg
         FDiFsr29lzaljeq/CRDVQHl9bFD+x9AOLu6PbKjj5zAzvZcMamYcMwSrP3xirv/+l55z
         e02Q==
X-Gm-Message-State: AODbwcB7KFz8MIzGeoj39gvXti0Onq2imOSS7CazbQBmQC6Y7+ah0deQ
        IDkSYVX50Ld+HmpF
X-Received: by 10.99.137.194 with SMTP id v185mr715837pgd.206.1494540277325;
        Thu, 11 May 2017 15:04:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 4/6] ls-files: prevent prune_cache from overeagerly pruning submodules
Date:   Thu, 11 May 2017 15:04:25 -0700
Message-Id: <20170511220427.192627-5-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170511220427.192627-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170511220427.192627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since (ae8d08242 pathspec: pass directory indicator to
match_pathspec_item()) the path matching logic has been able to cope
with submodules without needing to strip off a trailing slash if a path
refers to a submodule.

ls-files is the only caller of 'parse_pathspec()' which relies on the
behavior of the PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag because it
uses the result to construct a common prefix of all provided pathspecs
which is then used to prune the index of all entries which don't have
that prefix.  Since submodules entries in the index don't have a
trailing slash 'prune_cache()' will be overeager and prune a submodule
'sub' if the common prefix is 'sub/'.  To correct this behavior, only
prune entries which don't match up to, but not including, a trailing
slash of the common prefix.

This is in preparation to remove the
PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP flag in a later patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a6c70dbe9..1f3d47844 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -97,7 +97,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len = max_prefix_len;
 
-	if (len >= ent->len)
+	if (len > ent->len)
 		die("git ls-files: internal error - directory entry not superset of prefix");
 
 	if (!dir_path_match(ent, &pathspec, len, ps_matched))
@@ -238,7 +238,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 		strbuf_addstr(&name, super_prefix);
 	strbuf_addstr(&name, ce->name);
 
-	if (len >= ce_namelen(ce))
+	if (len > ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
@@ -403,6 +403,25 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 	active_nr = last - pos;
 }
 
+static int get_common_prefix_len(const char *common_prefix)
+{
+	int common_prefix_len;
+
+	if (!common_prefix)
+		return 0;
+
+	common_prefix_len = strlen(common_prefix);
+
+	/*
+	 * If the prefix has a trailing slash, strip it so that submodules wont
+	 * be pruned from the index.
+	 */
+	if (common_prefix[common_prefix_len - 1] == '/')
+		common_prefix_len--;
+
+	return common_prefix_len;
+}
+
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -624,8 +643,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		    "--error-unmatch");
 
 	parse_pathspec(&pathspec, 0,
-		       PATHSPEC_PREFER_CWD |
-		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       PATHSPEC_PREFER_CWD,
 		       prefix, argv);
 
 	/*
@@ -637,7 +655,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		max_prefix = NULL;
 	else
 		max_prefix = common_prefix(&pathspec);
-	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
+	max_prefix_len = get_common_prefix_len(max_prefix);
+
+	prune_cache(max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -651,7 +671,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	      show_killed || show_modified || show_resolve_undo))
 		show_cached = 1;
 
-	prune_cache(max_prefix, max_prefix_len);
 	if (with_tree) {
 		/*
 		 * Basic sanity check; show-stages and show-unmerged
-- 
2.13.0.rc2.291.g57267f2277-goog

