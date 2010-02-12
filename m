From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: [PATCH v4 2/2] git-imap-send: Convert LF to CRLF before storing patch to draft box
Date: Fri, 12 Feb 2010 20:36:12 +0900
Message-ID: <1265974572-6282-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 12 12:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NftqR-0001dA-4k
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 12:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab0BLLhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 06:37:52 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:58443 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab0BLLhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 06:37:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 6E625EBB57B;
	Fri, 12 Feb 2010 20:37:50 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rklKrU0jUiX4; Fri, 12 Feb 2010 20:37:50 +0900 (JST)
Received: from localhost.localdomain (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 0BAC8EBB575;
	Fri, 12 Feb 2010 20:37:50 +0900 (JST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139688>

According to RFC of IMAP, all messages must not have "bare newlines ('\n')".
'\n' should be converted to "\r\n" before storing messages to IMAP's mailbox.
This patch implements the converting function to git-imap-send.

---
v4: Based on Junio's indication, now lf_to_crlf() consider
about message with CRLF. And struct msg_data doesn't have
the bitfield member crlf now.

Cc: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 imap-send.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index c5958a3..624ede3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -95,7 +95,6 @@ struct msg_data {
 	char *data;
 	int len;
 	unsigned char flags;
-	unsigned int crlf:1;
 };
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
@@ -1280,6 +1279,44 @@ static int imap_make_flags(int flags, char *buf)
 	return d;
 }
 
+static void lf_to_crlf(struct msg_data *msg)
+{
+	char *new;
+	int i, j, lfnum = 0;
+
+	if (msg->data[0] == '\n')
+		lfnum++;
+	for (i = 1; i < msg->len; i++) {
+		if (msg->data[i - 1] != '\r' && msg->data[i] == '\n')
+			lfnum++;
+	}
+
+	new = xcalloc(msg->len + lfnum, sizeof(char));
+	if (msg->data[0] == '\n') {
+		new[0] = '\r';
+		new[1] = '\n';
+		i = 1;
+		j = 2;
+	} else {
+		new[0] = msg->data[0];
+		i = 1;
+		j = 1;
+	}
+	for ( ; i < msg->len; i++) {
+		if (msg->data[i] != '\n') {
+			new[j++] = msg->data[i];
+			continue;
+		}
+		if (!(msg->data[i - 1] == '\r'))
+			new[j++] = '\r';
+		/* else: This '\n' is already not bare newline*/
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
@@ -1289,6 +1326,7 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data)
 	int ret, d;
 	char flagstr[128];
 
+	lf_to_crlf(data);
 	memset(&cb, 0, sizeof(cb));
 
 	cb.dlen = data->len;
-- 
1.7.0.rc1.52.gf7cc2.dirty
