Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SbaF+87Y"
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5F19A6
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:09:00 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-778a6c440faso275189785a.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198540; x=1701803340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyjU3+2aACcGusXPzHPS4F+h43r7SvevI+1svAuY+R8=;
        b=SbaF+87Yl4pFHRI5d8jjYXIPqj8iTMfK7lrBc/G/5zzyBw9UT2Hj/LqT6/+iGoypm/
         72Lk2cfCli34Lcvu7fu6+hj/BnzUBhd9h+0kxa6YZ5qPrx6IB/4z5z+x7c5ixloxQ4nR
         0RNWn09Xh996zHBJK+fqTM1kEjJWxMSvX+zCgDU/qtHLi4UyOL+L95RET4QtsZOEiib2
         4jQKRAzvOQLmoDwWOVYQJZ1zDuEQN1wfJ4McTgZJG/XSFwc9EKd8gzRcnGuWCp6UURau
         xM8Ajul7cwuFumVLd256+BYjtMV+/SJ2cED8S3S8WRLujKXUA1iw0/OWQgS1UsynCsrr
         gQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198540; x=1701803340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyjU3+2aACcGusXPzHPS4F+h43r7SvevI+1svAuY+R8=;
        b=IDEZO1Gq/8pbdanKMzO7rXTlmseS5ekkGBd8lAWVy8AeWrkGo11/OhfJnoTUcugiqb
         D2Vt/oV1JNtOGuoBpq/NMP0poTtt5mYEOpkCbNXZEEJXmIyqZ71DVsgKNfldoit/mW4c
         paKHfaSmCqpv4SjBsB7lGbPFfWyrINoEq5CWY7JWRZIpj1uFIN8gpUj/pBfrT9Bl1z7O
         4mfPcSvDN0NOJezlvIMnRnfg/fbM1igP9x6gbk2k1Yjd7CqgB56sFI+Hk0Ko2TC5fPfQ
         eUZa5Xxgk9wlGnmNDm3SV1fcqkL7d1Ymg/6rqSdJb8Hu2kMIPFXGAUGNGO571mOYf89n
         N/9A==
X-Gm-Message-State: AOJu0YzPN3z6vQUv33k0LipWaL4CZlocOxSMOqnVu/ifyF6G56+5p2DU
	zuFuegC6ySPrP9T2pEF9IwyazrgJ25jdix23H3k=
X-Google-Smtp-Source: AGHT+IHHE5lXlE61vzqUDnstW5pQJdSlLw58Y1XqlmtuuJ+/AjUdUB2MsHn0SNrnAB5ofMxDRZ43DA==
X-Received: by 2002:a05:6214:90c:b0:67a:2969:dd3e with SMTP id dj12-20020a056214090c00b0067a2969dd3emr10055928qvb.62.1701198539824;
        Tue, 28 Nov 2023 11:08:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x5-20020a0ce785000000b0067a5571bca6sm1078464qvn.74.2023.11.28.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:59 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 24/24] t/perf: add performance tests for multi-pack reuse
Message-ID: <980b318f98143d8ba26443127e515c0c98a2bd6b.1701198172.git.me@ttaylorr.com>
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

To ensure that we don't regress either the size or runtime performance
of multi-pack reuse, add a performance test to measure both of these.

The test partitions the objects in GIT_TEST_PERF_LARGE_REPO into 1, 10,
and 100 packs, and then tries to perform a "clone" at each stage with
both single- and multi-pack reuse enabled.

Note that the `repack_into_n_chunks()` function in this new test script
differs from the existing `repack_into_n()`. The former partitions the
repository into N equal-sized chunks, while the latter produces N packs
of five commits each (plus their objects), and then another pack with
the remainder.

