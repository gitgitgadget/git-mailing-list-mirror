From: Johan Herland <johan@herland.net>
Subject: [RFC 05/11] Refactor path name parsing into new function:
 get_path_str()
Date: Mon, 27 Jul 2009 03:04:13 +0200
Message-ID: <1248656659-21415-6-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEfS-0004JH-R1
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbZG0BFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755465AbZG0BFn
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:43 -0400
Received: from mx.getmail.no ([84.208.15.66]:47198 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755375AbZG0BFm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:42 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF00L241PI7K70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:42 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:42 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.4819
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124147>

This is in preparation for adding mark reference capability to path names.

Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c |   60 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7ef9865..8a7cdc1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1853,6 +1853,24 @@ static void load_branch(struct branch *b)
 	}
 }
 
+static const char *get_path_str(
+	struct strbuf *sb,
+	const char *p,
+	char endc,
+	const char **endp)
+{
+	strbuf_reset(sb);
+	*endp = p;
+	if (!unquote_c_style(sb, p, endp)) {
+		/* successfully unquoted C-style quoted name */
+		p = sb->buf;
+	} else {
+		/* regular path ending at endc */
+		*endp = strchr(p, endc);
+	}
+	return p;
+}
+
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
@@ -1896,12 +1914,9 @@ static void file_change_m(struct branch *b)
 	if (*p++ != ' ')
 		die("Missing space after SHA1: %s", command_buf.buf);
 
-	strbuf_reset(&uq);
-	if (!unquote_c_style(&uq, p, &endp)) {
-		if (*endp)
-			die("Garbage after path in: %s", command_buf.buf);
-		p = uq.buf;
-	}
+	p = get_path_str(&uq, p, 0, &endp);
+	if (*endp)
+		die("Garbage after path in: %s", command_buf.buf);
 
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
@@ -1948,12 +1963,9 @@ static void file_change_d(struct branch *b)
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
 
-	strbuf_reset(&uq);
-	if (!unquote_c_style(&uq, p, &endp)) {
-		if (*endp)
-			die("Garbage after path in: %s", command_buf.buf);
-		p = uq.buf;
-	}
+	p = get_path_str(&uq, p, 0, &endp);
+	if (*endp)
+		die("Garbage after path in: %s", command_buf.buf);
 	tree_content_remove(&b->branch_tree, p, NULL);
 }
 
@@ -1966,29 +1978,21 @@ static void file_change_cr(struct branch *b, int rename)
 	struct tree_entry leaf;
 
 	s = command_buf.buf + 2;
-	strbuf_reset(&s_uq);
-	if (!unquote_c_style(&s_uq, s, &endp)) {
-		if (*endp != ' ')
-			die("Missing space after source: %s", command_buf.buf);
-	} else {
-		endp = strchr(s, ' ');
-		if (!endp)
-			die("Missing space after source: %s", command_buf.buf);
+	s = get_path_str(&s_uq, s, ' ', &endp);
+	if (*endp != ' ')
+		die("Missing space after source: %s", command_buf.buf);
+	if (s != s_uq.buf) {
 		strbuf_add(&s_uq, s, endp - s);
+		s = s_uq.buf;
 	}
-	s = s_uq.buf;
 
 	endp++;
 	if (!*endp)
 		die("Missing dest: %s", command_buf.buf);
 
-	d = endp;
-	strbuf_reset(&d_uq);
-	if (!unquote_c_style(&d_uq, d, &endp)) {
-		if (*endp)
-			die("Garbage after dest in: %s", command_buf.buf);
-		d = d_uq.buf;
-	}
+	d = get_path_str(&d_uq, endp, 0, &endp);
+	if (*endp)
+		die("Garbage after dest in: %s", command_buf.buf);
 
 	memset(&leaf, 0, sizeof(leaf));
 	if (rename)
-- 
1.6.4.rc3.138.ga6b98.dirty
