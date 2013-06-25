From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Mon, 24 Jun 2013 23:42:49 -0600
Message-ID: <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com> <1372116193-32762-10-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Vicent Marti <tanoku@gmail.com>, Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 07:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrM2K-0000xY-Ms
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 07:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab3FYFnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 01:43:12 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46183 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab3FYFnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 01:43:10 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so26919062ied.14
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 22:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hi9yguPNkTTbCsFRr+4uBcuM0qbHSCeuJZvOp8W6tI4=;
        b=YadzyTYse28HsPxZn4/pXNWv/JdBf5ULJB0IJcwY+CQJHeGidKivNroM8ERnQYir3U
         JgRJAhb7BR/1dpm90Q6Lb4BRfQT0pnclPKtwfoffTa621M/LshymJ2kjF0A9AqXv46Jk
         266TK69v92Gqmh56ZkUy1x7ZZAcx319SIpd2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=hi9yguPNkTTbCsFRr+4uBcuM0qbHSCeuJZvOp8W6tI4=;
        b=VRVKCFFihnwprErwJRt4kXtMNOeuyaOCyP1qJBcdZqUWQpUEtTEHIilZs85PKO91+D
         x9+A599UFuxxlZMKbLYPrIDFdpvcqYNt9wI0bfXzlnAq6Y+bq9aYDyFzNpWrsGLrICn2
         CfFf6wn9uQdvtqZb22HeZ4GB4SjX0ao9oZDmsJL/m3xJXTaBenGQoDPEoVoBnyDDU5Xm
         3q6aR7A48nASY9LrcC4Qt41Z/oiRc/dv98zKxzBuQcZ9Pb04ubSsohkdkOyWGxckwP/K
         Z99mH+CoDc/M4FIfYuiHTvT7q23c2xn4Yf08rXXsA2ZyWldJgv57rLn+BdTAbT38Ai/z
         hoDw==
X-Received: by 10.42.98.69 with SMTP id r5mr2235523icn.95.1372138989977; Mon,
 24 Jun 2013 22:43:09 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Mon, 24 Jun 2013 22:42:49 -0700 (PDT)
In-Reply-To: <1372116193-32762-10-git-send-email-tanoku@gmail.com>
X-Gm-Message-State: ALoCoQkGLJi9ZCEz3rI56V98c7VE01rQoBlyhiDqApznT9bwEp7+spRdL69jFfQgfcuUwLwPeXsC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228944>

On Mon, Jun 24, 2013 at 5:23 PM, Vicent Marti <tanoku@gmail.com> wrote:
> This is the technical documentation and design rationale for the new
> Bitmap v2 on-disk format.
> ---
>  Documentation/technical/bitmap-format.txt |  235 +++++++++++++++++++++++++++++
>  1 file changed, 235 insertions(+)
>  create mode 100644 Documentation/technical/bitmap-format.txt
>
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
> new file mode 100644
> index 0000000..5400082
> --- /dev/null
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -0,0 +1,235 @@
> +GIT bitmap v2 format & rationale
> +================================
> +
> +       - A header appears at the beginning, using the same format
> +       as JGit's original bitmap indexes.
> +
> +               4-byte signature: {'B', 'I', 'T', 'M'}
> +
> +               2-byte version number (network byte order)
> +                       The current implementation only supports version 2
> +                       of the bitmap index. The rationale for this is explained
> +                       in this document.
> +
> +               2-byte flags (network byte order)
> +
> +                       The folowing flags are supported:
> +
> +                       - BITMAP_OPT_FULL_DAG (0x1) REQUIRED
> +                       This flag must always be present. It implies that the bitmap
> +                       index has been generated for a packfile with full closure
> +                       (i.e. where every single object in the packfile can find
> +                        its parent links inside the same packfile). This is a
> +                       requirement for the bitmap index format, also present in JGit,
> +                       that greatly reduces the complexity of the implementation.
> +
> +                       - BITMAP_OPT_LE_BITMAPS (0x2)
> +                       If present, this implies that that the EWAH bitmaps in this
> +                       index has been serialized to disk in little-endian byte order.
> +                       Note that this only applies to the actual bitmaps, not to the
> +                       Git data structures in the index, which are always in Network
> +                       Byte order as it's costumary.
> +
> +                       - BITMAP_OPT_BE_BITMAPS (0x4)
> +                       If present, this implies that the EWAH bitmaps have been serialized
> +                       using big-endian byte order (NWO). If the flag is missing, **the
> +                       default is to assume that the bitmaps are in big-endian**.

