From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sun, 30 Dec 2012 07:05:42 -0500
Message-ID: <20121230120542.GA10820@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 13:06:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpHef-0001Br-RH
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 13:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab2L3MFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 07:05:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39631 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab2L3MFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 07:05:53 -0500
Received: (qmail 3483 invoked by uid 107); 30 Dec 2012 12:07:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 30 Dec 2012 07:07:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Dec 2012 07:05:42 -0500
Content-Disposition: inline
In-Reply-To: <20121229052747.GA14928@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212329>

On Sat, Dec 29, 2012 at 12:27:47AM -0500, Jeff King wrote:

> > If reachability bitmap is implemented, we'll have per-pack cache
> > infrastructure ready, so less work there for commit cache.
> 
> True. I don't want to dissuade you from doing any commit cache work. I
> only wanted to point out that this alternative may have merit because of
> its simplicity (so we can use it until a caching solution exists, or
> even after, if managing the cache has downsides).

So I was thinking about this, which led to some coding, which led to
some benchmarking.

I want to clean up a few things in the code before I post it, but the
general idea is to have arbitrary per-pack cache files in the
objects/pack directory. Like this:

  $ cd objects/pack && ls
  pack-a3e262f40d95fc0cc97d92797ff9988551367b75.commits
  pack-a3e262f40d95fc0cc97d92797ff9988551367b75.idx
  pack-a3e262f40d95fc0cc97d92797ff9988551367b75.pack
  pack-a3e262f40d95fc0cc97d92797ff9988551367b75.parents
  pack-a3e262f40d95fc0cc97d92797ff9988551367b75.timestamps
  pack-a3e262f40d95fc0cc97d92797ff9988551367b75.trees

Each file describes the objects in the matching pack. If a new pack is
generated, you'd throw away the old cache files along with the old pack,
and generate new ones. Or not. These are totally optional, and an older
version of git will just ignore them. A newer version will use them if
they're available, and otherwise fallback to the existing code (i.e.,
reading the whole object from the pack). So you can generate them at
repack time, later on, or not at all. For now I have a separate command
that generates them based on the pack index; if this turns out to be a
good idea, it would probably get called as part of "repack".

Each file is a set of fixed-length records. The "commits" file contains
the sha1 of every commit in the pack (sorted). A binary search of the
mmap'd file gives the position of a particular commit within the list,
and that position is used to index the parents, timestamps, and trees
files (obviously if it is missing, then the other files are useless, but
we already have to be able to fallback to just reading the objects
anyway).

I split it out into multiple files because you can actually operate with
a subset (though in my initial attempt, I transparently plug in at the
parse_commit layer, which means we need all items to consider the commit
"parsed", whether the caller actually cares or not. But in theory a
reader could only want to ask for one item).  Making a "generation"
cache file is an obvious next step (and because we already have
"commits", it is only 4 bytes per commit on top of it). Reachability
bitmaps would be another one (though due to the compression, I am not
sure they will work with a fixed-size record design, so this may need
some modification).

Anyway, here are the numbers I came up with (appended to my earlier
compression numbers):

git.git:
 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none |  56.72        | 0.68        | 0.33        |  2.45        |  1.94       
commit |  64.61 (+13%) | 0.50 (-26%) | 0.09 (-74%) |  2.42  (-1%) |  1.69 (-13%)
  tree |  60.68  (+6%) | 0.79 (+16%) | 0.33   (0%) |  2.23  (-8%) |  1.75  (-9%)
  both |  68.54 (+20%) | 0.48 (-29%) | 0.08 (-75%) |  2.24  (-8%) |  1.48 (-23%)
 cache |  59.29  (+4%) | 0.57 (-16%) | 0.05 (-84%) |  2.23  (-8%) |  1.66 (-14%)

linux.git:
 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none | 864.61        | 8.66        | 4.07        | 42.76        | 36.32       
commit | 970.46 (+12%) | 8.87  (+2%) | 1.02 (-74%) | 42.94   (0%) | 33.43  (-7%)
  tree | 895.37  (+3%) | 9.08  (+4%) | 4.07   (0%) | 36.01 (-15%) | 29.62 (-18%)
  both |1001.25 (+15%) | 8.90  (+2%) | 1.03 (-74%) | 35.57 (-16%) | 26.25 (-27%)
 cache | 894.78  (+3%) | 4.88 (-43%) | 0.69 (-83%) | 38.80  (-9%) | 32.79  (-9%)

webkit.git:
 Pack  | Size          |  Cold Revs  |  Warm Revs  | Cold Objects | Warm Objects
-------+---------------+-------------+-------------+--------------+--------------
  none |   3.46        | 1.61        | 1.38        | 20.46        | 18.72       
commit |   3.54  (+2%) | 1.42 (-11%) | 0.34 (-75%) | 20.42   (0%) | 17.57  (-6%)
  tree |   3.59  (+3%) | 1.61   (0%) | 1.39   (0%) | 16.01 (-21%) | 14.00 (-25%)
  both |   3.67  (+6%) | 1.45 (-10%) | 0.34 (-75%) | 15.94 (-22%) | 12.91 (-31%)
 cache |   3.47   (0%) | 0.49 (-69%) | 0.14 (-90%) | 19.53  (-4%) | 17.86  (-4%)


So you can see that it performs even better than no-compression on the
warm-revs case. Which makes sense, since we do not even have to touch
the object data at all, and can do the whole traversal straight out of
the cache. So we do not even have to memcpy the bytes around. And it
takes up even less space (3-4% versus 12-13% on the first two repos).
Which makes sense, because even though we are duplicating some
information that is in the packfile, we are leaving all of the commit
message bodies compressed.

The other interesting thing is that the cold cache performance also
improves by a lot. Again, this makes sense; we are doing the traversal
completely out of cache, and our data is even more tightly packed in the
cache than it is in the packfile.

Of course, it does very little for the full --objects listing, where we
spend most of our time inflating trees. We could couple this with
uncompressed trees (which are not all that much bigger, since the sha1s
do not compress anyway). Or we could have an external tree cache, but
I'm not sure exactly what it would look like (this is basically
reinventing bits of packv4, but doing so in a way that is redundant with
the existing packfile, rather than replacing it). Or since the point of
--objects is usually reachability, it may make more sense to pursue the
bitmap, which should be even faster still.

-Peff
