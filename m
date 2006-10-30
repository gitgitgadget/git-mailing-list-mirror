X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Mon, 30 Oct 2006 17:36:15 -0500
Message-ID: <20061030223615.GH5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:37:53 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30540>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gefjz-0003vK-R2 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422710AbWJ3WgU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422712AbWJ3WgU
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:36:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:11915 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422710AbWJ3WgT
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:36:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gefjk-0008HH-C3; Mon, 30 Oct 2006 17:36:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E23B320FB0C; Mon, 30 Oct 2006 17:36:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Since keeping a pushed pack or exploding it into loose objects should
be a local repository decision this teaches receive-pack to decide
if it should call unpack-objects or index-pack --stdin --fix-thin
based on the setting of receive.unpackLooseObjects.

If receive.unpackLooseObjects is true (which it is by default for
now) then we unpack-objects as we have in the past.

If it is false then we call index-pack and ask it to include our
pid and hostname in the .keep file to make it easier to identify
why a given pack has been kept in the repository.

Currently this leaves every received pack as a kept pack.  We really
don't want that as received packs will tend to be small.  Instead we
want to delete the .keep file automatically after all refs have
been updated.  That is being left as room for future improvement.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    9 ++++++++-
 cache.h                  |    1 +
 receive-pack.c           |   35 ++++++++++++++++++++++++++++++++---
 sha1_file.c              |    2 +-
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d9e73da..4eab9e8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -301,7 +301,14 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in gitlink:git-imap-send[1].
 
-receive.denyNonFastforwads::
+receive.unpackLooseObjects::
+	If set to true, git-receive-pack will unpack each received
+	object into a loose object in the repository.  If set to
+	false then the received pack file will be kept as is (but
+	may have delta bases appended onto the end).  Large pushes
+	into a repository will generally go faster if this is false.
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
index 7e154c5..6e377f0 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -7,9 +7,8 @@
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
-static const char *unpacker[] = { "unpack-objects", NULL };
-
 static int deny_non_fast_forwards = 0;
+static int unpack_loose_objects = 1;
 static int report_status;
 
 static char capabilities[] = "report-status";
@@ -25,6 +24,12 @@ static int receive_pack_config(const cha
 		return 0;
 	}
 
+	if (strcmp(var, "receive.unpacklooseobjects") == 0)
+	{
+		unpack_loose_objects = git_config_bool(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -229,7 +234,31 @@ static void read_head_info(void)
 
 static const char *unpack()
 {
-	int code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
+	static const char *unpacker[] = { "unpack-objects", NULL };
+	int code;
+	
+	if (unpack_loose_objects)
+		code = run_command_v_opt(1, unpacker, RUN_GIT_CMD);
+	else {
+		const char *keeper[5], *why_kept;
+		char my_host[255], keep_arg[128 + 255];
+
+		if (gethostname(my_host, sizeof(my_host)))
+			strcpy(my_host, "localhost");
+		snprintf(keep_arg, sizeof(keep_why),
+			"--keep=receive-pack %i on %s",
+			getpid(), my_host);
+		why_kept = keep_arg + 7;
+
+		keeper[0] = "index-pack";
+		keeper[1] = "--stdin";
+		keeper[2] = "--fix-thin";
+		keeper[3] = keep_arg;
+		keeper[4] = NULL;
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