I very much hate seeing a file format that is supposed to be portable
that supports both big-endian and little-endian encoding. Such a
specification forces everyone to implement two code paths to handle
reading data from the file, on the off-chance they are on the wrong
platform. Or it forces one platform to be unable to use the file. In
which case a repository may want to build two files, one for each
platform, but you blocked that off by allowing only one file.

What is wrong with picking one encoding and sticking to it? The .idx
file and the dircache use big-endian format. Why not just use
big-endian here too and convert words on demand as they are accessed
from the mmap region? That is what the .idx format does when accessing
an offset.

> +                       - BITMAP_OPT_HASH_CACHE (0x8)
> +                       If present, a hash cache for finding delta bases will be available
> +                       right after the header block in this index. See the following
> +                       section for details.
> +
> +               4-byte entry count (network byte order)
> +
> +                       The total count of entries (bitmapped commits) in this bitmap index.
> +
> +               20-byte checksum
> +
> +                       The SHA1 checksum of the pack this bitmap index belongs to.
> +
> +       - An OPTIONAL delta cache follows the header.

Some may find the name "delta cache" confusing as it does not cache
deltas of objects. May I suggest "path hash cache" as an alternative
name?

> +               The cache is formed by `n` 4-byte hashes in a row, where `n` is
> +               the amount of objects in the indexed packfile. Note that this amount
> +               is the **total number of objects** and is not related to the
> +               number of commits that have been selected and indexed in the
> +               bitmap index.
> +
> +               The hashes are stored in Network Byte Order and they are the same
> +               values generated by a normal revision walk during the `pack-objects`
> +               phase.

I find it interesting this is network byte order and not big-endian or
little-endian based on the flag in the header.

> +               The `n`nth hash in the cache is the name hash for the `n`th object
> +               in the index for the indexed packfile.
> +
> +               [RATIONALE]:
> +
> +               The bitmap index allows us to skip the Counting Objects phase
> +               during `pack-objects` and yield all the OIDs that would be reachable
> +               ("WANTS") when generating the pack.
> +
> +               This optimization, however, means that we're adding objects to the
> +               packfile straight from the packfile index, and hence we are lacking
> +               path information for the objects that would normally be generated
> +               during the "Counting Objects" phase.
> +
> +               This path information for each object is hashed and used as a very
> +               effective way to find good delta bases when compressing the packfile;
> +               without these hashes, the resulting packfiles are much less optimal.
> +
> +               By storing all the hashes in a cache together with the bitmapsin
> +               the bitmap index, we can yield not only the SHA1 of all the reachable
> +               objects, but also their hashes, and allow Git to be much smarter when
> +               finding delta bases for packing.
> +
> +               If the delta cache is not available, the bitmap index will obviously
> +               be smaller in disk, but the packfiles generated using this index will
> +               be between 20% and 30% bigger, because of the lack of name/path
> +               information when finding delta bases.

JGit does not encode this because we were afraid of freezing the hash
function into the file format. Indeed we are not certain JGit even
uses the same path hash function as C Git does, because C Git's
implementation is covered by the GPL and JGit prefers to license its
work under BSD.

If the path hash is going to become part of the format, the algorithm
for computing the hash should also be specified in the format so that
non-GPL implementations have an opportunity to be compatible.

One way we side-stepped the size inflation problem in JGit was to only
use the bitmap index information when sending data on the wire to a
client. Here delta reuse plays a significant factor in building the
pack, and we don't have to be as accurate on matching deltas. During
the equivalent of `git repack` bitmaps are not used, allowing the
traditional graph enumeration algorithm to generate path hash
information.

