Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1B641FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 22:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932697AbdCJWAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 17:00:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932482AbdCJWAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 17:00:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD31E60A06; Fri, 10 Mar 2017 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489183236;
        bh=NaMO7vuuBajodmyG8fFttbRbazWQF9tAGCM0momd/AU=;
        h=From:To:Cc:Subject:Date:From;
        b=Qn/kqqYsYN3B7kUUR4sZcRMIbGGS8tE+q3DYOq5Vlp+g1ZUD+bdMju89rznCdVfYm
         ZGbD8F/LN++iXvRmNcou0V4NuMg93ezdknXJ9sj1FnQJNaBfd+YUi9Oz2BVV8YOFav
         Mj8AZd6Txvnp595bnTQBF4ilvDIqKLTRI4LRY8p4=
Received: from jmelvin1-mac.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jmelvin@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F03060884;
        Fri, 10 Mar 2017 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1489183235;
        bh=NaMO7vuuBajodmyG8fFttbRbazWQF9tAGCM0momd/AU=;
        h=From:To:Cc:Subject:Date:From;
        b=LEuW4aOLtYz64QJt1zgrd5FrrpNqoTTTdo7EWTdm5hR1uIwRO59CkNiBZaJEQp0Mh
         wW6RjnZA49kXLZjaA5uxMrps0wDtePbFzUziWEvMIQnQWSnYjmLqdX2q3qI0TjkfUR
         /Vxhw/Pu2X5HSgIA2Mxnz8lXtWImhypNw7+lVNgk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F03060884
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jmelvin@codeaurora.org
From:   James Melvin <jmelvin@codeaurora.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nasserg@codeaurora.org, mfick@codeaurora.org,
        peff@peff.net, sbeller@google.com,
        James Melvin <jmelvin@codeaurora.org>
Subject: [PATCH v2] repack: Add option to preserve and prune old pack files
Date:   Fri, 10 Mar 2017 15:00:20 -0700
Message-Id: <20170310220020.2666-1-jmelvin@codeaurora.org>
X-Mailer: git-send-email 2.12.0.191.ga15447d9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new --preserve-and-prune option renames old pack files
instead of deleting them after repacking and prunes previously
preserved pack files.

This option is designed to prevent stale file handle exceptions
during git operations which can happen on users of NFS repos when
repacking is done on them. The strategy is to preserve old pack files
around until the next repack with the hopes that they will become
unreferenced by then and not cause any exceptions to running processes
when they are finally deleted (pruned).

Signed-off-by: James Melvin <jmelvin@codeaurora.org>
---
 Documentation/git-repack.txt |  4 +++
 builtin/repack.c             | 66 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 26afe6ed5..effd98a43 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -143,6 +143,10 @@ other objects in that pack they already have locally.
 	being removed. In addition, any unreachable loose objects will
 	be packed (and their loose counterparts removed).
 
+--preserve-and-prune::
+	 Preserve old pack files by renaming them instead of deleting. Prune any
+	 previously preserved pack files before preserving new ones.
+
 Configuration
 -------------
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 677bc7c81..78fad8f1a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -10,6 +10,7 @@
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
+static int preserve_and_prune;
 static int write_bitmaps;
 static char *packdir, *packtmp;
 
@@ -108,6 +109,60 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 	closedir(dir);
 }
 
+/*
+ * Adds all preserved packs hex strings to the fname list
+ */
+static void get_preserved_pack_filenames(struct string_list *fname_list)
+{
+	DIR *dir;
+	struct dirent *e;
+	char *fname;
+
+	if (!(dir = opendir(packdir)))
+		return;
+
+	while ((e = readdir(dir)) != NULL) {
+		size_t len;
+		if (!strip_suffix(e->d_name, ".old-pack", &len))
+			continue;
+
+		fname = xmemdupz(e->d_name, len);
+		string_list_append_nodup(fname_list, fname);
+	}
+	closedir(dir);
+}
+
+static void remove_preserved_packs(void) {
+	const char *exts[] = {"pack", "idx", "keep", "bitmap"};
+	int i;
+	struct string_list names = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	get_preserved_pack_filenames(&names);
+
+	for_each_string_list_item(item, &names) {
+		for (i = 0; i < ARRAY_SIZE(exts); i++) {
+			char *fname;
+			fname = mkpathdup("%s/%s.old-%s",
+					  packdir,
+					  item->string,
+					  exts[i]);
+			if (remove_path(fname))
+				warning(_("failed to remove '%s'"), fname);
+			free(fname);
+		}
+	}
+}
+
+static void preserve_pack(const char *file_path, const char *file_name,  const char *file_ext)
+{
+	char *fname_old;
+
+	fname_old = mkpathdup("%s/%s.old-%s", packdir, file_name, ++file_ext);
+	rename(file_path, fname_old);
+	free(fname_old);
+}
+
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap"};
@@ -121,7 +176,10 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_setlen(&buf, plen);
 		strbuf_addstr(&buf, exts[i]);
-		unlink(buf.buf);
+		if (preserve_and_prune)
+			preserve_pack(buf.buf, base_name, exts[i]);
+		else
+			unlink(buf.buf);
 	}
 	strbuf_release(&buf);
 }
@@ -194,6 +252,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_BOOL(0, "preserve-and-prune", &preserve_and_prune,
+				N_("preserve old pack files by renaming them instead of deleting, prune any "
+						"previously preserved pack files before preserving new ones")),
 		OPT_END()
 	};
 
@@ -404,6 +465,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	/* End of pack replacement. */
 
+	if (preserve_and_prune)
+		remove_preserved_packs();
+
 	if (delete_redundant) {
 		int opts = 0;
 		string_list_sort(&names);
-- 
2.12.0.191.ga15447d9f

