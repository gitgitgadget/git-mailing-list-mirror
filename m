From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Understanding version 4 packs
Date: Sun, 25 Mar 2007 04:46:41 -0400
Message-ID: <20070325084641.GG25863@spearce.org>
References: <20070324202356.GA20734@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Sun Mar 25 10:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVONR-0001lE-1w
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 10:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbXCYIq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbXCYIqv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 04:46:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43845 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbXCYIqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 04:46:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVONA-0003Jo-Qu; Sun, 25 Mar 2007 04:46:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2951B20FBAE; Sun, 25 Mar 2007 04:46:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070324202356.GA20734@bohr.gbar.dtu.dk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43042>

Peter Eriksen <s022018@student.dtu.dk> wrote:
> I have been reading the commits in the
> git://repo.or.cz/git/fastimport.git/ repository (git makes it quite easy
> to see what differs from mainline using "git log master..pack4"), and I
> think, I have understood some of the details.

Just to be clear, that branch is strictly a proposed prototype of
what a pack version 4 *might* look like.  Absolutely nothing has
been set into stone for that file format.

A good chunk of that code needs to be reworked just to get it merged
onto Junio's current 'master' as Nico and myself have been doing a
number of cleanups and bug fixes in some of the affected areas.  ;-)
 
> The easiest thing to get was the file name table, which is placed in the
> beginning of the pack (after the header) using the format:

That's not true.  The filename table (EXTOBJ_FILENAME_TABLE) may
appear at any position within the packfile (but like all objects
it must appear somewhere after position 12, as that is where the
header ends).

Now to help out the unpackers (index-pack and unpack-objects)
we have the convention that this table is written out before the
first OBJ_DICT_TREE.  That way the unpacker can load the table and
have it ready to go when it sees the first OBJ_DICT_TREE.  If we
didn't have this rule the unpackers would need to hang into all
OBJ_DICT_TREEs they see until they get the EXTOBJ_FILENAME_TABLE,
then they could actually process those pending OBJ_DICT_TREEs.
This is somewhat expensive on memory, and is just ugly to code.

So what you will find is that the EXTOBJ_FILENAME_TABLE is dumped
out behind all of the commits, but before the first OBJ_DICT_TREE,
and since all trees tend to get converted to an OBJ_DICT_TREE,
the EXTOBJ_FILENAME_TABLE is sandwiched exactly between the commits
and the trees.

Since the unpackers will probably never be smart enough to handle an
OBJ_DICT_TREE before an EXTOBJ_FILENAME_TABLE, its likely that we'll
just have the file format requirement that the EXTOBJ_FILENAME_TABLE
must appear before the first OBJ_DICT_TREE, but can otherwise appear
at any position in the file.

The reason we put the EXTOBJ_FILENAME_TABLE behind the commits is
we often walk the commit chains (following parent pointers) without
looking at the trees at all.  Consider `git log`, in the default
settings we don't need the trees.  By keeping the filename table
behind the commits the OS read-ahead buffering gets a better chance
at loading all of the data we need, and none of the data we don't.

So that's why its where it is.

> +------------+-------------------------------+
> | NR_ENTRIES |  Compressed file name table   |
> +------------+-------------------------------+
>    4 bytes

No.  A string table object (both the EXTOBJ_FILENAME_TABLE and the
EXTOBJ_IDENT_TABLE) has its uncompressed size stored in the standard
"size" field within the object header.  (This lets us malloc the
proper buffer quickly.)  Immediately behind that object header is
the deflated table.

The deflated table looks like:

+------------+-------+-------+-------+--------+----+
| NR_ENTRIES | MODE1 | str1  | MODE2 | str2   | ...
+------------+-------+-------+-------+--------+----+
   4 bytes    2 bytes   n1    2 bytes   n2

The field NR_ENTRIES is in big-endian (network) byte order.
Each MODE field is also in big-endian byte order.  Each string is
null terminated.  The lengths n1 and n2 in the diagram above would
include the null terminating byte.  There is no end-of-table marker;
the way to know the you reach the end of a table is by counting
NR_ENTRIES records out.

I did consider making NR_ENTRIES a vint (variable length int), but
decided against it for the sake of simplicity.  ;-)

For starters its much easier to just treat the darn thing as a
32 bit value and use ntohl.  Its also easier in the pack-objects
code, as I can reserve that space at the front of the table, as the
size is fixed.  Also, since its is actually inside of the deflated
zlib stream, and null bytes are very common (string terminaters)
any unnecessary leading nulls will probably compress quite well,
as the null byte will probably get a relatively short encoding in
the compressed stream.

The MODE fields are the standard POSIX mode bits in an
EXTOBJ_FILENAME_TABLE.

In an EXTOBJ_IDENT_TABLE the MODE fields actually store the
preferred timezone offset (hours in the first/high byte, minutes
in the second/low byte) of the user whose name/email is stored in
the string field.

