From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH, v3] git-tag: introduce --[no-]strip options
Date: Sat,  3 Dec 2011 19:12:56 +0200
Message-ID: <1322932376-15720-1-git-send-email-kirill@shutemov.name>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 18:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWt9G-0003jx-Ny
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 18:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab1LCRNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 12:13:08 -0500
Received: from shutemov.name ([188.40.19.243]:44365 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab1LCRNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 12:13:05 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 91F95114001; Sat,  3 Dec 2011 19:13:03 +0200 (EET)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186255>

From: "Kirill A. Shutemov" <kirill@shutemov.name>

Normally git tag stripes tag message lines starting with '#', trailing
spaces from every line and empty lines from the beginning and end.

--no-strip is useful if you want to take a tag message as-is, without
any stripping.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 Documentation/git-tag.txt |    6 ++++++
 builtin/tag.c             |   41 +++++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c83cb13..31463ca 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,6 +99,12 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+--strip::
+	Remove from tag message lines starting with '#', trailing spaces from
+	every line and empty lines from the beginning and end.  Enabled by
+	default. With `--no-strip`, the tag message given by the user is used
+	as-is.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..d82774d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -319,8 +319,14 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 	return 0;
 }
 
+struct create_tag_options {
+	unsigned int message;
+	unsigned int sign;
+	unsigned int strip;
+};
+
 static void create_tag(const unsigned char *object, const char *tag,
-		       struct strbuf *buf, int message, int sign,
+		       struct strbuf *buf, struct create_tag_options *opt,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
@@ -345,7 +351,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (header_len > sizeof(header_buf) - 1)
 		die(_("tag header too big."));
 
-	if (!message) {
+	if (!opt->message) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -356,7 +362,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
-		else
+		else if (opt->strip)
 			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
 		close(fd);
 
@@ -367,14 +373,15 @@ static void create_tag(const unsigned char *object, const char *tag,
 		}
 	}
 
-	stripspace(buf, 1);
+	if (opt->strip)
+		stripspace(buf, 1);
 
-	if (!message && !buf->len)
+	if (opt->message && !buf->len)
 		die(_("no tag message?"));
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (build_tag_object(buf, sign, result) < 0) {
+	if (build_tag_object(buf, opt->sign, result) < 0) {
 		if (path)
 			fprintf(stderr, _("The tag message has been left in %s\n"),
 				path);
@@ -422,9 +429,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
-
-	int annotate = 0, sign = 0, force = 0, lines = -1,
-		list = 0, delete = 0, verify = 0;
+	struct create_tag_options opt;
+	int annotate = 0, force = 0, lines = -1, list = 0,
+	    delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -442,7 +449,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &msg, "message",
 			     "tag message", parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
-		OPT_BOOLEAN('s', "sign", &sign, "annotated and GPG-signed tag"),
+		OPT_BOOLEAN('s', "sign", &opt.sign, "annotated and GPG-signed tag"),
+		OPT_BOOLEAN(0, "strip", &opt.strip,
+					"turn off tag message stripping"),
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
@@ -459,13 +468,16 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
+	opt.sign = 0;
+	opt.strip = 1;
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
@@ -523,9 +535,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
+	opt.message = msg.given || msgfile;
+
 	if (annotate)
-		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+		create_tag(object, tag, &buf, &opt, prev, object);
 
 	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-- 
1.7.7.3
