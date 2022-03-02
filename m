Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A29C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiCBA6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiCBA6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:58:50 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED13ED35
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id d19so139786ioc.8
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1/TaS4hJ7uvqeQbRpqvGUZQGPog/DBrFRJeVMB1op0=;
        b=UN/NHbhY39ubb8pdoJyrtcQ2cjYWwxJoQQBtPEChAEFyr3mxrsoS4SCA+LssjpwP9x
         xCaLTZ9Yp/xTW/Jm8GZqMdtt6kuFQ/UKk6HWTQodTOwcKN0MGIJN4+46k2V3jUI9925s
         1DyMypzcieWrwvF7sbtGiqOSPrHXEZSza7EfRNz+kNTAcck/7DL/ArOMUu8/KXq5Q3e3
         bkmkA9KYRRqTOTnmTEb2OcPUZl3f5s2qr0Ks6qhx+0dm8n4Do80bECKrwc1ICktkP+7l
         t13KQxsBsWeH4EaRvK9nTyxArxwLUb8Rep9QXRGOKkaNW3L3epjjIr0ekUXCN0I/rHaq
         B3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1/TaS4hJ7uvqeQbRpqvGUZQGPog/DBrFRJeVMB1op0=;
        b=3QG4E3Q8IGyrv6pH9NLeQNAAsEXNzfgaZENRk2Q6TwV21LdxM14GlncoL6Np3vQdsf
         +DefvcQGrZK9N8oM+OtIE134F3/q/meFjvDfEwDlDZHAMdX/5PYvbELuK7pFvZ+VcytY
         2vxLbvJarsDN6KJbncIOVb9OtfhgGXqzTrnXr4Xz0ijMU5MovR9hkKyk5SVaszZ+oatu
         CmKJL07eAvr0WDmBmlvP8fnbM5k5gJvDEkJOFGvVANExOhljjBFWTLrQ09E8EjxsGSWW
         GzRBDXZQBsE389S6SM/rB6O0SaL8kjrs54uqks2AkIYR83nns0/JYcGWSXkPAsiVs3WE
         JAAg==
X-Gm-Message-State: AOAM533Eass/bq7HOckZkXu6YWSLxTTXy43qF2tQwRXhGn+ITdgsOoyW
        zYDyTRZdvx6Sbg/c33MD2tmWFGo2bLJJPj3E
X-Google-Smtp-Source: ABdhPJxV+cQJhG4SANdEUiax5E2TtVeYY8EJSd25NpquC38rio2j3KvHIoy3ZkoYhkbcrJUpr4SWVg==
X-Received: by 2002:a02:271d:0:b0:307:ea12:ff8b with SMTP id g29-20020a02271d000000b00307ea12ff8bmr24261600jaa.274.1646182686231;
        Tue, 01 Mar 2022 16:58:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e23-20020a6b5017000000b00635b8032d45sm7918049iob.22.2022.03.01.16.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:58:05 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:58:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 03/17] pack-write: pass 'struct packing_data' to
 'stage_tmp_packfiles'
Message-ID: <a94d7dfeb3fb847c3ad10e5b227344c5980defeb.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This structure will be used to communicate the per-object mtimes when
writing a cruft pack. Here, we need the full packing_data structure
because the mtime information is stored in an array there, not on the
individual object_entry's themselves (to avoid paying the overhead in
structure width for operations which do not generate a cruft pack).

We haven't passed this information down before because one of the two
callers (in bulk-checkin.c) does not have a packing_data structure at
all. In that case (where no cruft pack will be generated), NULL is
passed instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 3 ++-
 bulk-checkin.c         | 2 +-
 pack-write.c           | 1 +
 pack.h                 | 3 +++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 178e611f09..385970cb7b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1254,7 +1254,8 @@ static void write_pack_file(void)
 
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, hash, &idx_tmp_name);
+					    &to_pack, &pack_idx_opts, hash,
+					    &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8785b2ac80..99f7596c4e 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -33,7 +33,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 	char *idx_tmp_name = NULL;
 
 	stage_tmp_packfiles(basename, pack_tmp_name, written_list, nr_written,
-			    pack_idx_opts, hash, &idx_tmp_name);
+			    NULL, pack_idx_opts, hash, &idx_tmp_name);
 	rename_tmp_packfile_idx(basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
diff --git a/pack-write.c b/pack-write.c
index a5846f3a34..d594e3008e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -483,6 +483,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
+			 struct packing_data *to_pack,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name)
diff --git a/pack.h b/pack.h
index b22bfc4a18..fd27cfdfd7 100644
--- a/pack.h
+++ b/pack.h
@@ -109,11 +109,14 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 #define PH_ERROR_PROTOCOL	(-3)
 int read_pack_header(int fd, struct pack_header *);
 
+struct packing_data;
+
 struct hashfile *create_tmp_packfile(char **pack_tmp_name);
 void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 const char *pack_tmp_name,
 			 struct pack_idx_entry **written_list,
 			 uint32_t nr_written,
+			 struct packing_data *to_pack,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name);
-- 
2.35.1.73.gccc5557600

