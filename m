From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 17:35:22 -0400
Message-ID: <20120411213522.GA28199@sigill.intra.peff.net>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:35:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5CN-0006SF-9X
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118Ab2DKVf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:35:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56989
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753593Ab2DKVfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:35:24 -0400
Received: (qmail 18076 invoked by uid 107); 11 Apr 2012 21:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Apr 2012 17:35:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Apr 2012 17:35:22 -0400
Content-Disposition: inline
In-Reply-To: <4F84DD60.20903@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195268>

On Tue, Apr 10, 2012 at 08:24:48PM -0500, Neal Kreitzinger wrote:

> (I read bup DESIGN doc to see what bup-style splitting is.) When you
> use bup delta technology in git.git I take it that you will use it
> for big-worktree-files *and* big-history-files

I'm not sure what those terms mean. We are talking about files at the
blob level. So they are either big or not big. We don't know how they
will delta, or what their histories will be like.

> (not-big-worktree-files that are not xdelta delta-friendly)?
> IOW, all binaries plus big-text-worktree-files.  Otherwise, small
> binaries will become large histories.

Files that don't delta won't be helped by splitting, as it is just
another form of finding deltas (in fact, it should produce worse results
than xdelta, because it works with larger granularity; its advantage is
that it is not as memory or CPU-hungry as something like xdelta).

So you really only want to use this for files that are too big to
practically run through the regular delta algorithm. And if you can
avoid it on files that will never delta well, you are better off
(because it adds storage overhead over a straight blob).

The first part is easy: only do it for files that are so big that you
can't run the regular delta algorithm. So since your only alternative is
doing nothing, you only have to perform better than nothing. :)

The second part is harder. We generally don't know that a file doesn't
delta well until we have two versions of it to try[1]. And that's where
some domain-specific knowledge can come in (e.g., knowing that a file is
compressed video, and that future versions are likely to differ in the
video content). But sometimes the results can be surprising. I keep a
repository of photos and videos, carefully annotated via exif tags. If
the media content changes, the results won't delta well. But if I change
the exif tags, they _do_ delta very well. So whether something like
bupsplit is a win depends on the exact update patterns.

[1] I wonder if you could do some statistical analysis on the randomness
    of the file content to determine this. That is, things which look
    very random are probably already heavily compressed, and are not
    going to compress further. You might guess that to mean that they
    will not delta well, either. And sometimes that is true. But the
    example I gave above violates it (most of the file is random, but
    the _changes_ from version to version will not be random, and that
    is what the delta is compressing).

> If small binaries are not going to be bup-delta-compressed, then what
> about using xxd to convert the binary to text and then xdelta
> compressing the hex dump to achieve efficient delta compression in
> the pack file?  You could convert the hexdump back to binary with xxd
> for checkout and such.

That wouldn't help. You are only trading the binary representation for a
less efficient one. But the data patterns will not change. The
redundancy you introduced in the first step may mostly come out via
compression, but it will never be a net win. I'm sure if I were a better
computer scientist I could write you some proof involving Shannon
entropy. But here's a fun experiment:

  # create two files, one very compressible and one not very
  # compressible
  dd if=/dev/zero of=boring.bin bs=1M count=1
  dd if=/dev/urandom of=rand.bin bs=1M count=1

  # now make hex dumps of each, and compress the original and the hex
  # dump
  for i in boring rand; do
    xxd <$i.bin >$i.hex
    for j in bin hex; do
      gzip -c <$i.$j >$i.$j.gz
    done
  done

  # and look at the results
  du {boring,rand}.*

I get:

  1024    boring.bin
  4       boring.bin.gz
  4288    boring.hex
  188     boring.hex.gz
  1024    rand.bin
  1028    rand.bin.gz
  4288    rand.hex
  2324    rand.hex.gz

So you can see that the thing that compresses well will do so in
either representation, but the end result is a net loss with the less
efficient representation. Whereas the thing that does not compress well
will achieve a better compression ratio in its text form, but will still
be a net loss. The reason is that you are just compressing out all of
the redundant bits.

You might observe that this is using gzip, not xdelta. But I think from
an information theory standpoint, they are two sides of the same coin
(e.g., you could consider a delta between two things to be equivalent to
concatenating them and compressing the result). You should be able to
design a similar experiment with xdelta.

> Maybe small binaries do xdelta well and the above is a moot point.

Some will and some will not. But it has nothing to do with whether they
are binary, and everything to do with the type of content they store (or
if binariness does matter, then our delta algorithms should be
improved).

> This is all theory to me, but the reality is looming over my head
> since most of the components I should be tracking are binaries small
> (large history?) and big (but am not yet because of "big-file"
> concerns -- I don't want to have to refactor my vast git ecosystem
> with filter branch later because I slammed binaries into the main
> project or superproject without proper systems programming (I'm not
> sure what the c/linux term is for 'systems programming', but in the
> mainframe world it meant making sure everything was configured for
> efficient performance)).

One of the things that makes bup not usable as-is for git is that it
fundamentally changes the object identities. It would be very easy for
"git add" to bupsplit a file into a tree, and store that tree using git
(in fact, that is more or less how bup works).  But that means that the
resulting object sha1 is going to depend on the splitting choices made.
Instead, we want to consider the split version of an object to be simply
an on-disk representation detail. Just as it is a representation detail
that some objects are stored in delta-encoding inside packs, versus as
loose objects; the sha1 of the object is the same, and we can
reconstruct it byte-for-byte when we want to.

So properly implemented, no, you would not have to ever filter-branch to
tweak these settings. You might have to do a repack to see the gains
(because you want to delete the old non-split representation you have in
your pack and replace it with a split representation), but that is
transparent to git's abstract data model.

-Peff