On git.git, I can produce the following results on my machine:

    Test                                                            this tree
    --------------------------------------------------------------------------------
    5332.3: clone for 1-pack scenario (single-pack reuse)           1.57(2.99+0.15)
    5332.4: clone size for 1-pack scenario (single-pack reuse)               231.8M
    5332.5: clone for 1-pack scenario (multi-pack reuse)            1.79(2.96+0.21)
    5332.6: clone size for 1-pack scenario (multi-pack reuse)                231.7M
    5332.9: clone for 10-pack scenario (single-pack reuse)          3.89(16.75+0.35)
    5332.10: clone size for 10-pack scenario (single-pack reuse)             209.9M
    5332.11: clone for 10-pack scenario (multi-pack reuse)          1.56(2.99+0.17)
    5332.12: clone size for 10-pack scenario (multi-pack reuse)              224.4M
    5332.15: clone for 100-pack scenario (single-pack reuse)        8.24(54.31+0.59)
    5332.16: clone size for 100-pack scenario (single-pack reuse)            278.3M
    5332.17: clone for 100-pack scenario (multi-pack reuse)         2.13(2.44+0.33)
    5332.18: clone size for 100-pack scenario (multi-pack reuse)             357.9M

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5332-multi-pack-reuse.sh | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 t/perf/p5332-multi-pack-reuse.sh

diff --git a/t/perf/p5332-multi-pack-reuse.sh b/t/perf/p5332-multi-pack-reuse.sh
new file mode 100755
index 0000000000..5c6c575d62
--- /dev/null
+++ b/t/perf/p5332-multi-pack-reuse.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='tests pack performance with multi-pack reuse'
+
+. ./perf-lib.sh
+. "${TEST_DIRECTORY}/perf/lib-pack.sh"
+
+packdir=.git/objects/pack
+
+test_perf_large_repo
+
+find_pack () {
+	for idx in $packdir/pack-*.idx
+	do
+		if git show-index <$idx | grep -q "$1"
+		then
+			basename $idx
+		fi || return 1
+	done
+}
+
+repack_into_n_chunks () {
+	git repack -adk &&
+
+	test "$1" -eq 1 && return ||
+
+	find $packdir -type f | sort >packs.before &&
+
+	# partition the repository into $1 chunks of consecutive commits, and
+	# then create $1 packs with the objects reachable from each chunk
+	# (excluding any objects reachable from the previous chunks)
+	sz="$(($(git rev-list --count --all) / $1))"
+	for rev in $(git rev-list --all | awk "NR % $sz == 0" | tac)
+	do
+		pack="$(echo "$rev" | git pack-objects --revs \
+			--honor-pack-keep --delta-base-offset $packdir/pack)" &&
+		touch $packdir/pack-$pack.keep || return 1
+	done
+
+	# grab any remaining objects not packed by the previous step(s)
+	git pack-objects --revs --all --honor-pack-keep --delta-base-offset \
+		$packdir/pack &&
+
+	find $packdir -type f | sort >packs.after &&
+
+	# and install the whole thing
+	for f in $(comm -12 packs.before packs.after)
+	do
+		rm -f "$f" || return 1
+	done
+	rm -fr $packdir/*.keep
+}
+
+for nr_packs in 1 10 100
+do
+	test_expect_success "create $nr_packs-pack scenario" '
+		repack_into_n_chunks $nr_packs
+	'
+
+	test_expect_success "setup bitmaps for $nr_packs-pack scenario" '
+		find $packdir -type f -name "*.idx" | sed -e "s/.*\/\(.*\)$/+\1/g" |
+		git multi-pack-index write --stdin-packs --bitmap \
+			--preferred-pack="$(find_pack $(git rev-parse HEAD))"
+	'
+
+	for reuse in single multi
+	do
+		test_perf "clone for $nr_packs-pack scenario ($reuse-pack reuse)" "
+			git for-each-ref --format='%(objectname)' refs/heads refs/tags >in &&
+			git -c pack.allowPackReuse=$reuse pack-objects \
+				--revs --delta-base-offset --use-bitmap-index \
+				--stdout <in >result
+		"
+
+		test_size "clone size for $nr_packs-pack scenario ($reuse-pack reuse)" '
+			wc -c <result
+		'
+	done
+done
+
+test_done
-- 
2.43.0.24.g980b318f98
