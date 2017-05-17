Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF182027C
	for <e@80x24.org>; Wed, 17 May 2017 13:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbdEQN2p (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:28:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:53657 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753426AbdEQN2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:28:45 -0400
Received: (qmail 5634 invoked by uid 109); 17 May 2017 13:28:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:28:42 +0000
Received: (qmail 9529 invoked by uid 111); 17 May 2017 13:29:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:29:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:28:39 -0400
Date:   Wed, 17 May 2017 09:28:39 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 19/23] read_packed_refs(): report unexpected fopen()
 failures
Message-ID: <20170517132839.fx6oebgqt5t65tia@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <5d13d0f0e0a63430a9bf2889e9a9e911382170de.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d13d0f0e0a63430a9bf2889e9a9e911382170de.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:42PM +0200, Michael Haggerty wrote:

> The old code ignored any errors encountered when trying to fopen the
> "packed-refs" file, treating all such failures as if the file didn't
> exist. But it could be that there is some other error opening the
> file (e.g., permissions problems), and we don't want to silently
> ignore such problems. So report any failures that are not due to
> ENOENT.

I think there are may be other "OK" errno values here, like ENOTDIR.
That's probably pretty unlikely in practice, though, as we're opening a
file at the root of the $GIT_DIR here (so somebody would had to have
racily changed our paths). It's probably fine to just err on the side of
safety.

> +	if (!f) {
> +		if (errno == ENOENT) {
> +			/*
> +			 * This is OK; it just means that no
> +			 * "packed-refs" file has been written yet,
> +			 * which is equivalent to it being empty.
> +			 */
> +			return packed_refs;
> +		} else {
> +			die("couldn't read %s: %s",
> +			    packed_refs_file, strerror(errno));
> +		}

I think this could be die_errno().

-Peff
