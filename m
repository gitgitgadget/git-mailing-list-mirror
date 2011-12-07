From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH, v5] git-tag: introduce --cleanup option
Date: Wed,  7 Dec 2011 05:01:45 +0200
Message-ID: <1323226905-31418-1-git-send-email-kirill@shutemov.name>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 04:02:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY7lm-0003j7-2q
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 04:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab1LGDCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 22:02:00 -0500
Received: from shutemov.name ([188.40.19.243]:52248 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898Ab1LGDB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 22:01:59 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 038C2114001; Wed,  7 Dec 2011 05:01:47 +0200 (EET)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186418>

From: "Kirill A. Shutemov" <kirill@shutemov.name>

Normally git tag strips tag message lines starting with '#', trailing
spaces from every line and empty lines from the beginning and end.

--cleanup allows to select different cleanup modes for tag message.
It provides the same interface as --cleanup option in git-commit.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 Documentation/git-tag.txt |    7 +++++
 builtin/tag.c             |   67 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c83cb13..622a019 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,6 +99,13 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+--cleanup=<mode>::
+	This option sets how the tag message is cleaned up.
+	The  '<mode>' can be one of 'verbatim', 'whitespace' and 'strip'.  The
+	'strip' mode is default. The 'verbatim' mode does not change message at
+	all, 'whitespace' removes just leading/trailing whitespace lines and
+	'strip' removes both whitespace and commentary.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..51a4184 100644
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
+	unsigned int message_given:1;
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
+	if (!opt->message_given) {
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
+	if (!opt->message_given && !buf->len)
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
+		OPT_STRING(0, "cleanup", &cleanup_arg, "mode",
+			"how to strip spaces and #comments from message"),
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
@@ -459,13 +486,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
+	memset(&opt, 0, sizeof(opt));
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
@@ -523,9 +552,19 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
+	opt.message_given = msg.given || msgfile;
+
+	if (!cleanup_arg || !strcmp(cleanup_arg, "strip"))
+		opt.cleanup_mode = CLEANUP_ALL;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		opt.cleanup_mode = CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		opt.cleanup_mode = CLEANUP_SPACE;
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
