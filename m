From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH, v4] git-tag: introduce --cleanup option
Date: Sun,  4 Dec 2011 06:20:26 +0200
Message-ID: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 05:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RX3ZO-0005Qk-7t
	for gcvg-git-2@lo.gmane.org; Sun, 04 Dec 2011 05:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab1LDEUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 23:20:36 -0500
Received: from shutemov.name ([188.40.19.243]:52184 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab1LDEUg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 23:20:36 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 36426114001; Sun,  4 Dec 2011 06:20:35 +0200 (EET)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186264>

From: "Kirill A. Shutemov" <kirill@shutemov.name>

Normally git tag stripes tag message lines starting with '#', trailing
spaces from every line and empty lines from the beginning and end.

--cleanup allows to select different cleanup modes for tag message.
It provides the same interface as --cleanup option in git-commit.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 Documentation/git-tag.txt |   10 ++++++
 builtin/tag.c             |   69 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 65 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c83cb13..c2d73f3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,6 +99,16 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+--cleanup=<mode>::
+	This option sets how the tag message is cleaned up.
+	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
+	and 'default'. The 'default' mode will strip leading and
+	trailing empty lines and #commentary from the tag message
+	only if the message is to be edited. Otherwise only whitespace
+	removed. The 'verbatim' mode does not change message at all,
+	'whitespace' removes just leading/trailing whitespace lines
+	and 'strip' removes both whitespace and commentary.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..27a66a3 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -268,6 +268,15 @@ static const char tag_template[] =
 	N_("\n"
 	"#\n"
 	"# Write a tag message\n"
+	"# Lines starting with '#' will be ignored.\n"
+	"#\n");
+
+static const char tag_template_nocleanup[] =
+	N_("\n"
+	"#\n"
+	"# Write a tag message\n"
+	"# Lines starting with '#' will be kept; you may remove them"
+	" yourself if you want to.\n"
 	"#\n");
 
 static void set_signingkey(const char *value)
@@ -319,8 +328,18 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 	return 0;
 }
 
+struct create_tag_options {
+	unsigned int message;
+	unsigned int sign;
+	enum {
+		CLEANUP_NONE,
+		CLEANUP_SPACE,
+		CLEANUP_ALL
+	} cleanup_mode;
+};
+
 static void create_tag(const unsigned char *object, const char *tag,
-		       struct strbuf *buf, int message, int sign,
+		       struct strbuf *buf, struct create_tag_options *opt,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
@@ -345,7 +364,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (header_len > sizeof(header_buf) - 1)
 		die(_("tag header too big."));
 
-	if (!message) {
+	if (!opt->message) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -356,8 +375,12 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
+		else if (opt->cleanup_mode == CLEANUP_ALL)
+			write_or_die(fd, _(tag_template),
+					strlen(_(tag_template)));
 		else
-			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
+			write_or_die(fd, _(tag_template_nocleanup),
+					strlen(_(tag_template_nocleanup)));
 		close(fd);
 
 		if (launch_editor(path, buf, NULL)) {
@@ -367,14 +390,15 @@ static void create_tag(const unsigned char *object, const char *tag,
 		}
 	}
 
-	stripspace(buf, 1);
+	if (opt->cleanup_mode != CLEANUP_NONE)
+		stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
 
-	if (!message && !buf->len)
+	if (opt->message && !buf->len)
 		die(_("no tag message?"));
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (build_tag_object(buf, sign, result) < 0) {
+	if (build_tag_object(buf, opt->sign, result) < 0) {
 		if (path)
 			fprintf(stderr, _("The tag message has been left in %s\n"),
 				path);
@@ -422,9 +446,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
-
-	int annotate = 0, sign = 0, force = 0, lines = -1,
-		list = 0, delete = 0, verify = 0;
+	struct create_tag_options opt;
+	char *cleanup_arg = NULL;
+	int annotate = 0, force = 0, lines = -1, list = 0,
+	    delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -442,7 +467,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &msg, "message",
 			     "tag message", parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
-		OPT_BOOLEAN('s', "sign", &sign, "annotated and GPG-signed tag"),
+		OPT_BOOLEAN('s', "sign", &opt.sign, "annotated and GPG-signed tag"),
+		OPT_STRING(0, "cleanup", &cleanup_arg, "default",
+			"how to strip spaces and #comments from message"),
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
@@ -459,13 +486,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
+	opt.sign = 0;
+
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
 	if (keyid) {
-		sign = 1;
+		opt.sign = 1;
 		set_signingkey(keyid);
 	}
-	if (sign)
+	if (opt.sign)
 		annotate = 1;
 	if (argc == 0 && !(delete || verify))
 		list = 1;
@@ -523,9 +552,21 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
+	opt.message = msg.given || msgfile;
+
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		opt.cleanup_mode = !opt.message ? CLEANUP_ALL : CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		opt.cleanup_mode = CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		opt.cleanup_mode = CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		opt.cleanup_mode = CLEANUP_ALL;
+	else
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
+
 	if (annotate)
-		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+		create_tag(object, tag, &buf, &opt, prev, object);
 
 	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-- 
1.7.7.3
