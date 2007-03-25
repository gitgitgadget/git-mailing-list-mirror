From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 05:18:07 -0400
Message-ID: <20070325091806.GH25863@spearce.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk> <alpine.LFD.0.83.0703241913110.18328@xanadu.home> <20070325083530.GA25523@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVOrh-0000F2-Nu
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 11:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227AbXCYJSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 05:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933281AbXCYJSO
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 05:18:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44364 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933227AbXCYJSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 05:18:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVOrX-0000xU-Cs; Sun, 25 Mar 2007 05:18:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CC57D20FBAE; Sun, 25 Mar 2007 05:18:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070325083530.GA25523@bohr.gbar.dtu.dk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43046>

Peter Eriksen <s022018@student.dtu.dk> wrote:
> On Sat, Mar 24, 2007 at 07:24:17PM -0400, Nicolas Pitre wrote:
> > On Sat, 24 Mar 2007, Peter Eriksen wrote:
> > 
> > > There is a new tree type called OBJ_DICT_TREE, which looks something
> > > like the following:
> > > 
> > > +-----------------+------------------------------------------------+----
> > > |  Table offset   |  SHA-1 of the blob corresponding to the path.  | ...
> > > +-----------------+------------------------------------------------+----
> > >       6 bytes                     20 bytes
> > 
> > Actually it is a 2-byte index in the path table, and a 4-byte index in a 
> > common SHA1 table.  So each tree entry is 6 bytes total.
> 
> What happens to the paths, that do not have a correponding entry in the
> path name table, because they are not among the 65535 most frequent
> paths in the pack?

They don't appear in the table.  And any tree that uses them is
forced to use the "legacy" OBJ_TREE encoding.  Which is what we
have now in pack v2, and in loose objects.
 
> > > The index (.idx) files are extended to have a 4 byte pointer to the
> > > offset of this file name table in the pack file for easy lookup.
> > 
> > Right.  And it will lose the SHA1 entries since they are already 
> > available in the pack.
> 
> Does this mean, that the current index format will change from:
> 
>   - The header is followed by sorted 24-byte entries, one entry
>     per object in the pack.  Each entry is:
> 
>     4-byte network byte order integer, recording where the
>     object is stored in the packfile as the offset from the
>     beginning.
> 
> to just 4-byte entries, and are the SHA-1 entries in that extra table
> of SHA-1's referenced by OBJ_DICT_TREE objects in the pack file?

or 8 byte entries (for 64 bit offsets, handling larger files).
But yes.

We will also still store the fan-out table at the start of the index,
as its very useful at runtime when reading the packfile for random
access, but isn't required for accurate encoding/decoding of the
data in the packfile.

> On disk format of version 4 packs (v0.1)
> =================================
> 
> There is a file name table, EXT_OBJ_FILENAME_TABLE, which is placed
> anywhere in the pack file, but before any OBJ_DICT_TREE objects, which
> are referencing the table, so that the pack can be easily streamed. It
> is using the format:
> 
> +-------------------------------+
> |  Compressed file name table   |
> +-------------------------------+
> 
> The uncompressed file name table contains NR_ENTRIES entries,
> and looks like this:
> 
> +------------+------+--------------+------+--------------------+----
> | NR_ENTRIES | MODE |  Full path 1 | MODE | Full path 2        | ...
> +------------+------+--------------+------+--------------------+----
>    4 bytes    2 bytes   n1 bytes    2 bytes     n2 bytes     
> 
> MODE is a network-byte-order integer representing the mode of the path,
> and the path is a variable length, null-terminated string.

Yes so far.
 
> The table is sorted by path then mode for easy binary lookup, and so
> that pointers into this table can be compared directly instead of
> comparing the corresponding paths and modes. This table contains the
> 65535 most used paths in the entire pack.

See my prior email about the sorting.  But yes.

> There is a new tree type called OBJ_DICT_TREE, which looks like the
> following:
> 
> +--------+----------------+----
> | P offs |   SHA-1 offs   | ...
> +--------+----------------+----
>   2 bytes      4 bytes

See my prior email; there's also that pesky record count at the start.

