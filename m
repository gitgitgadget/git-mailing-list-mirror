Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC59C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA10611C5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhJETkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:40:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:33310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhJETkH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 15:40:07 -0400
Received: (qmail 17548 invoked by uid 109); 5 Oct 2021 19:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 19:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5071 invoked by uid 111); 5 Oct 2021 19:38:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 15:38:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 15:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH] p3400: stop using tac(1)
Message-ID: <YVyppmEGkNCxZ+5L@coredump.intra.peff.net>
References: <85831cc2-307f-1be8-9bb3-c44028ad07fa@web.de>
 <YVq752xjzYz+LTq6@coredump.intra.peff.net>
 <f6a1296f-f524-9042-7f88-9591522971af@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6a1296f-f524-9042-7f88-9591522971af@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 05, 2021 at 08:45:38PM +0200, René Scharfe wrote:

> Am 04.10.21 um 10:31 schrieb Jeff King:
> > On Sat, Oct 02, 2021 at 07:44:14PM +0200, René Scharfe wrote:
> >
> >> b3dfeebb92 (rebase: avoid computing unnecessary patch IDs, 2016-07-29)
> >> added a perf test that calls tac(1) from GNU core utilities.  Support
> >> systems without it by reversing the generated list using sort -nr
> >> instead.  sort(1) with options -n and -r is already used in other tests.
> >
> > Cute fix. With regular seq(1), this whole thing can become:
> >
> >   seq 1000 -1 1
> >
> > without the extra process, but our test_seq doesn't understand non-1
> > increments (nor comparisons besides -le). It wouldn't be that hard to
> > teach it, but given that this is the first time we've wanted it, it may
> > not be worth the effort.
> 
> Right.  The original also allows "seq 1000 1", by the way.  Not sure we
> need that either.

I'm not sure what you mean by "original" here. "seq 1000 1" produces no
output for me (nor does it work with test_seq).

> But when you say "without the extra process", I think:

I meant without the extra tac/sort process.

> test_seq () {
> 	set_step='END {step = first < last ? 1 : -1}'
> 	loop='END {for (; first <= last && step > 0 || first >= last && step < 0; first += step) print first}'
> 	case $# in
> 	1)      awk -v first=1    -v last="$1"    "$set_step $loop" ;;
> 	2)      awk -v first="$1" -v last="$2"    "$set_step $loop" ;;
> 	3)      awk -v first="$1" -v last="$3" -v step="$2" "$loop" ;;
> 	*)      BUG "not 1, 2, or 3 parameters to test_seq" ;;
> 	esac </dev/null
> }

Right, that works. It does introduce an extra awk process per
invocation, though I doubt that really matters all that much. The diff I
showed in my earlier response works totally in shell, like the current
test_seq().

-Peff
