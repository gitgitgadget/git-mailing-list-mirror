X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Remove unsupported C99 style struct initializers in git-archive.
Date: Sun, 5 Nov 2006 00:37:23 -0500
Message-ID: <20061105053723.GC4193@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 05:37:38 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30948>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgahF-0004Zh-MO for gcvg-git@gmane.org; Sun, 05 Nov
 2006 06:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161023AbWKEFh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 00:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWKEFh0
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 00:37:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47556 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161023AbWKEFh0
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 00:37:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgahA-0003cO-75; Sun, 05 Nov 2006 00:37:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 30D1220E491; Sun,  5 Nov 2006 00:37:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

At least one older version of the Solaris C compiler doesn't support
the newer C99 style struct initializers.  To allow Git to compile
on those systems use an archive description struct which is easier
to initialize without the C99 struct initializer syntax.

Also since the archives array is not used by anyone other than
archive.c we can make it static.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 archive.h         |    2 --
 builtin-archive.c |   23 ++++++++++++-----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/archive.h b/archive.h
index 16dcdb8..6838dc7 100644
--- a/archive.h
+++ b/archive.h
@@ -25,8 +25,6 @@ struct archiver {
 	parse_extra_args_fn_t parse_extra;
 };
 
-extern struct archiver archivers[];
-
 extern int parse_archive_args(int argc,
 			      const char **argv,
 			      struct archiver *ar);
diff --git a/builtin-archive.c b/builtin-archive.c
index 9177379..2df1a84 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -15,16 +15,14 @@
 static const char archive_usage[] = \
 "git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
 
-struct archiver archivers[] = {
-	{
-		.name		= "tar",
-		.write_archive	= write_tar_archive,
-	},
-	{
-		.name		= "zip",
-		.write_archive	= write_zip_archive,
-		.parse_extra	= parse_extra_zip_args,
-	},
+static struct archiver_desc
+{
+	const char *name;
+	write_archive_fn_t write_archive;
+	parse_extra_args_fn_t parse_extra;
+} archivers[] = {
+	{ "tar", write_tar_archive, NULL },
+	{ "zip", write_zip_archive, parse_extra_zip_args },
 };
 
 static int run_remote_archiver(const char *remote, int argc,
@@ -88,7 +86,10 @@ static int init_archiver(const char *nam
 
 	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
 		if (!strcmp(name, archivers[i].name)) {
-			memcpy(ar, &archivers[i], sizeof(struct archiver));
+			memset(ar, 0, sizeof(*ar));
+			ar->name = archivers[i].name;
+			ar->write_archive = archivers[i].write_archive;
+			ar->parse_extra = archivers[i].parse_extra;
 			rv = 0;
 			break;
 		}
-- 
