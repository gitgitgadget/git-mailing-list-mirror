From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: packed GIT support commands.
Date: Thu, 14 Jul 2005 00:08:05 -0700
Message-ID: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 09:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsxpS-00046n-7S
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 09:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVGNHIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 03:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVGNHIL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 03:08:11 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37280 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262934AbVGNHIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 03:08:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714070803.MQSZ15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 03:08:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds documentation for creating packed archives, inspecting,
validating them, and unpacking them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-pack-objects.txt   |   80 ++++++++++++++++++++++++++++++++++
 Documentation/git-show-index.txt     |   36 +++++++++++++++
 Documentation/git-unpack-objects.txt |   33 ++++++++++++++
 Documentation/git-verify-pack.txt    |   13 +++++-
 4 files changed, 161 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-pack-objects.txt
 create mode 100644 Documentation/git-show-index.txt
 create mode 100644 Documentation/git-unpack-objects.txt

32a772fa72da57fbbe9ea27d195e6b755c83cd22
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-pack-objects.txt
@@ -0,0 +1,80 @@
+git-pack-objects(1)
+===================
+v0.1, July 2005
+
+NAME
+----
+git-pack-objects - Create a packed archive of objects.
+
+
+SYNOPSIS
+--------
+'git-pack-objects' [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list
+
+
+DESCRIPTION
+-----------
+Reads list of objects from the standard input, and writes a packed
+archive with specified base-name, or to the standard output.
+
+A packed archive is an efficient way to transfer set of objects
+between two repositories, and also is an archival format which
+is efficient to access.  The packed archive format (.pack) is
+designed to be unpackable without having anything else, but for
+random access, accompanied with the pack index file (.idx).
+
+'git-unpack-objects' command can read the packed archive and
+expand the objects contained in the pack into "one-file
+one-object" format; this is typically done by the smart-pull
+commands when a pack is created on-the-fly for efficient network
+transport by their peers.
+
+Placing both in pack subdirectory of $GIT_OBJECT_DIRECTORY (or
+any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
+enables GIT to read from such an archive.
+
+
+OPTIONS
+-------
+base-name::
+	Write into a pair of files (.pack and .idx), using
+	<base-name> to determine the name of the created file.
+	When this option is used, the two files are written in
+	<base-name>-<SHA1>.{pack,idx} files.  <SHA1> is a hash
+	of object names (currently in random order so it does
+	not have any useful meaning) to make the resulting
+	filename reasonably unique, and written to the standard
+	output of the command.
+
+--stdout::
+	Write the pack contents (what would have been writtin to
+	.pack file) out to the standard output.
+
+--window and --depth::
+	These two options affects how the objects contained in
+	the pack are stored using delta compression.  The
+	objects are first internally sorted by type, size and
+	optionally names and compared against the other objects
+	within --window to see if using delta compression saves
+	space.  --depth limits the maximum delta depth; making
+	it too deep affects the performance on the unpacker
+	side, because delta data needs to be applied that many
+	times to get to the necessary object.
+
+--incremental::
+	This flag causes an object already in a pack ignored
+	even if it appears in the standard input.
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+-------------
+Documentation by Junio C Hamano
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-show-index.txt
@@ -0,0 +1,36 @@
+git-show-index(1)
+=================
+v0.1, July 2005
+
+NAME
+----
+git-show-index - Show packed archive index
+
+
+SYNOPSIS
+--------
+'git-show-index' < idx-file
+
+
+DESCRIPTION
+-----------
+Reads given idx file for packed GIT archive created with
+git-pack-objects command, and dumps its contents.
+
+The information it outputs is subset of what you can get from
+'git-verify-pack -v'; this command only shows the packfile
+offset and SHA1 of each object.
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+--------------
+Documentation by Junio C Hamano
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
new file mode 100644
--- /dev/null
+++ b/Documentation/git-unpack-objects.txt
@@ -0,0 +1,33 @@
+git-unpack-objects(1)
+=====================
+v0.1, July 2005
+
+NAME
+----
+git-unpack-objects - Create a packed archive of objects.
+
+
+SYNOPSIS
+--------
+'git-unpack-objects' < pack-file
+
+
+DESCRIPTION
+-----------
+Reads a packed archive (.pack) from the standard input, and
+expands the objects contained in the pack into "one-file
+one-object" format in $GIT_OBJECT_DIRECTORY.
+
+
+Author
+------
+Written by Linus Torvalds <torvalds@osdl.org>
+
+Documentation
+-------------
+Documentation by Junio C Hamano
+
+GIT
+---
+Part of the link:git.html[git] suite
+
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -9,7 +9,7 @@ git-verify-pack - Validate packed GIT ar
 
 SYNOPSIS
 --------
-'git-verify-pack' <pack>.idx ...
+'git-verify-pack' [-v] <pack>.idx ...
 
 
 DESCRIPTION
@@ -23,6 +23,17 @@ OPTIONS
 <pack>.idx ...::
 	The idx files to verify.
 
+-v::
+	After verifying the pack, show list of objects contained
+	in the pack.  The format used is:
+
+		SHA1 type size offset-in-packfile
+
+	for objects that are not deltified in the pack, and
+
+		SHA1 type size offset-in-packfile depth base-SHA1
+
+	for objects that are deltified.
 
 Author
 ------
