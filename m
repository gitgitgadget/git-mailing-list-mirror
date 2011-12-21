From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: [PATCH 6/6] Provide documentation for git message digest extensions
Date: Tue, 20 Dec 2011 23:13:28 -0800
Message-ID: <1324451608.1684.24.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGMk-0000dk-Fc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1LUHN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:13:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60432 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1LUHNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:13:25 -0500
Received: by iaeh11 with SMTP id h11so11463747iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=jrIP5tqKgc5+YmwArfExK/cUvV09ntkaFJ9nUK2UyhU=;
        b=ZUql6+WAG9bDnyJKFUExU60Ir3khos0RYKcm09ViRghgLJ2HxqndIX2x5HrMyFW8ye
         AEDpoFqqlwcuvkmsaCeZiQREhm9iyBLMQV0ORkcwXfSW8AL/lSTsAsW0I4NJ8QrhESin
         PaF5bThRN/wqBhGf/4DkgHjHOBPUnxDmg+z/0=
Received: by 10.50.36.230 with SMTP id t6mr1595142igj.5.1324451604320;
        Tue, 20 Dec 2011 23:13:24 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id x18sm13805976ibi.2.2011.12.20.23.13.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:13:23 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187556>

The documentation includes API documentation for commands
and technical documentation for the message-digest-related
changes.  The technical documentation is in

* Documentation/technical/collision-detect.txt
* Documentation/technical/pack-format.txt

The modified commands are documented in

* Documentation/git-count-objects.txt
* Documentation/git-index-pack.txt
* Documentation/git-verify-pack.txt

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 Documentation/git-count-objects.txt          |   12 +-
 Documentation/git-index-pack.txt             |   17 +-
 Documentation/git-verify-pack.txt            |   27 ++
 Documentation/technical/collision-detect.txt |  342 ++++++++++++++++++++++++++
 Documentation/technical/pack-format.txt      |   47 ++++
 5 files changed, 439 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/technical/collision-detect.txt

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index 23c80ce..4cdbaf5 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -8,7 +8,7 @@ git-count-objects - Count unpacked number of objects and their disk consumption
 SYNOPSIS
 --------
 [verse]
-'git count-objects' [-v]
+'git count-objects' [-v] [-M]
 
 DESCRIPTION
 -----------
@@ -25,6 +25,16 @@ OPTIONS
 	objects, number of packs, disk space consumed by those packs,
 	and number of objects that can be removed by running
 	`git prune-packed`.
+-M::
+--count-md::
+	Report the number of loose objects with no stored message digests.
+	With the -v option, the number of missing "mds" files (these
+	contain the message digests for the SHA1 hashes in the corresponding
+	"idx" files) is reported, along with a count of the number of
+	mds files whose size is wrong (e.g., an index was created but the
+	existing MDS file was not updated) and a count of the number of
+	objects in pack files that do not have a stored message digest.
+	Values that are zero are not shown.
 
 GIT
 ---
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 909687f..c9389f4 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -11,14 +11,14 @@ SYNOPSIS
 [verse]
 'git index-pack' [-v] [-o <index-file>] <pack-file>
 'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
-                 [<pack-file>]
+		 [-m <mds-file>] [<pack-file>]
 

 DESCRIPTION
 -----------
-Reads a packed archive (.pack) from the specified file, and
-builds a pack index file (.idx) for it.  The packed archive
-together with the pack index can then be placed in the
+Reads a packed archive (.pack) from the specified file, and builds a
+pack index file (.idx) and a pack mds file (.mds) for it.  The packed
+archive together with the pack index can then be placed in the
 objects/pack/ directory of a git repository.
 

@@ -35,6 +35,14 @@ OPTIONS
 	fails if the name of packed archive does not end
 	with .pack).
 
+-m <mds-file>::
+	Write the generated pack mds file into the specified.
+	file Without this option, the name of the pack mds
+	file is constructed from the name of packed archive
+	file by replacing .pack with .idx (and the program
+	fails if the name of packed archive does not end
+	with .pack).
+
 --stdin::
 	When this flag is provided, the pack is read from stdin
 	instead and a copy is then written to <pack-file>. If
@@ -74,7 +82,6 @@ OPTIONS
 --strict::
 	Die, if the pack contains broken objects or links.
 
