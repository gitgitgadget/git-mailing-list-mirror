From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diff: don't use pathname-based diff drivers for
 symlinks
Date: Wed, 22 Sep 2010 01:50:06 -0400
Message-ID: <20100922055006.GA2980@sigill.intra.peff.net>
References: <20100921205914.GA1166@sigill.intra.peff.net>
 <20100921210124.GA1188@sigill.intra.peff.net>
 <vpqvd5ycp3w.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 22 07:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyIDk-00043D-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 07:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab0IVFuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 01:50:13 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49421 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab0IVFuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 01:50:12 -0400
Received: (qmail 17227 invoked by uid 111); 22 Sep 2010 05:50:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 22 Sep 2010 05:50:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Sep 2010 01:50:06 -0400
Content-Disposition: inline
In-Reply-To: <vpqvd5ycp3w.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156783>

On Wed, Sep 22, 2010 at 07:40:51AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We can drop the check in the textconv code, which is now redundant.
> 
> Am I correct if I say that this makes "[PATCH 3/3] RFC: blame,cat-file
> --textconv: Don't assume mode is ``S_IFREF | 0664''" obsolete?
> 
> (but patches 1 and 2 are still useful to check the behavior)

No. This just moves the check of the mode further down in the callstack.
But the problem that Kirill's patch fixes is that we were feeding a
bogus mode in the first place. So we still need to start actually
sending the correct mode.

> > Technically, this could be breaking somebody's setup if:
> >
> >   1. They found some use for userdiff config on symlinks. Textconv is
> >      already disabled. A custom diff driver might work.
> 
> I'm wondering about cases other than regular files and symlinks here.
> Directories are not a problem, since for Git, they somehow don't
> exist, but for example, "git diff" shows diff for subprojects too.
> After little testing, it seem the textconv is never applied on
> subprojects, but I couldn't say why.

Yeah, gitlinks were the only example I could come up with, too. The
current textconv code already checked for S_ISREG, so you couldn't
textconv them. I'm not sure if you could do an external diff, or mark
them as binary. I suspect not, since we tend to treat them specially in
the diff code, but I didn't actually test. At any rate, those things are
explicitly disallowed by my change.

> > +cat >expect <<'EOF'
> [...]
> It's recommanded to put these cat <<'EOF' within the
> test_expect_success, but otherwise, the code looks good.

I didn't think we had actually reached consensus on that.

-Peff
