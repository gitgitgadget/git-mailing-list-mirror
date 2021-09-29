Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F4C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C13C613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243657AbhI2B4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbhI2B4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:52 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25BCC061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:11 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k13so1109953ilo.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8/j7OCA5X6GA98KEGZELf+J6mt6aZqN/sCyf/uNXWng=;
        b=hg11mjPhW5JhKLForN3kDfkPEJFkrmebbucFIH5iA43gYaftSsBCa7rw1OFjiOlyVo
         aUxSWOcP0OY93T7VNay8wNPfnwZQ+MBwCgFhs/R0Qrpd6RREI5Ma/CbxUY1iwWLV2mpH
         YtooxHne1ZJiHpuxW+7enxKpiQv2kJqPKyqGafFNuxUtHe3SCfQquz28HpI1/hxvdf+b
         Qte3o3zPKmIf4cgRPqxWgP3k6OGhtWNTBhD6nJiStVTPKbDWCHRWdD17Lc/T2tx5Gf1e
         zftciUq14C5/UO1RGgRNhJClnKn/L1WcAeVoKBiTbq54NlzITx51MVFMq5yYQs6I5tSB
         KiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/j7OCA5X6GA98KEGZELf+J6mt6aZqN/sCyf/uNXWng=;
        b=5nN3ysxzHy2GDnvuHB5/fBMtbwT83y1K/sMXDQZQtrQSOnvTcMuVEl8X4HcWNFwAc5
         ktcz76fkfYuLvZ/OyjTPo+4S4j4evmWZPxwg4I5h8AnpnHAzZGyTC41zBvd2qx6QJmx8
         U2cs/Gu2naQ8tiHw3IMMAu5/8ZQR1RXB3KEah621aHwPbAA91V/rHh31XUO+f0gH786N
         wPvWy6Iw3Frx6zxu8TwYBSN2eH+xHhTMh7XMvijFchtuOImTfL28ueiifPRM4trsGdcj
         rJ+4jpce55jGuBPP/GA615VeQWBfHD8UgsViU+zf7XFgPO4BD56jMMIb1UkqQVBwduio
         skDA==
X-Gm-Message-State: AOAM532Jc0SlFVninaLvHd5qnXpgAbIP1UzFWxxAgYINHca9r2RD4j4u
        HdAO92jTVsDMM2de8bmoAAxGhr4W1shXVg==
X-Google-Smtp-Source: ABdhPJyGlkE7bYiCmiCRUaa0/Brz2pHSd+iUb5SeohMJNywPPrGIkmpxHdjsOBhvJJxI/J8SVaF0Rw==
X-Received: by 2002:a92:ca0b:: with SMTP id j11mr6517076ils.191.1632880511248;
        Tue, 28 Sep 2021 18:55:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x13sm473917ila.29.2021.09.28.18.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:55:10 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:55:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 4/9] builtin/repack.c: keep track of existing packs
 unconditionally
Message-ID: <1b3dd331cac3a94747838bfeb6be14c7c5a240ed.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
 <cover.1632880469.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1632880469.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be able to write a multi-pack index during repacking, `git
repack` must keep track of which packs it wants to write into the MIDX.
This set is the union of existing packs which will not be deleted,
new pack(s) generated as a result of the repack, and .keep packs.

Prior to this patch, `git repack` populated the list of existing packs
only when repacking all-into-one (i.e., with `-A` or `-a`), but we will
soon need to know this list when repacking when writing a MIDX without
a-i-o.

Populate the list of existing packs unconditionally, and guard removing
packs from that list only when repacking a-i-o.

Additionally, keep track of filenames of kept packs separately, since
this, too, will be used in an upcoming patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 56 +++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index dba83eede2..39f11df675 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -94,12 +94,14 @@ static void remove_pack_on_signal(int signo)
 }
 
 /*
- * Adds all packs hex strings to the fname list, which do not
- * have a corresponding .keep file. These packs are not to
- * be kept if we are going to pack everything into one file.
+ * Adds all packs hex strings to either fname_list or fname_kept_list
+ * based on whether each pack has a corresponding .keep file or not.
+ * Packs without a .keep file are not to be kept if we are going to
+ * pack everything into one file.
  */
-static void get_non_kept_pack_filenames(struct string_list *fname_list,
-					const struct string_list *extra_keep)
+static void collect_pack_filenames(struct string_list *fname_list,
+				   struct string_list *fname_kept_list,
+				   const struct string_list *extra_keep)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -112,21 +114,20 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 		size_t len;
 		int i;
 
+		if (!strip_suffix(e->d_name, ".pack", &len))
+			continue;
+
 		for (i = 0; i < extra_keep->nr; i++)
 			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
 				break;
-		if (extra_keep->nr > 0 && i < extra_keep->nr)
-			continue;
-
-		if (!strip_suffix(e->d_name, ".pack", &len))
-			continue;
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
-			string_list_append_nodup(fname_list, fname);
+		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
+		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
+			string_list_append_nodup(fname_kept_list, fname);
 		else
-			free(fname);
+			string_list_append_nodup(fname_list, fname);
 	}
 	closedir(dir);
 }
@@ -440,6 +441,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	int i, ext, ret;
@@ -572,9 +574,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
+	collect_pack_filenames(&existing_packs, &existing_kept_packs,
+			       &keep_pack_list);
+
 	if (pack_everything & ALL_INTO_ONE) {
-		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
-
 		repack_promisor_objects(&po_args, &names);
 
 		if (existing_packs.nr && delete_redundant) {
@@ -683,17 +686,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	reprepare_packed_git(the_repository);
 
 	if (delete_redundant) {
-		const int hexsz = the_hash_algo->hexsz;
 		int opts = 0;
-		string_list_sort(&names);
-		for_each_string_list_item(item, &existing_packs) {
-			char *sha1;
-			size_t len = strlen(item->string);
-			if (len < hexsz)
-				continue;
-			sha1 = item->string + len - hexsz;
-			if (!string_list_has_string(&names, sha1))
-				remove_redundant_pack(packdir, item->string);
+		if (pack_everything & ALL_INTO_ONE) {
+			const int hexsz = the_hash_algo->hexsz;
+			string_list_sort(&names);
+			for_each_string_list_item(item, &existing_packs) {
+				char *sha1;
+				size_t len = strlen(item->string);
+				if (len < hexsz)
+					continue;
+				sha1 = item->string + len - hexsz;
+				if (!string_list_has_string(&names, sha1))
+					remove_redundant_pack(packdir, item->string);
+			}
 		}
 
 		if (geometry) {
@@ -739,6 +744,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_packs, 0);
+	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
 	strbuf_release(&line);
 
-- 
2.33.0.96.g73915697e6

