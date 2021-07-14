Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E126C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0A761378
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhGNQYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:24:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:49452 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhGNQYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:24:17 -0400
Received: (qmail 28515 invoked by uid 109); 14 Jul 2021 16:21:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 16:21:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25580 invoked by uid 111); 14 Jul 2021 16:21:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jul 2021 12:21:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jul 2021 12:21:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Message-ID: <YO8PBBJZ2Q+5ZqFs@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:17:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Since a1c1d8170d (refs_resolve_ref_unsafe: handle d/f conflicts for
> writes, 2017-10-06) we don't, because our our callstack will look
> something like:
> 
>     files_copy_or_rename_ref() -> lock_ref_oid_basic() -> refs_resolve_ref_unsafe()
> 
> And then the refs_resolve_ref_unsafe() call here will in turn (in the
> code added in a1c1d8170d) do the equivalent of this (via a call to
> refs_read_raw_ref()):
> 
> 	/* Via refs_read_raw_ref() */
> 	fd = open(path, O_RDONLY);
> 	if (fd < 0)
> 		/* get errno == EISDIR */
> 	/* later, in refs_resolve_ref_unsafe() */
> 	if ([...] && errno != EISDIR)
> 		return NULL;
> 	[...]
> 	/* returns the refs/heads/foo to the caller, even though it's a directory */
> 	return refname;

Isn't that pseudo-code missing a conditional that's there in the real
code? In refs_resolve_ref_unsafe(), I see:

       if (refs_read_raw_ref(refs, refname,
                             oid, &sb_refname, &read_flags)) {
               *flags |= read_flags;

               /* In reading mode, refs must eventually resolve */
               if (resolve_flags & RESOLVE_REF_READING)
                       return NULL;

               /*
                * Otherwise a missing ref is OK. But the files backend
                * may show errors besides ENOENT if there are
                * similarly-named refs.
                */
               if (errno != ENOENT &&
                   errno != EISDIR &&
                   errno != ENOTDIR)
                       return NULL;

So if RESOLVE_REF_READING is set, we can return NULL immediately, with
errno set to EISDIR. Which contradicts this:

> I.e. even though we got an "errno == EISDIR" we won't take this
> branch, since in cases of EISDIR "resolved" is always
> non-NULL. I.e. we pretend at this point as though everything's OK and
> there is no "foo" directory.

So when is RESOLVE_REF_READING set? The resolve_flags parameter is
passed in by the caller. In lock_ref_oid_basic(), it comes from this:

    int mustexist = (old_oid && !is_null_oid(old_oid));
    [...]
    if (mustexist)
            resolve_flags |= RESOLVE_REF_READING;

So do any callers pass in old_oid? Surprisingly few. It used to be
called from other locking functions, but these days it looks like it is
only files_reflog_expire().

I'm not sure if this case is important or not. If we're expecting the
ref to exist, then an in-the-way directory is going to mean failure
either way. It could still exist within the packed-refs file, but then
refs_read_raw_ref() would not return failure.

So...I think it's fine? But the argument in your commit message seems to
have missed this case entirely.

-Peff
