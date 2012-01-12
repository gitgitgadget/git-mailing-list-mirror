From: Jeff King <peff@peff.net>
Subject: Re: leaky cherry-pick
Date: Wed, 11 Jan 2012 22:05:03 -0500
Message-ID: <20120112030503.GA26363@sigill.intra.peff.net>
References: <20120109223737.GA1589@padd.com>
 <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
 <20120110195017.GA19961@sigill.intra.peff.net>
 <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
 <7vipki7ix9.fsf@alter.siamese.dyndns.org>
 <CALkWK0m+okqJk05BMQAEMww6FNLxaLVhAM92WmUDeA_J-drOdg@mail.gmail.com>
 <20120111195605.GB12333@sigill.intra.peff.net>
 <7v7h0x6b89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:05:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAyW-0008Ki-8G
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465Ab2ALDFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 22:05:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35607
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab2ALDFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 22:05:06 -0500
Received: (qmail 27351 invoked by uid 107); 12 Jan 2012 03:12:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 22:12:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 22:05:03 -0500
Content-Disposition: inline
In-Reply-To: <7v7h0x6b89.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188423>

On Wed, Jan 11, 2012 at 04:00:38PM -0800, Junio C Hamano wrote:

> Yeah, that is definitely a leak.

Here it is with a commit message. "valgrind git cherry-pick" reports no
leaks in the attr code after this (but unfortunately still lots of leaks
from unpack-trees).

-Peff

-- >8 --
Subject: [PATCH] attr: fix leak in free_attr_elem

This function frees the individual "struct match_attr"s we
have allocated, but forgot to free the array holding their
pointers, leading to a very minor memory leak.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attr.c b/attr.c
index 96eda0e..303751f 100644
--- a/attr.c
+++ b/attr.c
@@ -301,6 +301,7 @@ static void free_attr_elem(struct attr_stack *e)
 		}
 		free(a);
 	}
+	free(e->attrs);
 	free(e);
 }
 
-- 
1.7.9.rc0.33.gd3c17
