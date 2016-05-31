From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 31 May 2016 18:31:18 -0400
Message-ID: <20160531223118.GD3824@sigill.intra.peff.net>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com>
 <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com>
 <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:31:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sCD-0002Kg-In
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661AbcEaWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:31:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:46801 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752837AbcEaWbV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:31:21 -0400
Received: (qmail 1593 invoked by uid 102); 31 May 2016 22:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:31:21 -0400
Received: (qmail 27941 invoked by uid 107); 31 May 2016 22:31:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 May 2016 18:31:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 May 2016 18:31:18 -0400
Content-Disposition: inline
In-Reply-To: <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296024>

On Fri, May 20, 2016 at 02:39:06PM +0200, Christian Couder wrote:

> I wonder if this mechanism could also be used or extended to clone and
> fetch an alternate object database.
> 
> In [1], [2] and [3], and this was also discussed during the
> Contributor Summit last month, Peff says that he started working on
> alternate object database support a long time ago, and that the hard
> part is a protocol extension to tell remotes that you can access some
> objects in a different way.
> 
> If a Git client would download a "$name.bndl" v3 bundle file that
> would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
> client would just need to download "$URL/alt-odb-$name.odb" and use
> the alternate object database support on this file.
> 
> This way it would know all it has to know to access the objects in the
> alternate database. The alternate object database may not contain the
> real objects, if they are too big for example, but just files that
> describe how to get the real objects.

I'm not sure about this strategy. I see two complications:

  1. I don't think bundles need to be a part of this "external odb"
     strategy at all. If I understand correctly, I think you want to use
     it as a place to stuff metadata that the server tells the client,
     like "by the way, go here if you want another way to access some
     objects".

     But there are lots of cases where the server might want to tell
     the client that don't involve bundles at all.

  2. A server pointing the client to another object store is actually
     the least interesting bit of the protocol.

     The more interesting cases (to me) are:

       a. The receiving side of a connection (e.g., a fetch client)
          somehow has out-of-band access to some objects. How does it
	  tell the other side "do not bother sending me these objects; I
	  can get them in another way"?

       b. The receiving side of a connection has out-of-band access to
          some objects. Some of these will be expensive to get (e.g.,
	  requiring a large download), and some may be fast (e.g.,
	  they've already been fetched to a local cache). How do we tell
	  the sending side not to assume we have cheap access to these
	  objects (e.g., for use as a delta base)?

So I don't think you want to tie this into bundles due to (1), and I
think that bundles would be insufficient anyway because of (2).

Or maybe I'm misunderstanding what you propose.

-Peff
