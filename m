From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X
 10.8
Date: Sat, 11 May 2013 10:45:43 +0200
Message-ID: <20130511084543.GA1905@sigill.intra.peff.net>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
 <20130511062336.GD3394@elie>
 <CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
 <20130511082203.GA953@sigill.intra.peff.net>
 <CAJDDKr7-sMrX=2Aek1LY8knM2jFPs933eLj3iZdTa68YYv-6Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 10:46:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub5RR-0007AR-HZ
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab3EKIpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:45:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:55737 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835Ab3EKIpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:45:47 -0400
Received: (qmail 17562 invoked by uid 102); 11 May 2013 08:46:11 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 03:46:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 10:45:43 +0200
Content-Disposition: inline
In-Reply-To: <CAJDDKr7-sMrX=2Aek1LY8knM2jFPs933eLj3iZdTa68YYv-6Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223945>

On Sat, May 11, 2013 at 01:38:32AM -0700, David Aguilar wrote:

> > Adding "--verify-objects" would sha1 the blobs, too, which might be more
> > reasonable (or running "git fsck"). Something like "git add" on a large
> > blob would also be a good test.
> 
> Thanks.  Here are the numbers with --verify-objects:
> 
> $ time git rev-list --all --objects --verify-objects >/dev/null
> 
> # CommonCrypto 32.24s user 4.65s system 99% cpu 37.098 total
> # master       33.00s user 4.68s system 99% cpu 37.852 total
> # BLK_SHA1     54.17s user 4.67s system 99% cpu 58.928 total
> 
> Doing BLK_SHA1 seems like less of a good idea now, so I think my
> latest re-roll might be the way to go...

Wow, that's really terrible. What level of optimization do you compile
with? With the other implementations, you are calling into
(presumably) optimized library code, but with BLK_SHA1 you are getting
whatever you just compiled.

Here are three timings that show how big a difference that can make:

  openssl,  -O0    0m21.152s
  BLK_SHA1, -O0    0m31.920s
  BLK_SHA1, -O3    0m19.652s

So it is a win over openssl with optimizations on, but a pretty big loss
otherwise.

-Peff
