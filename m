From: Mathias Weber <mweb@gmx.ch>
Subject: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 18:00:21 +0200
Message-ID: <4F71E415.9030800@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 18:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCYot-0006WT-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 18:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab2C0QAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 12:00:22 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:53084 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750876Ab2C0QAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 12:00:22 -0400
Received: (qmail invoked by alias); 27 Mar 2012 16:00:20 -0000
Received: from 214-171.5-85.cust.bluewin.ch (EHLO [192.168.12.190]) [85.5.171.214]
  by mail.gmx.net (mp020) with SMTP; 27 Mar 2012 18:00:20 +0200
X-Authenticated: #1340516
X-Provags-ID: V01U2FsdGVkX1/Nu0UnAxrN0432BnE6JKhKFDKpVVNFt9gzmOwe3t
	5fE7kyjBIkDQ4U
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194054>


The tag command does not support the --author option as the
commit command. This adds the --author option to create
annotated tags with a different author.

Signed-off-by: Mathias Weber <mathew.weber@gmail.com>
---
 builtin/tag.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index fe7e5e5..416fa88 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -309,17 +309,34 @@ struct create_tag_options {
 
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, struct create_tag_options *opt,
-		       unsigned char *prev, unsigned char *result)
+		       unsigned char *prev, unsigned char *result,
+		       const char *force_author)
 {
 	enum object_type type;
 	char header_buf[1024];
 	int header_len;
 	char *path = NULL;
+	char *name, *email;
+	const char *author_ident;
 
 	type = sha1_object_info(object, NULL);
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
+	if (force_author) {
+		const char *lb = strstr(force_author, " <");
+		const char *rb = strchr(force_author, '>');
+
+		if (!lb || !rb)
+			die(_("malformed --author parameter"));
+			name = xstrndup(force_author, lb - force_author);
+			email = xstrndup(lb + 2, rb - (lb + 2));
+
+		author_ident = fmt_ident(name, email, getenv("GIT_AUTHOR_DATE"),
+				IDENT_ERROR_ON_NO_NAME);
+	} else
+		author_ident = git_committer_info(IDENT_ERROR_ON_NO_NAME);
+
 	header_len = snprintf(header_buf, sizeof(header_buf),
 			  "object %s\n"
 			  "type %s\n"
@@ -328,7 +345,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 			  sha1_to_hex(object),
 			  typename(type),
 			  tag,
-			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
+			  author_ident);
 
 	if (header_len > sizeof(header_buf) - 1)
 		die(_("tag header too big."));
@@ -438,6 +455,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
+	const char *force_author = NULL;
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN('l', "list", &list, "list tag names"),
@@ -452,6 +470,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					"annotated tag, needs a message"),
 		OPT_CALLBACK('m', "message", &msg, "message",
 			     "tag message", parse_msg_arg),
+		OPT_STRING(0, "author", &force_author, "author",
+				 "override author for annotated tag"),
 		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
 		OPT_BOOLEAN('s', "sign", &opt.sign, "annotated and GPG-signed tag"),
 		OPT_STRING(0, "cleanup", &cleanup_arg, "mode",
@@ -556,7 +576,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("Invalid cleanup mode %s"), cleanup_arg);
 
 	if (annotate)
-		create_tag(object, tag, &buf, &opt, prev, object);
+		create_tag(object, tag, &buf, &opt, prev, object, force_author);
 
 	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-- 
1.7.5.4
