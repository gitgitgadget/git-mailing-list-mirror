From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2 2/3] Teach fetch-pack/upload-pack about --auto-include-tag
Date: Mon, 3 Mar 2008 22:27:33 -0500
Message-ID: <20080304032733.GB16462@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNpE-0001CL-Rt
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932AbYCDD1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757748AbYCDD1h
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:27:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43050 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757329AbYCDD1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:27:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWNoI-0007iw-RY; Mon, 03 Mar 2008 22:27:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 86A6520FBAE; Mon,  3 Mar 2008 22:27:33 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76028>

The new protocol extension "auto-include-tag" allows the client side
of the connection (fetch-pack) to request that the server side of the
native git protocol (upload-pack / pack-objects) use --auto-include-tag
as it prepares the packfile, thus ensuring that an annotated tag object
will be included in the resulting packfile if the object it refers to
was also included into the packfile.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fetch-pack.txt |    8 +++++++-
 builtin-fetch-pack.c             |    9 +++++++--
 fetch-pack.h                     |    3 ++-
 upload-pack.c                    |   10 ++++++++--
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 2b8ffe5..4f85898 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -8,7 +8,7 @@ git-fetch-pack - Receive missing objects from another repository
 
 SYNOPSIS
 --------
-'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
+'git-fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--auto-include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -45,6 +45,12 @@ OPTIONS
 	Spend extra cycles to minimize the number of objects to be sent.
 	Use it on slower connection.
 
+\--auto-include-tag::
+	If the remote side supports it, annotated tags objects will
+	be downloaded on the same connection as the other objects if
+	the object the tag references is downloaded.  The caller must
+	otherwise determine the tags this option made available.
+
 \--upload-pack=<git-upload-pack>::
 	Use this to specify the path to 'git-upload-pack' on the
 	remote side, if is not found on your $PATH.
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index b23e886..3701ee0 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -18,7 +18,7 @@ static struct fetch_pack_args args = {
 };
 
 static const char fetch_pack_usage[] =
-"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--auto-include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -174,13 +174,14 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 		}
 
 		if (!fetching)
-			packet_write(fd[1], "want %s%s%s%s%s%s%s\n",
+			packet_write(fd[1], "want %s%s%s%s%s%s%s%s\n",
 				     sha1_to_hex(remote),
 				     (multi_ack ? " multi_ack" : ""),
 				     (use_sideband == 2 ? " side-band-64k" : ""),
 				     (use_sideband == 1 ? " side-band" : ""),
 				     (args.use_thin_pack ? " thin-pack" : ""),
 				     (args.no_progress ? " no-progress" : ""),
+				     (args.auto_include_tag ? " auto-include-tag" : ""),
 				     " ofs-delta");
 		else
 			packet_write(fd[1], "want %s\n", sha1_to_hex(remote));
@@ -680,6 +681,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.use_thin_pack = 1;
 				continue;
 			}
+			if (!strcmp("--auto-include-tag", arg)) {
+				args.auto_include_tag = 1;
+				continue;
+			}
 			if (!strcmp("--all", arg)) {
 				args.fetch_all = 1;
 				continue;
diff --git a/fetch-pack.h b/fetch-pack.h
index 8d35ef6..98d6a39 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -12,7 +12,8 @@ struct fetch_pack_args
 		use_thin_pack:1,
 		fetch_all:1,
 		verbose:1,
-		no_progress:1;
+		no_progress:1,
+		auto_include_tag:1;
 };
 
 struct ref *fetch_pack(struct fetch_pack_args *args,
diff --git a/upload-pack.c b/upload-pack.c
index 660134a..f9ffe09 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -27,7 +27,8 @@ static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=n
 static unsigned long oldest_have;
 
 static int multi_ack, nr_our_refs;
-static int use_thin_pack, use_ofs_delta, no_progress;
+static int use_thin_pack, use_ofs_delta, use_auto_include_tag;
+static int no_progress;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static unsigned int timeout;
@@ -162,6 +163,8 @@ static void create_pack_file(void)
 		argv[arg++] = "--progress";
 	if (use_ofs_delta)
 		argv[arg++] = "--delta-base-offset";
+	if (use_auto_include_tag)
+		argv[arg++] = "--auto-include-tag";
 	argv[arg++] = NULL;
 
 	memset(&pack_objects, 0, sizeof(pack_objects));
@@ -494,6 +497,8 @@ static void receive_needs(void)
 			use_sideband = DEFAULT_PACKET_MAX;
 		if (strstr(line+45, "no-progress"))
 			no_progress = 1;
+		if (strstr(line+45, "auto-include-tag"))
+			use_auto_include_tag = 1;
 
 		/* We have sent all our refs already, and the other end
 		 * should have chosen out of them; otherwise they are
@@ -565,7 +570,8 @@ static void receive_needs(void)
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
-		" side-band-64k ofs-delta shallow no-progress";
+		" side-band-64k ofs-delta shallow no-progress"
+		" auto-include-tag";
 	struct object *o = parse_object(sha1);
 
 	if (!o)
-- 
1.5.4.3.529.gb25fb

