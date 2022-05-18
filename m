Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D29AC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiERXLS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiERXK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:10:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522ECB84E
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:10:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g3so3421944qtb.7
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bo+ivTzf0EDZiLZ3Ib1QjcIVdR0ks/eiqC5eD2VZ25s=;
        b=E6Rw8/t7R5BtzqMoiUEmVugcsoyAynCqct2oBxzuaVJoaMur+LCVjTdtI9tnW2lhCF
         KyBwwmKRxw75X69VGdKMBZeGZ/OWJrDajfqcr7aaEWTQQD+ZpOwgfrmES8bu/CRkH+qj
         RW7stUIztRUghCKbF6wsxtnV1htObm68uwFmkOFPPnez9ltP7l4IMt6m5fnT1ytrAxNB
         0MvTTrDVJqZPcd5AaLEWI6A0G7eZqElWX8i/djhZj/oA6gBSRO+e2oFzTj8gnG1bbjvy
         qRkw0/hkBKz+nEz68llU47tRA8iEUrynkwfrVxnzk6ab602Pchdad5dePHe836ayC0mB
         HwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bo+ivTzf0EDZiLZ3Ib1QjcIVdR0ks/eiqC5eD2VZ25s=;
        b=TrZNIjAxGL2pvElECXOasYBdhV06l0z3EdcR23UJ/5Bo6e8Mcmqt7PI1781cv1wyik
         WpkiQ+HbfEwuGV8hYA3OgWLmDvA1T+nIwGhdlvgqfyD6kpVniQpq995B3mJiDqxlfZfp
         glgaZyg9FN4SjxbynB3bndw0ELtNaYFL92XeTSRJ2KpQt3AmoaUXM+iJmpQZiKDEXtI8
         rLdk084fG475MLQxMsWuaMpFlebMhtoRsSWsT7Q75mSurw+o4N0t6WOFp+qH8yUUCo3Y
         c7kIXOump0LqtuDIkfktiFQhFfIRyDgH4WjlSEbKNEZ0KyQfz1WYCYoYVUDBjcWGLaBB
         A+mw==
X-Gm-Message-State: AOAM5334JpXS/s7rJkHI9ZjQSsZCyAx/z0MPaOaBlpk3NTtPoT3oIgE6
        wSSH11HCXFrgzSMSad4YMqeogWV40cBNaUMw
X-Google-Smtp-Source: ABdhPJwgSC+J+Nh64YCQ+rq2O9UVOSMDXSmRV9vcZ+wuT83KtuFz0TVNHNeKFXCxu2M+graNmc9HSA==
X-Received: by 2002:a05:622a:1a21:b0:2f1:f29e:40a with SMTP id f33-20020a05622a1a2100b002f1f29e040amr1840945qtb.235.1652915454308;
        Wed, 18 May 2022 16:10:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d198-20020a3768cf000000b0069fc13ce211sm349149qkc.66.2022.05.18.16.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:10:53 -0700 (PDT)
Date:   Wed, 18 May 2022 19:10:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 03/17] pack-write: pass 'struct packing_data' to
 'stage_tmp_packfiles'
Message-ID: <cdb21236e16ae72af5f234c0138cbd9ea725ab47.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1652915424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1652915424.git.me@ttaylorr.com>
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
index 014dcd4bc9..6ac927047c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1262,7 +1262,8 @@ static void write_pack_file(void)
 
 			stage_tmp_packfiles(&tmpname, pack_tmp_name,
 					    written_list, nr_written,
-					    &pack_idx_opts, hash, &idx_tmp_name);
+					    &to_pack, &pack_idx_opts, hash,
+					    &idx_tmp_name);
 
 			if (write_bitmap_index) {
 				size_t tmpname_len = tmpname.len;
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6d6c37171c..e988a388b6 100644
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
index 51812cb129..a2adc565f4 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -484,6 +484,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
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
2.36.1.94.gb0d54bedca

