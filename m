From: Jeff King <peff@peff.net>
Subject: Re: brtfs COW links and git
Date: Tue, 22 Mar 2011 07:43:46 -0400
Message-ID: <20110322114346.GC32446@sigill.intra.peff.net>
References: <20110319201532.GA6862@cthulhu>
 <20110321120051.GG16334@sigill.intra.peff.net>
 <20110322024421.GA15134@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 12:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q200D-0007oE-GS
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 12:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab1CVLnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 07:43:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50905
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673Ab1CVLnv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 07:43:51 -0400
Received: (qmail 23715 invoked by uid 107); 22 Mar 2011 11:44:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 07:44:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 07:43:46 -0400
Content-Disposition: inline
In-Reply-To: <20110322024421.GA15134@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169724>

On Mon, Mar 21, 2011 at 10:44:21PM -0400, Larry D'Anna wrote:

> * Jeff King (peff@peff.net) [110321 08:00]:
> > I'm not exactly clear on what you want to implement.
> 
> Neither was I, that's why I sent the vague email :-)

Fair enough. :)

> I think I have a better understanding now of what would need to be done:
> 
> * reading unadorned blobs, as a last resort if the object isn't found elsewhere.
>   use reflink (if available) to copy an unadorned blob into the working directory 
> 
> * writing unadorned blobs, according to size limit / attribute.
>   this also means computing the sha1 for the blob without reading
>   the entire thing into memory all at once.
> 
> * leaving unadorned blobs alone in gc, unless explicitly told not to

Yeah, all of these are sensible. I do get a little nervous because an
extra object-db area is a change to such a core part of git. I think the
performance improvement would have to be pretty impressive to be worth
the trouble (and I think it has the potential to be; I just think you
will need numbers to make this palatable for upstream inclusion).

You could also prototype it with something like git-media that is
external to git. If you haven't read this recent thread, take a look:

  http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=165389

> * supporting the easy cases of binary diffs for git-upload-pack.  it shouldn't 
>   have to send an entire copy of a huge file if only a little bit of the file 
>   changed.   This could use fiemap, or maybe bup's rolling checksum, or maybe 
>   either, depending on what's available.

The good news is that we already handle binary diffs in upload-pack via
deltas. The trick is just efficiently generating them for large files.
If you have two large objects which are sharing blocks, one block is a
delta candidate for the other (i.e., the remote has told you he has one
but needs the other), and you have fiemap support on the sending end,
then you should be able to efficiently generate a delta on the fly.

In practice, I don't know how useful that is. One of the killer
applications people want for this kind of support is for media files.
But when they change, they tend to change a lot. I don't know if deltas
between two versions of an audio or video file will really be useful.
But that isn't to say it won't help for some other files. I think part
of showing good numbers would be defining a plausible workload.

> * support for applying those binary diffs directly to the on-disk reflink.
>   this could probably just mmap the file and call patch-delta.

The patch may need to expand a section in the middle of the file. I
don't know what kind of syscall support there is for that level of
tweaking with reflinked files.

> I think these features would make some, but not all of the big file use cases
> much more usable.  What do you think?

I think they could help, especially for gigantic files where just
copying the file is painful, and the extra storage kills you. But there
are a lot of other issues, too, like git assuming it can pull whole
blobs into memory during diffs. There is some low-hanging fruit there,
and that's why I put forward the SoC project idea.

-Peff
