From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] introduce pack metadata cache files
Date: Wed, 30 Jan 2013 01:50:36 -0500
Message-ID: <20130130065036.GB11147@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091555.GC9999@sigill.intra.peff.net>
 <CACsJy8Af9g9Tdqr0dXyucq-M2aP5U2HvX3ANSsabqtuX=w4Q0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0RVv-0004gY-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 07:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab3A3Guj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 01:50:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53806 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501Ab3A3Guj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 01:50:39 -0500
Received: (qmail 27369 invoked by uid 107); 30 Jan 2013 06:52:02 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013 01:52:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2013 01:50:36 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Af9g9Tdqr0dXyucq-M2aP5U2HvX3ANSsabqtuX=w4Q0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214996>

On Wed, Jan 30, 2013 at 08:30:57AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Jan 29, 2013 at 4:15 PM, Jeff King <peff@peff.net> wrote:
> > +static void write_meta_header(struct metapack_writer *mw, const char *id,
> > +                             uint32_t version)
> > +{
> > +       version = htonl(version);
> > +
> > +       sha1write(mw->out, "META", 4);
> > +       sha1write(mw->out, "\0\0\0\1", 4);
> > +       sha1write(mw->out, mw->pack->sha1, 20);
> > +       sha1write(mw->out, id, 4);
> > +       sha1write(mw->out, &version, 4);
> > +}
> 
> Because you go with all-commit-info-in-one-file, perhaps we should
> have an uint32_t bitmap to describe what info this cache contains?  So
> far we need 4 bits for date, tree, 1st and 2nd parents (yes, I still
> want to check if storing 1-parent commits only gains us anything on
> some other repos). When commit count comes, it can take the fifth bit.
> Reachability bitmap offsets can take the sixth bit, if we just append
> the bitmaps at the end of the same file.

I thought about having some programmatic self-describing header like
that. But it makes the implementation much harder to verify, and it is
not like there is much point in picking and choosing those bits. My plan
was to do a combination of:

  1. Put truly optional bits into a separate metapack (e.g.,
     reachability bitmaps).

  2. When something becomes obviously obsolete (e.g., we move to
     generation numbers instead of timestamps in commits), bump the
     version number.

-Peff
