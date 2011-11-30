From: Bill Zaumen <bill.zaumen@gmail.com>
Subject: [PATCH 2/3] Add documentation for fast hash collision detection
Date: Tue, 29 Nov 2011 22:12:39 -0800
Message-ID: <1322633559.1728.331.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 07:12:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVdPc-0004Qc-JN
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 07:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab1K3GMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 01:12:51 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56379 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab1K3GMu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 01:12:50 -0500
Received: by iage36 with SMTP id e36so261981iag.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 22:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=Q4luI0Oe1OgQ7k5blT/Ad+srSXMQTiP0uQ8Ws4zCbSQ=;
        b=cDmt7HptmVvMsWZOsmY9jAUe8WCFlBTK2NtF6+yfqmeJ6+M+hIhG/SzADNX0kkDVuA
         plDeRs+0fmzLVWyHHoqQ8YCZ234E9vU04uLdcmoUdNUq9pmgHzRMfVyFoAtYcIO+EM/z
         ZkD3uWCOBIIk5hZ7Pgs4Sldc2eWJJKSNMTRE4=
Received: by 10.42.115.136 with SMTP id k8mr961907icq.46.1322633567622;
        Tue, 29 Nov 2011 22:12:47 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id wo4sm2122153igc.5.2011.11.29.22.12.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 22:12:46 -0800 (PST)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186104>

The documentation added is technical documentation describing
how fast hash collision detection operates and changes to
several git commands (a few new command-line arguments, mostly).

Note: the change to the implementation is in the child of
this commit.

Signed-off-by: Bill Zaumen <bill.zaumen+git@gmail.com>
---
 Documentation/git-count-objects.txt          |   12 +-
 Documentation/git-index-pack.txt             |   16 +-
 Documentation/git-verify-pack.txt            |   23 ++
 Documentation/technical/collision-detect.txt |  385 ++++++++++++++++++++++++++
 Documentation/technical/pack-format.txt      |   40 +++
 5 files changed, 471 insertions(+), 5 deletions(-)
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
index 909687f..3285fae 100644
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
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index cd23076..e81c514 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -33,6 +33,15 @@ OPTIONS
 	Do not verify the pack contents; only show the histogram of delta
 	chain length.  With `--verbose`, list of objects is also shown.
 
+-M::
+--show-mds::
+	Show the message digests along with the 40-character object names
+	(SHA1 value in hexidecimal). Ignored if --stat-only is set. If
+	--verbose is not set, only the table indexed by object names is
+	shown, although the files will be verified.  The message digests
+	printed are the actual ones - if the MDS file does not contain these,
+	the verification will fail.
+
 \--::
 	Do not interpret any more arguments as options.
 
