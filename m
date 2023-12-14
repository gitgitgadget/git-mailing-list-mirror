Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA806720B
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NDqSAlKb"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9f9fbfd11so61217a34.2
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592651; x=1703197451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhGfCoK2tH7CSsD31Uea+efJ+DNSx0N9h9XZ47wrw/8=;
        b=NDqSAlKbMExTVmQze3Hq4goJEsanXcRA7TsntaRbwki6o5YCG1vrYFLtA4oLnqEzo5
         lKU06P4p3EwoyVQNk/ZhXFq+P9fNWwvoIv1pGL10sVOBE550aZU8bwNkj0u7F9gyZgAg
         lr9AXnk/7zDPlN18xQ8hByE66PewnyENC+faIci8r+Uiuzto8fhVPIRdjkJTJiYWSs0J
         q/BC4CsB4XPKUjbUPbz1ZmrN+yg0Ps/yaLjIRgvqL5gUX8bMw55fulvh5tAAbIC/E9Qf
         LK2ZZ4ORy8glF25rLI5ZaoeyS7v8/5iCAc0Ic4HSZrHUgUnfLRJ14iWtKmQYGI+3fjGF
         gzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592651; x=1703197451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhGfCoK2tH7CSsD31Uea+efJ+DNSx0N9h9XZ47wrw/8=;
        b=G2lJybYh2VJ1Z9VqwlydzhB006K+HXu2q+JGdkjv2jIdpTUoRX5TyldwTbdq6hScMD
         FT60pfhTr+UbtHyjxFjQCD18/SKIAGynE0tDDXWqjvpMzLWFovJyPhTvYIK3AzQ36cE7
         QfR7qpEuCjy67OVbH+0kmlaClARxjI2hjrPopRtgnZsnfSsDd2wr0EE4jvLGXwxLOjS4
         OG1shVrRMMWLviAX8MbA1SguLuz6KtB6CPbANjEANvYUbRKXWF3mR4xtwoVvZWoKdI9k
         kEnMzICV5Fd820H2WR/d2MKn/VrKciYLEvi6uz2B7K5Pmweg5KKobDR4DavR5PHSi2Ko
         WE8g==
X-Gm-Message-State: AOJu0Yy2+MqjgpCmMs3LjCA0/92VCPTHBapFlaLHs3jMY8QL4QAITuTs
	d3UAlj+qcazC6zXzESYxXUqcOqonxtgMxh/KxKkr5A==
X-Google-Smtp-Source: AGHT+IGC6oS2gmVri538ikrtq0Co2V9TNixeYvSH6cThmAt5OjmjsK/6kjOyVaBSJshjYmTp5txW9A==
X-Received: by 2002:a05:6830:1395:b0:6d8:7a4e:37c1 with SMTP id d21-20020a056830139500b006d87a4e37c1mr9095638otq.9.1702592650784;
        Thu, 14 Dec 2023 14:24:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cn14-20020a056830658e00b006d87e38f91asm920385otb.56.2023.12.14.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:24:10 -0800 (PST)
Date: Thu, 14 Dec 2023 17:24:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/26] pack-objects: keep track of `pack_start` for each
 reuse pack
Message-ID: <9a5c38514bb6dedc44c28bab71a98fe1c0150ecb.1702592604.git.me@ttaylorr.com>
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

When reusing objects from a pack, we keep track of a set of one or more
`reused_chunk`s, corresponding to sections of one or more object(s) from
a source pack that we are reusing. Each chunk contains two pieces of
information:

  - the offset of the first object in the source pack (relative to the
    beginning of the source pack)
  - the difference between that offset, and the corresponding offset in
    the pack we're generating

The purpose of keeping track of these is so that we can patch an
OFS_DELTAs that cross over a section of the reuse pack that we didn't
take.

For instance, consider a hypothetical pack as shown below:

                                                (chunk #2)
                                                __________...
                                               /
                                              /
      +--------+---------+-------------------+---------+
  ... | <base> | <other> |      (unused)     | <delta> | ...
      +--------+---------+-------------------+---------+
       \                /
        \______________/
           (chunk #1)

Suppose that we are sending objects "base", "other", and "delta", and
that the "delta" object is stored as an OFS_DELTA, and that its base is
"base". If we don't send any objects in the "(unused)" range, we can't
copy the delta'd object directly, since its delta offset includes a
range of the pack that we didn't copy, so we have to account for that
difference when patching and reassembling the delta.

In order to compute this value correctly, we need to know not only where
we are in the packfile we're assembling (with `hashfile_total(f)`) but
also the position of the first byte of the packfile that we are
currently reusing. Currently, this works just fine, since when reusing
only a single pack those two values are always identical (because
verbatim reuse is the first thing pack-objects does when enabled after
writing the pack header).

But when reusing multiple packs which have one or more gaps, we'll need
to account for these two values diverging.

Together, these two allow us to compute the reused chunk's offset
difference relative to the start of the reused pack, as desired.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 102fe9a4f8..f51b86d99f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1015,6 +1015,7 @@ static off_t find_reused_offset(off_t where)
 
 static void write_reused_pack_one(struct packed_git *reuse_packfile,
 				  size_t pos, struct hashfile *out,
+				  off_t pack_start,
 				  struct pack_window **w_curs)
 {
 	off_t offset, next, cur;
@@ -1024,7 +1025,8 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 	offset = pack_pos_to_offset(reuse_packfile, pos);
 	next = pack_pos_to_offset(reuse_packfile, pos + 1);
 
-	record_reused_object(offset, offset - hashfile_total(out));
+	record_reused_object(offset,
+			     offset - (hashfile_total(out) - pack_start));
 
 	cur = offset;
 	type = unpack_object_header(reuse_packfile, w_curs, &cur, &size);
@@ -1094,6 +1096,7 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 
 static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfile,
 					 struct hashfile *out,
+					 off_t pack_start UNUSED,
 					 struct pack_window **w_curs)
 {
 	size_t pos = 0;
@@ -1125,10 +1128,12 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
 {
 	size_t i = 0;
 	uint32_t offset;
+	off_t pack_start = hashfile_total(f) - sizeof(struct pack_header);
 	struct pack_window *w_curs = NULL;
 
 	if (allow_ofs_delta)
-		i = write_reused_pack_verbatim(reuse_packfile, f, &w_curs);
+		i = write_reused_pack_verbatim(reuse_packfile, f, pack_start,
+					       &w_curs);
 
 	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
 		eword_t word = reuse_packfile_bitmap->words[i];
@@ -1145,7 +1150,7 @@ static void write_reused_pack(struct packed_git *reuse_packfile,
 			 * for why.
 			 */
 			write_reused_pack_one(reuse_packfile, pos + offset, f,
-					      &w_curs);
+					      pack_start, &w_curs);
 			display_progress(progress_state, ++written);
 		}
 	}
-- 
2.43.0.102.ga31d690331.dirty

