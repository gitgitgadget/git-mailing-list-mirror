From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 11/19] pack-objects: use bitmaps when packing objects
Date: Wed, 30 Oct 2013 03:36:27 -0400
Message-ID: <20131030073627.GG11317@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060352.GI23098@sigill.intra.peff.net>
 <CACsJy8DMOfZu+2DS=-J9jfiP796XYi=e7B28cdV=ck9J-VOTtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 08:36:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbQKQ-00081H-5f
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 08:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab3J3Hga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 03:36:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:58262 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751086Ab3J3Hg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 03:36:29 -0400
Received: (qmail 16161 invoked by uid 102); 30 Oct 2013 07:36:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 02:36:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 03:36:27 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DMOfZu+2DS=-J9jfiP796XYi=e7B28cdV=ck9J-VOTtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236994>

On Sat, Oct 26, 2013 at 05:25:14PM +0700, Nguyen Thai Ngoc Duy wrote:

> > For bitmaps to be used, the following must be true:
> >
> >   1. We must be packing to stdout (as a normal `pack-objects` from
> >      `upload-pack` would do).
> >
> >   2. There must be a .bitmap index containing at least one of the
> >      "have" objects that the client is asking for.
> >
> >   3. Bitmaps must be enabled (they are enabled by default, but can be
> >      disabled by setting `pack.usebitmaps` to false, or by using
> >      `--no-use-bitmap-index` on the command-line).
> >
> > If any of these is not true, we fall back to doing a normal walk of the
> > object graph.
> 
> I haven't read the bitmap creation code yet. But it probably does not
> matter. If the client requests a shallow fetch, you probably want to
> fall back to normal walk too.

One other criterion I should have mentioned: we must be using the
internal rev-list. That prevented us in v1.8.4.1 and earlier from using
bitmaps for shallow fetches. But as of v1.8.4.2, we always use
pack-objects' rev-walker. We may need to pass --no-use-bitmap-index for
shallow fetches.

As for repos that are themselves shallow, I do not know how doing a
"repack -b" would fare. Probably not well.

> Bitmaps may be made work with shallow fetches too, I'm not sure. We
> could substract the shallow'd commits out. The problem is if some
> other commits share parts of the shallow'd commits, I'm not sure how
> to detect that.

Yeah, I do not think shallow follows the same have/want reachability
rules that we rely on for taking the set difference via bitmaps. It may
be made to work eventually, but I think the important thing at this
point is making sure we properly fall back to the slow method when
shallow.

-Peff
