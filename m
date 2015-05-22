From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/3] using stat() to avoid re-scanning pack dir
Date: Fri, 22 May 2015 19:51:16 -0400
Message-ID: <20150522235116.GA4300@peff.net>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
 <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C5519759641@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8BULBJ=cL1+4TFX_7tYSCFL3MNEz1Ay0YGqx8W_8=nwAg@mail.gmail.com>
 <20150522071224.GA10734@peff.net>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975ADA4@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8DMqj8sCowZ5f-QZMgrAMFjGOaWfYjZWHxs+jvBsDpp5w@mail.gmail.com>
 <7FAE15F0A93C0144AD8B5FBD584E1C551975B851@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Sat May 23 01:51:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvwiq-0003MN-Jm
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464AbbEVXvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:51:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:35066 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756983AbbEVXvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 19:51:19 -0400
Received: (qmail 11383 invoked by uid 102); 22 May 2015 23:51:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 18:51:19 -0500
Received: (qmail 22368 invoked by uid 107); 22 May 2015 23:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 19:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 19:51:16 -0400
Content-Disposition: inline
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C551975B851@C111KXTEMBX51.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269776>

On Fri, May 22, 2015 at 03:02:45PM +0000, steve.norman@thomsonreuters.com wrote:

> On Friday, May 22, 2015 @ 11:06 AM Duy Nguyen did write:
> 
> > Strange. Maybe there is something else... Anyway some numbers from me.
> > This is nfs3 hosted by Raspberry Pi, accessed over wireless. I just
> > run index-pack on git.git pack instead of full clone.
> > 
> >  - v1.8.4.1 34s
> >  - v1.8.4.2 519s (oh.. wireless..)
> >  - v1.8.4.2 without has_sha1_file() in index-pack.c 33s
> >  - v1.8.4.2 + Jeff's mtime patch 36s
> 
> Just ran the test again and it was 12 seconds.   Too many versions of git available on the 
> machine and I think I might have run the wrong one:

Thanks for re-checking. Here's a series that fixes the rough edges of
the patch I sent earlier. I'd appreciate it if you can re-confirm that
it improves things for you.

  [1/3]: stat_validity: handle non-regular files
  [2/3]: cache.h: move stat_validity definition up
  [3/3]: prepare_packed_git: use stat_validity to avoid re-reading packs

I'm adding Michael to the cc, as I'm abusing the stat_validity code
which we worked on in 2013.

My big concern here is that using stat_validity with a directory is
racy. It works for a regular file like packed-refs because that file is
replaced atomically.  We fill the validity using fstat() on the same
descriptor we read the data from, and nobody modifies an already-written
file. So we know it matches what we read.

For a directory, I don't think that atomicity guarantee is there.
Somebody can modify the direct while we're reading. For the most part, I
think that is OK. We fstat() before reading any entries, so our fstat
data will then become out of date, and we'll re-read next time. It would
be a problem if opendir() looked at the entries at all (e.g., if it
called getdents() under Linux before our first readdir() call, then our
fstat is happening after the first read, and wouldn't match what we
read). I don't have any reason to believe that any libc does that, but
it is making an assumption about how opendir() is implemented.

The other problem is that I'm not sure stat data is enough to notice
when a directory changes. Certainly the mtime should change, but if you
have only one-second resolution on your mtimes, we can be fooled. For a
regular file that is replaced atomically, the inode will change (and
probably the size, too). But I don't know if that is the case for a
directory. Can writing an entry go undetected between two stat() calls
(or something even more pathological, like deleting one entry and
writing another one)?

-Peff
