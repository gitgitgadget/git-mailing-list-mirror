Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZFYeW17+"
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB3F170B
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:49 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-423cd566ffeso11445321cf.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198529; x=1701803329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiCJmkcXn9qQCJTM9uPvAKRKRLAuz4ZM0prseVj+urw=;
        b=ZFYeW17+0yIGXCtfL0aj7xYR8Z+reIDS/lyUisytWnhgna+sgaxPU3D3r/VfSZSnH1
         3oRFVwkCHENSiltEENmaVQF5qys+G9ETtYQIqJ0LVoUgPWIgvc+xIHUHmuGCF5gj52CN
         rd2jUTKiy1M5GV3V6bYiK2bCuUgicfGQTcwXo5fE4QA3rZnpsDQO+UqaDMkW+JsNxOzk
         ggO1hFqXB5l2Wldtx7oLRMCZ1sqkXyouIvO8jjQ3+JO+Buvu6TTwtxP7vf72d76xXdyl
         NEcrHbaxyVEVXv/NFhDT8kLdnK7LG9q1CXhyGUzHKcGqpegDHmQfR9RHyniJtf3j1l41
         BAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198529; x=1701803329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiCJmkcXn9qQCJTM9uPvAKRKRLAuz4ZM0prseVj+urw=;
        b=N865jszPzfoaeGATKJz+Dk5HjEtRC1xEqcARLgzmeM6dTM0lyCXHqmzgGJ3D86J/4J
         nE15NL7I2ogjVpaKDmHaMGC7ivVetj4nAYFTyrfRjM/+kqEuoAUhR4Qiulmu9pPFT/xq
         0Kt6jK0aNniDA0fSPrQ+lJvYbOC/brwsVAKs3UCri7Ktnp2reac83K92aeWdo56SSXxE
         2OGSFPhGwUUarPe1ix3vyCbFYLq9QraCFwHgNwotFk/qnuX3xbGaxuUdCLRvW70f+hs6
         2VOml5H/a7086NxUa2BiBkY7hN7bQoqiwxOUowKn1WintQnT5ZdAuqdqnAXx0HMVNqQ+
         QqQQ==
X-Gm-Message-State: AOJu0YzT8UrtYveJ+BNZNgJXl8OvS0PQzUyr9h2M/RuqU/+NzW258ffN
	w7tmFpOsaMHpbutyOu3gRWPqaHjAUM1NOPlaktA=
X-Google-Smtp-Source: AGHT+IE8Xu8lleWaYBp1rvv5e+4j+2e5vimacSwsajpA2purrZobdsVSFP8/yJLTaNNTF8JsJuWiWA==
X-Received: by 2002:ac8:58ca:0:b0:413:5e4d:bf46 with SMTP id u10-20020ac858ca000000b004135e4dbf46mr24273798qta.11.1701198528874;
        Tue, 28 Nov 2023 11:08:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85345000000b00417f330026bsm4796874qto.49.2023.11.28.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:48 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 20/24] pack-objects: add tracing for various packfile metrics
Message-ID: <46f1a03b8b15f0c4432c26aca1e842670638c798.1701198172.git.me@ttaylorr.com>
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

As part of the multi-pack reuse effort, we will want to add some tests
that assert that we reused a certain number of objects from a certain
number of packs.

We could do this by grepping through the stderr output of
`pack-objects`, but doing so would be brittle in case the output format
changed.

Instead, let's use the trace2 mechanism to log various pieces of
information about the generated packfile, which we can then use to
compare against desired values.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 902e70abc5..fa71fe1ccf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4620,6 +4620,13 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			   reuse_packfile_objects,
 			   (uintmax_t)reuse_packfiles_used_nr);
 
+	trace2_data_intmax("pack-objects", the_repository, "written", written);
+	trace2_data_intmax("pack-objects", the_repository, "written/delta", written_delta);
+	trace2_data_intmax("pack-objects", the_repository, "reused", reused);
+	trace2_data_intmax("pack-objects", the_repository, "reused/delta", reused_delta);
+	trace2_data_intmax("pack-objects", the_repository, "pack-reused", reuse_packfile_objects);
+	trace2_data_intmax("pack-objects", the_repository, "packs-reused", reuse_packfiles_used_nr);
+
 cleanup:
 	free_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
-- 
2.43.0.24.g980b318f98

