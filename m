From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed, 6 Feb 2013 17:12:40 -0500
Message-ID: <20130206221240.GC27507@sigill.intra.peff.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net>
 <7vmwvhmli7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:13:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DFX-0003Bq-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024Ab3BFWMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:12:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37140 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161021Ab3BFWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:12:43 -0500
Received: (qmail 10920 invoked by uid 107); 6 Feb 2013 22:14:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Feb 2013 17:14:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2013 17:12:40 -0500
Content-Disposition: inline
In-Reply-To: <7vmwvhmli7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215650>

On Wed, Feb 06, 2013 at 08:53:52AM -0800, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > Currently, "diff" and "cat-file" for blobs obey "--textconv" options
> > (with the former defaulting to "--textconv" and the latter to
> > "--no-textconv") whereas "show" does not obey this option, even though
> > it takes diff options.
> >
> > Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
> > default and "--no-textconv" when given.
> 
> What does "log -p" do currently, and what should it do?  Does/should
> it also use --textconv?
> 
> The --textconv is a natural extension of what --ext-diff provides us,
> so I think it should trigger the same way as how --ext-diff triggers.
> 
> We apply "--ext-diff" for "diff" by default but not for "log -p" and
> "show"; I suspect this may have been for a good reason but I do not
> recall the discussion that led to the current behaviour offhand.

I think Michael's commit message explains the situation badly.
--textconv is already on for "git show" (and for "git log") by default.
Diffs already use it.

This is more about the fact that when showing a single blob, we do not
bother to remember the context of the sha1 lookup, including its
pathname. Therefore we were not previously able to apply any
.gitattributes to the output. So this patch really does two things:

  1. Pass the information along to show_blob_object so that it can
     look up .gitattributes.

  2. Apply the textconv attribute (if ALLOW_TEXTCONV is on, of course).

And stating it that way makes it clear that there may be other missing
steps (3 and up) to apply other gitattributes. For example, should "git
show $blob" respect crlf attributes? Smudge filters?

-Peff
