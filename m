Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95398C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiGKSGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKSGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 14:06:40 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA72B634
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 11:06:39 -0700 (PDT)
Received: (qmail 8644 invoked by uid 109); 11 Jul 2022 18:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 18:06:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22061 invoked by uid 111); 11 Jul 2022 18:06:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 14:06:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 14:06:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 11/27] revisions API users: add "goto cleanup" for
 release_revisions()
Message-ID: <YsxmrRCSpze1csHz@coredump.intra.peff.net>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
 <patch-v6-11.27-e93791b6242-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-11.27-e93791b6242-20220413T195935Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 10:01:40PM +0200, Ævar Arnfjörð Bjarmason wrote:

> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index 70103c40952..2bfaf9ba7ae 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -77,8 +77,12 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
>  
>  	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
>  		perror("read_cache_preload");
> -		return -1;
> +		result = -1;
> +		goto cleanup;
>  	}
> +cleanup:
>  	result = run_diff_files(&rev, options);
> -	return diff_result_code(&rev.diffopt, result);
> +	result = diff_result_code(&rev.diffopt, result);
> +	release_revisions(&rev);
> +	return result;
>  }

A bit late, but I happened to notice Coverity complaining about this
code. And indeed, this patch seems pretty broken. If
read_cache_preload() fails, we assign "-1" to result and jump to
cleanup.

But then the first thing we do in cleanup is overwrite result! That
hides the error (depending on how run_diff_files behaves if the cache
load failed, but one can imagine it thinks there are no files to diff).

Should the cleanup label come after the call to run_diff_files()?

I was also somewhat confused by the double-assignment of "result" in the
cleanup label. But I think that is because diff_result_code() is
massaging the current value of "result" into the right thing. But in
that case, should the "-1" from earlier be passed to diff_result_code()?
I think probably not (and certainly it was not before your patch). Which
would imply that the label should go after that, like:

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 2bfaf9ba7a..92cf6e1e92 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -80,9 +80,9 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		result = -1;
 		goto cleanup;
 	}
-cleanup:
 	result = run_diff_files(&rev, options);
 	result = diff_result_code(&rev.diffopt, result);
+cleanup:
 	release_revisions(&rev);
 	return result;
 }

-Peff
