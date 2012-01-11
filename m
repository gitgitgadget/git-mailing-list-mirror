From: Jeff King <peff@peff.net>
Subject: Re: leaky cherry-pick
Date: Wed, 11 Jan 2012 14:56:05 -0500
Message-ID: <20120111195605.GB12333@sigill.intra.peff.net>
References: <20120109223737.GA1589@padd.com>
 <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
 <20120110195017.GA19961@sigill.intra.peff.net>
 <CALkWK0kDnxjtQ+ihH_dif_7yivHLd=pibao4KPs_PDXfc2UMOA@mail.gmail.com>
 <7vipki7ix9.fsf@alter.siamese.dyndns.org>
 <CALkWK0m+okqJk05BMQAEMww6FNLxaLVhAM92WmUDeA_J-drOdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl4HO-0007Lk-JA
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 20:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731Ab2AKT4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 14:56:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35310
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755909Ab2AKT4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 14:56:08 -0500
Received: (qmail 22802 invoked by uid 107); 11 Jan 2012 20:03:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 15:03:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 14:56:05 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0m+okqJk05BMQAEMww6FNLxaLVhAM92WmUDeA_J-drOdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188388>

On Wed, Jan 11, 2012 at 02:30:16PM +0530, Ramkumar Ramachandra wrote:

> > I somehow have a feeling that you did not read the conclusion in Pe=
ff's
> > message correctly. =C2=A0The code only keeps data from one active p=
ath of
> > per-directory .gitattributes files to the leaf of a working tree an=
d
> > releases unneeded data (IOW, it "pops" the attr_stack elements) whe=
n it
> > goes on to look at the next path, so my understanding is that there=
 is
> > nothing to "try implementing" here.
>=20
> My bad-  I thought the current implementation doesn't release the
> unneeded data.  So, does the entire 7 KB of leaked data come from one
> active path?

Hmm. Actually, I think there is a leak. Because the strategy I describe=
d
leaves the memory reachable from the global attr_stack variable, which
means valgrind will only show it if "--show-reachable" is turned on.

Maybe this?

diff --git a/attr.c b/attr.c
index 76b079f..1656db4 100644
--- a/attr.c
+++ b/attr.c
@@ -301,6 +301,7 @@ static void free_attr_elem(struct attr_stack *e)
 		}
 		free(a);
 	}
+	free(e->attrs);
 	free(e);
 }
=20

-Peff
