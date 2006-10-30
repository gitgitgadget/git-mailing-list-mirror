X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Move deny_non_fast_forwards handling completely into receive-pack.
Date: Mon, 30 Oct 2006 17:35:18 -0500
Message-ID: <20061030223518.GF5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:37:27 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30538>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GefjG-0003ku-07 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422703AbWJ3WfX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWJ3WfX
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:35:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:62602 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422703AbWJ3WfV
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:35:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gefip-00089b-3L; Mon, 30 Oct 2006 17:35:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9AB9220FB0C; Mon, 30 Oct 2006 17:35:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The 'receive.denynonfastforwards' option has nothing to do with
the repository format version.  Since receive-pack already uses
git_config to initialize itself before executing any updates we
can use the normal configuration strategy and isolate the receive
specific variables away from the core variables.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h        |    1 -
 environment.c  |    1 -
 receive-pack.c |   16 +++++++++++++++-
 setup.c        |    2 --
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index a360528..e997a85 100644
--- a/cache.h
+++ b/cache.h
@@ -189,7 +189,6 @@ extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
-extern int deny_non_fast_forwards;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 
diff --git a/environment.c b/environment.c
index 63b1d15..84d870c 100644
--- a/environment.c
+++ b/environment.c
@@ -20,7 +20,6 @@ int warn_ambiguous_refs = 1;
 int repository_format_version;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
-int deny_non_fast_forwards = 0;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
diff --git a/receive-pack.c b/receive-pack.c
index f6f1729..e966148 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -12,12 +12,26 @@ static const char *keep_packer[] = {
 	"index-pack", "--stdin", "--fix-thin", NULL
 };
 
+static int deny_non_fast_forwards = 0;
 static int report_status;
 static int keep_pack;
 
 static char capabilities[] = "report-status keep-pack";
 static int capabilities_sent;
 
+static int receive_pack_config(const char *var, const char *value)
+{
+	git_default_config(var, value);
+
+	if (strcmp(var, "receive.denynonfastforwards") == 0)
+	{
+		deny_non_fast_forwards = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (capabilities_sent)
@@ -290,7 +304,7 @@ int main(int argc, char **argv)
 		die("'%s': unable to chdir or not a git archive", dir);
 
 	setup_ident();
-	git_config(git_default_config);
+	git_config(receive_pack_config);
 
 	write_head_info();
 
diff --git a/setup.c b/setup.c
index 9a46a58..2afdba4 100644
--- a/setup.c
+++ b/setup.c
@@ -244,8 +244,6 @@ int check_repository_format_version(cons
                repository_format_version = git_config_int(var, value);
 	else if (strcmp(var, "core.sharedrepository") == 0)
 		shared_repository = git_config_perm(var, value);
-	else if (strcmp(var, "receive.denynonfastforwards") == 0)
-		deny_non_fast_forwards = git_config_bool(var, value);
        return 0;
 }
 
-- 
1.4.3.3.g7d63
