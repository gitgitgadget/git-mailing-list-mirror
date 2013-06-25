From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Tue, 25 Jun 2013 21:33:11 +0200
Message-ID: <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 25 21:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrYzi-0005hM-GT
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 21:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414Ab3FYTde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 15:33:34 -0400
Received: from mail-vb0-f42.google.com ([209.85.212.42]:55323 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab3FYTdc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 15:33:32 -0400
Received: by mail-vb0-f42.google.com with SMTP id i3so9974932vbh.29
        for <git@vger.kernel.org>; Tue, 25 Jun 2013 12:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZPyqO1kN2g6IiHPFSafxp3vILIQhU2Tsqb7rzi3HoI8=;
        b=F8tKcx9L5rCFknGMpPE3F/tfqryl6GI1KvBG58mhmn7rcE7oBwLJZHI5QCWZ8NZ2CT
         bxkflNiDb8oFdLk8UsGLfvyXoA/WK8XF9JC6NyAsjHIRYRC5V8LJL+AUSm6hIHRQwlH2
         hYXn5fjzcMN4eli47gi5SbX8tMaZzoodCKwpqEjtztHVdeVqcM3YvuemFPdabm+a3zwu
         wo1bs7y89c8SufcoeY5ImboXMpvjDvvIIRvnUlYd65nmGd/Wm3BlRHXiwFOX5/mLTx75
         VFk2nL9/cIyYKXGadi5RjiPgvsoUU8rvWSYCMbbiL6yEvSmEYiUk8zItHSLzphl+XUnu
         pRAw==
X-Received: by 10.221.39.72 with SMTP id tl8mr345606vcb.29.1372188812024; Tue,
 25 Jun 2013 12:33:32 -0700 (PDT)
Received: by 10.221.45.131 with HTTP; Tue, 25 Jun 2013 12:33:11 -0700 (PDT)
In-Reply-To: <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228986>

On Tue, Jun 25, 2013 at 7:42 AM, Shawn Pearce <spearce@spearce.org> wrote:
> I very much hate seeing a file format that is supposed to be portable
> that supports both big-endian and little-endian encoding.

Well, the bitmap index is not supposed to be portable, as it doesn't
get sent over the wire in any situation. Regardless, the format is
portable because it supports both encodings and clearly defines which
one the current file is using. I think that's a good tradeoff!

> Such a specification forces everyone to implement two code paths to handle
> reading data from the file, on the off-chance they are on the wrong
> platform.

Extra code paths have never been an issue in the
JGitAbstractFactoryGeneratorOfGit, har har har. Ah. I'm such a funny
guy when it comes to Java.

Anyway, I designed this keeping JGit in mind. In this specific case,
it doesn't force you to add any new code paths. The endianness changes
only affect the serialization format of the bitmaps, which is not part
of Git or JGit itself but of the Javaewah/libewok library. The
interface for reading on that library has already been wisely
abstracted on JGit
(https://github.com/eclipse/jgit/blob/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/PackBitmapIndexV1.java#L133),
so changing the byte order simply means changing the SimpleDataInput
to a LE one.

I agree this is not ideal, or elegant, but I'm having a hard time
making an argument for sacrificing objective speed for the sake of
subjective "simplicity".

> What is wrong with picking one encoding and sticking to it?

It prevents us from making this optimally fast on the machines where
it needs to be.

Regardless, I must admit I haven't generated numbers for this in a
while (the BE->LE switch is one of the first optimizations I did). I'm
going to try to re-implement full NWO loading and see how much slower
it is, before I continue arguing for/against it.

If I can get it within a reasonable margin (say, 15%) of the current
implementation, I'd definitely be in favor of sticking to only NWO on
the whole file. If it's slower than that, well, Git has never
compromised on speed, and I don't think there's a point to be made for
starting to do that now.

>> +                       - BITMAP_OPT_HASH_CACHE (0x8)
>> +                       If present, a hash cache for finding delta bases will be available
>> +                       right after the header block in this index. See the following
>> +                       section for details.
>> +
>> +               4-byte entry count (network byte order)
>> +
>> +                       The total count of entries (bitmapped commits) in this bitmap index.
>> +
>> +               20-byte checksum
>> +
>> +                       The SHA1 checksum of the pack this bitmap index belongs to.
>> +
>> +       - An OPTIONAL delta cache follows the header.
>
> Some may find the name "delta cache" confusing as it does not cache
> deltas of objects. May I suggest "path hash cache" as an alternative
> name?

Definitely, this is a typo.

>> +               The cache is formed by `n` 4-byte hashes in a row, where `n` is
>> +               the amount of objects in the indexed packfile. Note that this amount
>> +               is the **total number of objects** and is not related to the
>> +               number of commits that have been selected and indexed in the
>> +               bitmap index.
>> +
>> +               The hashes are stored in Network Byte Order and they are the same
>> +               values generated by a normal revision walk during the `pack-objects`
>> +               phase.
>
> I find it interesting this is network byte order and not big-endian or
> little-endian based on the flag in the header.

As stated before, the flag in the header only affects the
Javaewah/libewok interface. Everything Git-related in the bitmap index
is in NWO, like it is customary in Git.

>
>> +               The `n`nth hash in the cache is the name hash for the `n`th object
>> +               in the index for the indexed packfile.
>> +
>> +               [RATIONALE]:
>> +
>> +               The bitmap index allows us to skip the Counting Objects phase
>> +               during `pack-objects` and yield all the OIDs that would be reachable
>> +               ("WANTS") when generating the pack.
>> +
>> +               This optimization, however, means that we're adding objects to the
>> +               packfile straight from the packfile index, and hence we are lacking
>> +               path information for the objects that would normally be generated
>> +               during the "Counting Objects" phase.
>> +
>> +               This path information for each object is hashed and used as a very
>> +               effective way to find good delta bases when compressing the packfile;
>> +               without these hashes, the resulting packfiles are much less optimal.
>> +
>> +               By storing all the hashes in a cache together with the bitmapsin
>> +               the bitmap index, we can yield not only the SHA1 of all the reachable
>> +               objects, but also their hashes, and allow Git to be much smarter when
>> +               finding delta bases for packing.
>> +
>> +               If the delta cache is not available, the bitmap index will obviously
>> +               be smaller in disk, but the packfiles generated using this index will
>> +               be between 20% and 30% bigger, because of the lack of name/path
>> +               information when finding delta bases.
>
> JGit does not encode this because we were afraid of freezing the hash
> function into the file format. Indeed we are not certain JGit even
> uses the same path hash function as C Git does, because C Git's
> implementation is covered by the GPL and JGit prefers to license its
> work under BSD.
>
> If the path hash is going to become part of the format, the algorithm
> for computing the hash should also be specified in the format so that
> non-GPL implementations have an opportunity to be compatible.

Very valid point. I would hope that whoever wrote the original hash
will let us re-license it under BSD. It would be nice to define this
hash function as part of the format.

> One way we side-stepped the size inflation problem in JGit was to only
> use the bitmap index information when sending data on the wire to a
> client. Here delta reuse plays a significant factor in building the
> pack, and we don't have to be as accurate on matching deltas. During
> the equivalent of `git repack` bitmaps are not used, allowing the
> traditional graph enumeration algorithm to generate path hash
> information.

OH BOY HERE WE GO. This is worth its own thread, lots to discuss here.
I think peff will have a patchset regarding this to upstream soon,
we'll get back to it later.

>
>> +       - 4 EWAH bitmaps that act as type indexes
>> +
>> +               Type indexes are serialized after the hash cache in the shape
>> +               of four EWAH bitmaps stored consecutively (see Appendix A for
>> +               the serialization format of an EWAH bitmap).
>> +
>> +               There is a bitmap for each Git object type, stored in the following
>> +               order:
>> +
>> +                       - Commits
>> +                       - Trees
>> +                       - Blobs
>> +                       - Tags
>> +
>> +               In each bitmap, the `n`th bit is set to true if the `n`th object
>> +               in the packfile index is of that type.
>> +
>> +               The obvious consequence is that the XOR of all 4 bitmaps will result
>> +               in a full set (all bits sets), and the AND of all 4 bitmaps will
>> +               result in an empty bitmap (no bits set).
>
> Instead of XOR did you mean OR here?

Nope, I think XOR makes it more obvious: if the same bit is set on two
bitmaps, it would be cleared when XORed together, and hence all the
bits wouldn't be set. An OR would hide this case.

>
>> +       - N EWAH bitmaps, one for each indexed commit
>> +
>> +               Where `N` is the total amount of entries in this bitmap index.
>> +               See Appendix A for the serialization format of an EWAH bitmap.
>> +
>> +       - An entry index with `N` entries for the indexed commits
>> +
>> +               Index entries are stored consecutively, and each entry has the
>> +               following format:
>> +
>> +               - 20-byte SHA1
>> +                       The SHA1 of the commit that this bitmap indexes
>> +
>> +               - 4-byte offset (Network Byte Order)
>> +                       The offset **from the beginning of the file** where the
>> +                       bitmap for this commit is stored.
>
> Eh, another network byte order field in a file that also has selective
> ordering. *sigh*

:D :D :D again only the Javaewah interface.

>
>> +               - 1-byte XOR-offset
>> +                       The xor offset used to compress this bitmap. For an entry
>> +                       in position `x`, a XOR offset of `y` means that the actual
>> +                       bitmap representing for this commit is composed by XORing the
>> +                       bitmap for this entry with the bitmap in entry `x-y` (i.e.
>> +                       the bitmap `y` entries before this one).
>> +
>> +                       Note that this compression can be recursive. In order to
>> +                       XOR this entry with a previous one, the previous entry needs
>> +                       to be decompressed first, and so on.
>> +
>> +                       The hard-limit for this offset is 160 (an entry can only be
>> +                       xor'ed against one of the 160 entries preceding it). This
>> +                       number is always positivea, and hence entries are always xor'ed
>> +                       with **previous** bitmaps, not bitmaps that will come afterwards
>> +                       in the index.
>
> What order are these entries in? Sorted by SHA-1 or random?

Not-specified, since the whole index will be loaded in a hash table
like JGit does. In practice, it's toposorted because that makes for
better XOR bases.

> Colby found that doing an XOR against the descendant commit yielded
> very small bitmaps, so JGit tries to XOR-compress bitmaps along common
> linear slices of history. This is trivial in Linus' kernel tree where
> there is effectively only one history, but its more relevant with
> long-running side branches that have release tags that may not have
> fully merged into "master".

Indeed, indeed. We try to do the same.

>> +  This full parse, however, requires prohibitive loading times in LE
>> +  machines (i.e. all modern server hardware): a repository like
>> +  `torvalds/linux` can have about 8mb of bitmap indexes, resulting
>> +  in roughly 400ms of parse time.
>
> This makes me wonder what the JGit parse time is. It is ugly if we are
> spending 400ms to load the bitmap index for the kernel repository.

It's very bad. Of course you don't notice it because you're running in
`daemon` mode. It takes about 3s to load indexes for the
`torvalds/linux` network in my machine.

>
>> +  This is not an issue in JGit, which is capable of serving repositories
>> +  from a single-process daemon running on the JVM, but `git-daemon` in
>> +  git has been implemented with a process-based design (a new
>> +  `pack-objects` is spawned for each request), and the boot times
>> +  of parsing the bitmap index every time `pack-objects` is spawned can
>> +  seriously slow down requests (particularly for small fetches, where we'd
>> +  spend about 1.5s booting up and 300ms performing the Counting Objects
>> +  phase).
>
> There are other strategies that Git could use to handle request
> processing at scale. But I guess its reasonable to assume these aren't
> viable for Git for a number of reasons. E.g. "long tail" access effect
> that many servers have, where most requests are to a large number of
> repositories that themselves receive very few requests, an environment
> that does not lend itself to caching.
>
>> +  By storing the bitmaps in Little-Endian, we're able to `mmap` their
>> +  compressed data straight in memory without parsing it beforehand, and
>> +  since most queries don't require accessing all the serialized bitmaps,
>> +  we'll only page in the minimal amount of bitmaps necessary to perform
>> +  the reachability analysis as they are accessed.
>
> FWIW the .idx and .pack file formats `mmap` the compressed data
> straight into memory without parsing it beforehand, and do not use
> little-endian byte order. It is possible to have a single compressed
> file format definition that is portable to all architectures, and is
> accessed by mmap, at scale, with reasonable efficiency.
>
>> +- An index of all the bitmapped commits is written at the end of the packfile,
>> +  instead of interpersed with the serialized bitmaps in the middle of the
>> +  file.
>
> This is probably a mistake in the JGit design. Your approach is
> slightly more complex, but in general I agree with having a table of
> the SHA-1s isolated from the bitmaps themselves so that a reader can
> access specific bitmaps at random without needing to wade through all
> compressed bitmaps.
>
> I would have proposed putting the table at the start of the file, not
> the end. The writer making the file can completely serialize the
> bitmaps into memory before writing them to disk, and thus knows the
> full layout of the resulting file. If the bitmaps don't fit in RAM at
> writing time, game over, the optimization of having a very compact
> representation of the graph is no longer helping you.
>
>> +  Again, the old design implied a full parse of the whole bitmap index
>> +  (which JGit can afford because its daemon is single-process), but it made
>> +  impossible `mmaping` the bitmap index file and accessing only the parts
>> +  required to actually solve the query.
>> +
>> +  With an index at the end of the file, we can load only this index in memory,
>> +  allowing for very efficient access to all the available bitmaps lazily (we
>> +  have their offsets in the mmaped file).
>> +
>> +- The ordering of the objects in each bitmap has changed from
>> +  packfile-order (the nth bit in the bitmap is the nth object in the
>> +  packfile) to index-order (the nth bit in the bitmap is the nth object
>> +  in the INDEX of the packfile).
>
> Did you notice an increase in bitmap size when you did this? Colby
> tested both orderings and we observed the bitmaps were quantifiably
> smaller when using the pack file ordering, due to the pack file
> locality rules and the EWAH compression. Using the pack file ordering
> was a very conscious design decision.
>
>> +  There is not a noticeable performance difference when actually converting
>> +  from bitmap position to SHA1 and from SHA1 to bitmap position, but when
>> +  using packfile ordering like JGit does, queries need to go through the
>> +  reverse index (pack-revindex.c).
>> +
>> +  Generating this reverse index at runtime is **not** free (around 900ms
>> +  generation time for a repository like `torvalds/linux`), and once again,
>> +  this generation time needs to happen every time `pack-objects` is
>> +  spawned.
>
> Did you know the packer needs the reverse index in order to compute
> the end offset of an object it will copy as-is during delta reuse? How
> have you avoided making the reverse index?

I'm aware of that, but there are lots of other operations that can be
optimized with bitmaps that don't require a reverse index.

> Again this is why we chose to pin the JGit bitmap on the reverse index
> being present. It already had to be present to support as-is reuse.
> Once we knew we had to have that reverse index it was OK to rely on it
> to get better compression on the bitmaps, and thus make them take up
> less memory when loaded into a server. Even if you mmap a file you
> want it to be small so it is more likely to retain in the kernel
> buffer cache across process invocations.

Maybe this applies to the JVM (where you have to load the whole
index), but bitmap indexes are consistently one order of magnitude
smaller than packfile indexes (regardless of whether they use index
ordering or packfile ordering), and the packfile indexes are always
mapped on memory: This has never been an issue in Git, and I don't see
why it would become an issue now.

Pinning the bitmap index on the reverse index adds complexity (lookups
are two-step: first find the entry in the reverse index, and then find
the SHA1 in the index) and is measurably slower, in both loading and
lookup times. Since Git doesn't have a memory problem, it's very hard
to make an argument for design that is more complex and runs slower to
save memory.

To sum it up: I'd like to see this format be strictly in Network Byte
Order, and I'm going to try to make it run fast enough in that
encoding. Having the entry index at the end of the file and having the
bitmaps in index-order are Good Ideas (TM) because they are measurably
simpler and faster than their counterpoints. Do show code & benchmarks
if you think otherwise, though.

strawberry and watermelon kisses,
vmg
