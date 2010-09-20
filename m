From: Jeff King <peff@peff.net>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases
 with symlinks
Date: Mon, 20 Sep 2010 14:00:46 -0400
Message-ID: <20100920180046.GA1790@sigill.intra.peff.net>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
 <vpqhbhmx6tg.fsf@bauges.imag.fr>
 <7vpqwa254i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 20:00:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxkff-000793-1K
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 20:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab0ITSAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 14:00:48 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56549 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728Ab0ITSAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 14:00:47 -0400
Received: (qmail 26677 invoked by uid 111); 20 Sep 2010 18:00:46 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 20 Sep 2010 18:00:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Sep 2010 14:00:46 -0400
Content-Disposition: inline
In-Reply-To: <7vpqwa254i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156645>

On Sat, Sep 18, 2010 at 01:01:17PM -0700, Junio C Hamano wrote:

> diff knows symlinks and regular files are different, and produces "delete
> old then add new" if you changed a regular file to a symlink.
> 
> That said, if you changed a symlink from pointing at A to pointing at B,
> it does run the textual diff between the string we get from readlink(3).
> 
> I happen to think that textconv, if specified, for such a path should be
> honored, so that people can keep doing whatever munging they have been
> doing in their existing textconv filters.

I think you came to the conclusion later in the thread that this is a
bad idea, if only because it is not how "git diff" works, but I wanted
to make one additional point.

I think that git, being symlink aware, needs to behave similarly to
"lstat". That is, we should never dereference symlinks transparently
when diffing or analyzing content, because otherwise there is no way to
actually look at the symlink data itself. It is the user's
responsibility to dereference symlinks in their diffs (e.g., I can get
either the symlink data _or_ the actual file data by doing "git diff
symlink-to-foo.bin" or "git diff foo.bin". If git dereferenced for me, I
would get file data for _both_). Not to mention that we can't always
dereference anyway because of broken links or links outside the repo, as
Matthieu pointed out.

So doing anything but a straight text diff for the pathnames in symlink
blobs is, IMHO, a bug.

The one thing this does not enable is using a special diff driver on the
_pathnames_ of symlinks. Since these are by-definition text, I don't
know why anyone would want to do that. But it is an orthogonal problem,
anyway.  We would need some way in the .gitattributes or the .gitconfig
to say "this is the diff driver to use not based on pathname matching,
but based on the file's mode". E.g., a special "SYMLINK" diff driver
like:

  [diff "SYMLINK"]
    textconv = pointless-munge

But again, I have no idea why anyone would want such a feature, so it is
not worth thinking too hard about it.

-Peff
