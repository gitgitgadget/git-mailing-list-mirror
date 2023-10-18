Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9433947353
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SSchvAlV"
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3618B11F
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:13 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-457c057bdb5so2459756137.0
        for <git@vger.kernel.org>; Wed, 18 Oct 2023 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697653992; x=1698258792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FanJJajcn/KBmo9c7uu27oFtZUUHzBBDYrF7MNrLZyE=;
        b=SSchvAlVRoKYii4iwU5/cT3jIA55BXzM85lx4SCRlh/nXMUIGyUY97GbDqgR7slqkG
         zXDLFq8erVRhNfawCdqVMALygMnxykmkffRYzol3tYFjWcYQoJoMVzsrH4NoyZKxsIoP
         /orc+rqvDHtkZjWL+7iQvGcvSC5f4m1ARixBt5lK0V6bwnfLS2Dq72IU08IzfhTD+bNp
         Lx5u58xLsiafsNcdqEjwPSm2AcH3eduwJ6JJtr0+EI5CAdSZeRC55qvD6FkBJEbz+91c
         ziZnSB4ejZmORJn/+on8fEFEw6POSvc71pqsQq0m3oiTnJqYQ5UBbkbIhVH8fSgpGEjw
         +Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653992; x=1698258792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FanJJajcn/KBmo9c7uu27oFtZUUHzBBDYrF7MNrLZyE=;
        b=CWQjRTX6pHLxtiaAAAvVlvxZ/ZalKKXxzX2C97MX0i1BHi7kUmC4zzj9G2d98XT7LE
         Yz5YZjuO7M5NKxrFU7t71EkVDsKrkYhGY7k111c1Y39gHRun9OXMQ3i7t3PTaDY1FKjQ
         HPBoy3x/99/j0RkUQ0R1O7Pek1hOA3ZFznZr/FmRJaYN2mweYZ1tNMOHfAIOeNtwdNIS
         o2mTsfW/2JzRWsxSNTMzA1q7UxePFBX2TKmc5NHKIiafcYxyMrU/debkZayD5SnwFAt6
         BVxVvvpB2lavA9Is7lx80GYdFHvu7bNBSGb0NNVGPIyOafDVI8jJlNvPzB2fERByAW3p
         oSNA==
X-Gm-Message-State: AOJu0YxaDzJcPcEx5D/+ZV/A2NrBHOsPhSeS/c8+99T2O51R2N7szHyB
	MvJRgJXftiTYS+bzV3al8aYfSzwRXk10flqGC+o/AQ==
X-Google-Smtp-Source: AGHT+IE/uh0tPHSjE2L50PvYe1KmucNT/OXL4JJ0cebA+DMbtZ+/SbOsqlpUXYRAu67R8VNANVxc+Q==
X-Received: by 2002:a05:6102:54ac:b0:452:c729:e9df with SMTP id bk44-20020a05610254ac00b00452c729e9dfmr8246785vsb.33.1697653992151;
        Wed, 18 Oct 2023 11:33:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f5-20020ac84645000000b004181d77e08fsm141615qto.85.2023.10.18.11.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:33:11 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:33:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 13/17] commit-graph.c: unconditionally load Bloom filters
Message-ID: <3ff669a622355bd8eb63494cd90d241d47dd2d83.1697653929.git.me@ttaylorr.com>
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

In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
2023-08-01), we began ignoring the Bloom data ("BDAT") chunk for
commit-graphs whose Bloom filters were computed using a hash version
incompatible with the value of `commitGraph.changedPathVersion`.

Now that the Bloom API has been hardened to discard these incompatible
filters (with the exception of low-level APIs), we can safely load these
Bloom filters unconditionally.

We no longer want to return early from `graph_read_bloom_data()`, and
similarly do not want to set the bloom_settings' `hash_version` field as
a side-effect. The latter is because we want to wait until we know which
Bloom settings we're using (either the defaults, from the GIT_TEST
variables, or from the previous commit-graph layer) before deciding what
hash_version to use.

If we detect an existing BDAT chunk, we'll infer the rest of the
settings (e.g., number of hashes, bits per entry, and maximum number of
changed paths) from the earlier graph layer. The hash_version will be
inferred from the previous layer as well, unless one has already been
specified via configuration.

Once all of that is done, we normalize the value of the hash_version to
either "1" or "2".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6b21b17b20..7d0fb32107 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -327,12 +327,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	uint32_t hash_version;
 	hash_version = get_be32(chunk_start);
 
-	if (*c->commit_graph_changed_paths_version == -1) {
-		*c->commit_graph_changed_paths_version = hash_version;
-	} else if (hash_version != *c->commit_graph_changed_paths_version) {
-		return 0;
-	}
-
 	g->chunk_bloom_data = chunk_start;
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
@@ -2468,8 +2462,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
-	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
-		? 2 : 1;
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2501,10 +2494,18 @@ int write_commit_graph(struct object_directory *odb,
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
-			ctx->bloom_settings = g->bloom_filter_settings;
+
+			/* don't propagate the hash_version unless unspecified */
+			if (bloom_settings.hash_version == -1)
+				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
+			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
+			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;
+			bloom_settings.max_changed_paths = g->bloom_filter_settings->max_changed_paths;
 		}
 	}
 
+	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
+
 	if (ctx->split) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
-- 
2.42.0.415.g8942f205c8

