From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Mon, 6 Feb 2012 03:11:19 -0500
Message-ID: <20120206081119.GA3939@sigill.intra.peff.net>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <20120206000420.GC28735@sigill.intra.peff.net>
 <20120206063213.GC10489@tgrennan-laptop>
 <20120206070424.GC9931@sigill.intra.peff.net>
 <20120206071302.GA10447@sigill.intra.peff.net>
 <20120206074558.GA24535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJfb-0006ap-S3
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab2BFILY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:11:24 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58668
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943Ab2BFILV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:11:21 -0500
Received: (qmail 25037 invoked by uid 107); 6 Feb 2012 08:18:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 03:18:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:11:19 -0500
Content-Disposition: inline
In-Reply-To: <20120206074558.GA24535@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190041>

On Mon, Feb 06, 2012 at 02:45:58AM -0500, Jeff King wrote:

> > Hmm, the "filter->lines" code for "git tag -n" makes a similar error. It
> > should probably print nothing for objects that are not tags.
> 
> Ugh, this part of builtin/tag.c is riddled with small bugs. I'm
> preparing a series that will fix them, and hopefully it should make
> building your points-at patch on top much more pleasant.

So here's what I ended up with:

  [1/3]: tag: fix output of "tag -n" when errors occur
  [2/3]: tag: die when listing missing or corrupt objects
  [3/3]: tag: don't show non-tag contents with "-n"

I had hoped to have a 4th patch teach "tag -n" to use parse_object
instead of read_sha1_file directly. That way we could avoid reading tag
objects multiple times when things like "--contains" or "--points-at"
are used.  But we don't actually cache the body of an annotated tag,
only its headers. So the "tag -n" code has to read the object fresh.

I do still think it's worth using the parse_object interface for the
"--points-at" feature.

-Peff
