From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCHv2 2/6] add metadata-cache infrastructure
Date: Wed, 13 Jul 2011 15:18:05 -0400
Message-ID: <20110713191805.GA1885@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713070405.GB18566@sigill.intra.peff.net>
 <CAKPyHN1FgK6NXqZFZ=OvMgouhfxnGF0aXU+--y-P1u9BcK9Z4A@mail.gmail.com>
 <20110713083139.GA26838@sigill.intra.peff.net>
 <CAKPyHN1tixwJPJHG+wY34HVLYGT4fD9Sc-qJ8=on8EWfW-H6aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 21:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh4xC-0004jx-LS
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 21:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab1GMTSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 15:18:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45629
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722Ab1GMTSH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 15:18:07 -0400
Received: (qmail 27991 invoked by uid 107); 13 Jul 2011 19:18:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 15:18:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 15:18:05 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN1tixwJPJHG+wY34HVLYGT4fD9Sc-qJ8=on8EWfW-H6aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177070>

On Wed, Jul 13, 2011 at 10:45:52AM +0200, Bert Wesarg wrote:

> > It might make sense to put:
> >
> > =C2=A0if (!c->mem.width)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("BUG: zero-width metadata-cac=
he");
> >
> > into the initialization function to make it more clear, and make a =
note
> > in the API documentation.
>=20
> That should be good. Thanks.

I've squashed in the patch below for my next re-roll.

diff --git a/Documentation/technical/api-metadata-cache.txt b/Documenta=
tion/technical/api-metadata-cache.txt
index 192a868..e335b96 100644
--- a/Documentation/technical/api-metadata-cache.txt
+++ b/Documentation/technical/api-metadata-cache.txt
@@ -102,9 +102,10 @@ Functions
 	specifies a human-readable name which will be used for storage
 	in `$GIT_DIR/cache/$name`. The `width` parameter specifies the
 	size, in units of `char`, of the data to be stored (e.g., use
-	`sizeof(uint32_t)` to store 32-bit integers). The `validity`
-	parameter is either NULL or a pointer to a function providing a
-	20-byte validity sha1.
+	`sizeof(uint32_t)` to store 32-bit integers). The `width`
+	parameter must be greater than 0. The `validity` parameter is
+	either NULL or a pointer to a function providing a 20-byte
+	validity sha1.
=20
 `metadata_cache_lookup`::
=20
diff --git a/metadata-cache.c b/metadata-cache.c
index e2e5ff8..025d3a5 100644
--- a/metadata-cache.c
+++ b/metadata-cache.c
@@ -261,6 +261,9 @@ static void metadata_cache_init(struct metadata_cac=
he *c)
 	if (c->initialized)
 		return;
=20
+	if (!c->mem.width)
+		die("BUG: tried to initialize zero-width metadata cache");
+
 	open_disk_cache(c, metadata_cache_path(c->mem.name));
=20
 	ALLOC_GROW(autowrite, autowrite_nr+1, autowrite_alloc);

-Peff
