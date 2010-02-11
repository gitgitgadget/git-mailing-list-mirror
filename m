Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 18906 invoked by uid 107); 11 Feb 2010 14:39:25 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Thu, 11 Feb 2010 09:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab0BKOjG (ORCPT <rfc822;peff@peff.net>);
	Thu, 11 Feb 2010 09:39:06 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:64057 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab0BKOjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:39:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 17BB6EAF5F1;
	Thu, 11 Feb 2010 23:39:02 +0900 (JST)
X-Quarantine-ID: <Hb9of6kh8CPn>
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
X-Amavis-Alert:	BAD HEADER, Duplicate header field: "To"
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hb9of6kh8CPn; Thu, 11 Feb 2010 23:39:01 +0900 (JST)
Received: from localhost.localdomain (FL1-122-130-141-251.tky.mesh.ad.jp [122.130.141.251])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id A0E25EAF5EC;
	Thu, 11 Feb 2010 23:39:01 +0900 (JST)
From:	Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.org>
Subject: [PATCH v2 2/2] git-imap-send: Convert LF to CRLF before storing patch to draft box
Date:	Thu, 11 Feb 2010 23:38:55 +0900
Message-Id: <1265899135-11488-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
To:	gitster@pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

According to RFC of IMAP, all messages must not have "bare newlines ('\n')".
'\n' should be converted to "\r\n" before storing messages to IMAP's mailbox.
This patch implements the converting function to git-imap-send.

Cc: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff King <peff@peff.org>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 imap-send.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index dcd8a2a..dbc72ca 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1279,6 +1279,30 @@ static int imap_make_flags(int flags, char *buf)
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
+	msg->crlf = 1;
+}
+
 static int imap_store_msg(struct store *gctx, struct msg_data *data)
 {
 	struct imap_store *ctx = (struct imap_store *)gctx;
@@ -1288,6 +1312,7 @@ static int imap_store_msg(struct store *gctx, struct msg_data *data)
 	int ret, d;
 	char flagstr[128];
 
+	lf_to_crlf(data);
 	memset(&cb, 0, sizeof(cb));
 
 	cb.dlen = data->len;
-- 
1.6.5.2

