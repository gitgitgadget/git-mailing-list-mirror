Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDCB201A7
	for <e@80x24.org>; Thu, 18 May 2017 05:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbdERFIw (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 01:08:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:54066 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdERFIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 01:08:52 -0400
Received: (qmail 1771 invoked by uid 109); 18 May 2017 05:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 05:08:52 +0000
Received: (qmail 14799 invoked by uid 111); 18 May 2017 05:09:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 May 2017 01:09:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 May 2017 01:08:49 -0400
Date:   Thu, 18 May 2017 01:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 19/23] read_packed_refs(): report unexpected fopen()
 failures
Message-ID: <20170518050849.kopykuewhfq3psav@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <5d13d0f0e0a63430a9bf2889e9a9e911382170de.1495014840.git.mhagger@alum.mit.edu>
 <20170517132839.fx6oebgqt5t65tia@sigill.intra.peff.net>
 <xmqqwp9eu5h2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp9eu5h2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 01:57:45PM +0900, Junio C Hamano wrote:

> >> +	if (!f) {
> >> +		if (errno == ENOENT) {
> >> +			/*
> >> +			 * This is OK; it just means that no
> >> +			 * "packed-refs" file has been written yet,
> >> +			 * which is equivalent to it being empty.
> >> +			 */
> >> +			return packed_refs;
> >> +		} else {
> >> +			die("couldn't read %s: %s",
> >> +			    packed_refs_file, strerror(errno));
> >> +		}
> >
> > I think this could be die_errno().
> 
> I wonder what the endgame shape of this code should be, when it and
> nd/fopen-errors topic both graduate.  We cannot use fopen_or_warn(),
> as we not just want to warn but want to die, e.g.
> 
> 	f = fopen(...);
> 	if (!f) {
>         	if (warn_on_fopen_errors(...))
>                 	die_erno(...);
> 		return packed_refs;
> 	}

If we go that route I think the die becomes just:
 
   if (warn_on_fopen_errors(...))
	die("unable to open packed refs");

or something. If we want a single die, perhaps the cleanest thing is to
put the logic into its own function:

  static int missing_file_errno(int err)
  {
	return errno == ENOENT || errno == ENOTDIR;
  }
  ...
  if (!missing_file_errno(errno))
	die_errno("couldn't read %s", packed_refs_file);

It feels a little silly to make such a trivial helper, but the point is
to encapsulate that logic. And I think it would be used inside
fopen_or_warn(), and possibly other places. The name might need some
work; that was the best I could come up with.

-Peff
