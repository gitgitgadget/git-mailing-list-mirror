From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Retry HTTP requests on SSL connect failures
Date: Mon, 1 Oct 2012 18:23:06 -0400
Message-ID: <20121001222306.GB12496@sigill.intra.peff.net>
References: <CAJo=hJs=Zm4BPm94-sNWDUNkg2vAReSsTmKnDVw+xOU9NWcfUQ@mail.gmail.com>
 <1349126586-755-1-git-send-email-spearce@spearce.org>
 <7v1uhhc10y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIoOW-0005CT-RO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 00:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568Ab2JAWXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 18:23:10 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37518 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119Ab2JAWXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 18:23:09 -0400
Received: (qmail 24030 invoked by uid 107); 1 Oct 2012 22:23:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Oct 2012 18:23:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Oct 2012 18:23:06 -0400
Content-Disposition: inline
In-Reply-To: <7v1uhhc10y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206774>

On Mon, Oct 01, 2012 at 02:53:17PM -0700, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > +	for (attempts = 0; attempts < 2; attempts++) {
> > +		if (start_active_slot(slot)) {
> > +			run_active_slot(slot);
> > +			if (slot->results->curl_result == CURLE_SSL_CONNECT_ERROR)
> > +				continue;
> 
> Is it safe to continue and let start_active_slot() to add the same
> curl handle again when USE_CURL_MULTI is in effect?

I _think_ so. We reuse the slots anyway. So the usual workflow would be
get_active_slot, then start_active_slot, then run_active_slot. This loop
omits get_active_slot, which is responsible for (re-)initializing a
bunch of aspects of the slot. But we wouldn't want that here, since it
would mean we'd have to set up our URL, callbacks, etc, again.

My only worry would be that the failed curl request actually ended up
writing some data or made some other state change. But since we are
explicitly catching only ssl connection failures, presumably that would
not have happened.

-Peff
