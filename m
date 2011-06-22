From: Jeff King <peff@github.com>
Subject: Re: [PATCHv2 7/9] archive: implement configurable tar filters
Date: Tue, 21 Jun 2011 21:45:21 -0400
Message-ID: <20110622014521.GA30733@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
 <20110622012631.GG30604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCVb-0003ty-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab1FVBpX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 21:45:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44273
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757714Ab1FVBpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:45:22 -0400
Received: (qmail 7800 invoked by uid 107); 22 Jun 2011 01:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:45:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:45:21 -0400
Content-Disposition: inline
In-Reply-To: <20110622012631.GG30604@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176213>

On Tue, Jun 21, 2011 at 09:26:31PM -0400, Jeff King wrote:

> It's common to pipe the tar output produce by "git archive"
> through gzip or some other compressor. Locally, this can
> easily be done by using a shell pipe. When requesting a
> remote archive, though, it cannot be done through the
> upload-archive interface.
>=20
> This patch allows configurable tar filters, so that one
> could define a "tar.gz" format that automatically pipes tar
> output through gzip.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was split across several commits in the previous version of the
> series, but due to the cleanups it fits nicely into a single commit.

A few comments on what I took and what I didn't:

  1. config is now in tar.<filter>.*; this avoids having yet another
     config section. However, the flat names we give to "git config"
     look a little silly. E.g., "tar.tar.gz.command".

  2. Ren=C3=A9 suggested compressor as the config name. I wanted to sta=
y away
     from that name, as this really is about generic filtering. I expec=
t
     most uses will be compressors, but this is also our method for
     supporting other container formats via external helpers (e.g., you
     could convert to cpio on the fly). The word "filter" is generic,
     but it's also a bit redundant. The whole tar.<name> subsection is
     about the filter. I chose "command", as that is what is used for
     external diff in userdiff drivers, and it makes it clear that we
     are running an external helper. I'm lukewarm on it if somebody
     wants to argue for something else.

  3. There's no config to say you want or don't want -<n> compression
     levels. We always allow them, and it is up to the tool to complain
     if it doesn't want them. My reasoning is that most everything
     either takes them already (e.g., gzip, bzip2, xz), or would requir=
e
     a helper script that can either map them (7z) or reject them
     (whatever helper somebody might write to convert tar2cpio on the
     fly).

-Peff
