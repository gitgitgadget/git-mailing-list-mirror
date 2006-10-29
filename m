X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 3/3] Teach git-index-pack how to keep a pack file.
Date: Sun, 29 Oct 2006 04:41:59 -0500
Message-ID: <20061029094159.GE3847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 09:42:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30422>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge7BH-0000DE-7T for gcvg-git@gmane.org; Sun, 29 Oct
 2006 10:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932135AbWJ2JmM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 04:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWJ2JmM
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 04:42:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:13963 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932135AbWJ2JmL
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 04:42:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge7BS-0003Nr-Fe; Sun, 29 Oct 2006 04:42:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 42DE420E45B; Sun, 29 Oct 2006 04:42:04 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

To prevent a race condition between `index-pack --stdin` and
`repack -a -d` where the repack deletes the newly created pack
file before any refs are updated to reference objects contained
within it we mark the pack file as one that should be kept.  This
removes it from the list of packs that `repack -a -d` will consider
for removal.

Callers such as `receive-pack` which want to invoke `index-pack`
should use this new --keep option to prevent the newly created pack
and index file pair from being deleted before they have finished any
related ref updates.  Only after all ref updates have been finished
should the associated .keep file be removed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 I'm still working on the change to receive-pack.  Junio's latest
 patch (send-pack --keep) is a different way of doing at least some
 of what I'm still working on there.

 I'm throwing a pair of pipes around index-pack so I can capture
 the pack name thus allowing receive-pack to delete the correct
 .keep file after its completed the ref updates.  At that point
 receive-pack can easily examine the object count in the pack header
 and compare that against a config entry to decide if it should be
 keeping the pack or exploding it.


 Documentation/git-index-pack.txt |   24 ++++++++++++++++++--
 index-pack.c                     |   43 +++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 9fa4847..1235416 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -9,7 +9,7 @@ git-index-pack - Build pack index file f
 SYNOPSIS
 --------
 'git-index-pack' [-v] [-o <index-file>] <pack-file>
-'git-index-pack' --stdin [--fix-thin] [-v] [-o <index-file>] [<pack-file>]
+'git-index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>] [<pack-file>]
 
 
 DESCRIPTION
@@ -38,7 +38,10 @@ OPTIONS
 	instead and a copy is then written to <pack-file>. If
 	<pack-file> is not specified, the pack is written to
 	objects/pack/ directory of the current git repository with
-	a default name determined from the pack content.
+	a default name determined from the pack content.  If
+	<pack-file> is not specified consider using --keep to
+	prevent a race condition between this process and
+	gitlink::git-repack[1] .
 
 --fix-thin::
 	It is possible for gitlink:git-pack-objects[1] to build
@@ -48,7 +51,22 @@ OPTIONS
 	and they must be included in the pack for that pack to be self
 	contained and indexable. Without this option any attempt to
 	index a thin pack will fail. This option only makes sense in
-	conjonction with --stdin.
+	conjunction with --stdin.
+
+--keep::
+	Before moving the index into its final destination
+	create an empty .keep file for the associated pack file.
+	This option is usually necessary with --stdin to prevent a
+	simultaneous gitlink:git-repack[1] process from deleting
+	the newly constructed pack and index before refs can be
+	updated to use objects contained in the pack.
+
+--keep='why'::
+	Like --keep create a .keep file before moving the index into
+	its final destination, but rather than creating an empty file
+	place 'why' followed by an LF into the .keep file.  The 'why'
+	message can later be searched for within all .keep files to
+	locate any which have outlived their usefulness.
 
 
 Author
diff --git a/index-pack.c b/index-pack.c
index 866a054..b37dd78 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -10,7 +10,7 @@
 #include <signal.h>
 
 static const char index_pack_usage[] =
-"git-index-pack [-v] [-o <index-file>] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
@@ -754,6 +754,7 @@ static const char *write_index_file(cons
 
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
+		  const char *keep_name, const char *keep_msg,
 		  unsigned char *sha1)
 {
 	char name[PATH_MAX];
@@ -780,6 +781,23 @@ static void final(const char *final_pack
 		}
 	}
 
+	if (keep_msg) {
+		int keep_fd, keep_msg_len = strlen(keep_msg);
+		if (!keep_name) {
+			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
+				 get_object_directory(), sha1_to_hex(sha1));
+			keep_name = name;
+		}
+		keep_fd = open(keep_name, O_RDWR | O_CREAT, 0600);
+		if (keep_fd < 0)
+			die("cannot write keep file");
+		if (keep_msg_len > 0) {
+			write_or_die(keep_fd, keep_msg, keep_msg_len);
+			write_or_die(keep_fd, "\n", 1);
+		}
+		close(keep_fd);
+	}
+
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name) {
 			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
@@ -807,7 +825,8 @@ int main(int argc, char **argv)
 	int i, fix_thin_pack = 0;
 	const char *curr_pack, *pack_name = NULL;
 	const char *curr_index, *index_name = NULL;
-	char *index_name_buf = NULL;
+	const char *keep_name = NULL, *keep_msg = NULL;
+	char *index_name_buf = NULL, *keep_name_buf = NULL;
 	unsigned char sha1[20];
 
 	for (i = 1; i < argc; i++) {
@@ -818,6 +837,10 @@ int main(int argc, char **argv)
 				from_stdin = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
+			} else if (!strcmp(arg, "--keep")) {
+				keep_msg = "";
+			} else if (!strncmp(arg, "--keep=", 7)) {
+				keep_msg = arg + 7;
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "-o")) {
@@ -848,6 +871,16 @@ int main(int argc, char **argv)
 		strcpy(index_name_buf + len - 5, ".idx");
 		index_name = index_name_buf;
 	}
+	if (keep_msg && !keep_name && pack_name) {
+		int len = strlen(pack_name);
+		if (!has_extension(pack_name, ".pack"))
+			die("packfile name '%s' does not end with '.pack'",
+			    pack_name);
+		keep_name_buf = xmalloc(len);
+		memcpy(keep_name_buf, pack_name, len - 5);
+		strcpy(keep_name_buf + len - 5, ".keep");
+		keep_name = keep_name_buf;
+	}
 
 	curr_pack = open_pack_file(pack_name);
 	parse_pack_header();
@@ -880,9 +913,13 @@ int main(int argc, char **argv)
 	}
 	free(deltas);
 	curr_index = write_index_file(index_name, sha1);
-	final(pack_name, curr_pack, index_name, curr_index, sha1);
+	final(pack_name, curr_pack,
+		index_name, curr_index,
+		keep_name, keep_msg,
+		sha1);
 	free(objects);
 	free(index_name_buf);
+	free(keep_name_buf);
 
 	if (!from_stdin)
 		printf("%s\n", sha1_to_hex(sha1));
-- 
1.4.3.3.g7d63