@@ -48,6 +57,20 @@ for objects that are not deltified in the pack, and
 
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
index 0000000..0d33da8
--- /dev/null
+++ b/Documentation/technical/collision-detect.txt
@@ -0,0 +1,385 @@
+Fast Hash-Collision Detection
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
+Collision detection has been extended by computing a message digest or
+CRC of the object's contents (i.e., excluding the Git header). These
+message digests are stored separately from Git objects and are used
+for an independent collision test - looking up the message digests or
+CRCs using the SHA-1 IDs as a key can be done quickly, and comparing
+them is fast as well (a single unsigned-integer comparison for a
+32-bit CRC).  Assuming statistical independence in the CRC case, the
+changes of an undetected SHA-1 collision, should one occur, is 1 in
+2^32.  This extension is computationally cheap (timing the Git test
+suite (run via 'make test') showed only a small increase in running
+time and the extension is backwards compatible with existing Git
+repositories - if a CRC is not available for a SHA-1 value, the
+implementation reverts to its former behavior and simply compares
+SHA-1 values.  The CRC can, of course, be easily replaced with a
+SHA-256 or SHA-512 digest to reduce the chances of an undetected SHA-1
+collision to nearly zero.  For that reason, in the following we will
+use the terms MD (Message Digest) and CRC interchangeably.
+
+The implementation creates a directory in .git/objects named "crcs",
+which contains sub-directories and file names identical to the
+sub-directories in objects used to store loose objects: a two
+character directory name, with a 38-character file name, the
+concatenation of which gives the SHA-1 hash for the object.  the files
+in sub-directories of "crcs", however, simply contain 32-bit CRCs
+stored in network byte order.  In addition, for each pack file
+(.../objects/pack/FILE.pack), there is a corresponding file named
+.../objects/pack/FILE.mds in addition to .../objects/pack/FILE.idx.
+The MDS file contains the CRCs, stored in the same order as the SHA-1
+hashes in .../objects/pack/FILE.idx.  The format of the MDS file is
+described in pack-format.txt.
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
+		  |-crcs-.
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
+The mds files are relatively short - an average of 5 bytes per CRC
+plus some fixed overhead due to a header and trailer, with the CRCs
+listed in the same order as the SHA-1 values in the matching idx file
+(a function named nth_packed_object_objcrc32 has the same signature as
+the previously-defined function nth_packed_object_offset, so the
+procedure to look up the MD/CRC value from a pack file is the same).
+
+For fetch and push operations, the commands fetch-pack, send-pack,
+receive-pack, and upload-pack were modified so that various object IDs
+can have any one of the following formats, with each number
+represented in hexadecimal:
+
+		SHA1
+		SHA1-MD
+		SHA1-MD-BlobMD
+
+where SHA1 is the SHA-1 hash of a commit, MD is the 32-bit CRC of the
+commit (uncompressed, not including the Git object header), and BlobMD
+is a CRC of the CRCs for each blob found by traversing the commit's
+tree using a depth-first search, with blobs processed in the order
+they appear in the trees (this is a relatively fast operation because
+the CRCs of each blob are stored in the repository).
+
+Both receive-pack and upload-pack send a capability named "mds-check"
+to allow the two longer object IDs.  When the CRCs are available, the
+longer formats are used, but are generated only by fetch-pack and
+send-pack: because of backwards-compatibility constraints,
+receive-pack and upload-pack cannot determine the capabilities of
+fetch-pack and send-pack when connected to a remote repository).
+While the message digests associated with each object are computed
+once and stored, the "BlobMD" ones are computed each time - the
+"BlobMD" ones are only used by the Git commands fetch-pack,
+upload-pack, send-pack, and receive-pack.  In each case, a
+hash-collision check is performed only if the message digest used is
+available.  The collision checks during a fetch, push, or pull command
+are done by receive-pack and upload pack because send-pack and
+fetch-pack do not receive their peers' MD and BlobMD values.
+
+
+Implementation Details
+----------------------
+
+Functions to manipulate the message digest/CRC database are declared
+in the file crcdb.h.  The implementation as described above is in the
+file objd-crcdb.c: it is thus easy to change the implementation of how
+these objects are stored with minimal impact on the rest of the source
+code.
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
+to indicate whether a MD/CRC exists, and the second a pointer to a
+uint32_t containing the MD/CRC (a CRC currently).  For backwards
+compatibility with previously existing functions, those functions had
+there names changed by adding "_extended" to them, with macros in
+cache.h defined so that existing code that does not need to obtain a
+MD/CRC would not be changed. There are a few additional functions
+added to sha1_file.c such as one to determine if there is an MD/CRC
+for a given SHA-1 value. Many changes in the rest of Git that result
+from this simply change the arguments to these functions.  As a
+convention, most such arguments use names like objcrc32, objcrc32p,
+has_objcrc32 and has_objcrc32p in order to make it easy to find areas
+of the code implementing hash-collision detection using the git-grep
+command.
+
+A few data structures (notably struct pack_idx_entry and struct
+packed_git) contain fields used to store has_objcrc32 and objcrc32
+values or data associated with MDS files.  These are used while
+building new MDS files.
+
+Some of the Git commands (count-objects, index-pack, and verify-pack)
+have additional command-line options related to the MD/CRCs and mds
+files. This makes it possible to explicitly name an mds file being
+created and to request that various listings show both the MD/CRC
+values in addition to SHA-1 hashes (the MD/CRC values are not listed
+by default in case user-defined scripts assume the current behavior).
+
+For C files, changes were made to the following files (compared to
+commit 017d1e13) for the initial collision-detection implementation:
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
+       * objd-crcdb.c (new file)
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
+    * crcdb.h (new file)
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
+used.  When used, these use GDBM to store CRCs for SHA-1 hashes in
+cases in which the hash was not available - in this case the hash will
+be recomputed and stored for future use.  Testing indicates that
+packdb is not needed. It may be worth turning on during debugging to
+verify if a problem is discovered involving a missing MD/CRC. (As an
+aside, the packdb code is based on a test to see if GDBM would be
+efficient enough to store the MD/CRC values in general, thus avoiding
+the need to create "mds" files and reducing the number of files in the
+"crcs" directory, but it turned out that performance was not
+acceptable.)
+
+Security-Issue Details
+----------------------
+
+Without hash-collision detection, Git has a higher risk of data
+corruption due to the obvious hash-collision vulnerability, so the
+issue is really whether a usable vulnerability exists. Recent research
+has shown that SHA-1 collisions can be found in 2^63 operations or
+less.  While one result claimed 2^53 operations, the paper claiming
+that value was withdrawn from publication due to an error in the
+estimate. Another result claimed a complexity of between 2^51 and 2^57
+operations, and still another claimed a complexity of 2^57.5 SHA-1
+computations. A summary is available at
+<http://hackipedia.org/Checksums/SHA/html/SHA-1.htm#SHA-1>. Given the
+number of recent attacks, possibly by governments or large-scale
+criminal enterprises
+(<http://www.csmonitor.com/World/terrorism-security/2011/0906/Iranian-government-may-be-behind-hack-of-Dutch-security-firm>,
+<http://en.wikipedia.org/wiki/Operation_Aurora>,
+<http://en.wikipedia.org/wiki/Botnet#Historical_list_of_botnets>),
+which include botnets with an estimated 30 million computers, there is
+reason for some concern: while generating a SHA-1 collision for
+purposes of damaging a Git repository is extremely expensive
+computationally, it is possibly within reach of very well funded
+organizations. 2^32 operations, even if the operations are as
+expensive as computing a SHA-1 hash of a modest source-code file, can
+be performed in a reasonably short period of time on the type of
+hardware widely used in desktop or laptop computers at present. With
+sufficient parallelism, 30 million personal computers sufficient for
+playing the latest video games could perform 2^56 operations in a
+reasonable time.
+
+The security implications depend on how Git is used.  In the simplest
+case in which a single, shared repository is used by a number of
+developers, with source code only shared though this repository, the
+problems are minimal - Git will not allow one to insert an object
+whose SHA-1 hash matches that of an existing object.  Since an
+attacker would not know the SHA-1 hash until the correct object is
+already in the shared repository, all an attacker would succeed in
+doing is to create some confusion in his/her private repository and
+working copy (but note that some of the assumptions break down if
+developers email source files between themselves rather than transferring
+everything via a Git repository).
+developers, with source code only shared though this repository, the
+problems are minimal - Git will not allow one to insert an object
+whose SHA-1 hash matches that of an existing object.  Since an
+attacker would not know the SHA-1 hash until the correct object is
+already in the shared repository, all an attacker would succeed in
+doing is to create some confusion in his/her private repository and
+working copy (but note that some of the assumptions break down if
+developers email source files between themselves rather than transferring
+everything via a Git repository).
+
+In other cases, however, there could be an issue if a SHA-1 collision
+can be created quickly enough. As an example, suppose one is using the
+"Integration-manager workflow" described in "Pro Git" (see
+<http://progit.org/book/ch5-1.html>) with a "blessed repository" BR
+and two public developer repositories DPR1 and DPR2.  Suppose a
+developer puts a legitimate change to the code into DPR2. Another
+developer with read access to DPR2 and write access to DPR1
+immediately fetches this commit, and replaces one file with a modified
+version of the same size that has the same SHA-1 value, and then puts
+the commit into DPR1 (the change may be a trivial one designed to
+introduce an obscure buffer overflow error that can be exploited and
+may not stand out in a code review).  At this point DPR1 and DPR2 have
+identical commits (i.e., the same commit object) but with one file
+modified.  No local test on either DPR1 or DPR2 will uncover a
+discrepancy based on SHA-1 values, object contents, and digital
+signatures for commits.  Further assume that both developers send an
+email to the "integration manager" notifying him/her of the changes.
+
+Now suppose the above changes occurred late on a Friday afternoon and
+over a weekend.  On the next Monday morning, the "integration manager"
+reads the emails and pulls changes from DPR1 and then DPR2.  Once a
+'fetch' from DPR1 is complete, a subsequent fetch from DBR2 will not
+transfer any data related to the commit, as the integration manager's
+repository already has a commit with the matching SHA-1 value.  A
+modified copy will have been introduced into the system, and the
+developers using DPR2 may never notice the difference - as they will
+pull from DPR2 more often than BR, they will most likely have the
+correct files and the commit in their local repositories and the
+transfer protocol will avoid sending the commit if it is already
+available.  Furthermore, if the modified file introduces a hard-to-find
+buffer overflow testing may not uncover the problem.
+
+If the file in question is modified again, and a thin pack is used in
+a fetch so that the change is delta-encoded, the SHA-1 hashes may
+differ after de-deltafication, but such a change might not be
+introduced before a release.  While obtaining a different SHA-1
+hash than expected would be detected, the error would be a corrupted
+repository - a missing SHA-1 value in the tree associated with a commit.
+It would take some effort to figure out what went wrong - what
+happens depends on the state of both the client and server when a
+git-fetch operation runs.
+
+As a justification for the scenarios just described, one can use MD5
+as a model: http://www.mscs.dal.ca/~selinger/md5collision/ gives the
+following two 128-byte sequences (expressed in hexadecimal) as ones
+with the same MD5 hash:
+
+d131dd02c5e6eec4693d9a0698aff95c 2fcab58712467eab4004583eb8fb7f89
+55ad340609f4b30283e488832571415a 085125e8f7cdc99fd91dbdf280373c5b
+d8823e3156348f5bae6dacd436c919c6 dd53e2b487da03fd02396306d248cda0
+e99f33420f577ee8ce54b67080a80d1e c69821bcb6a8839396f9652b6ff72a70
+
+and
+
+d131dd02c5e6eec4693d9a0698aff95c 2fcab50712467eab4004583eb8fb7f89
+55ad340609f4b30283e4888325f1415a 085125e8f7cdc99fd91dbd7280373c5b
+d8823e3156348f5bae6dacd436c919c6 dd53e23487da03fd02396306d248cda0
+e99f33420f577ee8ce54b67080280d1e c69821bcb6a8839396f965ab6ff72a70
+
+These can be used for test purposes.  If you change the first 16 bytes
+of both sequences to the same new value, before the point where the
+files differ, you will get different MD5 hash values.  If you append
+the same text to both files, the MD5 values of the modified files are
+equal (and, of course, different from the previous value) but
+fortunately Git includes the length of an object's contents in the
+object's header, and the SHA-1 hash includes the header).  In most
+cases, whever a file is modified during software development, the
+file's length will change.  This causes a change early enough in the
+object so that applying the same patch to two different files that
+have the same SHA-1 value will typically result in two files with
+different SHA-1 values.  So, the result of a hash collision when
+multiple remote repositories are used would initially be different
+versions of the same file for the same commit in different
+repositories, possibly followed by some of the repositories being
+corrupted as one of these files is modified, depending on the state
+of each server and client when a fetch or pull operation is run.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1803e64..4dfaf92 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -158,3 +158,43 @@ Pack file entry: <+
     corresponding packfile.
 
     20-byte SHA1-checksum of all of the above.
+
+
+= pack-*.mds files contain message digests for objects (CRCs
+  initially, with other options possibly added at a later date such as
+  SHA-256).  The digests are stored in the same order as the sha-1 values
+  in the matching idx file.  These files have the following format:
+
+  - A 6-byte magic number consisting the the characters "PKMDS" followed
+    by a NULL character (0).
+
+  - A one-byte version number (= 1)
+
+  - A one-byte field-length value for message digest fields, in units of
+    4-byte words, with the legal value being 1. The length of the message
+    digest fields in bytes is denoted as wsize below).
+
+  - A set of blocks, each of which contains 4 entries encoded as follows:
+
+      * four one-byte fields, one per entry, for which a zero value
+	indicates that a matching entry does not exist and for which a
+	value of 1 indicates that the field contains a 32-bit CRC stored
+	in network byte order.
+
+      * 4 wsize-byte fields, one per entry, each containing a CRC
+	(by conventionwhich should be 0 if the CRC does not exist).
+	For each field, the data it contains should start at the first
+	byte, padded with NULL characters if the field is longer than
+	the digest it stores.
+
+    For the set of all blocks, the nth one-byte field and the nth 4-byte
+    field store the values for the nth entry in the file. The format
+    ensures that each message digest starts on a 32-bit boundary,
+    allowing 32-bit integer operations to be used in copying or
+    comparing values.
+
+  - A 20 byte SHA-1 hash of the SHA-1 hashes naming the objects whose
+    message digests are being stored, in the same order as they
+    appear in the corresponding idx file.
+
+  - A 20 byte SHA-1 hash of all of the above.
-- 
1.7.1
