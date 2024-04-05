Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC81D530
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338521; cv=none; b=SJWxWG80uWV0e+/6OlOJagxr992/LhBWZDOJm6RPUJ+Mva2D+G7xDcNY1rEDCXTnzk9+E9XgZC0RvWdxNGPmqEQzS0O5CNSex/zOg6HPnBDlqmBtny7rv24/hkR8kpOt1E1Wrta5S9Ap+mhNdWY6Qlm+XHs49EMMB3Tg2KldlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338521; c=relaxed/simple;
	bh=CtRIQWzObDyAWxhKwlo257dgNNYvbfqgId1YGEslLIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5jriJDKCX5jO4n+X3fXkRuKaeiJkHOhI+acxg6etm/GvBcp5D6gIMHuiN18WudQTeTRBQkvBV+TMBYZHA19b/O7XmTuoB2FcoCQseusjjjuLlyMELQMSbuxJ3vkuILWQK0LvGn/kQ5Bi882Cqm5gX0gg+lPO8yt00wvVAk1RQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18119 invoked by uid 109); 5 Apr 2024 17:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Apr 2024 17:35:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30812 invoked by uid 111); 5 Apr 2024 17:35:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Apr 2024 13:35:19 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Apr 2024 13:35:17 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: free and errno, was Re: [PATCH] apply: replace mksnpath() with a
 mkpathdup() call
Message-ID: <20240405173517.GA2529133@coredump.intra.peff.net>
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
 <20240404225313.GA2512966@coredump.intra.peff.net>
 <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14c99998-cc4a-4581-aab3-607d7fac7edb@web.de>

On Fri, Apr 05, 2024 at 12:52:35PM +0200, René Scharfe wrote:

> > So would it be that unreasonable to assume the modern, desired behavior,
> > and mostly shrug our shoulders for other platforms? We could even
> > provide:
> >
> >   #ifdef FREE_CLOBBERS_ERRNO
> >   void git_free(void *ptr)
> >   {
> >         int saved_errno = errno;
> >         free(ptr);
> >         errno = saved_errno;
> >   }
> >   #define free(ptr) git_free(ptr)
> >   #endif
> >
> > if we really wanted to be careful, though it's hard to know which
> > platforms even need it (and again, it's so rare to come up in practice
> > that I'd suspect people could go for a long time before realizing their
> > platform was a problem). I guess the flip side is that we could use the
> > function above by default, and disable it selectively (the advantage of
> > disabling it being that it's slightly more efficient; maybe that's not
> > even measurable?).
> 
> I think performing this ritual automatically every time on all platforms
> (i.e. to use git_free() unconditionally) to provide sane errno values
> around free(3) calls is better than having to worry about attacks from
> the deep.  But then again I'm easily scared and still a bit in shock, so
> perhaps I'm overreacting.

You may be right. The main reason not to do it is the extra assignments
(and call to errno, which I think can be a function hidden behind a
macro these days). But I kind of doubt it is measurable, and we expect
malloc/free to be a bit heavyweight (compared to regular instructions)
anyway. So it is probably me being overly cautious about the performance
side.

The other reason is that macros (especially of system names) can create
their own headaches.  We could require xfree() everywhere as a
complement to xmalloc (or maybe even just places where the errno
preservation seems useful), but that's one more thing to remember.

With the patch below you can see both in action:

  - hyperfine seems to show the git_free() version as ~1% slower to run
    "git log" (which I picked as something that probably does a
    reasonable number of mallocs). Frankly, I'm still suspicious that it
    could have such an impact. Maybe inlining git_free() would help?

  - usually #defining free(ptr) with an argument will avoid confusion
    with the word "free" as a token. But in this case there's a function
    pointer which is then called as struct->free(ptr), causing
    confusion.

diff --git a/convert.c b/convert.c
index 35b25eb3cb..dfb31ee3a3 100644
--- a/convert.c
+++ b/convert.c
@@ -1549,7 +1549,7 @@ typedef void (*free_fn)(struct stream_filter *);
 
 struct stream_filter_vtbl {
 	filter_fn filter;
-	free_fn free;
+	free_fn free_stream;
 };
 
 struct stream_filter {
@@ -1582,7 +1582,7 @@ static void null_free_fn(struct stream_filter *filter UNUSED)
 
 static struct stream_filter_vtbl null_vtbl = {
 	.filter = null_filter_fn,
-	.free = null_free_fn,
+	.free_stream = null_free_fn,
 };
 
 static struct stream_filter null_filter_singleton = {
@@ -1691,7 +1691,7 @@ static void lf_to_crlf_free_fn(struct stream_filter *filter)
 
 static struct stream_filter_vtbl lf_to_crlf_vtbl = {
 	.filter = lf_to_crlf_filter_fn,
-	.free = lf_to_crlf_free_fn,
+	.free_stream = lf_to_crlf_free_fn,
 };
 
 static struct stream_filter *lf_to_crlf_filter(void)
@@ -1787,7 +1787,7 @@ static void cascade_free_fn(struct stream_filter *filter)
 
 static struct stream_filter_vtbl cascade_vtbl = {
 	.filter = cascade_filter_fn,
-	.free = cascade_free_fn,
+	.free_stream = cascade_free_fn,
 };
 
 static struct stream_filter *cascade_filter(struct stream_filter *one,
@@ -1939,7 +1939,7 @@ static void ident_free_fn(struct stream_filter *filter)
 
 static struct stream_filter_vtbl ident_vtbl = {
 	.filter = ident_filter_fn,
-	.free = ident_free_fn,
+	.free_stream = ident_free_fn,
 };
 
 static struct stream_filter *ident_filter(const struct object_id *oid)
@@ -1992,7 +1992,7 @@ struct stream_filter *get_stream_filter(struct index_state *istate,
 
 void free_stream_filter(struct stream_filter *filter)
 {
-	filter->vtbl->free(filter);
+	filter->vtbl->free_stream(filter);
 }
 
 int stream_filter(struct stream_filter *filter,
diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5..324c47fdff 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1094,6 +1094,9 @@ static inline void move_array(void *dst, const void *src, size_t n, size_t size)
 	COPY_ARRAY(ALLOC_ARRAY((dst), dup_array_n_), (src), dup_array_n_); \
 } while (0)
 
+void git_free(void *ptr);
+#define free(ptr) git_free(ptr)
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
diff --git a/wrapper.c b/wrapper.c
index eeac3741cf..cfffb177e3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -822,3 +822,14 @@ uint32_t git_rand(void)
 
 	return result;
 }
+
+/* this should probably go in its own file, otherwise anything
+ * added below here uses the bare free()
+ */
+#undef free
+void git_free(void *ptr)
+{
+	int saved_errno = errno;
+	free(ptr);
+	errno = saved_errno;
+}
