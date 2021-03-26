Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA360C433E6
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 05:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF3661A43
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 05:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZF25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 01:28:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:49522 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhCZF2d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 01:28:33 -0400
Received: (qmail 28593 invoked by uid 109); 26 Mar 2021 05:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 05:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7939 invoked by uid 111); 26 Mar 2021 05:28:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 01:28:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 01:28:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: Re: [RFC PATCH v1 1/2] pathspec: warn: long and short forms are
 incompatible
Message-ID: <YF1w/xKbozpQn7Vf@coredump.intra.peff.net>
References: <xmqqft1iquka.fsf@gitster.g>
 <20210326024005.26962-1-stdedos+git@gmail.com>
 <20210326024005.26962-2-stdedos+git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210326024005.26962-2-stdedos+git@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 04:40:04AM +0200, Σταύρος Ντέντος wrote:

> +void check_mishandled_exclude(const char *entry) {
> +	size_t entry_len = strlen(entry);
> +	char flags[entry_len];
> +	char path[entry_len];

We avoid using variable-length arrays in our codebase. For one thing,
they were not historically supported by all platforms (we are slowly
using more C99 features, but we are introducing them slowly and
intentionally).

But two, they are limited in size and the failure mode is not graceful.
If "entry" is larger than the available stack, then we'll get a segfault
with no option to handle it better.

> +	if (sscanf(entry, ":!(%4096[^)])%4096s", &flags, &path) != 2) {
> +		return;

We also generally avoid using scanf, because it's error-prone. The
"4096" is scary here, but I don't _think_ it's a buffer overflow,
because "path" is already the same size as "entry" (not including the
NUL terminator, but that is negated by the fact that we'll have skipped
at least ":!").

Is this "%4096[^)]" actually valid? I don't think scanf understands
regular expressions.

We'd want to avoid making an extra copy of the string anyway. So you'd
probably want to just parse left-to-right in the original string, like:

  const char *p = entry;

  /* skip past stuff we know must be there */
  if (!skip_prefix(p, ":!(", &p))
        return;

  /* this checks count_slashes() > 0 in the flags section, though I'm
   * not sure I understand what that is looking for... */
  for (; *p && *p != ')'; p++) {
        if (*p == '/')
	        return;
  }
  if (*p++ != ')')
        return;

  /* now p is pointing at "path", though we don't seem to do anything
   * with it... */

-Peff
