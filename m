Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF82E36EB
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754130173; cv=none; b=FgTYJnvl5KGu94B8LFpHu4et409rAuhAlV1mVFHJrgDE3CJo6FuJkoEPawlAZH/MuOwgqZnQ1/1Yua87aqbUQFDhvfwPhZUAXpXKyfRvVb3xPXS4bngQEkM0nOl5hRV+q6fUTaTj/t5YOlLq8IEkU6TqNrx6HGtUJ2Va4w9VelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754130173; c=relaxed/simple;
	bh=UpP2n8hLC/6ZqcuNP72oADoHVzFGF8AeTHzWSULAMuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLwpCJ2wVGYCznfoGKO5NJrw3PNKeghWwOfI8zxhTbqfMxgujv75ROQRyWNqPN7wCntq5XGUjNMfxCTl0qTUQKFJsn7dTT5L+/g9kpLANOnla7DI6oLxNG2mkTdW1Gwx68Cln1mBGaBMi0d+ORVb/2GXtPuC7qgAa70+cYNrJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=POy+F9t6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="POy+F9t6"
Received: (qmail 9081 invoked by uid 109); 2 Aug 2025 10:22:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UpP2n8hLC/6ZqcuNP72oADoHVzFGF8AeTHzWSULAMuY=; b=POy+F9t6nGsV7Bfi9jNRk8OwhNhSnDGC7PIvIfT5bQGYYZcI4o9QfKYi5i2u8oJmuAzj/oWNNaKU+09eqBWYgOJPv6SyF267wPg4zGQX8toh1RSE3tWQ3oJ3GDoWcXqRMc2XrR1ek3lceDDsIWbVNHJMZZLDLVeGWDXr1ZabQzZvRYXn/sFhzGwBjsTZsDrpIOhC5/Vf0wU2SXCp28po8TEX7zRqJAAv6fiisNRzIaJ6tSQ5fUhJhAJ/Usc9eK7ZL3b4T6mUSfMgLaeQEECkTCmkgdpP/fGcG99IXkWVdziV2bl1T91H9j2JyObvZJ+d3fRlWfJsIB+X6mB5l8uSVA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 10:22:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12174 invoked by uid 111); 2 Aug 2025 10:22:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 06:22:55 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 06:22:49 -0400
From: Jeff King <peff@peff.net>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, hi@arnes.space,
	michal@isc.org
Subject: Re: [PATCH] diff: ensure consistent diff behavior with -I<regex>
 across output formats
Message-ID: <20250802102249.GA3738980@coredump.intra.peff.net>
References: <xmqqikjg47qt.fsf@gitster.g>
 <20250729081820.34626-1-yldhome2d2@gmail.com>
 <xmqqcy9io73j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy9io73j.fsf@gitster.g>

On Tue, Jul 29, 2025 at 05:28:00PM -0700, Junio C Hamano wrote:

> The enthusiasm is appreciated, but the implementation raises two
> questions.
> 
>  * This special cases -I<pattern>, but any option that causes us to
>    set the .diff_from_contents flag, not just -I<pattern>, can cause
>    the raw blob comparison to be potentially different from what the
>    blob contents are compared with various "ignore this class of
>    changes" criteria.  Shouldn't "git diff -w --name-status" and the
>    like get the same treatment?

We already have the diff_from_contents flag which is used for
--exit-code. We should be able to see where that logic is applied and do
something similar. It looks like it happens in diff_flush(), which makes
sense:

          if (output_format & DIFF_FORMAT_NO_OUTPUT &&
              options->flags.exit_with_status &&
              options->flags.diff_from_contents) {
                  /*
                   * run diff_flush_patch for the exit status. setting
                   * options->file to /dev/null should be safe, because we
                   * aren't supposed to produce any output anyway.
                   */
                  diff_free_file(options);
                  options->file = xfopen("/dev/null", "w");
                  options->close_file = 1;
                  options->color_moved = 0;
                  for (i = 0; i < q->nr; i++) {
                          struct diff_filepair *p = q->queue[i];
                          if (check_pair_status(p))
                                  diff_flush_patch(p, options);
                          if (options->found_changes)
                                  break;
                  }
          }

So here's a naive application of the same technique:

diff --git a/diff.c b/diff.c
index 76291e238c..0fe6eb7443 100644
--- a/diff.c
+++ b/diff.c
@@ -6845,8 +6845,28 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_CHECKDIFF)) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				flush_one_pair(p, options);
+
+			if (!check_pair_status(p))
+				continue;
+
+			if (options->flags.diff_from_contents) {
+				FILE *orig_out = options->file;
+				int orig_changes = options->found_changes;
+				int skip;
+
+				options->file = xfopen("/dev/null", "w");
+				diff_flush_patch(p, options);
+				skip = !options->found_changes;
+
+				fclose(options->file);
+				options->file = orig_out;
+				options->found_changes = orig_changes;
+
+				if (skip)
+					continue;
+			}
+
+			flush_one_pair(p, options);
 		}
 		separator++;
 	}

which works on a trivial example. It affects all of raw, name-only,
name-status, and checkdiff. I know Junio said that --raw should not be
affected, but I'm not sure I agree. Anyway, it should be possible to
split the logic by output type.

I'm not sure if stuff like --stat would need something similar. It's
already doing a content comparison, so presumably it handles it
internally. Maybe stuff like --dirstat would need it, too? In which case
we'd maybe want to annotate each filepair in an initial loop with
whether it's modified at the content-level, and then take that into
account in various code paths.

And of course it's horribly hacky looking. Some refactoring might help.
Certainly it is silly to open /dev/null each time through the loop.
There might also be a better way of checking whether the diff found
anything than the found_changes flag.

So this is really just sketching out the direction, and somebody would
need to figure out the details.

>  * Also, should we internally run diff twice, especially even when
>    we are going to show the patch output and are not limited to
>    FORMAT_NAME and FORMAT_NAME_STATUS?  Generally, running the real
>    diff in any of the diffcore transformatin is a sign of trouble.

The patch above also runs the diff twice for "-Ifoo --name-only -p". But
I think we are kind of stuck there. We want to show all name-only
entries before any content diffs. So either we have to run the content
diff twice, or we have to buffer it to show after we decide whether to
show name-only entries.

-Peff
