Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65046C433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiF2SrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF2SrP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 14:47:15 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623373B2BC
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:47:14 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id p31so26200493qvp.5
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZpRxP2pxbt62zotQ3LBu7s+VpuUAnNiRCUQjgppAgFI=;
        b=uEiHBVNEjaHkkHl9GkHHEkw+YNbNXIU6rgT3F9FWlbLrWprQrja912cD+nn3WdIqVe
         ADFsK5Y60MQME0k/w3LrisQ9NhUUcD2RWwYSOvm4tb0V1MA21mMjm2AxeO0hEod0+4RU
         saIFAtfyE2t/GOdd4VCjWz1XM7Zei9GV11/rAMajftu0zzCjQGtkrooNOapu+VXvMJe6
         pNSz+njWWo8PaoaPh0/5fTsbVN2OyHxZwusQo53C86qDvnzBgZiqltsOq7gFIw5RtHRk
         KKYZJVd4xJhusfMxGbADD/ju3TQeGY4qHHjLvPXNWLIuwIhyRCYSCChVdI60WjEecx8A
         YWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZpRxP2pxbt62zotQ3LBu7s+VpuUAnNiRCUQjgppAgFI=;
        b=6HT5g9hAPM9OcpoP6WpmV9BbHMr27KYijA49q58opEG3PCQZGlI2FVewYBTGJE2zjZ
         G4ZroOZpHYKHgFiT0vYr0rUbqhOqXwLxQdgfGBWJp1g6O5vxWIdV7wcZi+R6SQaKr6oi
         hYB2y604Znt405Zm0RNHfu353hYeRifS7dLGNRwN5A4ntnTXTEAxW4AHIfqYmyT/DWVs
         WTyPUQvWWPtPjRDYtWDmJB4+tbpKp0Tlky9agCkfZyY4ASu2xaeSuJvYH81QMXYqhC6v
         sAhlLO8w8BiGe3/urNR8JqZVPfTAJbI22Nz7inUOKqYhthDOIuzntQoaQmZUO4xMoGOi
         YE4w==
X-Gm-Message-State: AJIora+rM9dC0GmDnJ7Ye4lxghx1F5Z37SPe0CMJy2wMq1yQm7PFHez6
        oea+BCwoVZ0dLzGD8ooXu3U+vLne3vwSOA==
X-Google-Smtp-Source: AGRyM1sQCvzFUmzca6DzzePxYzt0gK5K+yy8HmgOc/UyrXiFtOkx/2Ie/5chqZ7SMuvgRUKgHSIhgA==
X-Received: by 2002:a05:6214:202d:b0:470:3e7a:d183 with SMTP id 13-20020a056214202d00b004703e7ad183mr9169928qvf.4.1656528433321;
        Wed, 29 Jun 2022 11:47:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bz19-20020a05622a1e9300b0031bba2e05aesm4628597qtb.58.2022.06.29.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:47:13 -0700 (PDT)
Date:   Wed, 29 Jun 2022 14:47:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: [RFC PATCH 2/4] builtin/repack.c: pass "cruft_expiration" to
 `write_cruft_pack`
Message-ID: <d346b65a43ba4f4c0c76f9483243e5277b411b11.1656528415.git.me@ttaylorr.com>
References: <cover.1656528343.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1656528343.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`builtin/repack.c`'s `write_cruft_pack()` is used to generate the cruft
pack when `--cruft` is supplied. It uses a static variable
"cruft_expiration" which is filled in by option parsing.

A future patch will add an `--expire-to` option which allows `git
repack` to write a cruft pack containing the pruned objects out to a
separate repository. In order to implement this functionality, some
callers will have to pass a value for `cruft_expiration` different than
the one filled out by option parsing.

Prepare for this by teaching `write_cruft_pack` to take a
"cruft_expiration" parameter, instead of reading a single static
variable.

The (sole) existing caller of `write_cruft_pack()` will pass the value
for "cruft_expiration" filled in by option parsing, retaining existing
behavior. This means that we can make the variable local to
`cmd_repack()`, and eliminate the static declaration.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 025882a075..19e789d745 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -32,7 +32,6 @@ static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
-static char *cruft_expiration;
 
 static const char *const git_repack_usage[] = {
 	N_("git repack [<options>]"),
@@ -664,6 +663,7 @@ static int write_midx_included_packs(struct string_list *include,
 
 static int write_cruft_pack(const struct pack_objects_args *args,
 			    const char *pack_prefix,
+			    const char *cruft_expiration,
 			    struct string_list *names,
 			    struct string_list *existing_packs,
 			    struct string_list *existing_kept_packs)
@@ -747,6 +747,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct pack_objects_args cruft_po_args = {NULL};
 	int geometric_factor = 0;
 	int write_midx = 0;
+	const char *cruft_expiration = NULL;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -986,7 +987,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
 
-		ret = write_cruft_pack(&cruft_po_args, pack_prefix, &names,
+		ret = write_cruft_pack(&cruft_po_args, pack_prefix,
+				       cruft_expiration, &names,
 				       &existing_nonkept_packs,
 				       &existing_kept_packs);
 		if (ret)
-- 
2.37.0.1.g1379af2e9d

