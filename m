Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2962C6AE
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WBN0G/EY"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1ef36a04931so31497fac.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592672; x=1703197472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi3NkmKbTEGlRgCqHBBRwBibXS5a8/ymuIbwWMc+rFk=;
        b=WBN0G/EYi+Liuoqaq0V9J7MQYPSwQuObEIi7+WxteQA5J4E21u+Sd2PVZVvt8aWgND
         9We7PAuTzu5wvJkTvi8ZJizUubYk9phSB8jyYBSOIqXfbuplK+JSkz6EV7EfVXnPC/VS
         dpOBdWd2WS8PhZhtPUPJzdt0RZ05ZPsGSBKouKJ1Inn8XauquQZrIueorXm6MeH3OfWR
         L0XR3nQ8bqSXQt04efokL++Fne69Jb8+CJsdNRrzHjKYNpH2Qzel4OI0oeHZyg5wdVZ2
         bxiamFsjjLCjkAParjIFr+jm98rEnf7yn+BONWy5YDtrU+sBwtTrz4N6oby+3MJAQcp9
         n4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592672; x=1703197472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi3NkmKbTEGlRgCqHBBRwBibXS5a8/ymuIbwWMc+rFk=;
        b=mxJePzRUS9Zb0V3xGZMCBy16YP4pP2pE+/9/rfmLdCGaK+cptV4QgqAk/hBShMNAM7
         uWubkudV/Yra9wInLrfe9zR6FSRSCNf/CvrAic3SynDWPc7dDsQWMNtbJmeHhuf2G8pt
         SkxALs6MIFjPIQqdUooDQK9OeFfC1WSGboSmNDAkl5WMINC6YBCLVWxuLavR1RGYLHCx
         uF/85SskxNELjy1gWppUGwAcsMjYbwcXJcqVsLzqG34iNrC7+ONkVLhcZkNji6b9XoKU
         ecK9vWDKoQ3R0eXjsT+6ayUHz0zU858JrDkTkf0MO2m0uIZJ/AuK+Wq1cXADAsvmhchi
         jpMw==
X-Gm-Message-State: AOJu0YxjvvAEqGYGvy5wYaQuZyGdGuywG2WMmoJJxDFc8BvVrWIIhZKi
	NewpdgpxpS1HIJtvQ0LV/XLolShniW32WiHAIiIHwg==
X-Google-Smtp-Source: AGHT+IEP8cVmQqnhzh7+d7NTBjyi6uwL9ayHlnEsjvJhgi1KYidHKLD5CKquonO3/n1ShuXRqO24Og==
X-Received: by 2002:a05:6870:55cc:b0:203:5cd1:b639 with SMTP id qk12-20020a05687055cc00b002035cd1b639mr892910oac.116.1702592672335;
        Thu, 14 Dec 2023 14:24:32 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pn9-20020a056871d30900b001fb5551af6fsm4716635oac.16.2023.12.14.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:31 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:30 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/26] pack-revindex: implement `midx_pair_to_pack_pos()`
Message-ID: <e99481014ed9dba161b30dea5e6af2b692f5ca9f.1702592604.git.me@ttaylorr.com>
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

Now that we have extracted the `midx_key_to_pack_pos()` function, we can
implement the `midx_pair_to_pack_pos()` function which accepts (pack_id,
offset) tuples and returns an index into the psuedo-pack order.

This will be used in a following commit in order to figure out whether
or not the MIDX chose a given delta's base object from the same pack as
the delta resides in. It will do so by locating the base object's offset
in the pack, and then performing a binary search using the same pack ID
with the base object's offset.

If (and only if) it finds a match (at any position) we can guarantee
that the MIDX selected both halves of the delta/base pair from the same
pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 11 +++++++++++
 pack-revindex.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index baa4657ed3..a7624d8be8 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -564,3 +564,14 @@ int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
 
 	return midx_key_to_pack_pos(m, &key, pos);
 }
+
+int midx_pair_to_pack_pos(struct multi_pack_index *m, uint32_t pack_int_id,
+			  off_t ofs, uint32_t *pos)
+{
+	struct midx_pack_key key = {
+		.pack = pack_int_id,
+		.offset = ofs,
+		.midx = m,
+	};
+	return midx_key_to_pack_pos(m, &key, pos);
+}
diff --git a/pack-revindex.h b/pack-revindex.h
index 6dd47efea1..422c2487ae 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -142,4 +142,7 @@ uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
  */
 int midx_to_pack_pos(struct multi_pack_index *midx, uint32_t at, uint32_t *pos);
 
+int midx_pair_to_pack_pos(struct multi_pack_index *midx, uint32_t pack_id,
+			  off_t ofs, uint32_t *pos);
+
 #endif
-- 
2.43.0.102.ga31d690331.dirty

