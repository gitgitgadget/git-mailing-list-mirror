From: Jeff King <peff@peff.net>
Subject: Re: [RFC] pack-objects: compression level for non-blobs
Date: Sun, 30 Dec 2012 16:31:24 -0500
Message-ID: <20121230213124.GA15946@sigill.intra.peff.net>
References: <1353911154-23495-1-git-send-email-b@rr-dav.id.au>
 <20121229004104.GA24828@sigill.intra.peff.net>
 <CACsJy8D_E0shqJAvZH7xqij6F4a6qUxkUPNcZL=0yX5w9bLd_g@mail.gmail.com>
 <20121229050707.GA14475@sigill.intra.peff.net>
 <CACsJy8AN3y_4wcZ_w0zz+ZAaDasRT-+h8vA_fp2j4+FL00dbLw@mail.gmail.com>
 <20121229052747.GA14928@sigill.intra.peff.net>
 <20121230120542.GA10820@sigill.intra.peff.net>
 <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Michael Barr <b@rr-dav.id.au>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 22:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpQci-00018G-Q0
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 22:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2L3Vb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 16:31:28 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39848 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052Ab2L3Vb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 16:31:27 -0500
Received: (qmail 5685 invoked by uid 107); 30 Dec 2012 21:32:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 30 Dec 2012 16:32:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Dec 2012 16:31:24 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8C4UttGKcw11do1POcHZJM7iZ2r7F3ESOqEnWL8kdz+dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212342>

On Sun, Dec 30, 2012 at 07:53:48PM +0700, Nguyen Thai Ngoc Duy wrote:

> >   $ cd objects/pack && ls
> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.commits
> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.idx
> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.pack
> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.parents
> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.timestamps
> >   pack-a3e262f40d95fc0cc97d92797ff9988551367b75.trees
> >
> > Each file describes the objects in the matching pack. If a new pack is
> > generated, you'd throw away the old cache files along with the old pack,
> > and generate new ones. Or not. These are totally optional, and an older
> > version of git will just ignore them. A newer version will use them if
> > they're available, and otherwise fallback to the existing code (i.e.,
> > reading the whole object from the pack). So you can generate them at
> 
> You have probably thought about this (and I don't have the source to
> check first), but we may need to version these extra files so we can
> change the format later if needed. Git versions that do not recognize
> new versions simply ignore the cahce.

Agreed. The current code has a 4-byte magic, followed by a 4-byte
version number, followed by a 4-byte record size[1]. Then the data,
followed by the pack sha1, followed by a sha1 of all of the preceding
data.  So you can verify the validity of any cache file (both its
checksum, and that it matches the right packfile), just as you can with
a ".idx" file.

[1] Probably the magic and version should be per-file-type, and the
    record size should be implicit from that; right now I make
    assumptions about what is in the files based on their names, but
    that is not part of the checksum.

> > repack time, later on, or not at all. For now I have a separate command
> > that generates them based on the pack index; if this turns out to be a
> > good idea, it would probably get called as part of "repack".
> 
> I'd like to make it part of index-pack, where we have nearly
> everything in memory. But let's leave it as a separate command first.

Yeah, in the long run that may work. The steps I figured were:

  1. Optional, external command. Let people experiment.

  2. Once it has proven itself, run the command from index-pack by
     default (or with a config option).

  3. If it turns out too slow, move the generation directly into the
     index-pack process.

The current iteration does not seem all that slow, but that is because I
am mostly picking static data out of the commits. So I have to load the
commits, and that's it. But something like reachability might be more
expensive (OTOH, it will always be more expensive, whether we have the
objects in memory or not).

> > Each file is a set of fixed-length records. The "commits" file contains
> > the sha1 of every commit in the pack (sorted). A binary search of the
> > mmap'd file gives the position of a particular commit within the list,
> 
> I think we could avoid storing sha-1 in the cache with Shawn's idea
> [1]. But now I read it again I fail to see it :(
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/206485

Right. My implementation is very similar to what Shawn said there. I.e.,
the timestamps file is literally 4 bytes times the number of commits.
The parents file is 40 bytes per commit (2 parents, with a marker to
indicate "more or less than 2"), though a lot of it is zero bytes.

Some alternatives I'm thinking about are:

  1. Using non-fixed-size records, which would allow trivial compression
     of entries like null sha1s. This would mean adding a separate
     lookup table, though, mapping sha1s to offsets. Still, even a
     32-bit offset is only 4 bytes per commit. If it meant dropping 40
     bytes of zeroes from the 2nd parent field out of half of all
     commits, that would be a win space-wise. It would be a
     double-indirect lookup, but it's constant effort, and only two page
     hits (which would be warm after the first lookup anyway).

  2. Storing offsets to objects in the packfile rather than their sha1s.
     This would save a lot of space, but would mean we couldn't refer to
     parents outside of the pack, but that may be OK. This is an
     optimization, and the case we want to target is a fully (or mostly)
     packed repo. It's OK to have the lookup fail and fallback to
     accessing the object.

  3. Dropping the "commits" file and just using the pack-*.idx as the
     index. The problem is that it is sparse in the commit space. So
     just naively storing 40 bytes per entry is going to waste a lot of
     space. If we had a separate index as in (1) above, that could be
     dropped to (say) 4 bytes of offset per object. But still, right now
     the commits file for linux-2.6 is about 7.2M (20 bytes times ~376K
     commits). There are almost 3 million total objects, so even storing
     4 bytes per object is going to be worse.

  4. Making a new index version that stores the sha1s separated by type.
     This means we can piggy-back on the regular index to get a packed
     list of just commits. But it also means that regular sha1 lookups
     of the objects have to look in several places (unless the caller
     annotates the call to read_sha1_object with "I am expecting this
     sha1 to be a commit"). And of course it means bumping the index
     version, which is a pain. The external index means it can be
     completely optional on top of the current index/pack.

> Depending on the use case, we could just generate packv4-like cache
> for recently-used trees only. I'm not sure how tree cache impact a
> merge operation on a very large worktree (iow, a lot of trees
> referenced from HEAD to be inflated). This is something a cache can
> do, but a new pack version cannot.

I do not care too much about the cost of running merge on a large
working tree. Of course it's better to make our optimizations as
generally applicable as possible, but there is a lot of other work going
on in a merge. The really painful, noticeable, repetitive bits right now
are:

  1. Running git-prune.

  2. Creating a pack from git-upload-pack.

Which are both just reachability problems. Something like "git log --
<pathspec>" would also be helped by packv4-ish tree access patterns,
though, but not by reachability bitmaps. And that may be something
worth caring about.

> Yes. And if narrow clone ever comes, which needs --objects limited by
> pathspec, we could just produce extra bitmaps for frequently-used
> pathspecs and only allow narrow clone with those pathspecs.

I hadn't thought about that. But yeah, because of the optional, external
nature, there's no reason you couldn't have extra bitmap sets for
specialized situations.

-Peff
