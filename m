Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DhngvcuN"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA375C3
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:04 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77d90497b86so184368585a.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198483; x=1701803283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CA5ONnhb7PPzj475MAowp+4NXW6jj44d07pJCN46+3g=;
        b=DhngvcuNdRfvEQIxZk7MPLhfqmz1q7Urjx0PxIUZNdKS2sfuedRalcwpS0u0ndYNt4
         KI1PT73ktvM0s1PBNacF7lfIwfAnJrtYBEurXdVX53dms3itiClD2RoNLlJr2KyCQmTJ
         w40I/F6b7JzMkFdRIwCoWPmqmAaEyJYZvAd27KY8SXD+/Xx3VLFd5E7kW9ZUxHqft2Nh
         V8PMlL/sviq6U9uq2Je5ptRfXrwdvSqzc1iE9SaYHyLImE/w2Ioa2Uc9Rfj0nAuidGvH
         VQQc/g6OuvM8spjRm+eWdWxSnqmNjzZcr+46dDHmcAlF5dfWtShpufQidQE0k1A7CZLP
         cG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198483; x=1701803283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA5ONnhb7PPzj475MAowp+4NXW6jj44d07pJCN46+3g=;
        b=G1ZHfO4d/Jr+eNbP3IurPPJtdlKEdqxguXnWk7O+J++n6OQWC7Gvw3UXq+59jUcZeZ
         8yOAwaOjJtSEF1HdMkwTcOk57KyKCBelZv+/wZjL4YfkauCEF6X+/hzvipV01OVLwC9I
         LzAfueNWN4V5eOYvmRJDeTHGIE85tdGnY4IvvG1jPPivUBiqSDn3SbMqfT750Yt9RKMz
         qPHHJSlkp7o6MICE/AtPjh3MBsbRVVZJiYf+4fYa/iNsfYNBtj7D5uZ6sXgDNjXJkBK9
         aa1aQOGeT2WVmBrS/cFuKktifOstcRyTw27nuyjLlRA+6EfkILkXW82ejm/BHqZTmsad
         mmdg==
X-Gm-Message-State: AOJu0Yw9+f6PV2u8NAuHkuQRe5dnKux1FBUZfDrGlCE5Xw7f7vEw9343
	nB8fsC9as2OujVKuBCEfAGAckcuk3QKwOJ98Gzc=
X-Google-Smtp-Source: AGHT+IH+NcO+XCA1NpBdDkuenAUF8SL7YIrZcg0rXWLaPFFgPLcv+fTn9mUWYVxY3msihL49hKyy3A==
X-Received: by 2002:a05:620a:802:b0:77d:9aa8:80f0 with SMTP id s2-20020a05620a080200b0077d9aa880f0mr11282223qks.70.1701198483510;
        Tue, 28 Nov 2023 11:08:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a228400b0077d606bec92sm4695576qkh.108.2023.11.28.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:03 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/24] pack-bitmap: plug leak in find_objects()
Message-ID: <bc38fba65547f5716a2ff9904dd615e755ea84bb.1701198172.git.me@ttaylorr.com>
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

The `find_objects()` function creates an object_list for any tips of the
reachability query which do not have corresponding bitmaps.

The object_list is not used outside of `find_objects()`, but we never
free it with `object_list_free()`, resulting in a leak. Let's plug that
leak by calling `object_list_free()`, which results in t6113 becoming
leak-free.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                      | 2 ++
 t/t6113-rev-list-bitmap-filters.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0260890341..d2f1306960 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1280,6 +1280,8 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		base = fill_in_bitmap(bitmap_git, revs, base, seen);
 	}
 
+	object_list_free(&not_mapped);
+
 	return base;
 }
 
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index 86c70521f1..459f0d7412 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -4,6 +4,8 @@ test_description='rev-list combining bitmaps and filters'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
+TEST_PASSES_SANITIZE_LEAK=true
+
 test_expect_success 'set up bitmapped repo' '
 	# one commit will have bitmaps, the other will not
 	test_commit one &&
-- 
2.43.0.24.g980b318f98

