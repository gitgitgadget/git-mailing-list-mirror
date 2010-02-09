From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH 4/4] git-imap-send: Add method to convert from LF to CRLF
Date: Tue,  9 Feb 2010 21:09:05 +0900
Message-ID: <1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 09 13:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nep3c-0000uz-4E
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 13:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab0BIMSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 07:18:52 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:54580 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab0BIMSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 07:18:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id B5E06E9D87A;
	Tue,  9 Feb 2010 21:09:55 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rJkQ6Uqy7HjO; Tue,  9 Feb 2010 21:09:55 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id BC805E9D86D;
	Tue,  9 Feb 2010 21:09:53 +0900 (JST)
X-Mailer: git-send-email 1.7.0.rc1.52.gf7cc2.dirty
In-Reply-To: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139397>

Some strict IMAP servers (e.g. Cyrus) don't
allow "bare newlines ('\n')" in messages.
So I added new boolean option "lf-to-crlf" to imap section.
If this option enabled, git-imap-send converts LF to CRLF("\r\n").

If you want to use it, add line:
	lf-to-crlf
to [imap] section of your .gitconfig .

This patch also adds description to Documentation/git-imap-send.txt .

Cc: Jeremy White <jwhite@codeweavers.com>
Cc: Robert Shearman <robertshearman@gmail.com>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 Documentation/git-imap-send.txt |    5 +++++
 imap-send.c                     |   30 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 9b2052f..c4c0670 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -75,6 +75,11 @@ imap.auth-method::
 	Specify authenticate method for authentication with IMAP server.
 	Current supported method is 'CRAM-MD5' only.
 
+imap.lf-to-crlf::
+	If you use strict IMAP server (e.g. Cyrus),
+	"bare newlines ('\n')" in messages are not allowed.
+	If this option enabled, git-imap-send converts LF to CRLF("\r\n").
+
 Examples
 ~~~~~~~~
 
diff --git a/imap-send.c b/imap-send.c
index 3ed9fc2..5329e28 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -147,6 +147,7 @@ struct imap_server_conf {
 	int ssl_verify;
 	int use_html;
 	char *auth_method;
+	int lf_to_crlf;
 };
 
 static struct imap_server_conf server = {
@@ -160,6 +161,7 @@ static struct imap_server_conf server = {
 	1,   	/* ssl_verify */
 	0,   	/* use_html */
 	NULL,	/* auth_method */
+	0,	/* lf_to_crlf */
 };
 
 struct imap_store_conf {
@@ -1242,6 +1244,29 @@ static int imap_make_flags(int flags, char *buf)
 	return d;
 }
 
+static void lf_to_crlf(struct msg_data *msg)
+{
+	char *new;
+	int i, j, lfnum = 0;
+
+	for (i = 0; i < msg->len; i++) {
+		if (msg->data[i] == '\n')
+			lfnum++;
+	}
+	new = xcalloc(msg->len + lfnum, sizeof(char));
+	for (i = 0, j = 0; i < msg->len; i++) {
+		if (msg->data[i] != '\n') {
+			new[j++] = msg->data[i];
+			continue;
+		}
+		new[j++] = '\r';
+		new[j++] = '\n';
+	}
+	msg->len += lfnum;
+	free(msg->data);
+	msg->data = new;
+}
+
 static int imap_store_msg(struct store *gctx, struct msg_data *data)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
@@ -1253,6 +1278,9 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data)
 
 	memset(&cb, 0, sizeof(cb));
 
+	if (server.lf_to_crlf)
+		lf_to_crlf(data);
+
 	cb.dlen = data->len;
 	cb.data = xmalloc(cb.dlen);
 	memcpy(cb.data, data->data, data->len);
@@ -1408,6 +1436,8 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		server.ssl_verify = git_config_bool(key, val);
 	else if (!strcmp("preformattedhtml", key))
 		server.use_html = git_config_bool(key, val);
+	else if (!strcmp("lf-to-crlf", key))
+		server.lf_to_crlf = git_config_bool(key, val);
 	else if (!val)
 		return config_error_nonbool(key);
 
-- 
1.7.0.rc1.52.gf7cc2.dirty
