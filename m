From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Index format v5
Date: Thu, 3 May 2012 19:25:12 +0200
Message-ID: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: trast@student.ethz.ch, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 19:25:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPzmM-00038x-QL
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 19:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab2ECRZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 13:25:15 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38698 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab2ECRZO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 13:25:14 -0400
Received: by lbbgm6 with SMTP id gm6so1431794lbb.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=JOZcVJm5cNsrCNlymL62I1yQtyes0DLnfZ0L0Am6lzo=;
        b=E1KMIv93A0cBl1q1/qUfYa1nIycSYxvGWLAMRLGBnpjVLz/vHd49bAT8YXyQg3N8Xq
         cUsuRbD2Mg4Jrq8mhpmqnavapCVz75n/fZSn31UZhngbVWkmi/2gGK/YegQ0zwWsJoNN
         MWmQwPEQ1fTDe4tB44aH9qjPtNHgsXe1BVDTpWWHD0TtCN2Q14KXQnLcbhR9oooy5C1N
         ovRLp45WikUDIZ0GIJfigVNx68OgZmlYJEruu+TZUpZVW6TNwDXlqbxE9afDQtOrLHsS
         guSLeZkmmT3pZjDJ8p00jevhDY9kJdLI53pTnG3u/LSjq+pZaBSjyFpulVQPPYDrmyHX
         1Sfw==
Received: by 10.152.110.4 with SMTP id hw4mr2812225lab.44.1336065912653; Thu,
 03 May 2012 10:25:12 -0700 (PDT)
Received: by 10.152.37.201 with HTTP; Thu, 3 May 2012 10:25:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196924>

