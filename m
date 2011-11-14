From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH, v2] tag: implement --[no-]strip option
Date: Mon, 14 Nov 2011 23:43:39 +0200
Message-ID: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 22:43:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ4Jn-0003bj-8h
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 22:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab1KNVno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 16:43:44 -0500
Received: from shutemov.name ([188.40.19.243]:34206 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009Ab1KNVnm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 16:43:42 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 4B928114001; Mon, 14 Nov 2011 23:43:41 +0200 (EET)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185405>

From: "Kirill A. Shutemov" <kirill@shutemov.name>

--strip::
	Remove from tag message lines staring with '#', trailing spaces
	from every line and empty lines from the beginning and end.
	Enabled by default. Use --no-strip to overwrite the behaviour.

--no-strip is useful if you want to take a tag message as-is, without
any stripping.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 Documentation/git-tag.txt |    5 +++++
 builtin/tag.c             |   41 ++++++++++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c83cb13..dbb76a6 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,6 +99,11 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+--strip::
+	Remove from tag message lines staring with '#', trailing spaces
+	from every line and empty lines from the beginning and end.
+	Enabled by default. Use --no-strip to overwrite the behaviour.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..05a1fd4 100644
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
@@ -423,8 +430,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
 
-	int annotate = 0, sign = 0, force = 0, lines = -1,
-		list = 0, delete = 0, verify = 0;
+	struct create_tag_options opt = {
+		.sign = 0,
+		.strip = 1,
+	};
+
+	int annotate = 0, force = 0, lines = -1, list = 0,
+	    delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -442,7 +454,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
@@ -462,10 +476,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
@@ -523,9 +537,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
1.7.7.2
