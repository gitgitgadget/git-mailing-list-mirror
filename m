Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA891F461
	for <e@80x24.org>; Fri, 17 May 2019 04:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEQEmy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 00:42:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:60372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725929AbfEQEmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 00:42:54 -0400
Received: (qmail 15497 invoked by uid 109); 17 May 2019 04:42:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 May 2019 04:42:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10674 invoked by uid 111); 17 May 2019 04:43:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 May 2019 00:43:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 May 2019 00:42:52 -0400
Date:   Fri, 17 May 2019 00:42:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
Message-ID: <20190517044252.GA12107@sigill.intra.peff.net>
References: <20190516214257.GD10787@sigill.intra.peff.net>
 <20190516231509.253998-1-jonathantanmy@google.com>
 <20190517010950.GA30146@sigill.intra.peff.net>
 <20190517012234.GA31027@sigill.intra.peff.net>
 <20190517043939.GA12063@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517043939.GA12063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 12:39:39AM -0400, Jeff King wrote:

> > I think to trigger it you'd have to manually assemble an evil pack as I
> > described (e.g., using the routines in t/lib-pack.sh). I'm going offline
> > for a bit, but I may have a go at it later tonight or tomorrow.
> 
> OK, doing so wasn't _too_ bad, though I did have to resurrect the
> horrible generator patch from [1]. My results are below. But more
> importantly, there is good news.

Oh, I forgot my [1]. It was this message:

  https://public-inbox.org/git/20130823182409.GA30130@sigill.intra.peff.net/

which explained how I hacked up pack-objects to generate the binary goo
in lib-pack.sh. Here's my forward-ported version of it, in case we need
it again.

I do think it would be useful for debugging and experimenting to have a
mode for pack-objects that takes in a list of instructions (add object
X, make it a delta against object Y) that skips its usual ordering and
delta constraints. This isn't it, but it's enough to hackily get what
you need. ;)

---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 9f424aabab..87955d9404 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3234,6 +3234,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
+	int magic = 0;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
@@ -3321,6 +3322,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
+		OPT_BOOL(0, "magic", &magic, "make deltas"),
 		OPT_END(),
 	};
 
@@ -3337,6 +3339,34 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, pack_objects_options,
 			     pack_usage, 0);
 
+	if (magic) {
+		struct object_id oid;
+		struct delta_index *index;
+		void *src, *trg, *delta;
+		enum object_type src_type, trg_type;
+		unsigned long src_size, trg_size, delta_size, z_delta_size;
+		unsigned char header[10];
+		unsigned long header_len;
+
+		get_oid(argv[0], &oid);
+		trg = read_object_file(&oid, &trg_type, &trg_size);
+
+		get_oid(argv[1], &oid);
+		src = read_object_file(&oid, &src_type, &src_size);
+
+		index = create_delta_index(src, src_size);
+		delta = create_delta(index, trg, trg_size, &delta_size, 8192);
+
+		z_delta_size = do_compress(&delta, delta_size);
+		header_len = encode_in_pack_object_header(header, sizeof(header),
+							  OBJ_REF_DELTA,
+							  delta_size);
+		fwrite(header, 1, header_len, stdout);
+		fwrite(oid.hash, 1, the_hash_algo->rawsz, stdout);
+		fwrite(delta, 1, z_delta_size, stdout);
+		return 0;
+	}
+
 	if (argc) {
 		base_name = argv[0];
 		argc--;
