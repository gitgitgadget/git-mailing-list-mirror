Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0741E2E
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LvXXIrbo"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5711A
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7757f2d3956so687550185a.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653989; x=1698258789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PDoDCF/c0g93jQOE09nRI+IBg8OcKoukZkKyO7zGKQ=;
        b=LvXXIrbo070KkZR1vbGeBHzLUJb8mOhnflh3R6xhH6mftcFHoKMWPEL5pgaRWuXNn3
         S66rN62RcCaqfCgt09gbo0mmyFk/r0I+aJFc9EYhz5Gt9NvcQqiM0k36mblZjS1O3Jw8
         bkMtd2GhMGCsQEX7iU/J4me40ZPMEjX58O1A70/4KFuR2bDemrx10IQOYrP1Cq4c+4cJ
         PVsfw2Zt5eTHgvBc6bDaw/kWcCEMCi/4jqUeGUEftasnK6tOCewo9lKx8+ZgzPPI6H0K
         Xq3wibl0QJSl6kA3+26j1oNLhVrYXd8213158tEN3dm+3WgtRXOK4XaJ22cCCZDWayc6
         S+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653989; x=1698258789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PDoDCF/c0g93jQOE09nRI+IBg8OcKoukZkKyO7zGKQ=;
        b=f6e4ZNZ+e5TtC8/IKXN4uzzi8gZ+ndGTA+UqccindpIBTeJtxyteFAsCut+IGfaWRf
         5/H6AoGjnFIo36O4gbt8l2sQpMuIV40dqWwl5PLSQD3mjyVW1ECW1pcWoIU/DsJN3KaA
         Vf7R8tvyvSFBH/Db53l+KWJtzRkSM/Ykdejz/IN97beG/sAQQeQiv35qIxI0YecT3SjN
         SmmB1j7qaSU8ME2oDKiOZ6mQDHy20G/vGckeCvSGEHhV0fYLijokQSwC9l81OFw1hQNt
         Otbaq/5gQJZYpdNl0T6Jik6eESSS1ElQg8+pqPuDPpkZUtaIiaOST6MH6r6i5cDEtq4l
         M9tA==
X-Gm-Message-State: AOJu0Yzfq2DqjXsfwW6ow03hYZENJ/cTHDq87jrctPWqS6frItQVbbOR
	ZvWyhDAgMUqpwxnPgxdVg88HJAjYw9oRNRzbfur5Nw==
X-Google-Smtp-Source: AGHT+IGenAUywz9ltpERoQLKm52ReZNifrQcwVaSTZF1rH+IbPlRYupa3V6h5Kc2OiKEsVprLsiMkA==
X-Received: by 2002:a05:6214:21a5:b0:66d:8203:9433 with SMTP id t5-20020a05621421a500b0066d82039433mr172041qvc.31.1697653988791;
        Wed, 18 Oct 2023 11:33:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id mi1-20020a056214558100b0066d15724ff7sm154525qvb.52.2023.10.18.11.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:08 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 12/17] bloom: prepare to discard incompatible Bloom filters
Message-ID: <85dbdc4ed28058bcf4d1eff8f134fd2299bd18fb.1697653929.git.me@ttaylorr.com>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cover.1697653929.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1697653929.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Callers use the inline `get_bloom_filter()` implementation as a thin
wrapper around `get_or_compute_bloom_filter()`. The former calls the
latter with a value of "0" for `compute_if_not_present`, making
`get_bloom_filter()` the default read-only path for fetching an existing
Bloom filter.

Callers expect the value returned from `get_bloom_filter()` is usable,
that is that it's compatible with the configured value corresponding to
`commitGraph.changedPathsVersion`.

This is OK, since the commit-graph machinery only initializes its BDAT
chunk (thereby enabling it to service Bloom filter queries) when the
Bloom filter hash_version is compatible with our settings. So any value
returned by `get_bloom_filter()` is trivially useable.

However, subsequent commits will load the BDAT chunk even when the Bloom
filters are built with incompatible hash versions. Prepare to handle
this by teaching `get_bloom_filter()` to discard filters that are
incompatible with the configured hash version.

Callers who wish to read incompatible filters (e.g., for upgrading
filters from v1 to v2) may use the lower level routine,
`get_or_compute_bloom_filter()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 bloom.c | 20 +++++++++++++++++++-
 bloom.h | 20 ++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/bloom.c b/bloom.c
index 9b6a30f6f6..739fa093ba 100644
--- a/bloom.c
+++ b/bloom.c
@@ -250,6 +250,23 @@ static void init_truncated_large_filter(struct bloom_filter *filter,
 	filter->version = version;
 }
 
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c)
+{
+	struct bloom_filter *filter;
+	int hash_version;
+
+	filter = get_or_compute_bloom_filter(r, c, 0, NULL, NULL);
+	if (!filter)
+		return NULL;
+
+	prepare_repo_settings(r);
+	hash_version = r->settings.commit_graph_changed_paths_version;
+
+	if (!(hash_version == -1 || hash_version == filter->version))
+		return NULL; /* unusable filter */
+	return filter;
+}
+
 struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 struct commit *c,
 						 int compute_if_not_present,
@@ -275,7 +292,8 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						     filter, graph_pos);
 	}
 
-	if (filter->data && filter->len)
+	if ((filter->data && filter->len) &&
+	    (!settings || settings->hash_version == filter->version))
 		return filter;
 	if (!compute_if_not_present)
 		return NULL;
diff --git a/bloom.h b/bloom.h
index 330a140520..bfe389e29c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -110,8 +110,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 						 const struct bloom_filter_settings *settings,
 						 enum bloom_filter_computed *computed);
 
-#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
-	(r), (c), 0, NULL, NULL)
+/*
+ * Find the Bloom filter associated with the given commit "c".
+ *
+ * If any of the following are true
+ *
+ *   - the repository does not have a commit-graph, or
+ *   - the repository disables reading from the commit-graph, or
+ *   - the given commit does not have a Bloom filter computed, or
+ *   - there is a Bloom filter for commit "c", but it cannot be read
+ *     because the filter uses an incompatible version of murmur3
+ *
+ * , then `get_bloom_filter()` will return NULL. Otherwise, the corresponding
+ * Bloom filter will be returned.
+ *
+ * For callers who wish to inspect Bloom filters with incompatible hash
+ * versions, use get_or_compute_bloom_filter().
+ */
+struct bloom_filter *get_bloom_filter(struct repository *r, struct commit *c);
 
 int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
-- 
2.42.0.415.g8942f205c8