> +       - 4 EWAH bitmaps that act as type indexes
> +
> +               Type indexes are serialized after the hash cache in the shape
> +               of four EWAH bitmaps stored consecutively (see Appendix A for
> +               the serialization format of an EWAH bitmap).
> +
> +               There is a bitmap for each Git object type, stored in the following
> +               order:
> +
> +                       - Commits
> +                       - Trees
> +                       - Blobs
> +                       - Tags
> +
> +               In each bitmap, the `n`th bit is set to true if the `n`th object
> +               in the packfile index is of that type.
> +
> +               The obvious consequence is that the XOR of all 4 bitmaps will result
> +               in a full set (all bits sets), and the AND of all 4 bitmaps will
> +               result in an empty bitmap (no bits set).

Instead of XOR did you mean OR here?

> +       - N EWAH bitmaps, one for each indexed commit
> +
> +               Where `N` is the total amount of entries in this bitmap index.
> +               See Appendix A for the serialization format of an EWAH bitmap.
> +
> +       - An entry index with `N` entries for the indexed commits
> +
> +               Index entries are stored consecutively, and each entry has the
> +               following format:
> +
> +               - 20-byte SHA1
> +                       The SHA1 of the commit that this bitmap indexes
> +
> +               - 4-byte offset (Network Byte Order)
> +                       The offset **from the beginning of the file** where the
> +                       bitmap for this commit is stored.

Eh, another network byte order field in a file that also has selective
ordering. *sigh*

