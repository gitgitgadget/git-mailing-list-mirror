Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E6E20357
	for <e@80x24.org>; Mon, 17 Jul 2017 15:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbdGQPCK (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 11:02:10 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35039 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdGQPCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 11:02:07 -0400
Received: by mail-yw0-f169.google.com with SMTP id v193so48523830ywg.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=KOB7IHP0Y7D5W69Hj0sdjvyoRlKDl/Zc8blf+QjhX10=;
        b=cdV14EEk+A00Csu7KYfhOtWaAakwVHlAnt8TgV2u4NLTmHj0K+fgjAVSqTdPsSYbuA
         1TkrUNV3d28kF8R2OHj7aijgOBZD2IyedI9XBZ0A7OQvhhAWpxVQPlL7+i8qgsFI0Twb
         YhIU912xKEXWQwkDNu/CiDRCdgCpcFFHDnbYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KOB7IHP0Y7D5W69Hj0sdjvyoRlKDl/Zc8blf+QjhX10=;
        b=TexiSrZwl3LGq9rh9UGuY4+mBdG/qhs2b2XWnS8iaPybTfrq5TywD1j3SfodnRTW1L
         WuFK257iGZ5wQaenUYjeK+jrwModwxo4ISegKpTds/JHtCynu+h3nn3sIBjoX1Zi18ui
         o0xw/5LIu8SHqFeQynTE8MEEMZndJPWolMpZtjgl9ZDSGoN/JPUVx8xNXwmsc9qaObXN
         CrsLI1F3zAB63geTQE+G2Yzik04yBZHPsDSuo/jpU8++AkGY4VkxWsxacLRLz6OEtLvA
         a+ledgGASm8/vL/W48SAvQuTnTrGfv/N/uwcBY+phNtmi3ohAmCvXzZyMpMkhjt+o3i1
         C4zQ==
X-Gm-Message-State: AIVw1124OV4AznHptd6Pk3Yo18PHXFbpniI+j8rusAZdvYCY/uuCUpL/
        AppJfISUGmq5vRVzQyLGwoE5+KdxyJvYq+Tekg==
X-Received: by 10.31.53.3 with SMTP id c3mr12412464vka.78.1500303725236; Mon,
 17 Jul 2017 08:02:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Mon, 17 Jul 2017 08:01:44 -0700 (PDT)
From:   Shawn Pearce <spearce@spearce.org>
Date:   Mon, 17 Jul 2017 08:01:44 -0700
Message-ID: <CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com>
Subject: reftable [v2]: new ref storage format
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an updated draft after discussion on list with Peff, Michael
Haggerty, and Dave Borowitz.

You can read a rendered version of this here:
https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md

Biggest changes from the first proposal are:

- reflog is now integrated into reftable
- block headers slightly different
- Peff's stack management idea is used
- Michael's compaction idea is used


## Overview

### Problem statement

Some repositories contain a lot of references (e.g.  android at 866k,
rails at 31k).  The existing packed-refs format takes up a lot of
space (e.g.  62M), and does not scale with additional references.
Lookup of a single reference requires linearly scanning the file.

Atomic pushes modifying multiple references require copying the
entire packed-refs file, which can be a considerable amount of data
moved (e.g. 62M in, 62M out) for even small transactions (2 refs
modified).

Repositories with many loose references occupy a large number of disk
blocks from the local file system, as each reference is its own file
storing 41 bytes (and another file for the corresponding reflog).
This negatively affects the number of inodes available when a large
number of repositories are stored on the same filesystem.  Readers can
be penalized due to the larger number of syscalls required to traverse
and read the `$GIT_DIR/refs` directory.

### Objectives

- Near constant time lookup for any single reference, even when the
  repository is cold and not in process or kernel cache.
- Efficient lookup of an entire namespace, such as `refs/tags/`.
- Occupy less disk space for large repositories.
- Support atomic push `O(size_of_update)` operations.
- Combine reflog storage with ref storage.

### Description

A reftable file is a portable binary file format customized for
reference storage. References are sorted, enabling linear scans,
binary search lookup, and range scans.

Storage in the file is organized into blocks.  Prefix compression
is used within a single block to reduce disk space.  Block size is
tunable by the writer.

### Performance

Space used, packed-refs vs. reftable:

repository | packed-refs | reftable | % original | avg ref
-----------|------------:|---------:|-----------:|---------:
android    |      62.2 M |   27.7 M |     44.4%  | 33 bytes
rails      |       1.8 M |  896.2 K |     47.6%  | 29 bytes
git        |      78.7 K |   27.9 K |     40.0%  | 43 bytes
git (heads)|       332 b |    222 b |     66.9%  | 37 bytes

Scan (read 866k refs) and lookup (single ref from 866k refs):

format      | scan    | lookup
------------|--------:|---------------:
packed-refs |  380 ms | 375420.0 usec
reftable    |  125 ms |     42.3 usec

Space used for 149,932 log entries on 43,061 refs,
reflog vs. reftable:

format        | size  | avg log
--------------|------:|-----------:
$GIT_DIR/logs | 173 M | 1209 bytes
reftable      |   4 M |   30 bytes

## Details

### Peeling

References in a reftable are always peeled.

### Reference name encoding

Reference names should be encoded with UTF-8.

### Ordering

Blocks are lexicographically ordered by their first reference.

### Directory/file conflicts

The reftable format accepts both `refs/heads/foo` and
`refs/heads/foo/bar` as distinct references.

This property is useful for retaining log records in reftable, but may
confuse versions of Git using `$GIT_DIR/refs` directory tree to
maintain references.  Users of reftable may choose to continue to
reject `foo` and `foo/bar` type conflicts to prevent problems for
peers.

## File format

### Structure

A reftable file has the following basic structure:

    first_block {
      header
      first_ref_block
    }
    ref_blocks*
    ref_index?
    log_blocks*
    log_index?
    footer

### Block size

The `block_size` is arbitrarily determined by the writer, and does not
have to be a power of 2.  The block size must be larger than the
longest reference name or log entry used in the repository, as
references cannot span blocks.

Powers of two that are friendly to the virtual memory system or
filesystem (such as 4k or 8k) are recommended.  Larger sizes
(64k) can yield better compression.

The largest block size is `16777215` bytes (15.99 MiB).

### Header

A 8-byte header appears at the beginning of the file:

    '\1REF'
    uint8( version_number = 1 )
    uint24( block_size )

The `block_size` and all other uint fields are in network byte order.

### First ref block

The first ref block shares the same block as the file header, and is 8
bytes smaller than all other blocks in the file.  The first block
immediately begins after the file header, at offset 8.

### Ref block format

A ref block is written as:

    'r'
    uint24 ( block_len )
    ref_record*
    uint32( restart_offset )*
    uint16( number_of_restarts )
    padding?

Blocks begin with `block_type = 'r'` and a 3-byte `block_len` which
encodes the number of bytes in the block up to, but not including the
optional `padding`.  This is almost always shorter than the file's
`block_size`.  In the first ref block, `block_len` includes 8 bytes
for the file header.

The 4-byte block header is followed by a variable number of
`ref_record`, describing reference names and values.  The format
is described below.

A variable number of 4-byte `restart_offset` values follows the
records.  Offsets are relative to the start of the block (0 in first
block to include file header) and refer to the first byte of any
`ref_record` whose name has not been prefixed compressed.  Readers can
start linear scans from any of these records.

The 2-byte `number_of_restarts + 1` stores the number of entries in
the `restart_offset` list.

Readers can use the restart count to binary search between restarts
before starting a linear scan.  The `number_of_restarts` field must be
the last 2 bytes of the block as specified by `block_len` from the
block header.

The end of the record may be filled with `padding` NUL bytes to fill
out the block to the common `block_size` as specified in the file
header.  Padding may be necessary to ensure the following block starts
at a block alignment, and does not spill into the tail of this block.
Padding may be omitted if the block is the last block of the file, or
there is no index block.  This allows reftable to efficiently scale
down to a small number of refs.

#### ref record

A `ref_record` describes a single reference, storing both the name and
its value(s). Records are formatted as:

    varint( prefix_length )
    varint( (suffix_length << 2) | value_type )
    suffix
    value?

The `prefix_length` field specifies how many leading bytes of the
prior reference record's name should be copied to obtain this
reference's name.  This must be 0 for the first reference in any
block, and also must be 0 for any `ref_record` whose offset is listed
in the `restart_offset` table at the end of the block.

Recovering a reference name from any `ref_record` is a simple concat:

    this_name = prior_name[0..prefix_length] + suffix

The second varint carries both `suffix_length` and `value_type`.  The
`suffix_length` value provides the number of bytes to copy from
`suffix` to complete the reference name.

The `value` immediately follows.  Its format is determined by
`value_type`, a 2 bit code, one of the following:

- `0x0`: deletion; no value data (see transactions, below)
- `0x1`: one 20-byte object id; value of the ref
- `0x2`: two 20-byte object ids; value of the ref, peeled target
- `0x3`: symbolic reference: `varint( target_len ) target`

Symbolic references use a varint length followed by a variable number
of bytes to encode the complete reference target.  No compression is
applied to the target name.

### Ref index

The ref index stores the name of the last reference from every ref
block in the file, enabling constant O(1) disk seeks for all lookups.
Any reference can be found by binary searching the index, identifying
the containing block, and searching within that block.

If present, the ref index block appears after the last ref block.  The
prior ref block should be padded to ensure the ref index starts on a
block alignment.

An index block should only be written if there are at least 4 blocks
in the file, as cold reads using the index requires 2 disk reads, and
binary searching <= 4 blocks also requires <= 2 reads.  Omitting the
index block from smaller files saves space.

Index block format:

    uint32( (0x80 << 24) | block_len )
    index_record*
    uint32( restart_offset )*
    uint16( number_of_restarts )

The index block header starts with the high bit set.  This identifies
the block as an index block, and not as a ref block, log block or file
footer.  The `block_len` field in an index block is 30-bits network
byte order, and allowed to occupy the space normally used by the block
type in other blocks.  This supports indexes significantly larger than
the file's `block_size`.

The `restart_offset` and `number_of_restarts` fields are identical in
format, meaning and usage as in ref blocks.

To reduce the number of reads required for random access in very large
files, the index block may be larger than the other blocks.  However,
readers must hold the entire index in memory to benefit from this, so
its a time-space tradeoff in both file size, and reader memory.
Increasing the block size in the writer decreases the index size.

Unlike ref blocks, the index block is not padded.

#### index record

An index record describes the last entry in another block.
Index records are written as:

    varint( prefix_length )
    varint( (suffix_length << 2) )
    suffix
    varint( block_offset )

Index records use prefix compression exactly like `ref_record`.  The
`suffix_length` is shifted 2 bits without a `type` to simplify unified
reader/writer code for both block types.

Index records store `block_offset` after the suffix, specifying the
offset in bytes (from the start of the file) of the block that ends
with this reference.

#### Reading the index

Readers loading the ref index must first read the footer (below) to
obtain `ref_index_offset`. If not present, the offset will be 0.

### Log block format

A log block is written as:

    'g'
    uint24( block_len )
    zlib_deflate {
      log_record*
      int32( restart_offset )*
      int16( number_of_restarts )
    }

Log blocks look similar to ref blocks, except `block_type = 'g'`.

The 4-block header is followed by the deflated block contents using
zlib deflate.  The `block_len` in the header is the inflated size
(including 4-byte block header), and should be used by readers to
preallocate the inflation output buffer.  Offsets within the block
(e.g.  `restart_offset`) still include the 4-byte header.  Readers may
prefer prefixing the inflation output buffer with the 4-byte header.

Within the deflate container, a variable number of `log_record`,
describing reference changes.  The log record format is described
below.  See ref block format (above) for a description of
`restart_offset` and `number_of_restarts`.

Unlike ref blocks, log blocks are written at any alignment, without
padding.  The first log block immediately follows the end of the last
ref block, or the ref index.  In very small files the log block may
appear in the first block.

Readers must keep track of the bytes consumed by the inflater to know
where the next log block begins.

#### log record

Log record keys are structured as:

    ref_name '\0' reverse_int32( time_sec )

where `time_sec` is the update time in seconds since the epoch.  The
`reverse_int32` function inverses the value so lexographical ordering
the network byte order time sorts more recent records first:

    reverse_int(int32 t) {
      return 0xffffffff - t;
    }

Log records have a similar starting structure to ref and index
records, utilizing the same prefix compression scheme applied to the
key described above.  Like in an index record, a log record uses
`value_type = 0x0`:

    varint( prefix_length )
    varint( (suffix_length << 2) | 0x0 )
    suffix

    old_id
    new_id
    sint16( tz_offset )
    varint( name_length  )   name
    varint( email_length )   email
    varint( message_length ) message

The value data following the key suffix is complex:

- two 20-byte SHA-1s (old id, new id)
- 2-byte timezone offset (signed)
- varint string of committer's name
- varint string of committer's email
- varint string of message

`tz_offset` is the absolute number of minutes from GMT the committer
was at the time of the update.  For example `GMT-0800` is encoded in
reftable as `int16(-480)` and `GMT+0230` is `int16(150)`.

The `message_length` may be 0, in which case there was no message
supplied for the update.

#### Reading the log

Readers accessing the log must first read the footer (below) to
determine the `log_offset`.  The first block of the log begins at
`log_offset` bytes since the start of the file.

In very small reftable files `log_offset`, may not be block aligned.

### Log index

The log index stores the log key (`refname \0 reverse_int32(time_sec)`)
for the last log record of every log block in the file, supporting
bounded-time lookup.

A log index block must be written if 2 or more log blocks are written
to the file.  If present, the log index appears after the first log
block.  There is no padding used to align the log index to block
alignment.

Log index format is identical to ref index, except the keys are 5
bytes longer to include `'\0'` and the 4-byte `reverse_int32(time)`.
Records use `block_offset` to refer to the start of a log block.

#### Reading the index

Readers loading the log index must first read the footer (below) to
obtain `log_index_offset`. If not present, the offset will be 0.

### Footer

After the last block of the file, a file footer is written.  It begins
like the file header, but is extended with additional data.

A 36-byte footer appears at the end:

    '\1REF'
    uint8( version_number = 1 )
    uint24( block_size )

    uint64( ref_index_offset )
    uint64( log_offset )
    uint64( log_index_offset )
    uint32( CRC-32 of prior )

If a section is missing (e.g. ref index) the corresponding offset
field (e.g. `ref_index_offset`) will be 0.

#### Reading the footer

Readers must seek to `file_length - 36` to access the footer.  A
trusted external source (such as `stat(2)`) is necessary to obtain
`file_length`.  When reading the footer, readers must verify:

- 4-byte magic is correct
- 1-byte version number is recognized
- 4-byte CRC-32 matches the other 32 bytes (including magic, and version)

Once verified, the other fields of the footer can be accessed.

### Varint encoding

Varint encoding is identical to the ofs-delta encoding method used
within pack files.

Decoder works such as:

    val = buf[ptr] & 0x7f
    while (buf[ptr] & 0x80) {
      ptr++
      val++
      val = val << 7
      val = val | (buf[ptr] & 0x7f)
    }

### Binary search

Binary search within a block is supported by the `restart_offset`
fields at the end of the block.  Readers can binary search through the
restart table to locate between which two restart points the sought
reference or key should appear.

Each record identified by a `restart_offset` stores the complete key
in the `suffix` field of the record, making the compare operation
during binary search straightforward.

Once a restart point lexicographically before the sought reference has
been identified, readers can linearly scan through the following
record entries to locate the sought record, terminating if the current
record sorts after (and therefore the sought key is not present).

#### Restart point selection

Writers determine the restart points at file creation.  The process is
arbitrary, but every 16 or 64 records is recommended.  Every 16 may
be more suitable for smaller block sizes (4k or 8k), every 64 for
larger block sizes (64k).

More frequent restart points reduces prefix compression and increases
space consumed by the restart table, both of which increase file size.

Less frequent restart points makes prefix compression more effective,
decreasing overall file size, with increased penalities for readers
walking through more records after the binary search step.

A maxium of `65536` restart points is supported in any type of block.
The `restart_count` field stores restart points `-1`, with a maxium
value of `65535`.

## Considerations

### Lightweight refs dominate

The reftable format assumes the vast majority of references are single
SHA-1 valued with common prefixes, such as Gerrit Code Review's
`refs/changes/` namespace, GitHub's `refs/pulls/` namespace, or many
lightweight tags in the `refs/tags/` namespace.

Annotated tags storing the peeled object cost only an additional 20
bytes per reference.

### Low overhead

A reftable with very few references (e.g.  git.git with 5 heads) uses
only 222 bytes for reftable vs. 332 bytes for packed-refs.  This
supports reftable scaling down, to be used for transaction logs
(below).

### Block size

For a Gerrit Code Review type repository with many change refs, larger
block sizes (64 KiB) and less frequent restart points (every 64) yield
better compression due to more references within the block able to
compress against the prior reference.

Larger block sizes reduces the index size, as the reftable will
require fewer blocks to store the same number of references.

### Minimal disk seeks

Assuming the index block has been loaded into memory, binary searching
for any single reference requires exactly 1 disk seek to load the
containing block.

### Logs are infrequently read

Logs are infrequently accessed, but can be large.  Deflating log
blocks saves disk space, with some increased penalty at read time.

Logs are stored in an isolated section from refs, reducing the burden
on reference readers that want to ignore logs.

### Logs are read backwards

Logs are frequently accessed backwards (most recent N records for master),
so log records are grouped by reference, and sorted descending by time.

## Repository format

When reftable is stored in a file-backed Git repository, the stack is
represented as a series of reftable files in the dedicated
`$GIT_DIR/reftable/` directory:

    stack
    22b9ac56abe0ddc5f23d651fe4ef46343f338d20.ref
    82f128e165c8afae9894aacf0219bc53a580f2ad.ref

where `.ref` files are named by the SHA-1 hash of the contents of the
reftable.

The `stack` file lists the current files, one per line, in order, from
oldest (base) to newest (most recent):

    $ cat stack
    82f128e165c8afae9894aacf0219bc53a580f2ad.ref
    22b9ac56abe0ddc5f23d651fe4ef46343f338d20.ref

Readers must read `stack` to determine which files are relevant right
now, and search through the stack in reverse order (last reftable is
examined first).

Files not listed in `stack` may be new (and about to be added to the
stack by the active writer), or ancient and ready to be pruned.

### Update transactions

Although reftables are immutable, mutations are supported by writing a
new reftable and atomically appending it to the stack:

1. Atomically create `stack.lock`
2. Copy current stack to `stack.lock`.
3. Prepare new reftable in temp file `.refXXXXXXX`.
   Include log entries.
4. Rename (3) to `${sha1}.ref`.
5. Append `${sha1}.ref` to `stack.lock`
6. Atomically rename `stack.lock` to `stack`.

Because a single `stack.lock` file is used to manage locking, the
repository is single-threaded for writers.  Writers may have to
busy-spin (with some small backoff) around creating `stack.lock`,
for up to an acceptable wait period, aborting if the repository is too
busy to mutate.  Application servers wrapped around repositories (e.g.
Gerrit Code Review) can layer their own in memory thread lock/wait
queue to improve fairness.

### Reference deletions

Deletion of any reference can be explicitly stored by setting the
`type` to `0x0` and omitting the `value` field of the `ref_record`.
This entry shadows the reference in earlier files in the stack.

### Compaction

A partial stack of reftables can be compacted by merging references
using a straightforward merge join across reftables, selecting the
most recent value for output, and omitting deleted references that do
not appear in remaining, lower reftables.

For sake of illustration, assume the stack currently consists of
reftable files (from oldest to newest): A, B, C, and D. The compactor
is going to compact B and C, leaving A and D alone.

1.  Obtain lock `stack.lock` and read the `stack` file.
2.  Obtain locks `B.lock` and `C.lock`.
    Ownership of these locks prevents other processes from trying
to compact these files.
3.  Release `stack.lock`.
4.  Compact `B` and `C` in temp file `.refXXXXXXX`.
5.  Reacquire lock `stack.lock`.
6.  Verify that `B` and `C` are still in the stack, in that order. This
    should always be the case, assuming that other processes are adhering
    to the locking protocol.
7.  Rename `.refXXXXXXX` to `X`.
8.  Write the new stack to `stack.lock`, replacing `B` and `C` with `X`.
9.  Atomically rename `stack.lock` to `stack`.
10. Delete `B` and `C`, perhaps after a short sleep to avoid forcing
    readers to backtrack.

This strategy permits compactions to proceed independently of updates.

## Alternatives considered

### bzip packed-refs

`bzip2` can significantly shrink a large packed-refs file (e.g. 62
MiB compresses to 23 MiB, 37%).  However the bzip format does not support
random access to a single reference. Readers must inflate and discard
while performing a linear scan.

Breaking packed-refs into chunks (individually compressing each chunk)
would reduce the amount of data a reader must inflate, but still
leaves the problem of indexing chunks to support readers efficiently
locating the correct chunk.

Given the compression ratios achieved by reftable's simple encoding
(e.g.  44%), without using a standard compression algorithm, it does
not seem necessary to add the complexity of bzip/gzip/zlib.

### JGit Ketch RefTree

[JGit Ketch][ketch] proposed [RefTree][reftree], an encoding of
references inside Git tree objects stored as part of the repository's
object database.

The RefTree format adds additional load on the object database storage
layer (more loose objects, more objects in packs), and relies heavily
on the packer's delta compression to save space.  Namespaces which are
flat (e.g.  thousands of tags in refs/tags) initially create very
large loose objects, and so RefTree does not address the problem of
copying many references to modify a handful.

Flat namespaces are not efficiently searchable in RefTree, as tree
objects in canonical formatting cannot be binary searched. This fails
the need to handle a large number of references in a single namespace,
such as GitHub's `refs/pulls`, or a project with many tags.

[ketch]: https://dev.eclipse.org/mhonarc/lists/jgit-dev/msg03073.html
[reftree]: https://public-inbox.org/git/CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com/

### LMDB

David Turner proposed [using LMDB][dt-lmdb], as LMDB is lightweight
(64k of runtime code) and GPL-compatible license.

A downside of LMDB is its reliance on a single C implementation.  This
makes embedding inside JGit (a popular reimplemenation of Git)
difficult, and hoisting onto virtual storage (for JGit DFS) virtually
impossible.

A common format that can be supported by all major Git implementations
(git-core, JGit, libgit2) is strongly preferred.

[dt-lmdb]: https://public-inbox.org/git/1455772670-21142-26-git-send-email-dturner@twopensource.com/

## Future

### Longer hashes

Version will bump (e.g.  2) to indicate `value` uses a different
object id length other than 20.  The length could be stored in an
expanded file header, or hardcoded as part of the version.
