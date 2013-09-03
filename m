From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] {fetch,receive}-pack: drop unpack-objects, delay loosing
 objects until the end
Date: Tue, 3 Sep 2013 02:49:38 -0400
Message-ID: <20130903064938.GB3608@sigill.intra.peff.net>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 08:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkQr-0002YI-K2
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 08:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219Ab3ICGtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 02:49:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:52692 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749Ab3ICGtl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 02:49:41 -0400
Received: (qmail 19102 invoked by uid 102); 3 Sep 2013 06:49:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 01:49:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 02:49:38 -0400
Content-Disposition: inline
In-Reply-To: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233685>

On Mon, Sep 02, 2013 at 10:05:07AM +0700, Nguyen Thai Ngoc Duy wrote:

> Current code peaks into the transfered pack's header, if the number of
> objects is under a limit, unpack-objects is called to handle the rest,
> otherwise index-pack is. This patch makes fetch-pack use index-pack
> unconditionally, then turn objects loose and remove the pack at the
> end. unpack-objects is deprecated and may be removed in future.

I do like consolidating the object-receiving code paths, but there is a
downside to this strategy: we increase the I/O in cases where we end up
unpacking, as we spool the tmpfile to disk, and then force objects loose
(whereas with the current code, unpack-objects reads straight from the
network into loose objects). I think that is what you're saying here:

>  - by going through index-pack first, then unpack, we pay extra cost
>    for completing a thin pack into a full one. But compared to fetch's
>    total time, it should not be noticeable because unpack-objects is
>    only called when the pack contains a small number of objects.

...but the cost is paid by total pack size, not number of objects. So if
I am pushing up a commit with a large uncompressible blob, I've
effectively doubled my disk I/O. It would make more sense to me for
index-pack to learn command-line options specifying the limits, and then
to operate on the pack as it streams in. E.g., to decide after seeing
the header to unpack rather than index, or to drop large blobs from the
pack (and put them in their own pack directly) as we are streaming into
it (we do not know the blob size ahead of time, but we can make a good
guess if it has a large on-disk size in the pack).

-Peff
