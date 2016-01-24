From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 02:18:15 -0500
Message-ID: <20160124071815.GB24084@sigill.intra.peff.net>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Pete Harlan <pgit@tento.net>
X-From: git-owner@vger.kernel.org Sun Jan 24 08:18:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNEwc-0005TB-38
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 08:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbcAXHSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 02:18:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:59333 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751282AbcAXHSS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 02:18:18 -0500
Received: (qmail 6726 invoked by uid 102); 24 Jan 2016 07:18:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 02:18:18 -0500
Received: (qmail 7683 invoked by uid 107); 24 Jan 2016 07:18:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 24 Jan 2016 02:18:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Jan 2016 02:18:15 -0500
Content-Disposition: inline
In-Reply-To: <20160124071234.GA24084@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284636>

On Sun, Jan 24, 2016 at 02:12:35AM -0500, Jeff King wrote:

> In theory, the ref-filter code could figure this out by us
> passing FILTER_REFS_TAGS. But there are two complications
> there:
> 
>   1. The handling of refname:short is deep in formatting
>      code that does not even have our ref_filter struct, let
>      alone the arguments to the filter_ref struct.
> 
>   2. In git v2.7.0, we expose the formatting language to the
>      user. If we follow this path, it will mean that
>      "%(refname:short)" behaves differently for "tag" versus
>      "for-each-ref" (including "for-each-ref refs/tags/"),
>      which can lead to confusion.
> 
> Instead, let's extend the "short" modifier in the formatting
> language to handle a specific prefix. This fixes "git tag",
> and lets users invoke the same behavior from their own
> custom formats (for "tag" or "for-each-ref") while leaving
> ":short" with its same consistent meaning in all places.

I think the patch I posted is a reasonable way to go. But I also don't
think that having "%(refname:short)" behave specially for "git-tag" is
all that unreasonable, either. But I'm open to argument.

Here are a few more considerations I had.

 - I'm not sure if the "special" behavior works as well for git-branch,
   which may want to shorten both "refs/heads/" and "refs/remotes/",
   depending on the type of ref.

   My solution may not extend there naturally, either, depending on how
   it is implemented.

 - To let users get the same behavior out of for-each-ref, we could
   perhaps auto-infer that looking at "refs/tags/" means shortening and
   disambiguation should only happen with respect to the "refs/tags/"
   hierarchy.

   But I'm uncomfortable changing the meaning of ":short" without at
   least a new option. And what would it mean for "git for-each-ref
   refs/heads/foo/"? Would it shorten "refs/heads/foo/bar" to just
   "bar", or would it still be "foo/bar"?

-Peff
