Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDDAC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F92061450
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 14:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhDWO1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 10:27:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:33408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDWO1P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 10:27:15 -0400
Received: (qmail 7490 invoked by uid 109); 23 Apr 2021 14:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 14:26:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8971 invoked by uid 111); 23 Apr 2021 14:26:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 10:26:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 10:26:38 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 3/6] fsck: don't hard die on invalid object types
Message-ID: <YILZHiuUyj0mt958@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
 <patch-3.6-d0d9cb33315-20210413T093734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.6-d0d9cb33315-20210413T093734Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 11:43:06AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change builtin/fsck.c to pass down a
> OBJECT_INFO_ALLOW_UNKNOWN_TYPE. This changes this very ungraceful
> error:
> 
>     $ git hash-object --stdin -w -t garbage --literally </dev/null
>     <OID>
>     $ git fsck
>     fatal: invalid object type
>     $
> 
> Into:
> 
>     $ git fsck
>     error: hash mismatch for <OID_PATH> (expected <OID>)
>     error: <OID>: object corrupt or missing: <OID_PATH>
>     [ the rest of the fsck output here, i.e. it didn't hard die ]
> 
> We'll still exit with non-zero, but now we'll finish the rest of the
> traversal. The tests that's being added here asserts that we'll still
> complain about other fsck issues (e.g. an unrelated dangling blob).
> 
> But why are we complaining about a "hash mismatch" for an object of a
> type we don't know about? We shouldn't. This is the bare minimal
> change needed to not make fsck hard die on a repository that's been
> corrupted in this manner. In subsequent commits we'll teach fsck to
> recognize this particular type of corruption and emit a better error
> message.

OK. The overall goal makes sense.

> The parse_loose_header() function being changed here is only used in
> builtin/fsck.c, see f6371f92104 (sha1_file: add read_loose_object()
> function, 2017-01-13) for its introduction.

This left me scratching my head for a long time. Did you mean
read_loose_object() in the beginning of the sentence?

> -static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
> -				       unsigned int flags)
> +int parse_loose_header(const char *hdr,
> +		       struct object_info *oi,
> +		       unsigned int flags)

So we are getting rid of the "extended" form and just making the
non-extended way take an OI. That seems kind of orthogonal...

> --- a/streaming.c
> +++ b/streaming.c
> @@ -341,6 +341,9 @@ static struct stream_vtbl loose_vtbl = {
>  
>  static open_method_decl(loose)
>  {
> +	struct object_info oi2 = OBJECT_INFO_INIT;
> +	oi2.sizep = &st->size;
> +

...and is what leads us to having to touch this otherwise unrelated
function.

I don't mind _too_ much getting rid of a helper function that would have
only one caller remaining (though "oi2" is a bit mysterious here). But
it seems like the patch would have been a lot easier to understand if
that were separately done (and explained). AFAICT the functional change
here is just passing the flag to read_loose_object(), which could be
calling parse_loose_header_extended(). I guess that would have to become
public, but that seems reasonable.

-Peff