I have been drafting the Version 5 of the index format over the past
few days with the help of Thomas Rast, Michael Haggerty, cmn and
barrbrain on IRC. It will save with prefix compression on the path, and
using a crc32 over the stat data, instead of the full data, since it is only
used for checking if the file is changed. (Thanks Michael Haggerty for
this hint. Unless we are missing something this will save another
~4 MB on the Webkit index.



GIT index format
================

= The git index file has the following format

  All binary numbers are in network byte order. Version 5 is described
  here.

   - A 16-byte header consisting of

     4-byte signature:
       The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")

     4-byte version number:
       The current supported versions are 2, 3, 4 and 5.

     32-bit number of directories.

     32-bit number of file entries.

   - Offset to the extensions.

     32-bit number of extensions.

     32-bit number offset to the extension. (Possibly none, as many as
     indicated in the 4-byte number of extensions)

   - A number of directory offsets (see below). [1]

   - A number of sorted directories (see below). [2]

   - 32-bit crc32 checksum for the header, extension offsets and directories.

   - A number of file offsets (see below). [1]

   - A number of file entries (see below).

   - A number of entries for conflicted data/resolved conflicts (see below).

   - Extensions

     Extensions are identified by signature. Optional extensions can
     be ignored if GIT does not understand them.

     GIT supports an arbitrary number of extension, but currently none
     is implemented. [3]

     4-byte extension signature. If the first byte is 'A'..'Z' the
     extension is optional and can be ignored.

     32-bit size of the extension

     32-bit crc32 checksum of the extension signature and size

     Extension data


== Directory entry offsets

  32-bit offset to the directory.

  This part is needed for making the directory entries bisectable and
    thus allowing a binary search.

== Directory entry

  Directory entries are sorted in lexicographic order by the name
  of their path starting with the root.

  Path names (variable length) relative to top level directory (without the
    leading slash). '/' is used as path separator. '.' indicates the root
    directory. The special patch components ".." and ".git" (without quotes)
    are disallowed. Trailing slash is also disallowed.

  1 nul byte to terminate the path.

  32-bit offset to the first file of a directory

  32-bit offset to conflicted/resolved data at the end of the index.
    0 if there is no such data. [4]

  4-byte number of subtrees this tree has

  4-byte number of entries in the index that is covered by the tree this
    entry represents. (entry_count) (-1 if the entry is invalid)

  160-bit object name for the object that would result from writing
    this span of index as a tree.

  The last 24 bytes are for the cache tree. An entry can be in an
    invalidated state which is represented by having -1 in the entry_count
    field. If an entry is in invalidated state, the next entry will begin
    after the number of subtrees, and the 160-bit object name is dropped.

  The entries are written out in the top-down, depth-first order. The
    first entry represents the root level of the repository, followed by
    the first subtree - let's call it A - of the root level, followed by
    the first subtree of A, ...

== File entry offsets

  32-bit offset to the directory.

  This part is needed for making the directory entries bisectable and
    thus allowing a binary search.

== File entry

  File entries are sorted in ascending order on the name field, after the
  respective offset given by the directory entries.

  File name (variable length). Nul bytes are not allowed in file names and
    they have no leading slash. They are 7-bit ASCII encoded.

  1 nul byte to terminate the filename.

  A 16-bit 'flags' field split into (high to low bits)

    1-bit assume-valid flag

    1-bit conflict flag

    2-bit stage (during merge)

    2-bit mode (0 = 1000644 (regular file without execution
      permission), 1 = 1000755 (regular file with execution
      permission), 2 = 1010000 (symbolic link), 3 = 1110
      (gitlink)) [5]

    1-bit skip-worktree flag (used by sparse checkout)

    1-bit intent-to-add flag (used by "git add -N")

    8-bit unused, must be zero [6]

  32-bit mtime seconds, the last time a file's data changed
    this is stat(2) data

  32-bit mtime nanosecond fractions
    this is stat(2) data

  32-bit crc32 checksum over ctime seconds, ctime nanoseconds,
    ino, file size, dev, uid, gid (All stat(2) data except mtime) [7]

  160-bit SHA-1 for the represented object

  32-bit crc32 checksum for the file entry

== Conflicted data

  A conflict is represented in the index as a set of higher stage entries.
  These entries are stored at the end of the index. When a conflict is
  resolved (e.g. with "git add path"). A bit is flipped, to indicate that
  the conflict is resolved, but the entries will be kept, so that
  conflicts can be recreated (e.g. with "git checkout -m", in case users
  want to redo a conflict resolution from scratch.

  - NUL-terminated filename of the entry

  - A 8-bit 'flags' field split into:

    - 1-bit conflicted state (conflicted/resolved) (1 if conflicted)

    - 7-bit unused

  - Three 4-byte octal numbers, entry mode of entries in stage 1 to 3 (a
    missing stage is represented by "0" in this field);
    and

  - At most three 160-bit object names of the entry in stages from 1 to 3
    (nothing is written for a missing stage).

  - 32-bit crc32 checksum over one conflicted entry.

== Design explanations

[1] The directory and file offsets are included in the index format
    to enable bisectability of the index, for binary searches.Updating
    a single entry and partial reading will benefit from this.

[2] The directories are saved in their own block, to be able to
    quickly search for a directory in the index. They include a
    offset to the (lexically) first file in the directory.

[3] The data of the cache-tree extension and the resolve undo
    extension is now part of the index itself, but if other extensions
    come up in the future, there is no need to change the index, they
    can simply be added at the end.

[4] To avoid rewrites of the whole index when there are conflicts or
    conflicts are being resolved, conflicted data will be stored at
    the end of the index. To mark the conflict resolved, just a bit
    has to be flipped. The data will still be there, if a user wants
    to redo the conflict resolution.

[5] Since only 4 modes are effectively allowed in git but 32-bit are
    used to store them, having a two bit flag for the mode is enough
    and saves 4 byte per entry.

[6] The length of the file name was dropped, since each file name is
    nul terminated anyway.

[7] Since all stat data (except mtime and ctime) is just used for
    checking if a file has changed a checksum of the data is enough.
    In addition to that Thomas Rast suggested ctime could be ditched
    completely (core.trustctime=false) and thus included in the
    checksum. This would save 24 bytes per index entry, which would
    be about 4 MB on the Webkit index.
    (Thanks for the suggestion to Michael Haggerty)
