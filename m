Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oLw4lSe3"
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66322C3
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:07:59 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77dc2981a58so44404585a.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198478; x=1701803278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cLCn8orZeq2NVlYlW/PfjjK2vcYVaNJmJlwkuyMQ2E=;
        b=oLw4lSe398J0+lsbK21HXksWlxjFZQW+N3A1psgSgcEP7F/o/W1IHIz8sUwfZnQgbD
         zNgjJKzC4FNfWUJUYK0w2oO+QSqaS3sS9ksKykES37mWYChlXrLz8xnv0mIdPrBFs2pm
         ey0XNQLHwfcOHKz7Ai1aQpGsFk5IZ8OdddKJRiIxGKnAYfD6vnGK18supxZ/cG5BhGZq
         42d+EmAr8xBCR1aMo/2+86mqR2LU4zyiFEbNHJWPuX76hzX2Ag5AFz5ZZMSEb/3JWFpU
         JMrXxckjS/j2zsV0FtFUwMqGbrGwHAOMtNN7xSZyq2cdctBMv0aqrl+vYLF8pkmwQQT9
         LNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198478; x=1701803278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cLCn8orZeq2NVlYlW/PfjjK2vcYVaNJmJlwkuyMQ2E=;
        b=fC6l80zx3mML+vr0WfEfIQnVprl5Zh/nzdsOZWl/gz4sGMF2hgUMaWUiL8kEKvm0lO
         cwZ0ROEqYqvy+kV5BQw8GlHPR7GWEocqYKZjuMr0R5f57sTPSXyJi221qSFvifOozblT
         dc7wBYUB1iqsX/CbgaXwKeZJH9cdEW16OLDHK/8J9aZF1a9nraTEJ9BMuB7E0YQLhYfB
         yzlVE1knjHkWcVR+RakuEqKD1gIl6uZPOmo1HKXyVKrRDPG28XwIB0F4OKCkTpLlXYcE
         6uutlpytKev/q381XNQMg8ixJxlolAUJAzyZUBuwxmkQ7JcOXtL5lVnPDhX/s97O5siN
         rMjQ==
X-Gm-Message-State: AOJu0YyeowU7DebJA7AmikDsvDI0ceVGmkYnhimniT4bqg2jhc45Z4jc
	cqdkqyxfy3y9a0eMd6keG/3MTTdk4ImKHiokUDI=
X-Google-Smtp-Source: AGHT+IFsIUgoqu/MdVf+vgPy5KGKoUi/qMcn8Av/EbyCuwEX6ITZ3JnwYl/DbUi5qu5u9o1b9OV9Xw==
X-Received: by 2002:a05:620a:674b:b0:77d:756d:34cc with SMTP id rq11-20020a05620a674b00b0077d756d34ccmr15187797qkn.20.1701198478280;
        Tue, 28 Nov 2023 11:07:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ea11-20020a05620a488b00b0077d93c7c785sm3026312qkb.119.2023.11.28.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:07:58 -0800 (PST)
Date: Tue, 28 Nov 2023 14:07:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/24] pack-objects: free packing_data in more places
Message-ID: <101d6a2841a909aa9c99225ebf1b65695cf116cb.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

The pack-objects internals use a packing_data struct to track what
objects are part of the pack(s) being formed.

Since these structures contain allocated fields, failing to
appropriately free() them results in a leak. Plug that leak by
introducing a free_packing_data() function, and call it in the
appropriate spots.

This is a fairly straightforward leak to plug, since none of the callers
expect to read any values or have any references to parts of the address
space being freed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  1 +
 midx.c                 |  5 +++++
 pack-objects.c         | 15 +++++++++++++++
 pack-objects.h         |  1 +
 4 files changed, 22 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 89a8b5a976..bfa60359d4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4522,6 +4522,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			   reuse_packfile_objects);
 
 cleanup:
+	free_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
 	strvec_clear(&rp);
 
diff --git a/midx.c b/midx.c
index 2f3863c936..3b727dc633 100644
--- a/midx.c
+++ b/midx.c
@@ -1592,8 +1592,13 @@ static int write_midx_internal(const char *object_dir,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
 			result = 1;
+			free_packing_data(&pdata);
+			free(commits);
 			goto cleanup;
 		}
+
+		free_packing_data(&pdata);
+		free(commits);
 	}
 	/*
 	 * NOTE: Do not use ctx.entries beyond this point, since it might
diff --git a/pack-objects.c b/pack-objects.c
index f403ca6986..1c7bedcc94 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -151,6 +151,21 @@ void prepare_packing_data(struct repository *r, struct packing_data *pdata)
 	init_recursive_mutex(&pdata->odb_lock);
 }
 
+void free_packing_data(struct packing_data *pdata)
+{
+	if (!pdata)
+		return;
+
+	free(pdata->cruft_mtime);
+	free(pdata->in_pack);
+	free(pdata->in_pack_by_idx);
+	free(pdata->in_pack_pos);
+	free(pdata->index);
+	free(pdata->layer);
+	free(pdata->objects);
+	free(pdata->tree_depth);
+}
+
 struct object_entry *packlist_alloc(struct packing_data *pdata,
 				    const struct object_id *oid)
 {
diff --git a/pack-objects.h b/pack-objects.h
index 0d78db40cb..336217e8cd 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -169,6 +169,7 @@ struct packing_data {
 };
 
 void prepare_packing_data(struct repository *r, struct packing_data *pdata);
+void free_packing_data(struct packing_data *pdata);
 
 /* Protect access to object database */
 static inline void packing_data_lock(struct packing_data *pdata)
-- 
2.43.0.24.g980b318f98

