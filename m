From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 02/10] replace: use OPT_CMDMODE to handle modes
Date: Sat, 17 May 2014 14:16:31 +0200
Message-ID: <20140517121640.27582.24061.chriscool@tuxfamily.org>
References: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlgzh-0001TK-NF
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbaEQP5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:57:42 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:44481 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757411AbaEQP5j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:57:39 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 3CFE231;
	Sat, 17 May 2014 17:57:37 +0200 (CEST)
X-git-sha1: 127898c998b32ee8bbee52df3cff26de477f79e0 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249477>

From: Jeff King <peff@peff.net>

By using OPT_CMDMODE, the mutual exclusion between modes is
taken care of for us. It also makes it easy for us to
maintain a single variable with the mode, which makes its
intent more clear. We can use a single switch() to make sure
we have covered all of the modes.

This ends up breaking even in code size, but the win will be
much bigger when we start adding more modes.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 28db96f..29cf699 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -168,11 +168,17 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
-	int list = 0, delete = 0, force = 0;
+	int force = 0;
 	const char *format = NULL;
+	enum {
+		MODE_UNSPECIFIED = 0,
+		MODE_LIST,
+		MODE_DELETE,
+		MODE_REPLACE
+	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
-		OPT_BOOL('l', "list", &list, N_("list replace refs")),
-		OPT_BOOL('d', "delete", &delete, N_("delete replace refs")),
+		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
+		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
@@ -182,42 +188,37 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
-	if (!list && !delete)
-		if (!argc)
-			list = 1;
+	if (!cmdmode)
+		cmdmode = argc ? MODE_REPLACE : MODE_LIST;
 
-	if (list && delete)
-		usage_msg_opt("-l and -d cannot be used together",
-			      git_replace_usage, options);
-
-	if (format && !list)
+	if (format && cmdmode != MODE_LIST)
 		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
-	if (force && (list || delete))
-		usage_msg_opt("-f cannot be used with -d or -l",
+	if (force && cmdmode != MODE_REPLACE)
+		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
-	/* Delete refs */
-	if (delete) {
+	switch (cmdmode) {
+	case MODE_DELETE:
 		if (argc < 1)
 			usage_msg_opt("-d needs at least one argument",
 				      git_replace_usage, options);
 		return for_each_replace_name(argv, delete_replace_ref);
-	}
 
-	/* Replace object */
-	if (!list && argc) {
+	case MODE_REPLACE:
 		if (argc != 2)
 			usage_msg_opt("bad number of arguments",
 				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
-	}
 
-	/* List refs, even if "list" is not set */
-	if (argc > 1)
-		usage_msg_opt("only one pattern can be given with -l",
-			      git_replace_usage, options);
+	case MODE_LIST:
+		if (argc > 1)
+			usage_msg_opt("only one pattern can be given with -l",
+				      git_replace_usage, options);
+		return list_replace_refs(argv[0], format);
 
-	return list_replace_refs(argv[0], format);
+	default:
+		die("BUG: invalid cmdmode %d", (int)cmdmode);
+	}
 }
-- 
1.9.rc0.17.g651113e
