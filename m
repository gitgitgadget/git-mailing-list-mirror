Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172B2202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 07:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbdCJHqD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 02:46:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:41816 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdCJHqC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 02:46:02 -0500
Received: (qmail 10721 invoked by uid 109); 10 Mar 2017 07:46:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 07:46:00 +0000
Received: (qmail 7951 invoked by uid 111); 10 Mar 2017 07:46:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 02:46:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 02:45:58 -0500
Date:   Fri, 10 Mar 2017 02:45:58 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
Message-ID: <20170310074558.ifse3omthmtih73l@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <63a6ec61-653d-6307-4739-2ebaa8dbde35@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63a6ec61-653d-6307-4739-2ebaa8dbde35@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 01:14:45AM +0100, René Scharfe wrote:

> >   3. There were a number of alloc-and-copy instances. The copy part is
> >      the same as (2) above, but you have to repeat the size, which is
> >      potentially error-prone. I wonder if we would want something like:
> > 
> >        #define ALLOC_COPY(dst, src) do { \
> >          (dst) = xmalloc(sizeof(*(dst))); \
> > 	 COPY_ARRAY(dst, src, 1); \
> >        while(0)
> > 
> >      That avoids having to specify the size at all, and triggers a
> >      compile-time error if "src" and "dst" point to objects of different
> >      sizes.
> 
> Or you could call it DUP or similar.  And you could use ALLOC_ARRAY in
> its definition and let it infer the size implicitly (don't worry too
> much about the multiplication with one):
> 
> 	#define DUPLICATE_ARRAY(dst, src, n) do {	\
> 		ALLOC_ARRAY((dst), (n));		\
> 		COPY_ARRAY((dst), (src), (n));		\
> 	} while (0)
> 	#define DUPLICATE(dst, src) DUPLICATE_ARRAY((dst), (src), 1)
> 
> But do we even want such a thing?  Duplicating objects should be rare, and
> keeping allocation and assignment/copying separate makes for more flexible
> building blocks.  Adding ALLOC (and CALLOC) for single objects could be more
> widely useful, I think.

There's no reason you can't have both the building blocks and the thing
that is built for them. I think there are 5 spots that would use
DUPLICATE(), but I agree that there are more which could use ALLOC().

I'd be more worried that we're slowly drifting away from idiomatic C.
If it's safer, that's good. But if it makes it hard for people new to
the project to figure out what the hell is going on, that may be not so
good.

Here's the list of DUPLICATE spots, for reference.

---
diff --git a/builtin/blame.c b/builtin/blame.c
index f7aa95f4b..f0ac1c511 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -661,8 +661,8 @@ static struct origin *find_rename(struct scoreboard *sb,
 static void add_blame_entry(struct blame_entry ***queue,
 			    const struct blame_entry *src)
 {
-	struct blame_entry *e = xmalloc(sizeof(*e));
-	memcpy(e, src, sizeof(*e));
+	struct blame_entry *e;
+	DUPLICATE(e, src);
 	origin_incref(e->suspect);
 
 	e->next = **queue;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 72c815844..d6cb893cf 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -206,8 +206,8 @@ static void llist_sorted_difference_inplace(struct llist *A,
 static inline struct pack_list * pack_list_insert(struct pack_list **pl,
 					   struct pack_list *entry)
 {
-	struct pack_list *p = xmalloc(sizeof(struct pack_list));
-	memcpy(p, entry, sizeof(struct pack_list));
+	struct pack_list *p;
+	DUPLICATE(p, entry);
 	p->next = *pl;
 	*pl = p;
 	return p;
@@ -238,8 +238,7 @@ static struct pack_list * pack_list_difference(const struct pack_list *A,
 			return pack_list_difference(A->next, B);
 		pl = pl->next;
 	}
-	ret = xmalloc(sizeof(struct pack_list));
-	memcpy(ret, A, sizeof(struct pack_list));
+	DUPLICATE(ret, A);
 	ret->next = pack_list_difference(A->next, B);
 	return ret;
 }
@@ -450,8 +449,7 @@ static void minimize(struct pack_list **min)
 		perm_all = perm = get_permutations(non_unique, n);
 		while (perm) {
 			if (is_superset(perm->pl, missing)) {
-				new_perm = xmalloc(sizeof(struct pll));
-				memcpy(new_perm, perm, sizeof(struct pll));
+				DUPLICATE(new_perm, perm);
 				new_perm->next = perm_ok;
 				perm_ok = new_perm;
 			}
diff --git a/diff.c b/diff.c
index 051761be4..dfe02f403 100644
--- a/diff.c
+++ b/diff.c
@@ -1168,8 +1168,8 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 				 struct diff_filespec *two)
 {
 	int i;
-	struct diff_options *o = xmalloc(sizeof(struct diff_options));
-	memcpy(o, orig_opts, sizeof(struct diff_options));
+	struct diff_options *o;
+	DUPLICATE(o, orig_opts);
 
 	ecbdata->diff_words =
 		xcalloc(1, sizeof(struct diff_words_data));
