From: Jeff King <peff@peff.net>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 14:52:29 -0400
Message-ID: <20120927185229.GD2519@sigill.intra.peff.net>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
 <20120927172037.GB1547@sigill.intra.peff.net>
 <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
 <20120927182233.GA2519@sigill.intra.peff.net>
 <CAJo=hJs4NXatb2vsZWWCamLGLmi+FoWkTaf3Ky-nereXkHEptA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THJCS-0001DU-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab2I0Swb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:52:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33009 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560Ab2I0Swb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:52:31 -0400
Received: (qmail 4690 invoked by uid 107); 27 Sep 2012 18:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 14:52:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 14:52:29 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJs4NXatb2vsZWWCamLGLmi+FoWkTaf3Ky-nereXkHEptA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206508>

On Thu, Sep 27, 2012 at 11:36:19AM -0700, Shawn O. Pearce wrote:

> > Interesting. I would have assumed it depended on order in the index.
> 
> No. We tried that. Assigning bits by order in index (aka order of
> SHA-1s sorted) results in horrible compression of the bitmap itself
> because of the uniform distribution of SHA-1. Encoding instead by pack
> order gets us really good bitmap compression, because object graph
> traversal order tends to take reachability into account. So we see
> long contiguous runs of 1s and get good compression. Sorting by SHA-1
> just makes the space into swiss cheese.

Right, that makes a lot of sense.

> > I think you are still OK, though, because
> > the filename comes from the sha1 over the index file, which in turn
> > includes the sha1 over the packfile. Thus any change in the packfile
> > would give you a new pack and index name.
> 
> No. The pack file name is composed from the SHA-1 of the sorted SHA-1s
> in the pack. Any change in compression settings or delta windows or
> even just random scheduling variations when repacking can cause
> offsets to slide, even if the set of objects being repacked has not
> differed. The resulting pack and index will have the same file names
> (as its the same set of objects), but the offset information and
> ordering is now different.

Are you sure? The trailer is computed over the sha1 of the actual pack
data (ordering, delta choices, and all), and is computed and written to
the packfile via sha1close (see pack-objects.c, ll. 753-763). That
trailer sha1 is fed into finish_tmp_packfile (l. 793).  That function
feeds it to write_idx_file, which starts a new sha1 computation that
includes the sorted sha1 list and other index info. But before we
sha1close that computation, we write the _original_ trailer sha1, adding
it to the new sha1 calculation. See pack-write.c, ll. 178-180.

And then that sha1 gets returned to finish_tmp_packfile, which uses it
to name the resulting files.

Am I reading the code wrong?

-Peff