> The table is sorted by path then mode for easy binary lookup, and so
> that pointers into this table can be compared directly instead of
> comparing the corresponding paths and modes.

Uh, not quite.

In the case of EXTOBJ_FILENAME_TABLE we sort by name+type using
the messy base_name_compare.  In this sorting string entries whose
mode match S_ISDIR (are directory modes) sort as though their name
ends with "/" (even though they actually don't).  If there is a tie,
we break the tie by sorting by the mode alone.

In the case of EXTOBJ_IDENT_TABLE we plan to sort by frequency of
occurance only.  This sorting puts the most frequent users at the
start of the table, allowing us to reference the top 128 authors
and committers in just 1 byte, and the next 16,257 top authors and
committers in just 2 bytes (as we use vints to index into here,
more later).

> There is a new tree type called OBJ_DICT_TREE, which looks something
> like the following:
> 
> +-----------------+------------------------------------------------+----
> |  Table offset   |  SHA-1 of the blob corresponding to the path.  | ...
> +-----------------+------------------------------------------------+----
>       6 bytes                     20 bytes

No.  As Nico stated the records of an OBJ_DICT_TREE are actually only
6 bytes each.

Actually an OBJ_DICT_TREE is *not* comprssed in the packfile.
I want to stress this point, as its unlike most other object types
where the data after the header is just a zlib stream.

Its data looks like:

+------------+-------+-------+-------+-------+----
| NR_ENTRIES | name1 | hash1 | name2 | hash2 | ...
+------------+-------+-------+-------+-------+----
 vint        2 bytes 4 bytes 2 bytes 4 bytes

The NR_ENTRIES field is our "standard" variable integer encoding
(the encoding used by OBJ_OFS_DELTA).  It tells us how many tree
entries to expect.

name1 is an index into the packfile's sole EXTOBJ_FILENAME_TABLE.
hash1 is an index into the packfile's sole SHA1 table.  This object
type hasn't been declared yet, but will be.  Both fields are in
big-endian / network byte order.
 
> These new tree objects will remain uncompressed in the pack file, but
> sorted with,

Yes, correct.

> and deltaed against other tree objects.

*only* against other OBJ_DICT_TREEs.  If a tree could not be
converted to an OBJ_DICT_TREE then it stays as an OBJ_TREE and only
deltas against other OBJ_TREEs.

> All normal tree
> objects are converted to OBJ_DICT_TREE when packing,

Almost.  We try to convert all trees to OBJ_DICT_TREE when packing,
but we cannot do so if the EXTOBJ_FILENAME_TABLE does not contain
one or more path/mode pairs required by that tree.  This can happen
if the EXTOBJ_FILENAME_TABLE would need to contain more than 2**16
entries, as the index into that table (name1 above) is strictly a
16 bit unsigned value.

Thus we have a rule in pack-objects where we first sort the
EXTOBJ_FILENAME_TABLE by frequency, clipping it to the top 2**16
entries, then we resort it according to the name+mode sort.

> and are converted
> back on the fly to callers who need an ordinary OBJ_TREE.

Yes.  But we don't want to actually do that.  One of our
goals is to adjust tree-walk.c (and if needed its callers)
to directly handle an OBJ_DICT_TREE.  This way we can avoid
a lot of costly decompression.

Further I think we can play a game with the delta encoder and
delta apply routines where we can even avoid applying OBJ_DICT_TREE
deltas when we are walking the tree; instead we can walk the deltas
directly.

This is the primary motiviation for keeping the OBJ_DICT_TREE format
a fixed width record, even if it might waste a tiny amount of space
for some projects.
 
> The index (.idx) files are extended to have a 4 byte pointer to the
> offset of this file name table in the pack file for easy lookup.

Yes.  But these may become 64 bit offsets, to allow for very large
packfiles.
 
> There is something similar with a table of common strings in commit
> objects (e.g. author and timezone), and a new object OBJ_DICT_COMMIT,
> but I have not understood that quite yet.

Its actually EXTOBJ_DICT_COMMIT.

The idea here is that author and committer strings appear very
commonly thoughout a project.  Look at Junio for example in
git.git, there are more than 3,000 commits with his name on them.
These compress rather poorly, and don't delta against each other
very well at all.  By pulling these common strings out to an
EXTOBJ_IDENT_TABLE we can save some space.

The other idea is to store the tree and the parent commits in pure
binary (so SHA-1s are 20 bytes, not 40 bytes hex) and to avoid text
headers, so that we can parse the important fields of a commit that
are needed for revision walking immediately from the raw pack data.
Since SHA-1s are uncompressable we aren't actually losing any disk
space here either.  Actually in my early experiements (predates the
packv4 code you looked at) this was saving about 63 bytes per commit.

> Is there something, I have gotten wrong with regards to my
> understanding?

You're close.  Not bad for no documentation!  ;-)

-- 
Shawn.
