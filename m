Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D60C12002
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6EF613DA
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 02:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhGQC0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 22:26:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:52600 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhGQC0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 22:26:42 -0400
Received: (qmail 22624 invoked by uid 109); 17 Jul 2021 02:23:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jul 2021 02:23:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16459 invoked by uid 111); 17 Jul 2021 02:23:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 22:23:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 22:23:45 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 09/11] reflog expire: don't lock reflogs using
 previously seen OID
Message-ID: <YPI/MYsdGaAysXr6@coredump.intra.peff.net>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-09.11-60d6cf342fc-20210716T140631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:13:05PM +0200, Ævar Arnfjörð Bjarmason wrote:

> During reflog expiry, the cmd_reflog_expire() function first iterates
> over all reflogs in logs/*, and then one-by-one acquires the lock for
> each one and expires it. This behavior has been with us since this
> command was implemented in 4264dc15e1 ("git reflog expire",
> 2006-12-19).
> 
> Change this to stop calling lock_ref_oid_basic() with the OID we saw
> when we looped over the logs, instead have it pass the OID it managed
> to lock.
> 
> This mostly mitigates a race condition where e.g. "git gc" will fail
> in a concurrently updated repository because the branch moved since
> "git reflog expire --all" was started. I.e. with:
> 
>     error: cannot lock ref '<refname>': ref '<refname>' is at <OID-A> but expected <OID-B>
> 
> This behavior of passing in an "oid" was needed for an edge-case that
> I've untangled in this and preceding commits though, namely that we
> needed this OID because we'd:
> 
>  1. Lookup the reflog name/OID via dwim_log()
>  2. With that OID, lock the reflog
>  3. Later in builtin/reflog.c we use the we looked as input to
>     lookup_commit_reference_gently(), assured that it's equal to the
>     OID we got from dwim_log().

s/we use the we/we use the oid we/ in point 3, I think?

This explains the race and why it mitigates it, which is good. Are we
sure that there is no value in matching the oid we found during the log
lookup with the current value of the ref? I.e., why is this safe to do?

I suspect it is OK. The only problem would be if the reflog.c is somehow
relying on the ref's value not having changed from the earlier call
(e.g., if it did some reachability computation based on that value).

But I don't think so. Between the dwim_log() call and the
reflog_expire() call in reflog_expire(), we do almost nothing. In
reflog_delete(), between the two we do count up the entries to find a
record number. We do use that in deciding whether to expire an entry,
but:

  - I believe it is counting up from the beginning of time, so if
    somebody appends a new entry in the meantime, we are OK.

  - Further updates are not strictly prevented by comparing the oids
    anyway (we could generate new reflog entries without changing the
    ref; either a noop, or a switch-and-revert).

I do suspect there's a latent bug there if somebody else tries to expire
the reflogs (because now they're deleting old entries which are part of
our "recno"). But it is neither helped nor hindered by your change here,
so let's ignore it for now.

> [...]

The patch itself looks correct to me.

I think it would be good to have a brief "why is this safe" argument in
the commit message along the lines of what I wrote above.

-Peff
