From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 13:19:56 -0400
Message-ID: <20130814171956.GA6884@sigill.intra.peff.net>
References: <520BAF9F.70105@googlemail.com>
 <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
 <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
 <520BB8A5.4010406@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	iveqy@iveqy.com, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 19:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ejv-0003mk-AG
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 19:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759921Ab3HNRUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 13:20:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:39334 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab3HNRUA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 13:20:00 -0400
Received: (qmail 553 invoked by uid 102); 14 Aug 2013 17:20:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Aug 2013 12:20:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Aug 2013 13:19:56 -0400
Content-Disposition: inline
In-Reply-To: <520BB8A5.4010406@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232299>

On Wed, Aug 14, 2013 at 07:04:37PM +0200, Stefan Beller wrote:

> But apart from my blabbering, I think ivegy made a good point:
> The C parts just don't rely on external things, but only libc and
> kernel, so it may be nicer than a shell script. Also as it is used
> serversided, the performance aspect is not negligible.
> 
> I included Jeff King, who maybe could elaborate on git-repack on the
> serverside?

I don't think the performance of repack as a C program versus a shell
script is really relevant to us at GitHub. Sure, we run a fair number of
repacks, but the cost is totally dominated by the pack-objects process
itself.

You might be able to achieve some speedups if it was not simply a
shell->C conversion, but an overall gc rewrite that did more in a single
process, and reused results (for example, you can reuse all or part of
the history traversal from pack-object's "counting objects" phase to do
the reachability analysis during prune)[1].

But I'd be very wary of stuffing too many things in a single process.
There are parts of the code that make assumptions about which objects
have been seen in the global object hash table (I believe index-pack is
one of these; see check_objects). And there are parts of the code which
must run separately (e.g., the connectivity check after transfer runs in
a separate process, both because it may die(), but also because we want
a clean slate of which packs are available, with no caching of results
we may have seen).

None of those problems is unsolvable, but it's very hard to know when
one is going to pop up and bite you. And because the repacking and
pruning code is the most likely place for a bug to cause data loss, it
makes me a bit nervous.

-Peff

[1] Another way to reuse the history traversal is to generate the
    much-discussed pack reachability bitmaps, and then use them in
    git-prune.
