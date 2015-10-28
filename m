From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add_submodule_odb: initialize alt_odb list earlier
Date: Wed, 28 Oct 2015 13:27:58 -0400
Message-ID: <20151028172758.GA21851@sigill.intra.peff.net>
References: <5630B876.7080407@sociomantic.com>
 <5630BE79.40708@gmail.com>
 <5630CF1B.9000706@sociomantic.com>
 <20151028140725.GA15304@sigill.intra.peff.net>
 <xmqqa8r3m2xq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Mathias L. Baumann" <mathias.baumann@sociomantic.com>,
	Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:28:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUWU-0001s1-CJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbbJ1R2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:28:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:49325 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751114AbbJ1R2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:28:01 -0400
Received: (qmail 24728 invoked by uid 102); 28 Oct 2015 17:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 12:28:00 -0500
Received: (qmail 4156 invoked by uid 107); 28 Oct 2015 17:28:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 13:28:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2015 13:27:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8r3m2xq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280379>

On Wed, Oct 28, 2015 at 08:24:17AM -0700, Junio C Hamano wrote:

> > Note that we can remove the prepare_alt_odb call from the
> > end. It is guaranteed to be a noop, since we will have
> > called it earlier.
> 
> Thanks for a quick and detailed diagnosis and a fix.
> 
> The removal is correct, but even without this fix, the order of
> calls in the original should have screamed "bug" loudly at us, I
> think.  We shouldn't be reading data from alternates file without
> first preparing the place we read data into.

Yeah, I agree. I spent a long time trying to figure out if that
prepare_alt_odb was actually doing something useful (like if it was
needed to somehow "cement" the new alt into place).

But I don't think it was.

In the majority of cases, it was a noop (we had already prepared when we
looked up the first object). But for other cases...

  - if read_info_alternates actually did something, we segfaulted (i.e.,
    this bug)

  - otherwise, we would prepare on _top_ of what we just added to the
    list, which was probably buggy (I didn't dig far enough to see if
    prepare_alt_odb() would overwrite what we just added to the list).

So some pretty dark corners of the code. :)

-Peff
