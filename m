Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B67C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 10:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDRKaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDRKaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 06:30:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7546B10FC
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 03:30:06 -0700 (PDT)
Received: (qmail 4901 invoked by uid 109); 18 Apr 2023 10:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 10:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 803 invoked by uid 111); 18 Apr 2023 10:30:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 06:30:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 06:30:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <20230418103005.GC508219@coredump.intra.peff.net>
References: <cover.1681764848.git.me@ttaylorr.com>
 <65ac7ed9b843a83f7b4cc0acd7b4e70d98ca20aa.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65ac7ed9b843a83f7b4cc0acd7b4e70d98ca20aa.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 04:54:15PM -0400, Taylor Blau wrote:

> The function `stage_tmp_packfiles()` generates a filename to use for
> staging the contents of what will become the pack's ".mtimes" file.
> 
> The name is generated in `write_mtimes_file()` and the result is
> returned back to `stage_tmp_packfiles()` which uses it to rename the
> temporary file into place via `rename_tmp_packfiles()`.
> 
> `write_mtimes_file()` returns a `const char *`, indicating that callers
> are not expected to free its result (similar to, e.g., `oid_to_hex()`).
> But callers are expected to free its result, so this return type is
> incorrect.

Makes sense. I do think in the long run that it might make sense for all
of these pack-write tmpfiles to tempfile.[ch] (either directly, or via
register_tempfile() after creating the file). And then it would be safe
to pass around the tempfile struct itself, which contains the filename,
without worrying so much about ownership issues.

But that's a much bigger change that shouldn't be part of your series.

-Peff
