From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/3] Teach cat-file a --quiet option
Date: Sat, 21 Apr 2007 21:14:47 -0400
Message-ID: <20070422011447.GC2910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfQfb-0000QE-61
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbXDVBPH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753931AbXDVBPH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:15:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36102 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbXDVBOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:14:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfQez-0002MC-NA; Sat, 21 Apr 2007 21:14:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2BE2B20FBAE; Sat, 21 Apr 2007 21:14:47 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45203>

Sometimes when you get the content of a file in a script you don't
want an error message for missing files; instead its OK to treat
a missing file the same as one whose content was empty.

This is especially true if the script is using something like
`cat-file blob HEAD:path/to/file` to look at an optional file's
content.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-cat-file.txt |    4 ++++
 builtin-cat-file.c             |   26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 075c0d0..f6edb1a 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -46,6 +46,10 @@ OPTIONS
 	or to ask for a "blob" with <object> being a tag object that
 	points at it.
 
+--quiet::
+	Don't print an error message if the object doesn't exist;
+	instead exit with non-zero status like -e.
+
 OUTPUT
 ------
 If '-t' is specified, one of the <type>.
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index b2437fe..8807a61 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -82,13 +82,15 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	enum object_type type;
 	void *buf;
 	unsigned long size;
-	int opt = 0, i;
+	int opt = 0, quiet = 0, i;
 	const char *exp_type = NULL, *obj_name = NULL;
 
 	git_config(git_default_config);
 	for (i = 1; i < argc; i++) {
 		const char *a = argv[i];
-		if (!opt && a[0] == '-' && a[1])
+		if (!strcmp(a, "--quiet"))
+			quiet = 1;
+		else if (!opt && a[0] == '-' && a[1])
 			opt = a[1];
 		else if (!opt && !exp_type)
 			exp_type = a;
@@ -99,8 +101,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	}
 	if (!obj_name)
 		usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
-	if (get_sha1(obj_name, sha1))
+	if (get_sha1(obj_name, sha1)) {
+		if (quiet || opt == 'e')
+			return 1;
 		die("Not a valid object name %s", obj_name);
+	}
 
 	buf = NULL;
 	switch (opt) {
@@ -125,8 +130,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	case 'p':
 		type = sha1_object_info(sha1, NULL);
-		if (type < 0)
+		if (type < 0) {
+			if (quiet)
+				return 1;
 			die("Not a valid object name %s", obj_name);
+		}
 
 		/* custom pretty-print here */
 		if (type == OBJ_TREE) {
@@ -135,8 +143,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		}
 
 		buf = read_sha1_file(sha1, &type, &size);
-		if (!buf)
+		if (!buf) {
+			if (quiet)
+				return 1;
 			die("Cannot read object %s", obj_name);
+		}
 		if (type == OBJ_TAG) {
 			pprint_tag(sha1, buf, size);
 			return 0;
@@ -152,8 +163,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		die("git-cat-file: unknown option: %s\n", exp_type);
 	}
 
-	if (!buf)
+	if (!buf) {
+		if (quiet)
+			return 1;
 		die("git-cat-file %s: bad file", obj_name);
+	}
 
 	write_or_die(1, buf, size);
 	return 0;
-- 
1.5.1.1.135.gf948
