Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9AC1F744
	for <e@80x24.org>; Wed, 13 Jul 2016 08:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbcGMIav (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 04:30:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:43970 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751013AbcGMIat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 04:30:49 -0400
Received: (qmail 18939 invoked by uid 102); 13 Jul 2016 08:30:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 04:30:50 -0400
Received: (qmail 11640 invoked by uid 107); 13 Jul 2016 08:31:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jul 2016 04:31:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2016 04:30:44 -0400
Date:	Wed, 13 Jul 2016 04:30:44 -0400
From:	Jeff King <peff@peff.net>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when
 generating non-stdout pack too
Message-ID: <20160713083044.GB18144@sigill.intra.peff.net>
References: <20160707190917.20011-1-kirr@nexedi.com>
 <20160707205223.GA11753@sigill.intra.peff.net>
 <20160708103855.GD5462@teco.navytux.spb.ru>
 <20160712190807.GB4809@teco.navytux.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160712190807.GB4809@teco.navytux.spb.ru>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 10:08:08PM +0300, Kirill Smelkov wrote:

> > Or are we fine with my arguments about recency order staying the same
> > when using bitmap reachability index for object graph traversal, and this
> > way the patch is fine to go in as it is?
> 
> Since there is no reply I assume the safe way to go is to let default
> for pack-to-file case to be "not using bitmap index". Please find updated
> patch and interdiff below. I would still be grateful for feedback on
> my above use-bitmap-for-pack-to-file arguments.

Yeah, I think that is a reasonable approach. I see here you've added new
config, though, and I don't think we want that.

For your purposes, where you're driving pack-objects individually, I
think a command-line option makes more sense.

If we did want to have a flag for "use bitmaps when repacking via
repack", I think it should be "repack.useBitmaps", and git-repack should
pass the command-line option to pack-objects. pack-objects is porcelain
and should not really be reading config at all. You'll note that
pack.writeBitmaps was a mistake and got deprecated in favor of
repack.writeBitmaps. I think pack.useBitmaps is a mistake, too, but
nobody has really noticed or cared because there's no good reason to set
it (the more interesting question is: are there bitmaps available? and
if so, we try to use them).

-Peff
