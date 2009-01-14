From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 07:25:36 -0500
Message-ID: <20090114122536.GA5939@coredump.intra.peff.net>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:27:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN4ps-0006ql-E8
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 13:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142AbZANMZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 07:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbZANMZl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 07:25:41 -0500
Received: from peff.net ([208.65.91.99]:52023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbZANMZk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 07:25:40 -0500
Received: (qmail 23727 invoked by uid 107); 14 Jan 2009 12:25:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Jan 2009 07:25:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2009 07:25:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105622>

On Wed, Jan 14, 2009 at 11:48:38AM +0100, Jan Engelhardt wrote:

> This is much shorter than inet_ntop'ing, and also translated
> unresolvable addresses into a string.

Er, doesn't this totally change the meaning of REMOTE_ADDR from an IP
address to a hostname? That seems bad because:

  - people already have hooks that compare REMOTE_ADDR against an
    address, so we are breaking their hooks

  - we are losing IP information in favor of hostname information; since
    (I assume) this is primarily intended for IP-based access control,
    we are adding an extra layer of indirection in the middle of our
    security model (i.e., I used to have to spoof an IP to fool your
    hook, but now I can do that _or_ spoof DNS).

So at the very least, you should be adding REMOTE_HOST in _addition_ to
REMOTE_ADDR, not instead of. But that still leaves one final concern,
which is that some git-daemon admins might not want to pay the cost for
a reverse lookup for every request. It's extra network traffic, and adds
extra latency to the process (but I don't personally run git-daemon, and
I don't know whether big sites like kernel.org actually care about
this).

-Peff
