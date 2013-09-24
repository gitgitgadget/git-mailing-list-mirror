From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 24 Sep 2013 01:45:21 -0400
Message-ID: <20130924054520.GC5875@sigill.intra.peff.net>
References: <20130917172829.GA21121@redhat.com>
 <xmqq38p3z5kg.fsf@gitster.dls.corp.google.com>
 <20130917201401.GA22000@redhat.com>
 <20130917201604.GA22008@redhat.com>
 <20130917201828.GC16860@sigill.intra.peff.net>
 <20130917203807.GA22059@redhat.com>
 <20130917205615.GA20178@sigill.intra.peff.net>
 <20130919213226.GA21291@redhat.com>
 <20130923210915.GA11202@redhat.com>
 <20130923213729.GE9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 07:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOLRB-0001zs-5c
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 07:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823Ab3IXFpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 01:45:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:53234 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab3IXFpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 01:45:25 -0400
Received: (qmail 1000 invoked by uid 102); 24 Sep 2013 05:45:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Sep 2013 00:45:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Sep 2013 01:45:21 -0400
Content-Disposition: inline
In-Reply-To: <20130923213729.GE9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235268>

On Mon, Sep 23, 2013 at 02:37:29PM -0700, Jonathan Nieder wrote:

> >> Add --order-sensitive to get historical unstable behaviour.
> 
> The --order-sensitive option seems confusing.  How do I use it to
> replicate a historical patch-id?  If I record all options that might
> have influenced ordering (which are those?) then am I guaranteed to
> get a reproducible result?  

Yes, I have the same complaint. I'd much rather the classic mode be
given a name of some sort, and then have a "--patch-id-mode=classic"
parameter (or probably some better name) that sets all of the
parameters. Then you know that two implementations using "classic"
should get the same output, and so forth if we have to tweak it again.

> So I would prefer either of the following over the above:
> 
>  a) When asked to compute the patch-id of a seekable file, use the
>     current streaming implementation until you notice a filename that
>     is out of order.  Then start over with sorted hunks (for example
>     building a table of offsets within the patch for each hunk to
>     support this).
> 
>     When asked to compute the patch-id of an unseekable file, stream
>     to a temporary file under $GIT_DIR to get a seekable file.

This would mean that everybody, whether they care about compatibility or
not, would have to pay the price to spool to $GIT_DIR, right? That's not
great, as most cases would not care.

>  b) Unconditionally use the new patch-id definition that is stable
>     under permutation of hunks.  If and when someone complains that
>     this invalidates their old patch-ids, they can work on adding a
>     nice interface for getting the old-style patch-ids.  I suspect it
>     just wouldn't come up.

I think I'd prefer this one. The "--patch-id-mode" above is how I would
do it, and in general when we are potentially breaking compatibility,
it's nice to anticipate and give an escape hatch. But I do find it
reasonably unlikely that this will come up, so maybe this is a good time
to practice YAGNI.

-Peff
