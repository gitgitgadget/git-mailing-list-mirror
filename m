From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 11/19] pack-objects: use bitmaps when packing objects
Date: Wed, 30 Oct 2013 16:07:54 -0400
Message-ID: <20131030200754.GB23011@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060352.GI23098@sigill.intra.peff.net>
 <CACsJy8DMOfZu+2DS=-J9jfiP796XYi=e7B28cdV=ck9J-VOTtA@mail.gmail.com>
 <20131030073627.GG11317@sigill.intra.peff.net>
 <CACsJy8B3VS=WSNeF35_JTiF6byZiefvEYnadkC8BAmKG5Z7gQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 21:08:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbc3e-0006h7-7G
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 21:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab3J3UH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 16:07:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:58738 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752343Ab3J3UH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 16:07:56 -0400
Received: (qmail 20953 invoked by uid 102); 30 Oct 2013 20:07:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 15:07:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 16:07:54 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B3VS=WSNeF35_JTiF6byZiefvEYnadkC8BAmKG5Z7gQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237065>

On Wed, Oct 30, 2013 at 05:28:08PM +0700, Nguyen Thai Ngoc Duy wrote:

> > One other criterion I should have mentioned: we must be using the
> > internal rev-list. That prevented us in v1.8.4.1 and earlier from using
> > bitmaps for shallow fetches. But as of v1.8.4.2, we always use
> > pack-objects' rev-walker. We may need to pass --no-use-bitmap-index for
> > shallow fetches.
> 
> I don't think a new option is needed. The code just needs to check if
> there are any commit grafts. If there are, fall back to the old way.
> That covers both shallow fetches and some rare grafted repos. I think
> refs/replace/* does not impact rev walking, so we should be fine if
> it's used.

I think there are two cases that we need to consider:

  1. We have a full repo and somebody requests a shallow clone for us.
     We probably do not want to use bitmaps here.  In the series we have
     been testing, shallow clones turned off bitmaps because we do not
     use the internal rev_list. But as of cdab485 (upload-pack: delegate
     rev walking in shallow fetch to pack-objects), that distinction
     doesn't hold. I think we can check the use of --shallow-file
     instead of explicitly turning off bitmaps there.

  2. We have a shallow clone that wants to repack. We probably want to
     turn off bitmap writing here. I don't think that grafts actually
     matter here, because pack-objects should always be looking at the
     true graph. It would mean that using "git rev-list
     --use-bitmap-index" does not respect the grafts, and we should
     probably disable it in that case (and ditto for replacements).

-Peff
