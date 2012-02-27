From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: don't assume the merge filter ref exists
Date: Mon, 27 Feb 2012 14:43:05 -0500
Message-ID: <20120227194305.GE1600@sigill.intra.peff.net>
References: <20120227122609.GA26981@mx.loc>
 <1330355513-22351-1-git-send-email-cmn@elego.de>
 <20120227193044.GD1600@sigill.intra.peff.net>
 <7vk4386pgi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 20:43:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26Tb-0000ZP-2U
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab2B0TnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:43:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58963
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244Ab2B0TnI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:43:08 -0500
Received: (qmail 29919 invoked by uid 107); 27 Feb 2012 19:43:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Feb 2012 14:43:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:43:05 -0500
Content-Disposition: inline
In-Reply-To: <7vk4386pgi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191659>

On Mon, Feb 27, 2012 at 11:33:49AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You would also get NULL if the object exists but is not a commit. Maybe:
> >
> >   die("object '%s' does not point to a commit", ...)
> >
> > would be better? It covers the wrong-type case, and is still technically
> > true when the object does not exist.
> 
> For this particular message I like the above a lot better.  The output
> from "git grep -e 'invalid object' -e 'bad object'" seems to show that
> the use of both are fairly evenly distributed.

It looks like "bad object" generally comes from parse_object failing,
which makes sense. It either means object corruption or you fed a full
40-char sha1 that didn't exist (which, if you are being that specific,
probably is an indication of broken-ness in your repository).

It looks like "invalid object" comes from failing to access the subject
of an annotated tag or an entry in a tree, both of which would meet the
same criteria (corruption or a missing 40-char sha1).

I don't think bad versus invalid in existing cases is a big deal, as
they are both used consistently. But in this case, I think either would
be wrong, since it is equally likely that the user gave an existing, OK
object of the wrong type.

-Peff
