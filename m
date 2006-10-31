X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 2/2] Teach receive-pack how to keep pack files based on object count.
Date: Tue, 31 Oct 2006 02:57:04 -0500
Message-ID: <20061031075704.GB7691@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 07:57:46 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30574>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeoV3-00084u-3y for gcvg-git@gmane.org; Tue, 31 Oct
 2006 08:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422796AbWJaH5N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 02:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422794AbWJaH5N
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 02:57:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:13523 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422913AbWJaH5K
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 02:57:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GeoUb-00043U-4q; Tue, 31 Oct 2006 02:57:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A991320FB0C; Tue, 31 Oct 2006 02:57:04 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Since keeping a pushed pack or exploding it into loose objects
should be a local repository decision this teaches receive-pack
to decide if it should call unpack-objects or index-pack --stdin
--fix-thin based on the setting of receive.unpackLimit and the
number of objects contained in the received pack.

If the number of objects (hdr_entries) in the received pack is
below the value of receive.unpackLimit (which is 5000 by default)
then we unpack-objects as we have in the past.

If the hdr_entries >= receive.unpackLimit then we call index-pack and
ask it to include our pid and hostname in the .keep file to make it
easier to identify why a given pack has been kept in the repository.

Currently this leaves every received pack as a kept pack.  We really
don't want that as received packs will tend to be small.  Instead we
want to delete the .keep file automatically after all refs have
been updated.  That is being left as room for future improvement.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |   11 +++++++-
 cache.h                  |    1 +
 receive-pack.c           |   66 +++++++++++++++++++++++++++++++++++++++++++--
 sha1_file.c              |    2 +-
 4 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d9e73da..9d3c71c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -301,7 +301,16 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in gitlink:git-imap-send[1].
 
-receive.denyNonFastforwads::
+receive.unpackLimit::
+	If the number of objects received in a push is below this
+	limit then the objects will be unpacked into loose object
+	files. However if the number of received objects equals or
+	exceeds this limit then the received pack will be stored as
+	a pack, after adding any missing delta bases.  Storing the
+	pack from a push can make the push operation complete faster,
+	especially on slow filesystems.
+
+receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
 	not a fast forward. Use this to prevent such an update via a push,
 	even if that push is forced. This configuration variable is
diff --git a/cache.h b/cache.h
index e997a85..6cb7e1d 100644
--- a/cache.h
+++ b/cache.h
@@ -376,6 +376,7 @@ extern struct packed_git *parse_pack_ind
 						char *idx_path);
 
 extern void prepare_packed_git(void);
+extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
 
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1, 
diff --git a/receive-pack.c b/receive-pack.c
index 7e154c5..b394833 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "pack.h"
 #include "refs.h"
 #include "pkt-line.h"
 #include "run-command.h"
@@ -7,9 +8,8 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
-static const char *unpacker[] = { "unpack-objects", NULL };
-
 static int deny_non_fast_forwards = 0;
+static int unpack_limit = 5000;
 static int report_status;
 
 static char capabilities[] = "report-status";
@@ -25,6 +25,12 @@ static int receive_pack_config(const cha
 		return 0;
 	}
 
+	if (strcmp(var, "receive.unpacklimit") == 0)
+	{
+		unpack_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -227,9 +233,63 @@ static void read_head_info(void)
 	}
 }
 
+static const char *parse_pack_header(struct pack_header *hdr)
+{
+	char *c = (char*)hdr;
+	ssize_t remaining = sizeof(struct pack_header);
+	do {
+		ssize_t r = xread(0, c, remaining);
+		if (r <= 0)
+			return "eof before pack header was fully read";
+		remaining -= r;
+		c += r;
+	} while (remaining > 0);
+	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
+		return "protocol error (pack signature mismatch detected)";
+	if (!pack_version_ok(hdr->hdr_version))
+		return "protocol error (pack version unsupported)";
+	return NULL;
+}
+
 static const char *unpack()
 {
-	int code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
+	struct pack_header hdr;
+	const char *hdr_err;
+	char hdr_arg[38];
+	int code;
+
+	hdr_err = parse_pack_header(&hdr);
+	if (hdr_err)
+		return hdr_err;
+	snprintf(hdr_arg, sizeof(hdr_arg), "--pack_header=%u,%u",
+		ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
+
+	if (ntohl(hdr.hdr_entries) < unpack_limit) {
+		const char *unpacker[3];
+		unpacker[0] = "unpack-objects";
+		unpacker[1] = hdr_arg;
+		unpacker[2] = NULL;
+		code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
+	} else {
+		const char *keeper[6];
+		char my_host[255], keep_arg[128 + 255];
+
+		if (gethostname(my_host, sizeof(my_host)))
+			strcpy(my_host, "localhost");
+		snprintf(keep_arg, sizeof(keep_arg),
+			"--keep=receive-pack %i on %s",
+			getpid(), my_host);
+
+		keeper[0] = "index-pack";
+		keeper[1] = "--stdin";
+		keeper[2] = "--fix-thin";
+		keeper[3] = hdr_arg;
+		keeper[4] = keep_arg;
+		keeper[5] = NULL;
+		code = run_command_v_opt(1, keeper, RUN_GIT_CMD);
+		if (!code)
+			reprepare_packed_git();
+	}
 
 	switch (code) {
 	case 0:
diff --git a/sha1_file.c b/sha1_file.c
index 5e6c8b8..7bda2d4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -663,7 +663,7 @@ void prepare_packed_git(void)
 	prepare_packed_git_run_once = 1;
 }
 
-static void reprepare_packed_git(void)
+void reprepare_packed_git(void)
 {
 	prepare_packed_git_run_once = 0;
 	prepare_packed_git();
-- 
1.4.3.3.g7d63
