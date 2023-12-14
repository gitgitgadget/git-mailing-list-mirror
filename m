Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C2671E8
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jkl4UK9m"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1f055438492so30671fac.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592627; x=1703197427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8TZpuvfY0jvCMNagKiqmDEug8KHOO6QlTzJG+1k+VA=;
        b=jkl4UK9mk8EqTeDXZhQ2IlYYXjXo/bjQk8cG3f2phQ6ib2fgdYWsOODuwGKG2hFvQE
         1aqYioLej1jQjg3f0nyTDmHmdF/iRcPCAWleoIpR1+dcGS/ttCvwA2JsdsJ3B5VkW4bK
         vkJZA6BWnVSRpkMyFpImK4rfR0hbNmZzmxx+j2m+OTOSDuGrmZ/y6qnIBBGierUUTjYX
         DeZ78VX2kqnub3SWyjke5r9yO5WkYsj+ICol+azQuHtmj0yeetgdBcEi8vAOyCUywRh3
         vp+2mDXwkrImzVsmC7pasSaDBFL7dn2xFLka35eeviIaxBMTMC1crLqy8DvMl9OOOd9W
         gIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592627; x=1703197427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8TZpuvfY0jvCMNagKiqmDEug8KHOO6QlTzJG+1k+VA=;
        b=fJk3smf99RfKQr5AolgRuX80SeWJt621zJU3MAuP9CZwrBH0N1vUhj7C2jTRTlIWMC
         dhvzs9UUSzzxEf0WPjHUlRnsITs1p4negERyk09OZsNx3m6iHMO1y4nNIuMUSoSL62w0
         t22Fjk6uTkB/LYc8w3H3t8hp9CCm+w1TVDRmoVp2S+XSu2X6JvikowQWSuOR4mtwKoLZ
         LSbG4qrkHkfeggC/KBlOco8iVr28cYF7qWGP1Z2qMuKy2aPOiJX+TptBEZ6AL9n+Ukno
         L/NG0e4BG6VkDmjzCV7LnV7XcpyRF1v/czD2g9O/pc2g09u2guq+rKMWynOA+6IQ2VU2
         s0cQ==
X-Gm-Message-State: AOJu0Yz9XM4nDGOtckmMMeON9f6GvlG0zwNqbAio95PEENHIMYfBi/iE
	VtzlrCdx13faiQ/T5f6lDktR2iAF9UhpM7Mb76xkfg==
X-Google-Smtp-Source: AGHT+IH7iFX2wTvs+q0vQPRAxZSkrsR4XsMP2cFL3Yen82E+oTJE0cdE535nLQt9DpiGoHweL8ccyQ==
X-Received: by 2002:a05:6870:56ac:b0:203:4ca8:fdd5 with SMTP id p44-20020a05687056ac00b002034ca8fdd5mr2058456oao.97.1702592626900;
        Thu, 14 Dec 2023 14:23:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ov19-20020a056870cb9300b001fb0168cc3esm4731057oab.42.2023.12.14.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:46 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/26] pack-bitmap: plug leak in find_objects()
Message-ID: <477df6c974bf5ba7bf91d2f720e9de4f0e91f246.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

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
2.43.0.102.ga31d690331.dirty

