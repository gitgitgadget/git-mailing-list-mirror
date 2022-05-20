Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F3C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiETTBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349739AbiETTBv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:01:51 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC05F14086C
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c1so7791928qkf.13
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xx33mqhEyxGWYB4pqWplKQqlTWmqNGKRwGcRa5vNGpk=;
        b=FC17A+EH5qTGQvEOy8vmaX0SWonvCjHXqIIU7vVjVoFagerkkgxebF6H/vBfTJr6bi
         YDoRYlbcFGHt6jJeaFfZht+3kyHt2nRxSiCcegRWi6aaW6taZCJlpAHPC27mA1ZgYhpw
         jHQidajiJLH1Z+RWFXP7fd3YYMZpOuiCm4srfch8EpCeSqu8aLMhtA7FCS6pFowd9kgT
         /4mXrXTdtwwPSgTMF6ZgzHWmYcBAw/WiBWTrIzthnTAd7zlLkWyMQadMW2tBFzqlgzop
         EnWmZgGvdaUAIpuphJh1f6zSyTCN51mvDTLNf975MXly2yzDLJBxRKAGOGl08ZWb4QhK
         se2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xx33mqhEyxGWYB4pqWplKQqlTWmqNGKRwGcRa5vNGpk=;
        b=c0UyFWvtfx9sJp/ANy38oKyufZ48+bTGXmTVKcrG6oe37fzLlX2BpFiVzSc2qmQjVe
         phQT3MkL79IRYi3RbCcMZJ56IklBrp1CjcXyJ1bQKouboNBw7mUJm6mfyTFxSEn+Nc9q
         BBmDJTmjkGReVBxesr6v/T+FpObj/U1Sx9UFq6mi+oZUB1jWQoEeRVCDmM9xb2OvrPcA
         Z38oMT8/hbPKWVtajciS+yHZvIoJLpipknTpq7OODgcNo+yXNVjZ2RdFgzh5okqffs88
         Hgud2SwHi6r0iNMKV6xO+uWLLBR1temg6WyyAI7WiYTheCYAUD/IsPaKyxuWeQYCJjkd
         FFlQ==
X-Gm-Message-State: AOAM5311YfOFCx7hatFFetzfCUgzYO3ICxD7OQX/xezIUrYcuPy4R9rb
        nXcoWLpnN54Q0kdlcB2oFCtEL6G5W+gCCsaJ
X-Google-Smtp-Source: ABdhPJwIzgm5jVE0nu/Vt1a3ByQ5urVa84+2ck3cmGRmrb953+7AYPNCtcVy8YIYSKJ70/urgo2lnw==
X-Received: by 2002:ae9:e896:0:b0:6a3:522c:af49 with SMTP id a144-20020ae9e896000000b006a3522caf49mr1955366qkg.37.1653073307131;
        Fri, 20 May 2022 12:01:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ey10-20020a05622a4c0a00b002f9052c265bsm157428qtb.48.2022.05.20.12.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:01:46 -0700 (PDT)
Date:   Fri, 20 May 2022 15:01:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
Subject: [PATCH 1/3] repack: respect --keep-pack with geometric repack
Message-ID: <035d1a40ce73c3a556367c992286d4e631d6f4ef.1653073280.git.me@ttaylorr.com>
References: <cover.1653073280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1653073280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'repack' to ignore packs named on the command line with the
'--keep-pack' option. Specifically, modify 'init_pack_geometry()' to treat
command line-kept packs the same way it treats packs with an on-disk '.keep'
file (that is, skip the pack and do not include it in the 'geometry'
structure).

Without this handling, a '--keep-pack' pack would be included in the
'geometry' structure. If the pack is *before* the geometry split line (with
at least one other pack and/or loose objects present), 'repack' assumes the
pack's contents are "rolled up" into another pack via 'pack-objects'.
However, because the internally-invoked 'pack-objects' properly excludes
'--keep-pack' objects, any new pack it creates will not contain the kept
objects. Finally, 'repack' deletes the '--keep-pack' as "redundant" (since
it assumes 'pack-objects' created a new pack with its contents), resulting
in possible object loss and repository corruption.

