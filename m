From: Jeff King <peff@peff.net>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Tue, 16 Jun 2015 16:50:06 -0400
Message-ID: <20150616205006.GA4864@peff.net>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <CACsJy8Bb1O7QZtiPWdzYwYgOdV0dLDgD3Xu_YaWNUbsuTqJB5g@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C55197764FE@C111KXTEMBX51.ERF.thomson.com>
 <20150605121817.GA22125@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, git@vger.kernel.org
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Tue Jun 16 22:50:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4xoI-0005tG-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 22:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881AbbFPUuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 16:50:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:47064 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756571AbbFPUuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 16:50:09 -0400
Received: (qmail 23644 invoked by uid 102); 16 Jun 2015 20:50:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 15:50:09 -0500
Received: (qmail 18947 invoked by uid 107); 16 Jun 2015 20:50:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 16:50:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 16:50:06 -0400
Content-Disposition: inline
In-Reply-To: <20150605121817.GA22125@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271796>

On Fri, Jun 05, 2015 at 08:18:17AM -0400, Jeff King wrote:

> On Fri, Jun 05, 2015 at 12:01:16PM +0000, steve.norman@thomsonreuters.com wrote:
> 
> > On Sunday, May 24, 2015 @ 10:01 AM Duy Nguyen [mailto:pclouds@gmail.com] did scribble:
> > 
> > > In case you want to back away from option 2 because it starts to leak
> > > raciness, which your old commit tried to fix in the first place. I
> > > think the only other place that tests for lots of non-existent loose
> > > objects is write_sha1_file (e.g. "tar -xf bigtarball.tar.gz; cd
> > > bigtarball; git init; git add ."). But the number of calls should be
> > > much smaller compared to index-pack and it does not use has_sha1_file,
> > > it uses check_and_freshen_file() instead.
> > > 
> > > There are other places where has_sha1_file() may return 0, but I think
> > > the number of calls is even smaller to bother (shallow.c,
> > > fetch-pack.c, apply.c, buik-checkin.c)
> > 
> > Any updates / further thoughts on this?
> 
> Sorry, I haven't had a chance to look at it further. It still on my todo
> list. My plan is:
> 
>   1. Devise some torture to tests to see whether my patch series is in
>      fact racy on Linux.

I do not know that we needed further convincing that the patch series to
stat() the objects/pack directory was flaky, but just as an extra data
point in case somebody tries this approach later: it is indeed flaky.

I've been running with it for a week or so, and I noticed that a simple
clone of a small repository fails racily:

  $ git clone --bare --no-local . foo.git
  Cloning into bare repository 'child.git'...
  remote: Counting objects: 210, done.
  remote: Compressing objects: 100% (98/98), done.
  remote: Total 210 (delta 99), reused 210 (delta 99)
  Receiving objects: 100% (210/210), 68.00 KiB | 0 bytes/s, done.
  Resolving deltas: 100% (99/99), done.
  Checking connectivity... done.
  error: internal error: refs/heads/master is not a valid packed reference!

Sometimes it works, and sometimes not.  It looks like we're failing to
re-scan the pack directory when we should (presumably because the open()
and readdir() operations are not atomic).

-Peff
