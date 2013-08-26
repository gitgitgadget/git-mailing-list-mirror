From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 15:28:26 -0400
Message-ID: <20130826192826.GA23598@sigill.intra.peff.net>
References: <1377528372-31206-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 21:28:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE2St-0006fF-5A
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 21:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760Ab3HZT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 15:28:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:39342 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab3HZT2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 15:28:34 -0400
Received: (qmail 26923 invoked by uid 102); 26 Aug 2013 19:28:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 14:28:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 15:28:26 -0400
Content-Disposition: inline
In-Reply-To: <1377528372-31206-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233015>

On Mon, Aug 26, 2013 at 10:46:12AM -0400, Phil Hord wrote:

> This version is a bit more deterministic and also adds a test.
> 
> It accepts the expense of examining the path argument again to 
> determine if it is a tree-ish + path rather than just a tree (commit).
> The get_sha1 call occurs one extra time for each tree-ish argument,
> so it's not expensive.

I don't like this approach in general because it lacks atomicity. IOW,
the thing you are looking up may change between the two get_sha1 calls.
You're _almost_ good here because you don't actually care what the
second call returns, but only which features it _would_ have used. But
you may see the second call fail because the ref doesn't exist anymore,
or points to a different tree, and you will erroneously use ":" instead
of "/".

I admit this is not that likely, but I'd really rather avoid introducing
such races if we can.

> We avoid mucking with the object_array API this way, and also do not
> rely on the object-type to tell us anything about the way the object
> name was spelled.

Changing the object_array API would be hard, but I don't think we need
to do it here. Can we simply stop using object_array to pass the list,
and instead just have a custom list?

I'll see how painful that is.

-Peff
