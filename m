From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding
 .gitmodules
Date: Wed, 20 Jun 2012 15:11:32 -0400
Message-ID: <20120620191132.GB31520@sigill.intra.peff.net>
References: <cover.1340202515.git.brad.king@kitware.com>
 <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com>
 <4FE20DD3.6040607@web.de>
 <4FE21133.2030001@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	gitster@pobox.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQJY-0007oe-LL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837Ab2FTTLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:11:37 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39110
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328Ab2FTTLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:11:36 -0400
Received: (qmail 27682 invoked by uid 107); 20 Jun 2012 19:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Jun 2012 15:11:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jun 2012 15:11:32 -0400
Content-Disposition: inline
In-Reply-To: <4FE21133.2030001@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200332>

On Wed, Jun 20, 2012 at 02:06:43PM -0400, Brad King wrote:

> > Hmm, I have no objections against the intention of the patch. But
> > as I understand it this message will reoccur when the user e.g.
> > edits the .gitmodules file later with any editor who just writes
> > lfs and adds it.
> > 
> > I don't know terribly much about crlf support but maybe flagging
> > the .gitmodules file in .gitattributes would be a better solution
> > here? Opinions?
> 
> Once a user edits the file with an outside tool it is his/her
> responsibility to add .gitattributes for the file.  In the reported
> case Git is creating the file and already knows the crlf mode when
> creating it.
> 
> I think Junio's proposal to teach "git config" to respect crlf
> configuration is a more general solution.

I don't think so. It should not be an issue at all that .gitmodules has
CRLF or even mixed line endings; the config parser knows that its input
is a text file and ignores the CRs already.

The only problem is when adding the file, because git is not aware that
.gitmodules is, by definition, a text file.  The point of safecrlf was
to prevent accidents with files which are really binary, or for which
mixed line endings must be preserved; .gitmodules is not such a file. We
know that, but we never tell git.

We can paper over the problem by normalizing line endings when config
writes it out, but that does not cover the case of somebody editing it
manually and introducing mixed line endings. Nor does it help if
somebody checks in a .gitmodules file with CRLF, which we then checkout
on a LF-based system. Or if we do a merge between two versions with
different line endings.

The only sane thing is to have a canonical in-repo representation.
Fortunately we already have the infrastructure for that, and in theory
it should be as easy as adding ".gitmodules text" to our built-in
gitattributes (you could even do "eol=lf", but I don't see a reason not
to respect the native line endings in the working tree, given that git
can handle the CRLFs just fine).

I say "in theory" there because I am not sure whether specifying a file
as definitely text via attributes will actually suppress the safecrlf
check or not. IMHO, it should, since safecrlf is really about preventing
false positives via autocrlf or text=auto.

I don't see any reason for each individual repo to have to add these
attributes manually. This is a git-specific file, and the format is
dictated by git. We know that it's a text file, so why not help out the
user? We should possibly do the same thing for .gitattributes and
.gitignore.

-Peff
