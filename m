From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 13/24] documentation: add documentation of the index-v5 file format
Date: Sun, 18 Aug 2013 21:42:02 +0200
Message-ID: <1376854933-31241-14-git-send-email-t.gummerer@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 18 21:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB8y7-000434-0g
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 21:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab3HRTst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 15:48:49 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:37546 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647Ab3HRTss (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 15:48:48 -0400
Received: by mail-wg0-f43.google.com with SMTP id z12so2833779wgg.34
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/O//XadlL4wlxxmIr4pgQzrPJSFdpTg/+2E3C/eJLtg=;
        b=laETN693/w+U6fDWa0SZRtAmzf2hHSnpRQrYnKQgu2haaDPhCe4BLHooR4RtEDXaqz
         O7q8HDj0EiuxQq9EXo3M0+SRTcvw0Jc8/tly6hbIOcPm1w2UafqRSaFxJrbpKqn8XIyK
         I7F1MJ1x0jogIZVMKkF0nA7EMMidirpHWDOWDwmkUa4DjqgJsN6DoMNW8d7X8wr3hRYR
         eFJUSntrRRoOGKEHb0DIunu1bt2mUX3nKmOu+sa6WiM1Z3vfMnhIM4116b9G2ye912pd
         bLS2tvQZJrUP66Yo2iFm8NQi5ndoATJn2k2atK0G4a+Y4hiHnNcNnSWrfTqgrldQNsJg
         9bRQ==
X-Received: by 10.194.123.227 with SMTP id md3mr5791745wjb.17.1376855326640;
        Sun, 18 Aug 2013 12:48:46 -0700 (PDT)
Received: from localhost (host105-104-dynamic.0-79-r.retail.telecomitalia.it. [79.0.104.105])
        by mx.google.com with ESMTPSA id a4sm12383477wik.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 12:48:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.4.1231.g9fbf354.dirty
In-Reply-To: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232502>

Add a documentation of the index file format version 5 to
Documentation/technical.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Thomas Rast <trast@student.ethz.ch>
Helped-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Helped-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/technical/index-file-format-v5.txt | 301 +++++++++++++++++++++++
 1 file changed, 301 insertions(+)
 create mode 100644 Documentation/technical/index-file-format-v5.txt

diff --git a/Documentation/technical/index-file-format-v5.txt b/Documentation/technical/index-file-format-v5.txt
new file mode 100644
index 0000000..5209c02
--- /dev/null
+++ b/Documentation/technical/index-file-format-v5.txt
@@ -0,0 +1,301 @@
+GIT index format
+================
+
+== The git index
+
+   The git index file (.git/index) documents the status of the files
+     in the git staging area.
+
+   The staging area is used for preparing commits, merging, etc.
+
+== The git index file format
+
+   All binary numbers are in network byte order. Version 5 is described
+     here. The index file consists of various sections. They appear in
+     the following order in the file.
+
+   - header: the description of the index format, including it's signature,
+     version and various other fields that are used internally.
+
+   - diroffsets (ndir entries of "direcotry offset"): A 4-byte offset
+       relative to the beginning of the "direntries block" (see below)
+       for each of the ndir directories in the index, sorted by pathname
+       (of the directory it's pointing to). [1]
+
+   - direntries (ndir entries of "directory offset"): A directory entry
+       for each of the ndir directories in the index, sorted by pathname
+       (see below). [2]
+
+   - fileoffsets (nfile entries of "file offset"): A 4-byte offset
+       relative to the beginning of the fileentries block (see below)
+       for each of the nfile files in the index. [1]
+
+   - fileentries (nfile entries of "file entry"): A file entry for
+       each of the nfile files in the index (see below).
+
+   - crdata: A number of entries for conflicted data/resolved conflicts
+       (see below).
+
+   - Extensions (Currently none, see below in the future)
+
+     Extensions are identified by signature. Optional extensions can
+     be ignored if GIT does not understand them.
+
+     GIT supports an arbitrary number of extension, but currently none
+     is implemented. [3]
+
+     extsig (32-bits): extension signature. If the first byte is 'A'..'Z'
+     the extension is optional and can be ignored.
+
+     extsize (32-bits): size of the extension, excluding the header
+       (extsig, extsize, extchecksum).
+
+     extchecksum (32-bits): crc32 checksum of the extension signature
+       and size.
+
+    - Extension data.
+
+== Header
+   sig (32-bits): Signature:
+     The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
+
+   vnr (32-bits): Version number:
+     The current supported versions are 2, 3, 4 and 5.
+
+   nfile (32-bits): number of file entries in the index.
+
+   ndir (32-bits): number of directories in the index.
+
+   fblockoffset (32-bits): offset to the file block, relative to the
+     beginning of the file.
+
+   - Offset to the extensions.
+
+     nextensions (32-bits): number of extensions.
+
+     extoffset (32-bits): offset to the extension. (Possibly none, as
+       many as indicated in the 4-byte number of extensions)
+
+   headercrc (32-bits): crc checksum including the header and the
+     offsets to the extensions.
+
+
+== Directory offsets (diroffsets)
+
+  diroffset (32-bits): offset to the directory relative to the
+    beginning of the index file. There are ndir + 1 offsets in the
+    diroffset table, the last is pointing to the end of the last
+    direntry. With this last entry, we are able to replace the strlen
+    of the directory name when reading the directory name, by
+    calculating it from diroffset[n+1]-diroffset[n]-61.  61 is the
+    size of the directory data, which follows each each directory +
+    the crc sum + the NUL byte.
+
+  This part is needed for making the directory entries bisectable and
+    thus allowing a binary search.
+
+== Directory entry (direntries)
+
+  Directory entries are sorted in lexicographic order by the name
+    of their path starting with the root.
+
+  pathname (variable length, nul terminated): relative to top level
+    directory (without the leading slash). '/' is used as path
+    separator. A string of length 0 ('') indicates the root directory.
+    The special path components ".", and ".." (without quotes) are
+    disallowed. The path also includes a trailing slash. [9]
+
+  foffset (32-bits): offset to the lexicographically first file in
+    the file offsets (fileoffsets), relative to the beginning of
+    the fileoffset block.
+
+  cr (32-bits): offset to conflicted/resolved data at the end of the
+    index. 0 if there is no such data. [4]
+
+  ncr (32-bits): number of conflicted/resolved data entries at the
+    end of the index if the offset is non 0. If cr is 0, ncr is
+    also 0.
+
+  nsubtrees (32-bits): number of subtrees this tree has in the index.
+
+  nfiles (32-bits): number of files in the directory, that are in
+    the index.
+
+  nentries (32-bits): number of entries in the index that is covered
+    by the tree this entry represents. (-1 if the entry is invalid).
+    This number includes all the files in this tree, recursively.
+
+  objname (160-bits): object name for the object that would result
+    from writing this span of index as a tree. This is only valid
+    if nentries is valid, meaning the cache-tree is valid.
+
+  flags (16-bits): 'flags' field split into (high to low bits) (For
+    D/F conflicts)
+
+    stage (2-bits): stage of the directory during merge
+
+    14-bit unused
+
+  dircrc (32-bits): crc32 checksum for each directory entry.
+
+  The last 24 bytes (4-byte number of entries + 160-bit object name) are
+    for the cache tree. An entry can be in an invalidated state which is
+    represented by having -1 in the entry_count field.
+
+  The entries are written out in the top-down, depth-first order. The
+    first entry represents the root level of the repository, followed by
+    the first subtree - let's call it A - of the root level, followed by
+    the first subtree of A, ... There is no prefix compression for
+    directories.
+
+== File offsets (fileoffsets)
+
+  fileoffset (32-bits): offset to the file relative to the beginning of
+    the fileentries block.
+
+  This part is needed for making the file entries bisectable and
+    thus allowing a binary search. There are nfile + 1 offsets in the
+    fileoffset table, the last is pointing to the end of the last
+    fileentry. With this last entry, we can replace the strlen when
+    reading each filename, by calculating its length with the offsets.
+
+== File entry (fileentries)
+
+  File entries are sorted in ascending order on the name field, after the
+  respective offset given by the directory entries. All file names are
+  prefix compressed, meaning the file name is relative to the directory.
+
+  filename (variable length, nul terminated). The exact encoding is
+    undefined, but the filename cannot contain a NUL byte (iow, the same
+    encoding as a UNIX pathname).
+
+  flags (16-bits): 'flags' field split into (high to low bits)
+
+    assumevalid (1-bit): assume-valid flag
+
+    intenttoadd (1-bit): intent-to-add flag, used by "git add -N".
+      Extended flag in index v3.
+
+    stage (2-bit): stage of the file during merge
+
+    skipworktree (1-bit): skip-worktree flag, used by sparse checkout.
+      Extended flag in index v3.
+
+    smudged (1-bit): indicates if the file is racily smudged.
+
+    invalid (1-bit): This bit can be set to indicate that a file was
+      deleted, but not yet removed from the index, because the index
+      was only partially rewritten.  Entries with this flags should be
+      ignored when reading the index file.
+
+    9-bit unused, must be zero [6]
+
+  mode (16-bits): file mode, split into (high to low bits)
+
+    objtype (4-bits): object type
+      valid values in binary are 1000 (regular file), 1010 (symbolic
+      link) and 1110 (gitlink)
+
+    3-bit unused
+
+    permission (9-bits): unix permission. Only 0755 and 0644 are valid
+      for regular files. Symbolic links and gitlinks have value 0 in
+      this field.
+
+  mtimes (32-bits): mtime seconds, the last time a file's data changed
+    this is stat(2) data
+
+  mtimens (32-bits): mtime nanosecond fractions
+    this is stat(2) data
+
+  file size (32-bits): The on-disk size, trucated to 32-bit.
+    this is stat(2) data
+
+  statcrc (32-bits): crc32 checksum over ctime seconds, ctime
+    nanoseconds, ino, dev, uid, gid (All stat(2) data
+    except mtime and file size). If the statcrc is 0 it will
+    be ignored. [7]
+
+  objhash (160-bits): SHA-1 for the represented object
+
+  entrycrc (32-bits): crc32 checksum for the file entry. The crc code
+    includes the offset to the offset to the file, relative to the
+    beginning of the file.
+
+== Conflict data
+
+  A conflict is represented in the index as a set of higher stage entries.
+  These entries are stored at the end of the index. When a conflict is
+  resolved (e.g. with "git add path"). A bit is flipped, to indicate that
+  the conflict is resolved, but the entries will be kept, so that
+  conflicts can be recreated (e.g. with "git checkout -m", in case users
+  want to redo a conflict resolution from scratch.
+
+  The conflicts will also be stored in the fileentries part of the index,
+  to simplify reading and writing of the index.
+
+  filename (variable length, nul terminated): filename of the entry,
+    relative to its containing directory).
+
+  nfileconflicts (32-bits): number of conflicts for the file [8]
+
+  flags (nfileconflicts entries of "flags") (16-bits): 'flags' field
+    split into:
+
+    conflicted (1-bit): conflicted state (conflicted/resolved) (1 if
+      conflicted)
+
+    stage (2-bits): stage during merge.
+
+    13-bit unused
+
+  entry_mode (nfileconflicts entries of "entry mode") (16-bits):
+    octal numbers, entry mode of eache entry in the different stages.
+    (How many is defined by the 4-byte number before)
+
+  objectnames (nfileconflicts entries of "object name") (160-bits):
+    object names  of the different stages.
+
+  conflictcrc (32-bits): crc32 checksum over conflict data.
+
+== Design explanations
+
+[1] The directory and file offsets are included in the index format
+    to enable bisectability of the index, for binary searches.Updating
+    a single entry and partial reading will benefit from this.
+
+[2] The directories are saved in their own block, to be able to
+    quickly search for a directory in the index. They include a
+    offset to the (lexically) first file in the directory.
+
+[3] The data of the cache-tree extension and the resolve undo
+    extension is now part of the index itself, but if other extensions
+    come up in the future, there is no need to change the index, they
+    can simply be added at the end.
+
+[4] To avoid rewrites of the whole index when there are conflicts or
+    conflicts are being resolved, conflicted data will be stored at
+    the end of the index. To mark the conflict resolved, just a bit
+    has to be flipped. The data will still be there, if a user wants
+    to redo the conflict resolution.
+
+[5] Since only 4 modes are effectively allowed in git but 32-bit are
+    used to store them, having a two bit flag for the mode is enough
+    and saves 4 byte per entry.
+
+[6] The length of the file name was dropped, since each file name is
+    nul terminated anyway.
+
+[7] Since all stat data (except mtime and ctime) is just used for
+    checking if a file has changed a checksum of the data is enough.
+    In addition to that Thomas Rast suggested ctime could be ditched
+    completely (core.trustctime=false) and thus included in the
+    checksum. This would save 24 bytes per index entry, which would
+    be about 4 MB on the Webkit index.
+    (Thanks for the suggestion to Michael Haggerty)
+
+[8] Since there can be more stage #1 entries, it is necessary to know
+    the number of conflict data entries there are.
+
+[9] As Michael Haggerty pointed out on the mailing list, storing the
+    trailing slash will simplify a few operations.
-- 
1.8.3.4.1231.g9fbf354.dirty
