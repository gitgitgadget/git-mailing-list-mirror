From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/4] cat-file: do not die on --textconv without
 textconv filters
Date: Wed, 6 Feb 2013 17:43:53 -0500
Message-ID: <20130206224353.GG27507@sigill.intra.peff.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
 <b20e91bc71e59b5390005f2e6428e69a467e80b5.1360162813.git.git@drmicha.warpmail.net>
 <20130206221912.GD27507@sigill.intra.peff.net>
 <7vvca59j4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Dj2-0002mV-DW
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789Ab3BFWn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:43:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37185 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968Ab3BFWn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:43:56 -0500
Received: (qmail 11683 invoked by uid 107); 6 Feb 2013 22:45:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:45:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:43:53 -0500
Content-Disposition: inline
In-Reply-To: <7vvca59j4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215657>

On Wed, Feb 06, 2013 at 02:23:36PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Which made me wonder: what happens with:
> >
> >   git cat-file --textconv HEAD
> >
> > It looks like we die just before textconv-ing, because we have no
> > obj_context.path. But that is also unlike all of the other --textconv
> > switches, which mean "turn on textconv if you are showing a blob that
> > supports it" and not "the specific operation is --textconv, apply it to
> > this blob". I don't know if that is worth changing or not.
> 
> OK, so in that sense, "cat-file --textconv HEAD" (or HEAD:) should
> die with "Hey, that is not a blob", in other words, Michael's patch
> does what we want without further tweaks, right?

Right, it will die because we do not find a path in the object_context.
For the same reason that "cat-file --textconv $sha1" would die.

A more interesting case is "cat-file --textconv HEAD:Documentation",
which does have a path, but not a blob. And I think that speaks to your
point that we want to fall-through to the pretty-print case, not the
blob case.

> By the way are we sure textconv_object() barfs and dies if fed a non
> blob?  Otherwise the above does not hold, and the semantics become
> "turn on textconv if the object you are showing supports it,
> otherwise it has to be a blob.", I think.

I'm not sure. The sha1 would get passed all the way down to
fill_textconv. I think because sha1_valid is set, it will not try to
reuse the working tree file, so we will end up in
diff_populate_filespec, and we could actually textconv the tree object
itself.

So yeah, I think we want a check that makes sure we are working with a
blob before we even call that function, and "--textconv" should just be
"you must feed me a blob of the form $treeish:$path". In practice nobody
wants to do anything else anyway, so let's keep the code paths simple;
we can always loosen it later if there is a good reason to do so.

-Peff
