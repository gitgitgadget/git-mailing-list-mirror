From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/2] git.c: make sure we do not leak GIT_* to alias
 scripts
Date: Tue, 8 Dec 2015 12:20:10 -0500
Message-ID: <20151208172010.GA12886@sigill.intra.peff.net>
References: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
 <1449329538-18623-1-git-send-email-pclouds@gmail.com>
 <xmqqzixmm6na.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BHT2+_i4SoG6xv40wGX_gxwZFk=3WYOH196ZiHA7raWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 18:20:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Lw3-0006Qo-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbbLHRUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2015 12:20:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:38929 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750822AbbLHRUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:20:13 -0500
Received: (qmail 30160 invoked by uid 102); 8 Dec 2015 17:20:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Dec 2015 11:20:13 -0600
Received: (qmail 546 invoked by uid 107); 8 Dec 2015 17:20:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Dec 2015 12:20:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2015 12:20:10 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8BHT2+_i4SoG6xv40wGX_gxwZFk=3WYOH196ZiHA7raWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282167>

On Tue, Dec 08, 2015 at 05:55:20PM +0100, Duy Nguyen wrote:

> On Mon, Dec 7, 2015 at 7:54 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writ=
es:
> >
> >>  Let's hope there will be no third report about this commit..
> >
> > Hmm, why does this additional test fail only under prove but pass
> > without it?
>=20
> It passes with prove for me. Some mysterious variable leaks through s=
omehow?

It fails for me when run via "make" (with prove or without) but not as
"./t0001-init.sh". Looks like extra variables from my config.mak leak
through:

  $ make t0001-init.sh GIT_TEST_OPTS=3D"-v -i"
  [...]
  --- expected    2015-12-08 17:18:06.304699181 +0000
  +++ actual      2015-12-08 17:18:06.312699180 +0000
  @@ -9,5 +9,9 @@
   GIT_MERGE_VERBOSITY
   GIT_PREFIX
   GIT_TEMPLATE_DIR
  +GIT_TEST_GIT_DAEMON
  +GIT_TEST_HTTPD
  +GIT_TEST_OPTS
   GIT_TEXTDOMAINDIR
   GIT_TRACE_BARE
  +MAKEFLAGS
  not ok 6 - No extra GIT_* on alias scripts

Any GIT_TEST_* is allowed through by test-lib.sh.

=46or the MAKEFLAGS one, I suspect it's hitting

  MAKEFLAGS=3DGIT_TEST_OPTS=3D...

You should probably anchor your regex. :)

-Peff
