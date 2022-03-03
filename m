Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4520EC433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiCCAVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiCCAVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:21:35 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F763E2346
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:20:51 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id f21so2723767qke.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1/TaS4hJ7uvqeQbRpqvGUZQGPog/DBrFRJeVMB1op0=;
        b=mGMmH2hSA8vMyG9F7VKuGZfthuajLZH5ziJLKLD/I2uXO4HoZAkb0jha6m6fn5lLk9
         tqZct680RgGiYURrdVqBoVVFVU1ZIx9XaXYu9Zmt2IWYlKg4GfefdSY2irH65SfM4PKt
         aIXgfHQd1kGgmskQP0Pia51MlhnV5asFCeEAy6hJASmQqdAMBlgbDgyu7ItbJSoQPxxV
         ixZd7AJF23ha3WnOTd8oWGiuX3eypADu65R4piJ62xwD6cFluGxd1unahmlkPH+HaUTK
         lyPSDnJPnMIuirE7HFnZU2o6IWhr6YKKyKjb9mHuQn9/aSaRB57+IXPxj7VzfhWwIRiS
         KTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1/TaS4hJ7uvqeQbRpqvGUZQGPog/DBrFRJeVMB1op0=;
        b=TJxluq5CuJ5ndVPwB8naKHPMMsoOUf+bZADkZ1X9Z5qt+Kml++JU2kj5Lw/e1fBXWn
         S7CxV+BwCFJ6VNDlCFwHOtk4+ddM9PlIx3m11kESjtu0AK8kGmDo//6v1Vkw9nxvkFCz
         iZjpN6bHoaEgvlRa/jifjIelpiXi1GcOx6SdZKdurHCmQEX0rfBYcceIEstOMDeW4E0h
         JAzJPsau76RvHMRio3rJuaqrMdSv2wOIoXJYWbrZCa2/abqGYNDfRWryFsX0YKKRvYg9
         83iOvUt1ITf1o8UMjFbfP1T/ZyAiCW/rHQ6R69kn+NkXjohAAmAuQWvHUuGDsBstrgZE
         zeoA==
X-Gm-Message-State: AOAM532EIyyfeUd4kLc33P77UOFCFaGsQC3+E6Sf6QWYFdnwX3Z+sqnP
        TWl8uMO5WprLQ4tBmZ7zGWQoDsr78jQS+TlZ
X-Google-Smtp-Source: ABdhPJzKcC6Zcw9qeAITJ51glTT1rrKEv162D54bOW0ei6jaSzSsOKI8AeawqzB2oQ3ZO0nJi8sOOw==
X-Received: by 2002:a37:648c:0:b0:5f1:9243:7b5d with SMTP id y134-20020a37648c000000b005f192437b5dmr17428623qkb.719.1646266850291;
        Wed, 02 Mar 2022 16:20:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm308184qkd.10.2022.03.02.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 16:20:49 -0800 (PST)
Date:   Wed, 2 Mar 2022 19:20:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v3 03/17] pack-write: pass 'struct packing_data' to
 'stage_tmp_packfiles'
Message-ID: <0f5d6d64924bcc1c81853ae246327338f7679a5e.1646266835.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1646266835.git.me@ttaylorr.com>
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

