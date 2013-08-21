From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document the HTTP transport protocols
Date: Wed, 21 Aug 2013 18:00:21 -0400
Message-ID: <20130821220021.GA32130@sigill.intra.peff.net>
References: <1377092713-25434-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	rctay89@gmail.com, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:00:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCGS4-0003gG-OV
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab3HUWAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:00:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:50184 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3HUWAY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:00:24 -0400
Received: (qmail 15234 invoked by uid 102); 21 Aug 2013 22:00:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 17:00:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 18:00:21 -0400
Content-Disposition: inline
In-Reply-To: <1377092713-25434-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232741>

On Wed, Aug 21, 2013 at 08:45:13PM +0700, Nguyen Thai Ngoc Duy wrote:

>  On the topic, C Git's (maybe) violations on this spec are:
>  
>   - The client does not strip trailing slashes from $GIT_URL before
>     sending to the server, as described in section "URL Format".

Yeah. We get the basic gist right by not adding an extra "/" if there is
already a trailing slash (so you do not have http://host/path//info/refs").
But we do not go out of our way to remove multiple slashes that the user
hands out (either at the end or in the middle of the URL). I doubt that
it matters in practice.

>   - The client does not check that HTTP status code is either 200 or
>     304 when receiving response in discovering references phase.

We rely on curl's CURLOPT_FAILONERROR to handle errors. And curl handles
redirects internally. So yes, we could get a "204" or something weird,
but it would almost certainly not pass the other checks (proper
content-type, starting with pkt-line, etc). I doubt it's a problem in
practice.

We also handle 401 these days, which is not in the document, but
obviously makes sense to do (ditto for 407, but I cannot remember if we
actually handle that or not; there were patches, but I think they may
have been dropped).

>   - The client verifies the first 5 bytes against pattern
>     "^[0-9a-fA-F]{4}#" instead of "^[0-9a-f]{4}#" as described in
>     section "discovering references".

I think this could be counted as "be liberal in what you accept",
although I do not know offhand of any implementations that use
uppercase. But if it is not true pkt-line we would figure it out pretty
quickly anyway.

> [...]

I read through the rest and did not see anything inaccurate. Thanks for
working on this.

-Peff
