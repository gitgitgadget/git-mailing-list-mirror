From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH] tag: implement --no-strip option
Date: Mon, 14 Nov 2011 13:08:22 +0200
Message-ID: <1321268902-2170-1-git-send-email-kirill@shutemov.name>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 12:08:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPuOz-0002H8-Dg
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 12:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab1KNLI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 06:08:27 -0500
Received: from shutemov.name ([188.40.19.243]:55496 "EHLO shutemov.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755108Ab1KNLI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 06:08:26 -0500
Received: by shutemov.name (Postfix, from userid 500)
	id 2F0B0114001; Mon, 14 Nov 2011 13:08:25 +0200 (EET)
X-Mailer: git-send-email 1.7.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185375>

From: "Kirill A. Shutemov" <kirill@shutemov.name>

--no-strip turns off strip any comments or empty lines.

It's useful if you want to take a tag message as-is, without any
stripping.

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
---
 Documentation/git-tag.txt |    4 ++++
 builtin/tag.c             |   13 ++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c83cb13..947d4e5 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -99,6 +99,10 @@ OPTIONS
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
+-S::
+--no-strip::
+	Take tag message as-is. Do not strip any comments or empty lines.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..427d646 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -320,7 +320,7 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 }
 
 static void create_tag(const unsigned char *object, const char *tag,
-		       struct strbuf *buf, int message, int sign,
+		       struct strbuf *buf, int message, int sign, int nostrip,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
@@ -356,7 +356,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
-		else
+		else if (!nostrip)
 			write_or_die(fd, _(tag_template), strlen(_(tag_template)));
 		close(fd);
 
@@ -367,7 +367,8 @@ static void create_tag(const unsigned char *object, const char *tag,
 		}
 	}
 
-	stripspace(buf, 1);
+	if (!nostrip)
+		stripspace(buf, 1);
 
 	if (!message && !buf->len)
 		die(_("no tag message?"));
@@ -423,7 +424,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
 
-	int annotate = 0, sign = 0, force = 0, lines = -1,
+	int annotate = 0, sign = 0, nostrip = 0, force = 0, lines = -1,
 		list = 0, delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -443,6 +444,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			     "tag message", parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
 		OPT_BOOLEAN('s', "sign", &sign, "annotated and GPG-signed tag"),
+		OPT_BOOLEAN('S', "no-strip", &nostrip,
+					"turn off tag message stripping"),
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
@@ -525,7 +528,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+			   sign, nostrip, prev, object);
 
 	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-- 
1.7.7.2
