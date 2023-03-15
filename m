Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC217C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjCORSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjCORSH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:18:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A1284F7C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:18:00 -0700 (PDT)
Received: (qmail 18424 invoked by uid 109); 15 Mar 2023 17:18:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 17:18:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2293 invoked by uid 111); 15 Mar 2023 17:17:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 13:17:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 13:17:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
Message-ID: <ZBH9xxJDTT3jzm5u@coredump.intra.peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
 <230315.86h6umxh7c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230315.86h6umxh7c.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 02:37:39PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 	-		CALLOC_ARRAY(filter.name_patterns, alloc);
> 	-
> 	-		while (strbuf_getline(&line, stdin) != EOF) {
> 	-			ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
> 	-			filter.name_patterns[nr++] = strbuf_detach(&line, NULL);
> 	-		}
> 	-
> 	-		/* Add a terminating NULL string. */
> 	-		ALLOC_GROW(filter.name_patterns, nr + 1, alloc);
> 	-		filter.name_patterns[nr + 1] = NULL;
> 	+		while (strbuf_getline(&line, stdin) != EOF)
> 	+			strvec_push(&stdin_pat, line.buf);
> 	+		filter.name_patterns = stdin_pat.v;
> 	 	} else {
> 	 		filter.name_patterns = argv;
> 	 	}
> 	@@ -123,10 +117,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
> 	 	free_commit_list(filter.with_commit);
> 	 	free_commit_list(filter.no_commit);
> 	 	ref_sorting_release(sorting);
> 	-	if (from_stdin) {
> 	-		for (size_t i = 0; filter.name_patterns[i]; i++)
> 	-			free(filter.name_patterns[i]);
> 	-		free(filter.name_patterns);
> 	-	}
> 	+	strvec_clear(&stdin_pat);
> 	 	return 0;
> 	 }
> 
> It *is* an extra copy though, as your implementation re-uses the strbuf
> we already allocated.

At first I thought you meant "extra allocation" here. But you really do
mean an extra copy of the bytes.

The number of allocations is the same either way. In the original, we
detach the strbuf in each iteration of the loop as it becomes the final
entry in the array, but then have to allocate a new strbuf for the next
iteration. With a strvec, we can reuse the same strbuf over and over,
but make a new allocation when we add it to the strvec.

So yes, we end up with an extra memcpy() of the bytes. But the flip side
is that the final allocations we store in the strvec are correctly
sized, without the extra slop that the strbuf added while reading.

> But presumably that's trivial in this case, and if we care I think we
> should resurrect something like [1] instead, i.e. we could just teach
> the strvec API to have a strvec_push_nodup(). But I doubt that in this
> case it'll matter.

Yeah, I'd agree it is not important either way in this case. But I
wanted to think it through above, just because it's not clear to me that
even in a tight loop, the "allocate buffer and then attach to the
strvec" approach would be the better tradeoff.

I guess it would make sense to wait for a case where it _does_ matter
and then we could experiment with the two approaches. ;)

-Peff
