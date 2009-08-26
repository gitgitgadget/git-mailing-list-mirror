From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 13:48:23 -0400
Message-ID: <20090826174823.GA1202@coredump.intra.peff.net>
References: <20090826121600.GA29098@atjola.homenet>
 <1251298007-18693-1-git-send-email-catap@catap.ru>
 <20090826155029.GA5750@atjola.homenet>
 <20090826161059.GC32741@coredump.intra.peff.net>
 <20090826165618.GA7477@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 19:48:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgMbp-0002a3-UD
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 19:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbZHZRsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZHZRsY
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 13:48:24 -0400
Received: from peff.net ([208.65.91.99]:34947 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbZHZRsX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 13:48:23 -0400
Received: (qmail 23857 invoked by uid 107); 26 Aug 2009 17:48:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 26 Aug 2009 13:48:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Aug 2009 13:48:23 -0400
Content-Disposition: inline
In-Reply-To: <20090826165618.GA7477@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127110>

On Wed, Aug 26, 2009 at 06:56:18PM +0200, Bj=C3=B6rn Steinbrink wrote:

> On 2009.08.26 12:10:59 -0400, Jeff King wrote:
> > So I think the code should probably look like this (totally unteste=
d):
> >=20
> >   remote_head =3D find_ref_by_name(refs, "HEAD");
> >   if (option_branch) {
> >           strbuf_addf(&branch_head, "%s%s", src_ref_prefix, option_=
branch);
> >           head_points_at =3D find_ref_by_name(refs, branch_head.buf=
);
> >           if (!head_points_at)
> >                   warning("remote branch not found, etc");
> >   }
> >   if (!head_points_at)
> >     head_points_at =3D guess_remote_head(remote_head, mapped_refs, =
0);
>=20
> Hm, why "refs" for find_ref_by_name(), but "mapped_ref" for
> guess_remote_head()?

Blind copying of the current code? :)

Good question, though. AFAICT, the difference between mapped_refs and
refs is that the former contains only the refs we are actually fetching=
,
and its peer_ref member is filled in as appropriate.

Later in the code, we look at head_points_at->peer_ref, which means it
_must_ come from mapped_refs. And which means the code I posted is
bogus, as the ref we look up in "refs" will not have that member filled
in. So I think we do need:

  head_points_at =3D find_ref_by_name(mapped_refs, branch_head.buf);

Good catch.

-Peff
