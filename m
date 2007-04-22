From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Cleanup variables in cat-file
Date: Sat, 21 Apr 2007 21:14:39 -0400
Message-ID: <20070422011439.GA2910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:15:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfQfR-0000MS-9h
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbXDVBOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbXDVBOo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:14:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36093 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbXDVBOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:14:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfQes-0002Lb-V2; Sat, 21 Apr 2007 21:14:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1016B20FBAE; Sat, 21 Apr 2007 21:14:39 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45201>

I want to add new command line options to cat-file, but
to do that we need to change how we handle argv[] first.
This is a simple cleanup that assigns names to the two
arguments we currently care about.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-cat-file.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index d61d3d5..f132d58 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -83,17 +83,21 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	void *buf;
 	unsigned long size;
 	int opt;
+	const char *exp_type, *obj_name;
 
 	git_config(git_default_config);
 	if (argc != 3)
 		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	if (get_sha1(argv[2], sha1))
-		die("Not a valid object name %s", argv[2]);
+	exp_type = argv[1];
+	obj_name = argv[2];
+
+	if (get_sha1(obj_name, sha1))
+		die("Not a valid object name %s", obj_name);
 
 	opt = 0;
-	if ( argv[1][0] == '-' ) {
-		opt = argv[1][1];
-		if ( !opt || argv[1][2] )
+	if ( exp_type[0] == '-' ) {
+		opt = exp_type[1];
+		if ( !opt || exp_type[2] )
 			opt = -1; /* Not a single character option */
 	}
 
@@ -121,15 +125,17 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	case 'p':
 		type = sha1_object_info(sha1, NULL);
 		if (type < 0)
-			die("Not a valid object name %s", argv[2]);
+			die("Not a valid object name %s", obj_name);
 
 		/* custom pretty-print here */
-		if (type == OBJ_TREE)
-			return cmd_ls_tree(2, argv + 1, NULL);
+		if (type == OBJ_TREE) {
+			const char *ls_args[3] = {"ls-tree", obj_name, NULL};
+			return cmd_ls_tree(2, ls_args, NULL);
+		}
 
 		buf = read_sha1_file(sha1, &type, &size);
 		if (!buf)
-			die("Cannot read object %s", argv[2]);
+			die("Cannot read object %s", obj_name);
 		if (type == OBJ_TAG) {
 			pprint_tag(sha1, buf, size);
 			return 0;
@@ -138,15 +144,15 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		/* otherwise just spit out the data */
 		break;
 	case 0:
-		buf = read_object_with_reference(sha1, argv[1], &size, NULL);
+		buf = read_object_with_reference(sha1, exp_type, &size, NULL);
 		break;
 
 	default:
-		die("git-cat-file: unknown option: %s\n", argv[1]);
+		die("git-cat-file: unknown option: %s\n", exp_type);
 	}
 
 	if (!buf)
-		die("git-cat-file %s: bad file", argv[2]);
+		die("git-cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
 	return 0;
-- 
1.5.1.1.135.gf948