> That is, each entry contains a 2-byte index into the path table, and a
> corresponding 4-byte index into a SHA-1 table.
> 
> These new tree objects will remain uncompressed in the pack file, but
> sorted with, and deltaed against other tree objects. All normal tree
> objects are converted to OBJ_DICT_TREE when packing, and are converted
> back on the fly to callers who need an ordinary OBJ_TREE.

Yup, but see my prior email as there's also the rule that OBJ_DICT_TREE
cannot delta against an OBJ_TREE (or vice-versa).

> The index (.idx) files are extended to have a 4 byte pointer to the
> offset of this file name table in the pack file for easy lookup.
> 
> There is something similar with a table, EXT_OBJ_IDENT_TABLE of common
> strings in commit objects (e.g. author and timezone), and a new object
> OBJ_DICT_COMMIT, but I have not understood that quite yet.

OBJ_DICT_COMMIT is rather simple:

 - stored uncompressed, like OBJ_DICT_TREE

+---------+------+-------+------------+-------------+-------------+-----
| RAW_LEN | tree | flags | parents... | commit_time | author_time | ...
+---------+------+-------+------------+-------------+-------------+-----
  vint     idref  1 byte   idref * n   4 bytes       4 bytes

Here RAW_LEN is the total length of this commit when its in its
standard raw format, the one that is used to compute the SHA-1.
This helps the decoder when we need to recreate a normal commit.
We store this a vint just because we can.

The tree and parent idrefs are currently full 20-byte SHA-1s,
but these are likely to change to 4 byte SHA-1 indexes like in
an OBJ_DICT_TREE.

The flags field is actually 3 fields crammed into 1 byte:

  flags & 128 == if set, the author_time == commit_time and the
  author_time field is not present in the stream;

  flags & 64 == if set, the author == committer and the author ident
  field is not present in the stream;

  flags & 63 == number of parent idrefs (n above).  May be 0.
  I'm actually considering making this flags & 31, leaving ourselves
  a spare bit for the future.  Why?  You can't make a commit with
  more than 16 parents right now.

Now after the n parent idrefs (again, 20-byte SHA-1 but could also
be the 4 byte SHA-1 indexes) we always have the commit_time field,
and optionally the author_time field (if flags & 128 == 0).

 [sidenote: after re-reading this, I don't like the definition of
  flags & 128 == 1 implying there is 4 bytes *less* data in the
  stream.  Every other place within Git we use a bit set to mean
  *more* data follows, and a bit not set to mean *less* data
  follows.  pack v4 is backwards here, and that's wrong.]

The commit_time field is a 4 byte big-endian seconds-since-epoch
thing.  We're actually saying the high-bit must not be set here,
leaving that room for future expansion.  We may just later redefine
it to mean an unsigned time_t, or to mean its variable length
encoded, or...  ;-)

Why commit_time, and why before the idents?  Because if you look at
our revision walking code we care about commit_time to sort commits
in struct commit_list.  Making it early where we can get to it fast
helps the commit walker skip through commits it doesn't want to show.

The author_time field is not present if flags & 128 is true.
If flags & 128 is false, its present, and uses the same encoding
as commit_time.  Why is this field optional?  Because its not
uncommon for it to match commit_time!  ;-)

----+-----------+--------+---------------------
... | committer | author | deflated_message ...
----+-----------+--------+---------------------
      vint         vint

Now to finish out the object we have the committer as a variable
length integer index into EXTOBJ_IDENT_TABLE.  The author is
the same, except its optional and is only present if flags &
64 is false.  Why?  Again, because it is commonf for author ==
committer in many projects.

The remainder of the buffer is the zlib deflated message.

Now the message is tricky.  When inflated it actually usually starts
with an LF.  Why?

In 'raw' format of a commit we consider the end of the header lines
and the start of the message itself to be a single blank line.  But
there can be additional headers beyond tree/parent/author/committer.
Like what?  The newer encoding header!

So commits that have no encoding header have their inflated message
starting with an LF.  Commits that actually used the encoding header
have their inflated message starting with 'encoding '.  So we can
tell if there are additional headers (or not) in a given commit by
looking at the inflated message to see if the first character is
an LF, or not.

This format allows us to store any additional headers that
might get developed, while still enjoying the benefits of the
EXTOBJ_DICT_COMMIT encoding for the headers that are currently
somewhat important to Git.

-- 
Shawn.
