Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9A41F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 11:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeCVLwu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 07:52:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:38692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752580AbeCVLwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 07:52:49 -0400
Received: (qmail 11670 invoked by uid 109); 22 Mar 2018 11:52:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Mar 2018 11:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19025 invoked by uid 111); 22 Mar 2018 11:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 22 Mar 2018 07:53:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2018 07:52:47 -0400
Date:   Thu, 22 Mar 2018 07:52:47 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
Message-ID: <20180322115247.GB22763@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net>
 <CACsJy8DkF3TpTGKp5MdS1ApC8Yj6FOL5uAg5U__PjBAQY1vdNw@mail.gmail.com>
 <20180322093212.GB28907@sigill.intra.peff.net>
 <CACsJy8CieaHxW-EE=3t4tdwAHoEg9+Bw3zpd+ZpROOc2k4Guxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CieaHxW-EE=3t4tdwAHoEg9+Bw3zpd+ZpROOc2k4Guxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 11:57:27AM +0100, Duy Nguyen wrote:

> On Thu, Mar 22, 2018 at 10:32 AM, Jeff King <peff@peff.net> wrote:
> > That would still mean you could get into a broken state for serving
> > fetches, but you could at least get out of it by running "git repack".
> 
> I was puzzled by this "broken state" statement. But you were right! I
> focused on the repack case and forgot about fetch/clone case. I will
> probably just drop this patch for now. Then maybe revisit this some
> time in fiture when I find out how to deal with this nicely.

Here's a sketch of the "separate array" concept I mentioned before, in
case that helps. Not tested at all beyond compiling.

---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 4406af640f..e4e308b453 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1090,7 +1090,7 @@ static void create_object_entry(const struct object_id *oid,
 	else
 		nr_result++;
 	if (found_pack) {
-		oe_set_in_pack(entry, found_pack);
+		oe_set_in_pack(&to_pack, entry, found_pack);
 		entry->in_pack_offset = found_offset;
 	}
 
diff --git a/pack-objects.h b/pack-objects.h
index 9f8e450e19..b94b9232fa 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -7,6 +7,8 @@
 #define OE_Z_DELTA_BITS		16
 #define OE_DELTA_SIZE_BITS	31
 
+#define OE_IN_PACK_EXTENDED ((1 << OE_IN_PACK_BITS) - 1)
+
 /*
  * State flags for depth-first search used for analyzing delta cycles.
  *
@@ -111,8 +113,13 @@ struct packing_data {
 	uint32_t index_size;
 
 	unsigned int *in_pack_pos;
-	int in_pack_count;
-	struct packed_git *in_pack[1 << OE_IN_PACK_BITS];
+
+	struct packed_git **in_pack;
+	uint32_t in_pack_count;
+	size_t in_pack_alloc;
+
+	uint32_t *in_pack_extended;
+	size_t in_pack_extended_alloc;
 };
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
@@ -174,17 +181,13 @@ static inline void oe_set_in_pack_pos(const struct packing_data *pack,
 static inline unsigned int oe_add_pack(struct packing_data *pack,
 				       struct packed_git *p)
 {
-	if (pack->in_pack_count >= (1 << OE_IN_PACK_BITS))
-		die(_("too many packs to handle in one go. "
-		      "Please add .keep files to exclude\n"
-		      "some pack files and keep the number "
-		      "of non-kept files below %d."),
-		    1 << OE_IN_PACK_BITS);
 	if (p) {
 		if (p->index > 0)
 			die("BUG: this packed is already indexed");
 		p->index = pack->in_pack_count;
 	}
+	ALLOC_GROW(pack->in_pack, pack->in_pack_count + 1,
+		   pack->in_pack_alloc);
 	pack->in_pack[pack->in_pack_count] = p;
 	return pack->in_pack_count++;
 }
@@ -192,18 +195,28 @@ static inline unsigned int oe_add_pack(struct packing_data *pack,
 static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
 					    const struct object_entry *e)
 {
-	return pack->in_pack[e->in_pack_idx];
-
+	uint32_t idx = e->in_pack_idx;
+	if (idx == OE_IN_PACK_EXTENDED)
+		idx = pack->in_pack_extended[e - pack->objects];
+	return pack->in_pack[idx];
 }
 
-static inline void oe_set_in_pack(struct object_entry *e,
+static inline void oe_set_in_pack(struct packing_data *pack,
+				  struct object_entry *e,
 				  struct packed_git *p)
 {
 	if (p->index <= 0)
 		die("BUG: found_pack should be NULL "
 		    "instead of having non-positive index");
-	e->in_pack_idx = p->index;
-
+	else if (p->index < OE_IN_PACK_EXTENDED)
+		e->in_pack_idx = p->index;
+	else {
+		size_t index = e - pack->objects;
+		ALLOC_GROW(pack->in_pack_extended,
+			   index, pack->in_pack_extended_alloc);
+		pack->in_pack_extended[index] = p->index;
+		e->in_pack_idx = OE_IN_PACK_EXTENDED;
+	}
 }
 
 static inline struct object_entry *oe_delta(