> +               - 1-byte XOR-offset
> +                       The xor offset used to compress this bitmap. For an entry
> +                       in position `x`, a XOR offset of `y` means that the actual
> +                       bitmap representing for this commit is composed by XORing the
> +                       bitmap for this entry with the bitmap in entry `x-y` (i.e.
> +                       the bitmap `y` entries before this one).
> +
> +                       Note that this compression can be recursive. In order to
> +                       XOR this entry with a previous one, the previous entry needs
> +                       to be decompressed first, and so on.
> +
> +                       The hard-limit for this offset is 160 (an entry can only be
> +                       xor'ed against one of the 160 entries preceding it). This
> +                       number is always positivea, and hence entries are always xor'ed
> +                       with **previous** bitmaps, not bitmaps that will come afterwards
> +                       in the index.

What order are these entries in? Sorted by SHA-1 or random?

Colby found that doing an XOR against the descendant commit yielded
very small bitmaps, so JGit tries to XOR-compress bitmaps along common
linear slices of history. This is trivial in Linus' kernel tree where
there is effectively only one history, but its more relevant with
long-running side branches that have release tags that may not have
fully merged into "master".

> +               - 1-byte flags for this bitmap
> +                       At the moment the only available flag is `0x1`, which hints
> +                       that this bitmap can be re-used when rebuilding bitmap indexes
> +                       for the repository.
> +
> +               - 2 bytes of RESERVED data (used right now for better packing).
> +
> +== Rationale for changes from the Bitmap Format v1
> +
> +- Serialized EWAH bitmaps can be stored in Little-Endian byte order,
> +  if defined by the BITMAP_OPT_LE_BITMAPS flag in the header.
> +
> +  The original JGit implementation stored bitmaps in Big-Endian byte
> +  order (NWO) because it was unable to `mmap` the serialized format,
> +  and hence always required a full parse of the bitmap index to memory,
> +  where the BE->LE conversion could be performed.

You can mmap a file and convert each word on access if your machine is
not using the same byte order. It is not necessary to convert the
entire file before using it through a mmap region.

> +  This full parse, however, requires prohibitive loading times in LE
> +  machines (i.e. all modern server hardware): a repository like
> +  `torvalds/linux` can have about 8mb of bitmap indexes, resulting
> +  in roughly 400ms of parse time.

This makes me wonder what the JGit parse time is. It is ugly if we are
spending 400ms to load the bitmap index for the kernel repository.

> +  This is not an issue in JGit, which is capable of serving repositories
> +  from a single-process daemon running on the JVM, but `git-daemon` in
> +  git has been implemented with a process-based design (a new
> +  `pack-objects` is spawned for each request), and the boot times
> +  of parsing the bitmap index every time `pack-objects` is spawned can
> +  seriously slow down requests (particularly for small fetches, where we'd
> +  spend about 1.5s booting up and 300ms performing the Counting Objects
> +  phase).

There are other strategies that Git could use to handle request
processing at scale. But I guess its reasonable to assume these aren't
viable for Git for a number of reasons. E.g. "long tail" access effect
that many servers have, where most requests are to a large number of
repositories that themselves receive very few requests, an environment
that does not lend itself to caching.

> +  By storing the bitmaps in Little-Endian, we're able to `mmap` their
> +  compressed data straight in memory without parsing it beforehand, and
> +  since most queries don't require accessing all the serialized bitmaps,
> +  we'll only page in the minimal amount of bitmaps necessary to perform
> +  the reachability analysis as they are accessed.

FWIW the .idx and .pack file formats `mmap` the compressed data
straight into memory without parsing it beforehand, and do not use
little-endian byte order. It is possible to have a single compressed
file format definition that is portable to all architectures, and is
accessed by mmap, at scale, with reasonable efficiency.

> +- An index of all the bitmapped commits is written at the end of the packfile,
> +  instead of interpersed with the serialized bitmaps in the middle of the
> +  file.

This is probably a mistake in the JGit design. Your approach is
slightly more complex, but in general I agree with having a table of
the SHA-1s isolated from the bitmaps themselves so that a reader can
access specific bitmaps at random without needing to wade through all
compressed bitmaps.

I would have proposed putting the table at the start of the file, not
the end. The writer making the file can completely serialize the
bitmaps into memory before writing them to disk, and thus knows the
full layout of the resulting file. If the bitmaps don't fit in RAM at
writing time, game over, the optimization of having a very compact
representation of the graph is no longer helping you.

> +  Again, the old design implied a full parse of the whole bitmap index
> +  (which JGit can afford because its daemon is single-process), but it made
> +  impossible `mmaping` the bitmap index file and accessing only the parts
> +  required to actually solve the query.
> +
> +  With an index at the end of the file, we can load only this index in memory,
> +  allowing for very efficient access to all the available bitmaps lazily (we
> +  have their offsets in the mmaped file).
> +
> +- The ordering of the objects in each bitmap has changed from
> +  packfile-order (the nth bit in the bitmap is the nth object in the
> +  packfile) to index-order (the nth bit in the bitmap is the nth object
> +  in the INDEX of the packfile).

Did you notice an increase in bitmap size when you did this? Colby
tested both orderings and we observed the bitmaps were quantifiably
smaller when using the pack file ordering, due to the pack file
locality rules and the EWAH compression. Using the pack file ordering
was a very conscious design decision.

> +  There is not a noticeable performance difference when actually converting
> +  from bitmap position to SHA1 and from SHA1 to bitmap position, but when
> +  using packfile ordering like JGit does, queries need to go through the
> +  reverse index (pack-revindex.c).
> +
> +  Generating this reverse index at runtime is **not** free (around 900ms
> +  generation time for a repository like `torvalds/linux`), and once again,
> +  this generation time needs to happen every time `pack-objects` is
> +  spawned.

Did you know the packer needs the reverse index in order to compute
the end offset of an object it will copy as-is during delta reuse? How
have you avoided making the reverse index?

Again this is why we chose to pin the JGit bitmap on the reverse index
being present. It already had to be present to support as-is reuse.
Once we knew we had to have that reverse index it was OK to rely on it
to get better compression on the bitmaps, and thus make them take up
less memory when loaded into a server. Even if you mmap a file you
want it to be small so it is more likely to retain in the kernel
buffer cache across process invocations.
