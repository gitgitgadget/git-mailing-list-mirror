From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 21:09:12 -0500
Message-ID: <20131122020911.GA12042@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 03:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjgBK-0004l6-Si
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 03:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767Ab3KVCJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 21:09:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:43539 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753427Ab3KVCJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 21:09:14 -0500
Received: (qmail 19817 invoked by uid 102); 22 Nov 2013 02:09:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Nov 2013 20:09:13 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Nov 2013 21:09:12 -0500
Content-Disposition: inline
In-Reply-To: <20131121160426.GA21843@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238171>

On Thu, Nov 21, 2013 at 12:04:26PM -0400, Joey Hess wrote:

> Jeff King wrote:
> > This latter behavior is much worse for two reasons. One,
> > git reports an allocation error when the real error is
> > corruption. And two, the program dies unconditionally, so
> > you cannot even run fsck (which would otherwise ignore the
> > broken object and keep going).
> 
> BTW, I've also seen git cat-file --batch report wrong sizes for objects,
> sometimes without crashing. This is particularly problimatic because if
> the object size is wrong, it's very hard to detect the actual end of the
> object output in the batch mode stream.

Hrm. For --batch, I'd think we would open the whole object and notice
the corruption, even with the current code. But for --batch-check, we
use sha1_object_info, and for an "experimental" object, we do not need
to de-zlib the object at all.  So we end up reporting whatever crap we
decipher from the garbage bytes.  My patch would fix that, as we would
not incorrectly guess an object is experimental anymore.

If you have specific cases that trigger even after my patch, I'd be
interested to see them.

-Peff
