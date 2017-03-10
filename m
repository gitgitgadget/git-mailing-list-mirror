Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5F5202F8
	for <e@80x24.org>; Fri, 10 Mar 2017 08:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755064AbdCJISF (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 03:18:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:41857 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbdCJISE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 03:18:04 -0500
Received: (qmail 13223 invoked by uid 109); 10 Mar 2017 08:18:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 08:18:02 +0000
Received: (qmail 1214 invoked by uid 111); 10 Mar 2017 08:18:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 03:18:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 03:18:00 -0500
Date:   Fri, 10 Mar 2017 03:18:00 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
Message-ID: <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
 <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
 <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
 <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
 <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
 <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
 <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
 <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
 <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
 <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 01:14:16AM +0100, René Scharfe wrote:

> >   2. Ones which just copy a single object, like:
> > 
> >        memcpy(&dst, &src, sizeof(dst));
> > 
> >      Perhaps we should be using struct assignment like:
> > 
> >        dst = src;
> > 
> >      here. It's safer and it should give the compiler more room to
> >      optimize. The only downside is that if you have pointers, it is
> >      easy to write "dst = src" when you meant "*dst = *src".
> 
> Compilers can usually inline memcpy(3) calls, but assignments are
> shorter and more pleasing to the eye, and we get a type check for
> free.  How about this?

Yeah, I mostly wasn't sure how people felt about "shorter and more
pleasing". It _is_ shorter and there's less to get wrong. But the
memcpy() screams "hey, I am making a copy" and is idiomatic to at least
a certain generation of C programmers.

I guess something like COPY(dst, src) removes the part that you can get
wrong, while still screaming copy. It's not idiomatic either, but at
least it stands out. I dunno.

> diff --git a/contrib/coccinelle/copy.cocci b/contrib/coccinelle/copy.cocci
> new file mode 100644
> index 0000000000..f0d883932a
> --- /dev/null
> +++ b/contrib/coccinelle/copy.cocci
> @@ -0,0 +1,31 @@
> +@@
> +type T;
> +T dst;
> +T src;
> [...]
> +type T;
> +T dst;
> +T *src;

I think this misses the other two cases: (*dst, src) and (*dst, *src).

Perhaps squash this in?

---
 builtin/blame.c               |  2 +-
 builtin/pack-redundant.c      |  4 ++--
 contrib/coccinelle/copy.cocci | 32 ++++++++++++++++++++++++++++++++
 diff.c                        |  4 ++--
 dir.c                         |  2 +-
 fast-import.c                 |  6 +++---
 line-log.c                    |  2 +-
 7 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f7aa95f4b..d0d917b37 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -680,7 +680,7 @@ static void dup_entry(struct blame_entry ***queue,
 {
 	origin_incref(src->suspect);
 	origin_decref(dst->suspect);
-	memcpy(dst, src, sizeof(*src));
+	*dst = *src;
 	dst->next = **queue;
 	**queue = dst;
 	*queue = &dst->next;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 72c815844..ac1d8111e 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -207,7 +207,7 @@ static inline struct pack_list * pack_list_insert(struct pack_list **pl,
 					   struct pack_list *entry)
 {
 	struct pack_list *p = xmalloc(sizeof(struct pack_list));
-	memcpy(p, entry, sizeof(struct pack_list));
+	*p = *entry;
 	p->next = *pl;
 	*pl = p;
 	return p;
@@ -451,7 +451,7 @@ static void minimize(struct pack_list **min)
 		while (perm) {
 			if (is_superset(perm->pl, missing)) {
 				new_perm = xmalloc(sizeof(struct pll));
-				memcpy(new_perm, perm, sizeof(struct pll));
+				*new_perm = *perm;
 				new_perm->next = perm_ok;
 				perm_ok = new_perm;
 			}
diff --git a/contrib/coccinelle/copy.cocci b/contrib/coccinelle/copy.cocci
index f0d883932..da9969c84 100644
--- a/contrib/coccinelle/copy.cocci
+++ b/contrib/coccinelle/copy.cocci
@@ -29,3 +29,35 @@ T *src;
 - memcpy(&dst, src, sizeof(T));
 + dst = *src;
 )
+
+@@
+type T;
+T *dst;
+T src;
+@@
+(
+- memcpy(dst, &src, sizeof(*dst));
++ *dst = src;
+|
+- memcpy(dst, &src, sizeof(src));
++ *dst = src;
+|
+- memcpy(dst, &src, sizeof(T));
++ *dst = src;
+)
+
+@@
+type T;
+T *dst;
+T *src;
+@@
+(
+- memcpy(dst, src, sizeof(*dst));
++ *dst = *src;
+|
+- memcpy(dst, src, sizeof(*src));
++ *dst = *src;
+|
+- memcpy(dst, src, sizeof(T));
++ *dst = *src;
+)
diff --git a/diff.c b/diff.c
index 051761be4..fbd68ecd0 100644
--- a/diff.c
+++ b/diff.c
@@ -1169,7 +1169,7 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 {
 	int i;
 	struct diff_options *o = xmalloc(sizeof(struct diff_options));
-	memcpy(o, orig_opts, sizeof(struct diff_options));
+	*o = *orig_opts;
 
 	ecbdata->diff_words =
 		xcalloc(1, sizeof(struct diff_words_data));
@@ -3359,7 +3359,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 
 void diff_setup(struct diff_options *options)
 {
-	memcpy(options, &default_diff_options, sizeof(*options));
+	*options = default_diff_options;
 
 	options->file = stdout;
 
diff --git a/dir.c b/dir.c
index 4541f9e14..d3d0039bf 100644
--- a/dir.c
+++ b/dir.c
@@ -2499,7 +2499,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	if (next > rd->end)
 		return -1;
 	*untracked_ = untracked = xmalloc(st_add(sizeof(*untracked), len));
-	memcpy(untracked, &ud, sizeof(ud));
+	*untracked = ud;
 	memcpy(untracked->name, data, len + 1);
 	data = next;
 
diff --git a/fast-import.c b/fast-import.c
index 6c13472c4..3e294c2b5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -875,7 +875,7 @@ static struct tree_content *dup_tree_content(struct tree_content *s)
 	for (i = 0; i < s->entry_count; i++) {
 		a = s->entries[i];
 		b = new_tree_entry();
-		memcpy(b, a, sizeof(*a));
+		*b = *a;
 		if (a->tree && is_null_sha1(b->versions[1].sha1))
 			b->tree = dup_tree_content(a->tree);
 		else
@@ -1685,7 +1685,7 @@ static int tree_content_remove(
 
 del_entry:
 	if (backup_leaf)
-		memcpy(backup_leaf, e, sizeof(*backup_leaf));
+		*backup_leaf = *e;
 	else if (e->tree)
 		release_tree_content_recursive(e->tree);
 	e->tree = NULL;
@@ -1735,7 +1735,7 @@ static int tree_content_get(
 	return 0;
 
 found_entry:
-	memcpy(leaf, e, sizeof(*leaf));
+	*leaf = *e;
 	if (e->tree && is_null_sha1(e->versions[1].sha1))
 		leaf->tree = dup_tree_content(e->tree);
 	else
diff --git a/line-log.c b/line-log.c
index 64f141e20..de5bbb5bd 100644
--- a/line-log.c
+++ b/line-log.c
@@ -765,7 +765,7 @@ static void move_diff_queue(struct diff_queue_struct *dst,
 			    struct diff_queue_struct *src)
 {
 	assert(src != dst);
-	memcpy(dst, src, sizeof(struct diff_queue_struct));
+	*dst = *src;
 	DIFF_QUEUE_CLEAR(src);
 }
 
