Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EEFC433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC08561183
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 03:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJUDm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 23:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhJUDmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 23:42:22 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9D4C06176E
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p142so598313iod.0
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 20:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s2ibN6+1k6rVkvuEOds43rdcysScrKXebfEmK8hXZJA=;
        b=5Vw1m71+3zCUlcupWUYtKVEItf2oGdaZIi19KiEkv64vIgPALma/CVPA6HGVwjpSYx
         TFRYZl117gC77Jr4nXt8koxIwDdmBB2iysjrdI5qXPvQbABYoig4A/E/gXf655Q2gKWD
         a3Dxdpp8i6o/dSmIIcbFUdsZjGe4xkf1F0i+/cJ4RRO3KtBJx4rYs6ADLCYTguVf9cyz
         VeaJzVwF4okwXtoSLsWm+fupH7H2ONmdXe+m3lmveTHJUHrsBKyvMjfTckJxNB9/hab0
         CSvu0vjBE7RbOS8CNdd29y4KUi9Fmye3H/PdW5O+z1XknBLKzJ+O/RwSuVRol41gcKug
         NeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2ibN6+1k6rVkvuEOds43rdcysScrKXebfEmK8hXZJA=;
        b=QWzfTRUaa3kdxsTSA4DIn0L6wv14AnWa2+01ImpQYYGGnn2KUp5k9qIT32C83fiz3E
         Jc1E7OWCN502cFEYSXX4d2RHSEf0EM3wxdoVTXmV6oFrYaULb8DfwHyEk15rw83rxcgn
         mDfiNkJapKomIn5rG+Aw5K0ihP4OYxPqYFOdCIHilYeoc6/wNukQ8OiYdB6NLSCn1rNn
         KCgtZeeBvu125HnNWdG2h7caZGh3Q+xLF3mepXUSwePFWxhOwK4Z2LmWFN2W1rEnAQcw
         SZcinZpdVSHgI+Yw694QktlUwFrvij89aZY2Jk5uEZu5ZjQW81A5kFa94qUICHi0ngJn
         h9Qg==
X-Gm-Message-State: AOAM533u+Pq16V3x/B1g1CJ6SxPsSNPf3QmsWGU/nO2EJKOaTnluVuU2
        f7okIxWxXsYiDgNni2/Kc9uARTG1n1RXkA==
X-Google-Smtp-Source: ABdhPJx3RoEiGCIluy/6ysrsBgUOOm//Qxv1jKkE6BPNa5KzCHGRCefY2Sq+MdVTsWSy55gaH+3RCw==
X-Received: by 2002:a5d:8f8e:: with SMTP id l14mr2317837iol.124.1634787598735;
        Wed, 20 Oct 2021 20:39:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c5sm2005069ilq.71.2021.10.20.20.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 20:39:58 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:39:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 05/11] builtin/repack.c: avoid leaking child arguments
Message-ID: <a68c77c00638bef7e8ce88929015a587d2d1b6f8.1634787555.git.me@ttaylorr.com>
References: <cover.1634787555.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1634787555.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git repack` invokes a handful of child processes: one to write the
actual pack, and optionally ones to repack promisor objects and update
the MIDX.

In none of these cases do we bother to call child_process_clear(), which
frees the memory associated with each child's arguments and environment.

In order to do so, tweak each function that spawns a child process to
have a `cleanup` label that we always visit before returning from each
function. Then, make sure that we call child_process_clear() as a part
of that label.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82..d16bab09a4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -244,6 +244,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
+	int ret = 0;
 
 	prepare_pack_objects(&cmd, args);
 	cmd.in = -1;
@@ -260,7 +261,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 
 	if (cmd.in == -1)
 		/* No packed objects; cmd was never started */
-		return;
+		goto cleanup;
 
 	close(cmd.in);
 
@@ -293,7 +294,12 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 		free(promisor_name);
 	}
 	fclose(out);
-	if (finish_command(&cmd))
+	ret = finish_command(&cmd);
+
+cleanup:
+	child_process_clear(&cmd);
+
+	if (ret)
 		die(_("could not finish pack-objects to repack promisor objects"));
 }
 
@@ -559,10 +565,10 @@ static int write_midx_included_packs(struct string_list *include,
 	struct string_list_item *item;
 	struct packed_git *largest = get_largest_active_pack(geometry);
 	FILE *in;
-	int ret;
+	int ret = 0;
 
 	if (!include->nr)
-		return 0;
+		goto cleanup;
 
 	cmd.in = -1;
 	cmd.git_cmd = 1;
@@ -587,14 +593,19 @@ static int write_midx_included_packs(struct string_list *include,
 
 	ret = start_command(&cmd);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	in = xfdopen(cmd.in, "w");
 	for_each_string_list_item(item, include)
 		fprintf(in, "%s\n", item->string);
 	fclose(in);
 
-	return finish_command(&cmd);
+	ret = finish_command(&cmd);
+
+cleanup:
+	child_process_clear(&cmd);
+
+	return ret;
 }
 
 int cmd_repack(int argc, const char **argv, const char *prefix)
@@ -608,7 +619,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
-	int i, ext, ret;
+	int i, ext, ret = 0;
 	FILE *out;
 	int show_progress = isatty(2);
 
@@ -794,7 +805,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (geometry) {
 		FILE *in = xfdopen(cmd.in, "w");
@@ -819,7 +830,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (!names.nr && !po_args.quiet)
 		printf_ln(_("Nothing new to pack."));
@@ -893,7 +904,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		string_list_clear(&include, 0);
 
 		if (ret)
-			return ret;
+			goto cleanup;
 	}
 
 	reprepare_packed_git(the_repository);
@@ -946,12 +957,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		write_midx_file(get_object_directory(), NULL, NULL, flags);
 	}
 
+cleanup:
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
 	strbuf_release(&line);
+	child_process_clear(&cmd);
 
-	return 0;
+	return ret;
 }
-- 
2.33.0.96.g73915697e6