Add a test ensuring that '--keep-pack' packs are now appropriately handled.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Victoria Dye <vdye@github.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c            | 46 ++++++++++++++++++++++++++++---------
 t/t7703-repack-geometric.sh | 28 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d1a563d5b6..ea56e92ad5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -137,6 +137,8 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 			string_list_append_nodup(fname_nonkept_list, fname);
 	}
 	closedir(dir);
+
+	string_list_sort(fname_kept_list);
 }
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
@@ -332,17 +334,38 @@ static int geometry_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-static void init_pack_geometry(struct pack_geometry **geometry_p)
+static void init_pack_geometry(struct pack_geometry **geometry_p,
+			       struct string_list *existing_kept_packs)
 {
 	struct packed_git *p;
 	struct pack_geometry *geometry;
+	struct strbuf buf = STRBUF_INIT;
 
 	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
 	geometry = *geometry_p;
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
-		if (!pack_kept_objects && p->pack_keep)
-			continue;
+		if (!pack_kept_objects) {
+			/*
+			 * Any pack that has its pack_keep bit set will appear
+			 * in existing_kept_packs below, but this saves us from
+			 * doing a more expensive check.
+			 */
+			if (p->pack_keep)
+				continue;
+
+			/*
+			 * The pack may be kept via the --keep-pack option;
+			 * check 'existing_kept_packs' to determine whether to
+			 * ignore it.
+			 */
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+
+			if (string_list_has_string(existing_kept_packs, buf.buf))
+				continue;
+		}
 
 		ALLOC_GROW(geometry->pack,
 			   geometry->pack_nr + 1,
@@ -353,6 +376,7 @@ static void init_pack_geometry(struct pack_geometry **geometry_p)
 	}
 
 	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
+	strbuf_release(&buf);
 }
 
 static void split_pack_geometry(struct pack_geometry *geometry, int factor)
@@ -714,17 +738,20 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strbuf_release(&path);
 	}
 
+	packdir = mkpathdup("%s/pack", get_object_directory());
+	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
+	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
+
+	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
+			       &keep_pack_list);
+
 	if (geometric_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		init_pack_geometry(&geometry);
+		init_pack_geometry(&geometry, &existing_kept_packs);
 		split_pack_geometry(geometry, geometric_factor);
 	}
 
-	packdir = mkpathdup("%s/pack", get_object_directory());
-	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
-	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
-
 	sigchain_push_common(remove_pack_on_signal);
 
 	prepare_pack_objects(&cmd, &po_args);
@@ -764,9 +791,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
-	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
-			       &keep_pack_list);
-
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index bdbbcbf1ec..91bb2b37a8 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -180,6 +180,34 @@ test_expect_success '--geometric ignores kept packs' '
 	)
 '
 
+test_expect_success '--geometric ignores --keep-pack packs' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# Create two equal-sized packs
+		test_commit kept && # 3 objects
+		git repack -d &&
+		test_commit pack && # 3 objects
+		git repack -d &&
+
+		find $objdir/pack -type f -name "*.pack" | sort >packs.before &&
+		git repack --geometric 2 -dm \
+			--keep-pack="$(basename "$(head -n 1 packs.before)")" >out &&
+		find $objdir/pack -type f -name "*.pack" | sort >packs.after &&
+
+		# Packs should not have changed (only one non-kept pack, no
+		# loose objects), but $midx should now exist.
+		grep "Nothing new to pack" out &&
+		test_path_is_file $midx &&
+
+		test_cmp packs.before packs.after &&
+
+		git fsck
+	)
+'
+
 test_expect_success '--geometric chooses largest MIDX preferred pack' '
 	git init geometric &&
 	test_when_finished "rm -fr geometric" &&
-- 
2.36.1.94.gb0d54bedca

