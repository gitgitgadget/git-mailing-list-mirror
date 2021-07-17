Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CFC12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BDD6127C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhGQCd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:33:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:52634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232405AbhGQCd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:33:28 -0400
Received: (qmail 22661 invoked by uid 109); 17 Jul 2021 02:30:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:30:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16518 invoked by uid 111); 17 Jul 2021 02:30:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:30:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:30:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 11/11] refs/files: remove unused "errno == EISDIR" code
Message-ID: <YPJAx1AIkMhN/dgV@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-11.11-96c3e5e9f79-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-11.11-96c3e5e9f79-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:13:07PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Further historical commentary:
> 
> Before the two preceding commits the caller in files_reflog_expire()
> was the only one out of our 4 callers that would pass non-NULL as an
> oid. We would then set a (now gone) "resolve_flags" to
> "RESOLVE_REF_READING" and just before that "errno != EISDIR" check do:
> [...]

Right, thanks for digging into this situation in the commit message.

> @@ -891,30 +890,9 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
>  	CALLOC_ARRAY(lock, 1);
>  
>  	files_ref_path(refs, &ref_file, refname);
> -	resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
> -					     RESOLVE_REF_NO_RECURSE,
> -					     &lock->old_oid, type);
> -	if (!resolved && errno == EISDIR) {
> -		/*
> -		 * we are trying to lock foo but we used to
> -		 * have foo/bar which now does not exist;
> -		 * it is normal for the empty directory 'foo'
> -		 * to remain.
> -		 */
> -		if (remove_empty_directories(&ref_file)) {
> -			last_errno = errno;
> -			if (!refs_verify_refname_available(
> -					    &refs->base,
> -					    refname, NULL, NULL, err))
> -				strbuf_addf(err, "there are still refs under '%s'",
> -					    refname);
> -			goto error_return;
> -		}
> -		resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
> -						     RESOLVE_REF_NO_RECURSE,
> -						     &lock->old_oid, type);
> -	}
> -	if (!resolved) {
> +	if (!refs_resolve_ref_unsafe(&refs->base, refname,
> +				     RESOLVE_REF_NO_RECURSE,
> +				     &lock->old_oid, type)) {

I agree that this is all trivially dead code now, and can be removed.

>  		last_errno = errno;
>  		if (last_errno != ENOTDIR ||
>  		    !refs_verify_refname_available(&refs->base, refname,

Not necessary, but I think "last_errno != ENOTDIR" will always be true
now, too. We treat it the same as EISDIR in refs_resolve_ref_unsafe().
It's not that big a cleanup, but it could easily go on top.

-Peff
