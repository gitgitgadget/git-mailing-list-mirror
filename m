From: Jeff King <peff@peff.net>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 16:18:09 -0400
Message-ID: <20120927201809.GA11772@sigill.intra.peff.net>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
 <20120927172037.GB1547@sigill.intra.peff.net>
 <CAJo=hJuXCYa=MKSqCRsxmwFdFYZamK_94zc3fE0tmvwUAVA2Ow@mail.gmail.com>
 <20120927182233.GA2519@sigill.intra.peff.net>
 <CAJo=hJs4NXatb2vsZWWCamLGLmi+FoWkTaf3Ky-nereXkHEptA@mail.gmail.com>
 <20120927185229.GD2519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>,
	David Barr <barr@github.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THKXN-0000Sg-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 22:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab2I0USM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 16:18:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33111 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2I0USL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 16:18:11 -0400
Received: (qmail 5644 invoked by uid 107); 27 Sep 2012 20:18:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 16:18:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 16:18:09 -0400
Content-Disposition: inline
In-Reply-To: <20120927185229.GD2519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206517>

On Thu, Sep 27, 2012 at 02:52:29PM -0400, Jeff King wrote:

> > No. The pack file name is composed from the SHA-1 of the sorted SHA-1s
> > in the pack. Any change in compression settings or delta windows or
> > even just random scheduling variations when repacking can cause
> > offsets to slide, even if the set of objects being repacked has not
> > differed. The resulting pack and index will have the same file names
> > (as its the same set of objects), but the offset information and
> > ordering is now different.
> 
> Are you sure? The trailer is computed over the sha1 of the actual pack
> data (ordering, delta choices, and all), and is computed and written to
> the packfile via sha1close (see pack-objects.c, ll. 753-763). That
> trailer sha1 is fed into finish_tmp_packfile (l. 793).  That function
> feeds it to write_idx_file, which starts a new sha1 computation that
> includes the sorted sha1 list and other index info. But before we
> sha1close that computation, we write the _original_ trailer sha1, adding
> it to the new sha1 calculation. See pack-write.c, ll. 178-180.
> 
> And then that sha1 gets returned to finish_tmp_packfile, which uses it
> to name the resulting files.
> 
> Am I reading the code wrong?

And the answer is...yes. I'm blind.

The final bit of code in write_idx_file is:

        sha1write(f, sha1, 20);
        sha1close(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
                            ? CSUM_CLOSE : CSUM_FSYNC));
        git_SHA1_Final(sha1, &ctx);

So we write the trailer, but the sha1 we pull out is _not_ the sha1 over
the index format. It is from "ctx", not "f"; and hte former is from the
object list. Just like you said. :)

So yeah, we would want to put the pack trailer sha1 into the
supplementary index file, and check that it matches when we open it.
It's a slight annoyance, but it's O(1).

Anything which rewrote the pack and index would also want to rewrite
these supplementary files. So the worst case would be:

  1. Pack with a new version which builds the supplementary file.

  2. Repack with an old version which generates a pack with identical
     objects, but different ordering. It does not regenerate the
     supplementary file, because it does not know about it.

  3. Try to read with newer git.

Without the extra trailer check, we get a wrong answer. With the check,
we notice that the supplementary file is bogus, and fallback to the slow
path. Which I think is OK, considering that this is a reasonably
unlikely scenario to come up often (and it is no slower than it would be
if you generated a _new_ packfile in step 2).

-Peff
