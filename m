From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 07/10] builtin/replace: teach listing using short, medium
 or long formats
Date: Sat, 28 Dec 2013 12:00:12 +0100
Message-ID: <20131228110016.2272.37189.chriscool@tuxfamily.org>
References: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 12:01:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwreD-0007rw-4r
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab3L1LBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:01:19 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33992 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755100Ab3L1LAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:00:50 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 54ACD63;
	Sat, 28 Dec 2013 12:00:49 +0100 (CET)
X-git-sha1: c503fb6483617887d1b70726d18d852b6e823175 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131228105505.2272.58873.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239775>

By default when listing replace refs, only the sha1 of the
replaced objects are shown.

In many cases, it is much nicer to be able to list all the
sha1 of the replaced objects along with the sha1 of the
replacment objects.

And in other cases it might be interesting to also show the
types of the replaced and replacement objects.

This patch introduce a new --format=<fmt> option where
<fmt> can be any of the following:

	'short': this is the same as when no --format
		option is used, that is only the sha1 of
		the replaced objects are shown
	'medium': this also lists the sha1 of the
		replacement objects
	'long': this shows the sha1 and the type of both
		the replaced and the replacement objects

Some documentation and some tests will follow.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index b1bd3ef..b93d204 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -16,27 +16,69 @@
 static const char * const git_replace_usage[] = {
 	N_("git replace [-f] <object> <replacement>"),
 	N_("git replace -d <object>..."),
-	N_("git replace -l [<pattern>]"),
+	N_("git replace [--format=<format>] [-l [<pattern>]]"),
 	NULL
 };
 
+enum replace_format {
+      REPLACE_FORMAT_SHORT,
+      REPLACE_FORMAT_MEDIUM,
+      REPLACE_FORMAT_LONG
+};
+
+struct show_data {
+	const char *pattern;
+	enum replace_format format;
+};
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
-	const char *pattern = cb_data;
+	struct show_data *data = cb_data;
+
+	if (!fnmatch(data->pattern, refname, 0)) {
+		if (data->format == REPLACE_FORMAT_SHORT)
+			printf("%s\n", refname);
+		else if (data->format == REPLACE_FORMAT_MEDIUM)
+			printf("%s -> %s\n", refname, sha1_to_hex(sha1));
+		else { /* data->format == REPLACE_FORMAT_LONG */
+			unsigned char object[20];
+			enum object_type obj_type, repl_type;
+
+			if (get_sha1(refname, object))
+				return error("Failed to resolve '%s' as a valid ref.", refname);
+
+			obj_type = sha1_object_info(object, NULL);
+			repl_type = sha1_object_info(sha1, NULL);
 
-	if (!fnmatch(pattern, refname, 0))
-		printf("%s\n", refname);
+			printf("%s (%s) -> %s (%s)\n", refname, typename(obj_type),
+			       sha1_to_hex(sha1), typename(repl_type));
+		}
+	}
 
 	return 0;
 }
 
-static int list_replace_refs(const char *pattern)
+static int list_replace_refs(const char *pattern, const char *format)
 {
+	struct show_data data;
+
 	if (pattern == NULL)
 		pattern = "*";
+	data.pattern = pattern;
+
+	if (format == NULL || *format == '\0' || !strcmp(format, "short"))
+		data.format = REPLACE_FORMAT_SHORT;
+	else if (!strcmp(format, "medium"))
+		data.format = REPLACE_FORMAT_MEDIUM;
+	else if (!strcmp(format, "long"))
+		data.format = REPLACE_FORMAT_LONG;
+	else
+		die("invalid replace format '%s'\n"
+		    "valid formats are 'short', 'medium' and 'long'\n",
+		    format);
 
-	for_each_replace_ref(show_reference, (void *) pattern);
+	for_each_replace_ref(show_reference, (void *) &data);
 
 	return 0;
 }
@@ -127,10 +169,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int list = 0, delete = 0, force = 0;
+	const char *format = NULL;
 	struct option options[] = {
 		OPT_BOOL('l', "list", &list, N_("list replace refs")),
 		OPT_BOOL('d', "delete", &delete, N_("delete replace refs")),
 		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
+		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
 	};
 
@@ -140,6 +184,10 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		usage_msg_opt("-l and -d cannot be used together",
 			      git_replace_usage, options);
 
+	if (format && delete)
+		usage_msg_opt("--format and -d cannot be used together",
+			      git_replace_usage, options);
+
 	if (force && (list || delete))
 		usage_msg_opt("-f cannot be used with -d or -l",
 			      git_replace_usage, options);
@@ -157,6 +205,9 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			usage_msg_opt("bad number of arguments",
 				      git_replace_usage, options);
+		if (format)
+			usage_msg_opt("--format cannot be used when not listing",
+				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 	}
 
@@ -168,5 +219,5 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		usage_msg_opt("-f needs some arguments",
 			      git_replace_usage, options);
 
-	return list_replace_refs(argv[0]);
+	return list_replace_refs(argv[0], format);
 }
-- 
1.8.4.1.616.g07f5c81
