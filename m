Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D961F404
	for <e@80x24.org>; Thu, 16 Aug 2018 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeHPXCv (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 19:02:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:58026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725803AbeHPXCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 19:02:51 -0400
Received: (qmail 15408 invoked by uid 109); 16 Aug 2018 20:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 20:02:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19013 invoked by uid 111); 16 Aug 2018 20:02:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 16:02:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 16:02:23 -0400
Date:   Thu, 16 Aug 2018 16:02:23 -0400
From:   Jeff King <peff@peff.net>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
Message-ID: <20180816200222.GA7422@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <20180816155714.GA22739@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180816155714.GA22739@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 11:57:14AM -0400, Jeff King wrote:

> The only way to solve that is to count bytes. We don't have a total byte
> count in most cases, and it wouldn't always make sense (e.g., the
> "Compressing objects" meter can show the same issue, but it's not really
> putting through bytes in a linear way).  In some cases we do show
> transmitted size and throughput, but that's just for network operations.
> We could do the same for "gc" with the patch below. But usually
> throughput isn't all that interesting for a filesystem write, because
> bandwidth isn't the bottleneck.

Just realized I forgot to include the patch. Here it is, for reference.

Doing something similar for fsck would be quite a bit more invasive.

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 80c880e9ad..e1130b959d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -837,7 +837,7 @@ static void write_pack_file(void)
 		if (pack_to_stdout)
 			f = hashfd_throughput(1, "<stdout>", progress_state);
 		else
-			f = create_tmp_packfile(&pack_tmp_name);
+			f = create_tmp_packfile(&pack_tmp_name, progress_state);
 
 		offset = write_pack_header(f, nr_remaining);
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9f3b644811..0df45b8f55 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -178,7 +178,7 @@ static void prepare_to_stream(struct bulk_checkin_state *state,
 	if (!(flags & HASH_WRITE_OBJECT) || state->f)
 		return;
 
-	state->f = create_tmp_packfile(&state->pack_tmp_name);
+	state->f = create_tmp_packfile(&state->pack_tmp_name, NULL);
 	reset_pack_idx_option(&state->pack_idx_opts);
 
 	/* Pretend we are going to write only one object */
diff --git a/pack-write.c b/pack-write.c
index a9d46bc03f..b72480b440 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -334,14 +334,15 @@ int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 	return n;
 }
 
-struct hashfile *create_tmp_packfile(char **pack_tmp_name)
+struct hashfile *create_tmp_packfile(char **pack_tmp_name,
+				     struct progress *progress)
 {
 	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
 	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
-	return hashfd(fd, *pack_tmp_name);
+	return hashfd_throughput(fd, *pack_tmp_name, progress);
 }
 
 void finish_tmp_packfile(struct strbuf *name_buffer,
diff --git a/pack.h b/pack.h
index 34a9d458b4..c87628b093 100644
--- a/pack.h
+++ b/pack.h
@@ -98,7 +98,8 @@ extern int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 #define PH_ERROR_PROTOCOL	(-3)
 extern int read_pack_header(int fd, struct pack_header *);
 
-extern struct hashfile *create_tmp_packfile(char **pack_tmp_name);
+extern struct hashfile *create_tmp_packfile(char **pack_tmp_name,
+					    struct progress *progress);
 extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
