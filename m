Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IiTadKG0"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2F910FB
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:39 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77bc5d8490dso342118985a.2
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198518; x=1701803318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9jusTEKxOqvtQziRVIyM7EH2YLqR3mDeyS0923frbk=;
        b=IiTadKG0dsxG2UsEN1csrrO9Jf/QBcL8cRNclFURUas90MSIB1TTgbl5zslJ4A/BqU
         apZNSnXjkbcy6KNDFQYuv6Fgc6fYogK4sLi30zJeDE0ud+MY1wXuR6DQZaffELng+mjo
         lfKdCw3gT/psQdD0PrlRSNc2/y6HX7RBT/5urys6FfEJJC+IFK4G9fH3vEub7q1qHzS6
         stYl9KvqJuqjTa7tJ5eoAr36JRe82Ia+sS6wDNjOUHe+FOEcKwRDTn1rluJ1N8Q+mRvg
         B2dSRMMM0hVEwhO1fJ6ZyAk/QgS4mX9xGLtW8zjP3aO2+mYFevCtOyLimn/+/EKsz8ce
         xVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198518; x=1701803318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9jusTEKxOqvtQziRVIyM7EH2YLqR3mDeyS0923frbk=;
        b=mu6zQ0w35h+ZhmE+tq1750I6mqYTL1+VcEgWhX3RmESgvoTE6ZyRQWP3rPenF0s+ji
         7/eu3FkgRuBB0gIepboeCY5hy9YZYKmUNL7QavMxUcne4fL9QLR8Va0hhCGp7FJSICRj
         K9JZFIHWikf/xkBLMCJWqJVmyFpsC2NGQt9RRHeR9FTm5IEEXU57EX7UbukHOlG26zyJ
         HO2IWAEsSkDez1i9DQDsVKIzrqKEOQpiIM0Xem0pq82++1AUER4MeYwlMSL667FGvoG5
         N9Qmxn9SCh8JjcXY3hrDe1uIEJq8+DAONPRFDp7U6juLRaxoW62qxJ0Praa7CLJ1QYTS
         1O5w==
X-Gm-Message-State: AOJu0Yzl9/jgfjwk0VBEe32QhYfsQKFSlbqOzWE/9Cbp1AAXye3/dM1e
	Qys6DlmJlQ8qyZYEDO/ECq+2PN1FKgB4aOD6L6U=
X-Google-Smtp-Source: AGHT+IHjFhA4NNlmUgs6h9HgUf6Q1yNsX54zyZ9kiKeLlmztQC8xWh77JKJKDrdCoqthHKDau3w9PQ==
X-Received: by 2002:a0c:f950:0:b0:67a:45d8:7a6e with SMTP id i16-20020a0cf950000000b0067a45d87a6emr7501734qvo.57.1701198518405;
        Tue, 28 Nov 2023 11:08:38 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 10-20020a05621420ca00b0067a2749baa5sm3556499qve.60.2023.11.28.11.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:38 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:37 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/24] pack-objects: prepare `write_reused_pack()` for
 multi-pack reuse
Message-ID: <67a8196978244b56d4f60861f140b78c59d15e30.1701198172.git.me@ttaylorr.com>
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

The function `write_reused_pack()` within `builtin/pack-objects.c` is
responsible for performing pack-reuse on a single pack, and has two main
functions:

  - it dispatches a call to `write_reused_pack_verbatim()` to see if we
    can reuse portions of the packfile in whole-word chunks

  - for any remaining objects (that is, any objects that appear after
    the first "gap" in the bitmap), call write_reused_pack_one() on that
    object to record it for reuse.

Prepare this function for multi-pack reuse by removing the assumption
that the bit position corresponding to the first object being reused
from a given pack may not be at bit position zero.

The changes in this function are mostly straightforward. Initialize `i`
to the position of the first word to contain bits corresponding to that
reuse pack. In most situations, we throw the initialized value away,
since we end up replacing it with the return value from
write_reused_pack_verbatim(), moving us past the section of whole words
that we reused.

Likewise, modify the per-object loop to ignore any bits at the beginning
of the first word that do not belong to the pack currently being reused,
as well as skip to the "done" section once we have processed the last
bit corresponding to this pack.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3b7704d062..b5e6f6377a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1128,7 +1128,7 @@ static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 			      struct hashfile *f)
 {
-	size_t i = 0;
+	size_t i = reuse_packfile->bitmap_pos / BITS_IN_EWORD;
 	uint32_t offset;
 	off_t pack_start = hashfile_total(f) - sizeof(struct pack_header);
 	struct pack_window *w_curs = NULL;
@@ -1146,17 +1146,23 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 				break;
 
 			offset += ewah_bit_ctz64(word >> offset);
+			if (pos + offset < reuse_packfile->bitmap_pos)
+				continue;
+			if (pos + offset >= reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr)
+				goto done;
 			/*
 			 * Can use bit positions directly, even for MIDX
 			 * bitmaps. See comment in try_partial_reuse()
 			 * for why.
 			 */
-			write_reused_pack_one(reuse_packfile->p, pos + offset,
+			write_reused_pack_one(reuse_packfile->p,
+					      pos + offset - reuse_packfile->bitmap_pos,
 					      f, pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
 
+done:
 	unuse_pack(&w_curs);
 }
 
-- 
2.43.0.24.g980b318f98

