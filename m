From: Jeff King <peff@peff.net>
Subject: Re: push race
Date: Tue, 16 Oct 2012 01:37:50 -0400
Message-ID: <20121016053750.GA22281@sigill.intra.peff.net>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com>
 <20121015185608.GC31658@sigill.intra.peff.net>
 <CAJo=hJu=eqgUhJvvpMLJ05AT6o+nVUDcm+tHV8en8OCX2-2qgA@mail.gmail.com>
 <20121016045118.GA21359@sigill.intra.peff.net>
 <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, marcnarc@xiplink.com,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 07:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNzqu-0003pl-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 07:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab2JPFhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 01:37:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54545 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094Ab2JPFhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 01:37:53 -0400
Received: (qmail 12190 invoked by uid 107); 16 Oct 2012 05:38:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Oct 2012 01:38:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2012 01:37:50 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8AJVAoUHft6+rdOjWCpLWWj3m0NgvFd9pToQRQ5uD8_gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207803>

On Tue, Oct 16, 2012 at 12:15:21PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Oct 16, 2012 at 11:51 AM, Jeff King <peff@peff.net> wrote:
> >> Its worth nothing that a SHA-1 collision can be identified at the
> >> server because the server performs a byte-for-byte compare of both
> >> copies of the object to make sure they match exactly in every way. Its
> >> not fast, but its safe. :-)
> >
> > Do we? I thought early versions of git did that, but we did not
> > double-check collisions any more for performance reasons. You don't
> > happen to remember where that code is, do you (not that it really
> > matters, but I am just curious)?
> 
> We do. I touched that sha-1 collision code last time I updated
> index-pack, to support large blobs. We only do that when we receive an
> object that we already have, which should not happen often unless
> you're under attack, so little performance impact normally. Search
> "collision" in index-pack.c

Ah, thanks, I remember this now. I think that I was thinking of the very
early code to check every sha1 file write. E.g., the code killed off by
aac1794 (Improve sha1 object file writing., 2005-05-03). But that is
ancient history that is not really relevant.

Interesting that we check only in index-pack. If the pushed content is
small enough, we will call unpack-objects. That follows the usual code
path for writing the object, which will prefer the existing copy.

I suspect a site that is heavy on alternates is invoking the index-pack
code path more frequently than necessary (e.g., history gets pushed to
one forked repo, then when it goes to the next one, we may not share the
ref that tells the client we already have the object and receive it a
second time).

-Peff
