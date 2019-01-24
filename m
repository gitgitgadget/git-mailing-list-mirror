Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126E41F453
	for <e@80x24.org>; Thu, 24 Jan 2019 12:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfAXMKk (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 07:10:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:47038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727386AbfAXMKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 07:10:39 -0500
Received: (qmail 24831 invoked by uid 109); 24 Jan 2019 12:10:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 12:10:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27720 invoked by uid 111); 24 Jan 2019 12:10:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 07:10:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 07:10:38 -0500
Date:   Thu, 24 Jan 2019 07:10:38 -0500
From:   Jeff King <peff@peff.net>
To:     Joey Hess <id@joeyh.name>
Cc:     git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124121037.GA4949@sigill.intra.peff.net>
References: <20190122220714.GA6176@kitenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122220714.GA6176@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 06:07:14PM -0400, Joey Hess wrote:

> joey@darkstar:~/tmp/t> ls -l big-file
> -rw-r--r-- 1 joey joey 11811160064 Jan 22 17:48 big-file
> joey@darkstar:~/tmp/t> git status
> fatal: Out of memory, realloc failed
> 
> This file is checked into git, but using a smudge/clean filter, so the actual
> data checked into git is a hash. I did so using git-annex v7 mode, but I
> suppose git lfs would cause the same problem.
> 
> [pid  6573] mmap(NULL, 11811164160, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)
> 
> Why status needs to mmap a large file that is not modified
> and that is configured to pass through smudge/clean, I don't know.
> It seems like it should be possible for status work in this situation.

One minor point: I don't think this is us mmap-ing the file. The
descriptor is -1, and Git never uses PROT_WRITE. This is likely your
libc using mmap to fulfill a malloc() request.

That said, it just turns the question into: why did Git try to malloc
that many bytes?  If I reproduce your example (using a 100MB file) and
set GIT_ALLOC_LIMIT in the environment, the backtrace to die() is:

  #1  0x0000555555786d65 in memory_limit_check (size=104857601, gentle=0) at wrapper.c:27
  #2  0x0000555555787084 in xrealloc (ptr=0x0, size=104857601) at wrapper.c:137
  #3  0x000055555575612e in strbuf_grow (sb=0x7fffffffdbf0, extra=104857600) at strbuf.c:98
  #4  0x000055555575731a in strbuf_read (sb=0x7fffffffdbf0, fd=4, hint=104857600) at strbuf.c:429
  #5  0x0000555555664a1f in apply_single_file_filter (path=0x5555558c787c "foo.rand", ...)
  #6  0x0000555555665321 in apply_filter (path=0x5555558c787c "foo.rand", ...)
  ...

Looking at apply_single_file_filter(), it's not the _original_ file that
it's trying to store, but rather the data coming back from the filter.
It's just that we use the original file size as a hint!

In this case (and I'd venture to say in most gigantic-file cases) it's
much larger than we need, to the point of causing a problem.

In other words, I think this patch fixes your problem:

diff --git a/convert.c b/convert.c
index 0d89ae7c23..85aebe2ed3 100644
--- a/convert.c
+++ b/convert.c
@@ -732,7 +732,7 @@ static int apply_single_file_filter(const char *path, const char *src, size_t le
 	if (start_async(&async))
 		return 0;	/* error was already reported */
 
-	if (strbuf_read(&nbuf, async.out, len) < 0) {
+	if (strbuf_read(&nbuf, async.out, 0) < 0) {
 		err = error(_("read from external filter '%s' failed"), cmd);
 	}
 	if (close(async.out)) {

though possibly we should actually continue to use the file size as a
hint up to a certain point, which avoids reallocations for more "normal"
filters where the input and output sizes are in the same ballpark.

Just off the top of my head, something like:

  /* guess that the filtered output will be the same size as the original */
  hint = len;

  /* allocate 10% extra in case the clean size is slightly larger */
  hint *= 1.1;

  /*
   * in any case, never go higher than half of core.bigfileThreshold.
   * We'd like to avoid allocating more bytes than that, and that still
   * gives us room for our strbuf to preemptively double if our guess is
   * just a little on the low side.
   */
  if (hint > big_file_threshold / 2)
	hint = big_file_threshold / 2;

But to be honest, I have no idea if that would even produce measurable
benefits over simply growing the strbuf from scratch (i.e., hint==0).

-Peff
