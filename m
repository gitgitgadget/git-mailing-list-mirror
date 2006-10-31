X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 1/2] Allow pack header preprocessing before unpack-objects/index-pack.
Date: Tue, 31 Oct 2006 02:56:29 -0500
Message-ID: <20061031075629.GA7691@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 07:56:48 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30573>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeoUD-0007we-Pu for gcvg-git@gmane.org; Tue, 31 Oct
 2006 08:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422773AbWJaH4i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 02:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422912AbWJaH4i
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 02:56:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:10451 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422773AbWJaH4h
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 02:56:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GeoU3-00042e-4V; Tue, 31 Oct 2006 02:56:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 21AFC20FB0C; Tue, 31 Oct 2006 02:56:30 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Some applications which invoke unpack-objects or index-pack --stdin
may want to examine the pack header to determine the number of
objects contained in the pack and use that value to determine which
executable to invoke to handle the rest of the pack stream.

However if the caller consumes the pack header from the input stream
then its no longer available for unpack-objects or index-pack --stdin,
both of which need the version and object count to process the stream.

This change introduces --pack_header=ver,cnt as a command line option
that the caller can supply to indicate it has already consumed the
pack header and what version and object count were found in that
header.  As this option is only meant for low level applications
such as receive-pack we are not documenting it at this time.

Credit goes to Nicolas Pitre for suggesting this approach on the
git mailing list.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 This series of two patches replaces my last receive-pack (3/3)
 patch.

 builtin-unpack-objects.c |   31 +++++++++++++++++++++++++------
 index-pack.c             |   30 +++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index e70a711..a5cfd0b 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -326,11 +326,16 @@ static void unpack_one(unsigned nr, unsi
 	}
 }
 
-static void unpack_all(void)
+static void unpack_all(struct pack_header *hdr)
 {
 	int i;
-	struct pack_header *hdr = fill(sizeof(struct pack_header));
-	unsigned nr_objects = ntohl(hdr->hdr_entries);
+	unsigned nr_objects;
+
+	if (!hdr) {
+		hdr = fill(sizeof(struct pack_header));
+		use(sizeof(struct pack_header));
+	}
+	nr_objects = ntohl(hdr->hdr_entries);
 
 	if (ntohl(hdr->hdr_signature) != PACK_SIGNATURE)
 		die("bad pack file");
@@ -339,7 +344,6 @@ static void unpack_all(void)
 	fprintf(stderr, "Unpacking %d objects\n", nr_objects);
 
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
-	use(sizeof(struct pack_header));
 	for (i = 0; i < nr_objects; i++)
 		unpack_one(i, nr_objects);
 	if (delta_list)
@@ -348,7 +352,8 @@ static void unpack_all(void)
 
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	int i, have_hdr = 0;
+	struct pack_header hdr;
 	unsigned char sha1[20];
 
 	git_config(git_default_config);
@@ -371,6 +376,18 @@ int cmd_unpack_objects(int argc, const c
 				recover = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--pack_header=", 14)) {
+				char *c;
+				hdr.hdr_signature = htonl(PACK_SIGNATURE);
+				hdr.hdr_version = htonl(strtoul(arg + 14, &c, 10));
+				if (*c != ',')
+					die("bad %s", arg);
+				hdr.hdr_entries = htonl(strtoul(c + 1, &c, 10));
+				if (*c)
+					die("bad %s", arg);
+				have_hdr = 1;
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
@@ -378,7 +395,9 @@ int cmd_unpack_objects(int argc, const c
 		usage(unpack_usage);
 	}
 	SHA1_Init(&ctx);
-	unpack_all();
+	if (have_hdr)
+		SHA1_Update(&ctx, &hdr, sizeof(struct pack_header));
+	unpack_all(have_hdr ? &hdr : NULL);
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(fill(20), sha1))
diff --git a/index-pack.c b/index-pack.c
index b37dd78..1911df8 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -161,9 +161,12 @@ static const char *open_pack_file(const
 	return pack_name;
 }
 
-static void parse_pack_header(void)
+static void parse_pack_header(struct pack_header *hdr)
 {
-	struct pack_header *hdr = fill(sizeof(struct pack_header));
+	if (!hdr) {
+		hdr = fill(sizeof(struct pack_header));
+		use(sizeof(struct pack_header));
+	}
 
 	/* Header consistency check */
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
@@ -172,7 +175,6 @@ static void parse_pack_header(void)
 		die("pack version %d unsupported", ntohl(hdr->hdr_version));
 
 	nr_objects = ntohl(hdr->hdr_entries);
-	use(sizeof(struct pack_header));
 }
 
 static void bad_object(unsigned long offset, const char *format,
@@ -822,11 +824,12 @@ static void final(const char *final_pack
 
 int main(int argc, char **argv)
 {
-	int i, fix_thin_pack = 0;
+	int i, fix_thin_pack = 0, have_hdr = 0;
 	const char *curr_pack, *pack_name = NULL;
 	const char *curr_index, *index_name = NULL;
 	const char *keep_name = NULL, *keep_msg = NULL;
 	char *index_name_buf = NULL, *keep_name_buf = NULL;
+	struct pack_header hdr;
 	unsigned char sha1[20];
 
 	for (i = 1; i < argc; i++) {
@@ -841,6 +844,16 @@ int main(int argc, char **argv)
 				keep_msg = "";
 			} else if (!strncmp(arg, "--keep=", 7)) {
 				keep_msg = arg + 7;
+			} else if (!strncmp(arg, "--pack_header=", 14)) {
+				char *c;
+				hdr.hdr_signature = htonl(PACK_SIGNATURE);
+				hdr.hdr_version = htonl(strtoul(arg + 14, &c, 10));
+				if (*c != ',')
+					die("bad %s", arg);
+				hdr.hdr_entries = htonl(strtoul(c + 1, &c, 10));
+				if (*c)
+					die("bad %s", arg);
+				have_hdr = 1;
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "-o")) {
@@ -861,6 +874,8 @@ int main(int argc, char **argv)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die("--fix-thin cannot be used without --stdin");
+	if (have_hdr && !from_stdin)
+		die("--pack_header cannot be used without --stdin");
 	if (!index_name && pack_name) {
 		int len = strlen(pack_name);
 		if (!has_extension(pack_name, ".pack"))
@@ -883,7 +898,12 @@ int main(int argc, char **argv)
 	}
 
 	curr_pack = open_pack_file(pack_name);
-	parse_pack_header();
+	if (have_hdr) {
+		if (output_fd >= 0)
+			write_or_die(output_fd, &hdr, sizeof(struct pack_header));
+		SHA1_Update(&input_ctx, &hdr, sizeof(struct pack_header));
+	}
+	parse_pack_header(have_hdr ? &hdr : NULL);
 	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
 	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
 	if (verbose)
-- 
1.4.3.3.g7d63
