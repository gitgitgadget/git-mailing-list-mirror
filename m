Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5FC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3E3619EC
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhKPTea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:34:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:60398 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhKPTe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:34:29 -0500
Received: (qmail 20975 invoked by uid 109); 16 Nov 2021 19:31:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Nov 2021 19:31:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1084 invoked by uid 111); 16 Nov 2021 19:31:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Nov 2021 14:31:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Nov 2021 14:31:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0006: date_mode can leak .strftime_fmt member
Message-ID: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
References: <211104.86mtmki5ol.gmgdl@evledraar.gmail.com>
 <patch-1.1-15f5bd3e4f4-20211116T183025Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-15f5bd3e4f4-20211116T183025Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 07:31:12PM +0100, Ævar Arnfjörð Bjarmason wrote:

> As there is no date_mode_release() API function, and given the
> set of current callers it probably is not worth adding one, let's
> release the .strftime_fmt member that is obtained from strdup()
> before the caller of show_date() is done with it.

It does feel a bit ugly to assume that we can touch strftime_fmt here,
especially since we don't even confirm that we parsed DATE_STRFTIME.
You initialize it as NULL and the current code doesn't touch it
otherwise, so there's no bug. But it would be reasonable for other date
formats to store ancillary data as a union with strftime_fmt, which
would invalidate this.

It also seems like other callers will need to do similar cleanup. E.g.,
"git -c log.date=format:foo log" has the same leak. So maybe it is worth
adding an actual cleanup function.

-Peff
