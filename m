Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDEE1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 09:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbcFPJZm (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 05:25:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:55497 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752713AbcFPJZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 05:25:39 -0400
Received: (qmail 9470 invoked by uid 102); 16 Jun 2016 09:25:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:25:39 -0400
Received: (qmail 14301 invoked by uid 107); 16 Jun 2016 09:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 05:25:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 05:25:36 -0400
Date:	Thu, 16 Jun 2016 05:25:36 -0400
From:	Jeff King <peff@peff.net>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Message-ID: <20160616092535.GA29954@sigill.intra.peff.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
 <20160614215019.GB22334@sigill.intra.peff.net>
 <20160614222633.GA32020@sigill.intra.peff.net>
 <xmqqporj72p4.fsf@gitster.mtv.corp.google.com>
 <20160615005614.GB32601@sigill.intra.peff.net>
 <75709ea6-b2bb-fddf-1175-cb8aae66629a@drmicha.warpmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75709ea6-b2bb-fddf-1175-cb8aae66629a@drmicha.warpmail.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 15, 2016 at 09:17:54AM +0200, Michael J Gruber wrote:

> As for the flexibility:
> We do code specifically for gpg, which happens to work for gpg2 also.
> The patch doesn't add any gpg ui requirements that we don't require
> elsewhere already.
> More flexibility requires a completely pluggable approach - gpgsm
> already fails to meet the gpg command line ui.

Does it? I haven't run it in production, but I did some tests with gpgsm
a few months ago and found it to be a drop-in replacement, at least with
respect to git. Though I don't think that matters one way or the other
for the current discussion; it _does_ do --status-fd.

> In any case, "status-fd" is *the* way to interface with gpg reliably
> just like plumbing commands are *the* way to interface with git reliably.

Fair enough. I've generally found its exit code pretty reliable. It's
unclear to me if the problem you saw was because gpg was exiting 0 but
producing no signature, or if your debugging was masking its exit code.

Either way, I do not mind using --status-fd; it seems like it should be
more robust in general. It's the tip commit in the series I'm about to
post.

> As for the read locking:
> I'm sorry I have no idea about that area at all. I thought that I'm
> doing the same that we do for verify, but apparently not. My
> strbuf_read-fu is not that strong either (read: copy&paste). I trust
> your assessment completely, though.

Yeah, you're right that the deadlock thing is also a possibility on the
verification side. I'm not sure whether it's possible to trigger in
practice or not. See the analysis in the series.

> As for the original problem:
> That had a different cause, as we know now (rebase dropping signatures
> without hint). I still think we should check gpg status codes properly.

Yep, I agree.

-Peff