-
 Note
 ----
 
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index cd23076..f69ed3f 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -33,6 +33,19 @@ OPTIONS
 	Do not verify the pack contents; only show the histogram of delta
 	chain length.  With `--verbose`, list of objects is also shown.
 
+-M::
+--show-mds::
+	Show the message digests along with the 40-character object names
+	(SHA1 value in hexidecimal). Ignored if --stat-only is set. If
+	--verbose is not set, only the table indexed by object names is
+	shown, although the files will be verified.  The message digests
+	printed are the actual ones - if the MDS file does not contain these,
+	the verification will fail.  The message digests will be
+	prefaced with a two-byte code indicating the type of digest.
+	The values (n hexadecimal) are 01 for a CRC, 05 for SHA-1, 08
+	for SHA-256, and 10 for SHA-512.  If the digest stored does
+	not match the actual digest, the actual one is printed as well.
+
 \--::
 	Do not interpret any more arguments as options.
 
@@ -48,6 +61,20 @@ for objects that are not deltified in the pack, and
 
 for objects that are deltified.
 
+When the -M option is used, the offset-in-pack field is followed by an
+entry giving the message digest.  The format used is:
+
+      md=0xHEX_VALUE
+
+when a message digest exists, and
+
+     <no md>
+
+when a message digest does not exist.  These entries precede the depth
+entry for deltified objects.  A non-existent message digest will be shown
+only if the MDS file is missing - while the MDS-file format allows missing
+entries, the file will not be considered valid.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/collision-detect.txt b/Documentation/technical/collision-detect.txt
new file mode 100644
index 0000000..d5a4364
--- /dev/null
+++ b/Documentation/technical/collision-detect.txt
@@ -0,0 +1,342 @@
+Hash-Collision Detection using Message Digests
+=============================
+
+Initially Git used a SHA-1 hash as an object ID under the assumption
+that a hash collision would never occur in practice. While an
+accidental SHA-1 collision is extremely unlikely, it is possible,
+although very expensive, to generate multiple files with the same
+SHA-1 value in under 2^57 operations.  With computer performance
+increasing significantly from one year to the next, Git's assumptions
+about SHA-1 will eventually not hold in the case of a malicious
+attempt to damage a project.  One should note that just because the
+probability of a SHA-1 collision occurring accidentally is extremely
+low does not mean a priori that SHA-1 provides an adequate safety
+margin for preventing a malicious attempt to damage repositories and a
+discussion below outlines some of the issues regarding this
+possibility.
+
+While one could modify Git to use SHA-224, SHA-256, SHA-384, or
+SHA-512 instead of SHA-1, the change would have to support the
+original format as well (in order to deal with existing Git
+repositories). While one could convert an existing repository to use
+the new hash function, this would require rewriting every object,
+including trees and commits.  The outcome would be problematic given
+the existence of email and documentation that might name commits by
+their SHA-1 hashes. One should note that Git performs a byte-by-byte
+check for hash collisions when a pack file is indexed.  Unfortunately,
+during fetch or pull operations, Git tries to avoid copying objects
+when a peer already has a copy, and this is determined solely on the
+basis of SHA-1 hashes.
+
+The following describes a modification to Git's initial design that is
+(a) relatively easy to implement, (b) is compatible with and can
+interoperate with older versions of Git (both the program and the
+repositories) (c) has a small computational overhead, and (d)
+increases security substantially, with a goal of detecting hash
+collisions early and automatically.  Because the implementation is
+relatively simple and the overhead very low, it makes sense to
+incorporate this change (or some alternative) before the security
+issue becomes a serious problem.
+
+Although Git generally uses that assumption that there will never be a
+hash collision using SHA-1 in practice, under some circumstances, Git
+will detect collisions via a byte-by-byte comparison as objects are
+added to the repository or as pack files are indexed.  This test is
+performed when an index is built (via the Git pack-index command), but
+a byte-by-byte comparison was deemed too computationally expensive to
+use in all circumstances: with pack files in particular, simply
+extracting an object can require not only decompressing it, but
+handling a series of delta encodings.
+
+Collision detection has been extended by computing a message digest of
+the object's contents (i.e., excluding the Git header). These message
+digests are stored separately from Git objects and are used for an
+independent collision test - looking up the message digests using the
+SHA-1 IDs as a key can be done quickly, and comparing them is fast as
+well (the digests are aligned to allow 32-bit or 64-bit integer
+comparisions).  This extension is computationally cheap (timing the
+Git test suite (run via 'make test') showed only a small increase in
+running time and the extension is backwards compatible with existing
+Git repositories - if a MD is not available for a SHA-1 value, the
+implementation reverts to its former behavior and simply compares
+SHA-1 values.  The implementation allows message digests to be easily
+added.
+
+The implementation creates a directory in .git/objects named "mdsd",
+which contains sub-directories and file names identical to the
+sub-directories in objects used to store loose objects: a two
+character directory name, with a 38-character file name, the
+concatenation of which gives the SHA-1 hash for the object.  the files
+in sub-directories of "mdsd", however, simply contain a one-byte code
+indicating the type of message digest, followed by the digest in its
+binary representation as a sequence of bytes.  In addition, for each
+pack file (.../objects/pack/FILE.pack), there is a corresponding file
+named .../objects/pack/FILE.mds in addition to
+.../objects/pack/FILE.idx.  The MDS file contains the MDs, stored in
+the same order as the SHA-1 hashes in .../objects/pack/FILE.idx.  The
+format of the MDS file is described in pack-format.txt.
+
+Thus, the directory structure (only part of it is shown) is as
+follows:
+
+ .git---.
+	|
+	|-objects-.
+	|	  |--XX--.
+	.	  |	 |--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
+	.	  |	 .
+	.	  |	 .
+		  |	 .
+		  .
+		  .
+		  .
+		  |-mdsd-.
+		  |	 |--XX--.
+		  |	 |	|--XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
+		  |	 .	.
+		  |	 .	.
+		  |	 .	.
+		  |
+		  |-pack-.
+		  |	 |--YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY.pack
+		  |	 |--YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY.idx
+		  |	 |--YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY.mds
+		  |	 .
+		  |	 .
+		  |	 .
+		  |
+		  `-info-.
+			 .
+			 .
+
+The mds files are relatively short - an average of N+1 bytes per MD
+of length N (provided N is a multiple of 4)
+plus some fixed overhead due to a header and trailer, with the MDs
+listed in the same order as the SHA-1 values in the matching idx file
+(a function named nth_packed_object_digest has the same signature as
+the previously-defined function nth_packed_object_offset, so the
+procedure to look up the MD value from a pack file is the same).
+
+For fetch and push operations, the commands fetch-pack, send-pack,
+receive-pack, and upload-pack were modified so that various object IDs
+can have any one of the following formats, with each number
+represented in hexadecimal:
+
+		SHA1
+		SHA1-MD
+
+where SHA1 is the SHA-1 hash of a commit and MD the message digest
+(prefixed by a code indicating the type of digest) of the commit
+(uncompressed, not including the Git object header).
+
+Both receive-pack and upload-pack send a capability named "mds-check"
+to allow the two longer object IDs.  When the MDs are available, the
+longer formats are used, but are generated only by fetch-pack and
+send-pack: because of backwards-compatibility constraints,
+receive-pack and upload-pack cannot determine the capabilities of
+fetch-pack and send-pack when connected to a remote repository).  The
+collision checks during a fetch, push, or pull command are done by
+receive-pack and upload pack because send-pack and fetch-pack do not
+receive their peers' MD values - send-pack and fetch-pack cannot determine
+their peers' capabilities given the current design.
+
+Changes to the Commit Format
+----------------------------
+
+A new header is available, positioned as the last header. It's name is
+"digest" and its value is a hex representation of a message digest in
+which the first two bytes name the algorithm used to generate the
+digest and the remaining bytes are the digest itself.  This digest is
+a digest of other digests or SHA-1 values.  It starts by including the
+digests of each object in the commit's tree with the exception of a
+commit from a submodule - in that case, the SHA-1 value itself is
+used.  The tree is searched depth first, including the tree's root,
+which provides the first digest.  This is followed by the digest for
+each parent commit in the order listed in the commit.  Finally, the
+digest covers the author, committer, encoding, and the commit message,
+all excluding the terminating newline character in the header.
+
+Note that the digest header complicates any attempt at generate a hash
+collision for a commit message - if you change a field, you also have
+to change the digest in a specific way.
+
+Configuration
+-------------
+
+There are several variables in the Makefile:
+
+      * MDSDB should have the value 0. If an alternative implementation
+	is defined, other values will be available.
+
+      * MDIGEST_DEFAULT should be defined to explicitly set the
+	default message digest.
+
+      * PACKDB should be defined to turn on the packdb functions.
+
+      * PACKDB_TEST should be defined only for debugging.  It uses some
+	packdb functions where not necessary to verify that these work
+	properly.  Turning this test on decreases performance.
+
+      * COMMIT_DIGEST should be defined to add a digest header to
+	commit messages as described above
+
+      * COMMIT_DIGEST_TEST should be defined to force commit_tree to
+	compute the digest even when COMMIT_DIGEST is undefined, in
+	which case the digest will be computed but not included in a
+	commit.
+
+Key Functions
+-------------
+
+For general use, the functions documented in mdigest.h can extract
+data from message digests and compare them.  The function verify_commit
+will test a commit to make sure that its digest field matches the
+repository.  The function has_sha1_file_digest allows one to determine
+if a digest exists and obtain a copy of that digest.
+
+To find functions that are used in the implementation (e.g., if changes
+to the pack-file format become necessary), search for the type
+mdigest_t or variables width digest in their names (e.g., digestp).
+
+
+Implementation Details
+----------------------
+
+Functions to manipulate the message digest/MD database are declared
+in the file mdsdb.h.  The implementation as described above is in the
+file objd-mdsdb.c: it is thus easy to change the implementation of how
+these objects are stored with minimal impact on the rest of the source
+code.  The message digest structure and functions to manipulate it are
+declared in mdigest.h, with the implementation in mdigest.c.
+
+In pack-write.c, there is a new function named write_mds_file with the
+same function signature as write_idx_file.  Both are called in pairs
+(write_idx_file first) so that the idx file and mds file for the
+corresponding pack file will always be created.
+
+In commit.c, there is a new function that recursively traverses the
+tree associated with a commit and finds the "blob" entries and looks
+up those entries' message digests in order to compute a message digest
+of these message digests (which is faster than computing a message
+digest of all the bytes in the blobs associated with a commit).
+
+Various function names signatures in sha1_file.c were changed to take
+two additional arguments, the first a pointer to an int used as a flag
+to indicate whether a MD exists, and the second a pointer to a
+uint32_t containing the MD.  For backwards compatibility with
+previously existing functions, those functions had there names changed
+by adding "_extended" to them, with macros in cache.h defined so that
+existing code that does not need to obtain a MD would not be
+changed. There are a few additional functions added to sha1_file.c
+such as one to determine if there is an MD for a given SHA-1
+value. Many changes in the rest of Git that result from this simply
+change the arguments to these functions.  As a convention, most such
+arguments use names like objcrc32, objcrc32p, has_objcrc32 and
+has_objcrc32p in order to make it easy to find areas of the code
+implementing hash-collision detection using the git-grep command.
+
+A few data structures (notably struct pack_idx_entry and struct
+packed_git) contain fields used to store has_objcrc32 and objcrc32
+values or data associated with MDS files.  These are used while
+building new MDS files.
+
+Some of the Git commands (count-objects, index-pack, and verify-pack)
+have additional command-line options related to the MDs and mds
+files. This makes it possible to explicitly name an mds file being
+created and to request that various listings show both the MD
+values in addition to SHA-1 hashes (the MD values are not listed
+by default in case user-defined scripts assume the current behavior).
+
+For C files, changes were made to the following files (compared to
+commit f56564968 - v1.7.8-rc4) for the initial collision-detection
+implementation:
+
+       * builtin/count-objects.c
+       * builtin/fetch-pack.c
+       * builtin/index-pack.c
+       * builtin/init-db.c
+       * builtin/pack-objects.c
+       * builtin/pack-redundant.c
+       * builtin/prune-packed.c
+       * builtin/prune.c
+       * builtin/receive-pack.c
+       * builtin/send-pack.c
+       * builtin/verify-pack.c
+       * commit.c
+       * environment.c
+       * fast-import.c
+       * gdbm-packdb.c (new file)
+       * git.c
+       * hex.c
+       * http.c
+       * mdigest.c (new file)
+       * objd-mdsdb.c (new file)
+       * pack-write.c
+       * sha1_file.c
+       * upload-pack.c
+
+The other files had changes that reflected changes to function
+signatures.
+
+The header files that were modified are
+
+    * cache.h
+    * commit.h
+    * mdigest.h (new file)
+    * mdsdb.h (new file)
+    * pack.h
+    * packdb.h (new file)
+
+where the changes are mostly new function declarations, a few macros
+for backwards-compatibility, and a few additional fields in some
+data structures.
+
+Minor changes were made to the test suite: t0000-basic.sh,
+t5300-pack-object.sh, t5304-prune.sh, t5500-fetch-pack.sh, and
+t5510-fetch.sh.
+
+The packdb functions are conditionally compiled and by default are not
+used.  When used, these use GDBM to store MDs for SHA-1 hashes in
+cases in which the hash was not available - in this case the hash will
+be recomputed and stored for future use.  Testing indicates that
+packdb is not needed. It may be worth turning on during debugging to
+verify if a problem is discovered involving a missing MD. (As an
+aside, the packdb code is based on a test to see if GDBM would be
+efficient enough to store the MD values in general, thus avoiding
+the need to create "mds" files and reducing the number of files in the
+"mdsd" directory, but it turned out that performance was not
+acceptable.)
+
+Security-Issue Details
+----------------------
+
+Without hash-collision detection, Git has a possible risk of data
+corruption due to the obvious hash-collision vulnerability, so the
+issue is really whether a usable vulnerability exists. In the case
+of a single shared repository (one common repository shared by
+multiple developers), this risk is mitigated by Git's rule that
+an existing entry is never overridden. The situation is more complex
+when multiple repositories are used, as a race condition may exist.
+Also, the risk depends on whether or not developers exchange source
+files by some out-of-band mechanism (e.g., email) - when programming
+in Java, for example, it is customary to use the javadocs program to
+create API documentation from stylized comments in source files. A
+programmer might send a peer a copy of a source file and to review
+and correct the java-doc comments, providing an opporunity for the
+second developer to insert a modified file into the respository. The
+first developer would presumably check that the source code has not
+changed (an automated test for this might use the java compiler's
+"-g:none" option so that line-number data does not appear in the object
+file), and review the comments, but would not care about formatting
+(location of line breaks, etc., as the javadocs program generates HTML).
+
+In any event, recent research has shown that SHA-1 collisions can be
+found in 2^63 operations or less.  While one result claimed 2^53
+operations, the paper claiming that value was withdrawn from
+publication due to an error in the estimate. Another result claimed a
+complexity of between 2^51 and 2^57 operations, and still another
+claimed a complexity of 2^57.5 SHA-1 computations. A summary is
+available at
+<http://hackipedia.org/Checksums/SHA/html/SHA-1.htm#SHA-1>.
+This is within or close to the number of computations that can be
+managed by a well-funded organization.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1803e64..a2aad5f 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -158,3 +158,50 @@ Pack file entry: <+
     corresponding packfile.
 
     20-byte SHA1-checksum of all of the above.
+
+
+= pack-*.mds files contain message digests for objects.  The digests
+  are stored in the same order as the sha-1 values in the matching idx
+  file.  These files have the following format:
+
+  - A 6-byte magic number consisting the the characters "PKMDS" followed
+    by a NULL character (0).
+
+  - A one-byte version number (= 1)
+
+  - A one-byte field-length value for message digest fields, in units
+    of 4-byte words.  (The length of the message digest fields in bytes
+    is denoted as wbsize below)
+
+  - A set of blocks, each of which contains 4 entries encoded as follows:
+
+      * four one-byte fields (wcode fields), one per entry, for which
+	a zero value indicates that a matching entry does not exist
+	and a non-zero value indicates the type of message digest
+	encoded as follows:
+
+	   + 1 for a CRC  (used as a trivial case for performance testing)
+
+	   + 5 for SHA-1
+
+	   + 8 for SHA-256
+
+	   + 16 for SHA-512
+
+      * 4 wbsize-byte fields, each containing a message digest (by
+	convention which must be all NULL characters if the MD does
+	not exist).  For each field, the data it contains should start
+	at the first byte, padded with NULL characters if the field is
+	longer than the digest it stores.
+
+    For the set of all blocks, the nth one-byte field and the nth
+    wcode field store the values for the nth entry in the
+    file. The format ensures that each message digest starts on a
+    32-bit boundary, allowing 32-bit integer operations to be used in
+    copying or comparing values.
+
+  - A 20 byte SHA-1 hash of the SHA-1 hashes naming the objects whose
+    message digests are being stored, in the same order as they
+    appear in the corresponding idx file.
+
+  - A 20 byte SHA-1 hash of all of the above.
-- 
1.7.1
