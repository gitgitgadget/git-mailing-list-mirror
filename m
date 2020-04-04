Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7530C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CEC206C3
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 14:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDDOVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:21:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33470 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725730AbgDDOVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 10:21:34 -0400
Received: (qmail 5142 invoked by uid 109); 4 Apr 2020 14:21:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 04 Apr 2020 14:21:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29395 invoked by uid 111); 4 Apr 2020 14:31:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Apr 2020 10:31:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Apr 2020 10:21:31 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix -Wmaybe-uninitialized warnings under -O0
Message-ID: <20200404142131.GA679473@coredump.intra.peff.net>
References: <33984eeaabbfbcfd4b9d3903549d8b7d6c4ced7e.1585726172.git.liu.denton@gmail.com>
 <20200401095255.GA60227@coredump.intra.peff.net>
 <20200401140643.GA880372@generichostname>
 <20200403140447.GA639586@coredump.intra.peff.net>
 <20200404120743.GA636417@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200404120743.GA636417@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 04, 2020 at 08:07:43AM -0400, Denton Liu wrote:

> >   for_each_string_list_item(...) {
> >     ret = for_each_fullref_in(...);
> 
> This loop is missing a bit of important context:
> 
> 	if (ret)
> 		break;
> 

Yes, I omitted it because it's not relevant to whether ret is
initialized or not (i.e., if we enter the loop then it always is.
But I think it is to the argument you make below.

> > Your patch silences it, but is it doing the right thing? It sets "ret =
> > 0", but we haven't actually iterated anything. Should it be an error
> > instead?
> 
> I understood the semantics of for_each_fullref_in_pattern() (in the
> non-early return case) to be "for each item, iterate and compute a
> value; if that value is non-zero return it. If not found, return zero".
> The missing context above is important since, without it, we lose the
> semantics.
> 
> If I'm understanding the above correctly then, studying this function in
> a vacuum, it would make sense to assign a default value of 0 since if
> the for operates on an empty list, the function should consider the item
> vacuously not found and we should return 0 as a result.

I think the break on "ret" is better understood as "if we saw an error,
return it; otherwise keep going".

If we were given zero patterns, is that a noop success, or is it an
error? This should never happen because we cover that case earlier, so
it would be a bug in find_longest_prefixes. Perhaps:

diff --git a/ref-filter.c b/ref-filter.c
index b1812cb69a..b358567663 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1964,6 +1964,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 	}
 
 	find_longest_prefixes(&prefixes, filter->name_patterns);
+	if (!prefixes.nr)
+		BUG("no common ref prefix?");
 
 	for_each_string_list_item(prefix, &prefixes) {
 		ret = for_each_fullref_in(prefix->string, cb, cb_data, broken);

is worth doing to document that assumption. Ideally that would then let
the compiler know that we'll always enter the loop, but it doesn't seem
to be quite the clever.

So I dunno. I think it probably doesn't matter between "0" and "-1",
because this case really shouldn't be reachable.

> This was the type of analysis I applied to the other changes. I'll admit
> that I studied the other functions in a vacuum as well since these
> seemed to be superficial warnings (since they aren't triggered with
> -O{0,2}) which indicated to me that the code was correct except for some
> "cosmetic" errors. I dunno, perhaps this is my inexperience showing
> through.

Yeah, the code is correct in this case, and I don't think the
uninitialized case can be reached. But the subtle linkage here is that
patterns[0] being non-NULL means that find_longest_prefixes() will never
return a zero-length list, which means we'll always enter that loop at
least once.

> P.S. Do we want to quash the -O3 warnings as well?

They're probably worth looking at. I've periodically swept through and
fixed them, as recently as last September (try "git log --grep=-O3").
But new ones seem to have cropped up. I'm not sure if they were
introduced in the code or if the compiler got smarter (or dumber).

Just skimming the output, I see:

  In function ‘ll_binary_merge’,
      inlined from ‘ll_xdl_merge’ at ll-merge.c:115:10,
      inlined from ‘ll_union_merge’ at ll-merge.c:151:9:
  ll-merge.c:74:4: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
     74 |    warning("Cannot merge binary files: %s (%s vs. %s)",
        |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     75 |     path, name1, name2);
        |     ~~~~~~~~~~~~~~~~~~~

This one seems likely to be accurate (and just uncovered by more
aggressive inlining). The union_merge function passes in NULL filenames,
and probably could trigger this warning on binary input.

  trace2/tr2_dst.c: In function ‘tr2_dst_get_trace_fd.part.0’:
  trace2/tr2_dst.c:296:10: error: ‘fd’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
    296 |  dst->fd = fd;
        |  ~~~~~~~~^~~~
  trace2/tr2_dst.c:229:6: note: ‘fd’ was declared here
    229 |  int fd;
        |      ^~

This one looks like a false positive. The tr2 code does something
unusual for our code base: on error it returns errno. And I think the
compiler is not aware that errno would not be zero after a syscall
failure. It might be worth changing the return value to match our usual
pattern (return -1, and the caller can look in errno), which would
appease the compiler as a side effect.

  revision.c: In function ‘do_add_index_objects_to_pending’:
  revision.c:322:22: error: array subscript [1, 2147483647] is outside array bounds of ‘char[1]’ [-Werror=array-bounds]
    322 |   if (0 < len && name[len] && buf.len)
        |                  ~~~~^~~~~

This one is confusing. I imagine the char[1] is the empty string we
frequently pass to add_pending_object() and friends. And the "len" here
comes from interpret_branch_name(name, ...). So somehow the compiler
doesn't quite know that the length we'll return is going to be less than
or equal to the string length we pass in.

I don't know how to fix that aside from this, which isn't great (btw, it
looks like a lot of this code could stand to switch to using ssize_t
instead of int; there are probably weird errors if you managed to
somehow feed a 2GB branch name).

diff --git a/revision.c b/revision.c
index 8136929e23..9bc398bec1 100644
--- a/revision.c
+++ b/revision.c
@@ -317,9 +317,10 @@ static void add_pending_object_with_path(struct rev_info *revs,
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
-		int len = interpret_branch_name(name, 0, &buf, 0);
+		size_t namelen = strlen(name);
+		int len = interpret_branch_name(name, namelen, &buf, 0);
 
-		if (0 < len && name[len] && buf.len)
+		if (len == namelen && buf.len)
 			strbuf_addstr(&buf, name + len);
 		add_reflog_for_walk(revs->reflog_info,
 				    (struct commit *)obj,

-Peff
