Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F25C12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB321613ED
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhGQCLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:11:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:52582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232184AbhGQCLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:11:16 -0400
Received: (qmail 22597 invoked by uid 109); 17 Jul 2021 02:08:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:08:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16405 invoked by uid 111); 17 Jul 2021 02:08:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:08:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:08:19 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/11] refs/files: add a comment about
 refs_reflog_exists() call
Message-ID: <YPI7k7TnfQSQM7YF@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-08.11-1e25b7c59c5-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-08.11-1e25b7c59c5-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:13:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Add a comment about why it is that we need to check for the the

s/the the//

> existence of a reflog we're deleting after we've successfully acquired
> the lock in files_reflog_expire(). As noted in [1] the lock protocol
> for reflogs is somewhat intuitive.

Did you mean unintuitive here?

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index ec9c70d79cc..f73637fa087 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3068,6 +3068,17 @@ static int files_reflog_expire(struct ref_store *ref_store,
>  		strbuf_release(&err);
>  		return -1;
>  	}
> +
> +	/*
> +	 * When refs are deleted their reflog is deleted before the
> +	 * ref itself deleted. This race happens because there's no
> +	 * such thing as a lock on the reflog, instead we always lock
> +	 * the "loose ref" (even if packet) above with
> +	 * lock_ref_oid_basic().
> +	 *
> +	 * If race happens we've got nothing more to do, we were asked
> +	 * to delete the reflog, and it's not there anymore. Great!
> +	 */
>  	if (!refs_reflog_exists(ref_store, refname)) {
>  		unlock_ref(lock);
>  		return 0;

I think everything is accurate here, though I wouldn't have made the
distinction with "locking the loose ref". There is no such thing as
locking a packed ref; we always take the loose lock.

s/packet/packed/, and maybe s/If race/If a race/.

-Peff
