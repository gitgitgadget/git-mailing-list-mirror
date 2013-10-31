From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] remote-curl: fix large pushes with GSSAPI
Date: Thu, 31 Oct 2013 02:34:51 -0400
Message-ID: <20131031063451.GA5513@sigill.intra.peff.net>
References: <1383014197-11607-1-git-send-email-sandals@crustytoothpaste.net>
 <20131030084510.GO11317@sigill.intra.peff.net>
 <20131030224030.GC12595@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 07:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VblqM-0000Ys-D8
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 07:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab3JaGey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 02:34:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:58987 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855Ab3JaGey (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 02:34:54 -0400
Received: (qmail 18123 invoked by uid 102); 31 Oct 2013 06:34:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Oct 2013 01:34:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Oct 2013 02:34:51 -0400
Content-Disposition: inline
In-Reply-To: <20131030224030.GC12595@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237079>

On Wed, Oct 30, 2013 at 10:40:30PM +0000, brian m. carlson wrote:

> If you would split it out, that would be great.  Then I'll simply rebase
> my patch on top of yours and go from there.

I just included your patch on top, since it was the residue left over
after committing my refactoring. Please read over the result to make
sure I am not defaming you. :)

I noticed while committing the first patch that we do not actually
follow the "do not look at curl after finish_active_slot" rule for the
content-type. Again, we get away with it because we are not running
multiple slots at the time (we only check content-type during the
initial discovery).

I think the refactoring here is the cleanest thing by the existing
rules, but I also think we could get away with the somewhat simpler
patch of just teaching probe_rpc to grab the AUTHAVAIL (because it still
has the old slot and does not need to call get_active_slot again, and
because we know we are only using a single slot).

Going through all of this, I can't help but be annoyed at how much http
baggage we are carrying around for the curl_multi code for parallel
fetches, which is only used for dumb http. The smart-http code would be
happy with a single curl handle we used each time. But I imagine there
are still people relying on dumb http, and dropping the parallel fetch
would be a pretty severe regression for them.

  [1/3]: http: return curl's AUTHAVAIL via slot_results
  [2/3]: remote-curl: pass curl slot_results back through run_slot
  [3/3]: remote-curl: fix large pushes with GSSAPI

-Peff
