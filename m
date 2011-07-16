From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 14/23] transport-helper: factor out push_update_refs_status
Date: Sat, 16 Jul 2011 15:03:34 +0200
Message-ID: <1310821424-4750-15-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:11:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4eq-0008HP-Px
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab1GPNLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:11:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37892 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab1GPNLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:11:43 -0400
Received: by ewy4 with SMTP id 4so997240ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=x5bst0oMJ8a+/WrLPf27ij5xCa5tUEzs4u7NL1Tpr2U=;
        b=B8QrNiSlPv0E7W+jTMG4yRexCvlX0gSd3A3cO4Q0pDb9z+qXA37W/lAFhkgcNksE0j
         woUomrn+ZDY57z4Xit0kJ4sXfr0Zl5pToutG6UeqRpC7UwiAZ5dOyrLr0BqMT6ac0zYr
         bgG5MBhbfv4AP8xftDkA9f1tOL6Upc3JCAO3Q=
Received: by 10.14.94.206 with SMTP id n54mr1565759eef.91.1310821490510;
        Sat, 16 Jul 2011 06:04:50 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177275>

The update ref status part of push is useful for the export command
as well, factor it out into it's own function.

Also factor out push_update_ref_status to avoid a long loop without
an explicit condition with a non-trivial body.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 transport-helper.c |  153 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 84 insertions(+), 69 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 6cccb20..dd8dd2c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -559,6 +559,88 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static void push_update_ref_status(struct strbuf *buf,
+				   struct ref **ref,
+				   struct ref *remote_refs)
+{
+	char *refname, *msg;
+	int status;
+
+	if (!prefixcmp(buf->buf, "ok ")) {
+		status = REF_STATUS_OK;
+		refname = buf->buf + 3;
+	} else if (!prefixcmp(buf->buf, "error ")) {
+		status = REF_STATUS_REMOTE_REJECT;
+		refname = buf->buf + 6;
+	} else
+		die("expected ok/error, helper said '%s'\n", buf->buf);
+
+	msg = strchr(refname, ' ');
+	if (msg) {
+		struct strbuf msg_buf = STRBUF_INIT;
+		const char *end;
+
+		*msg++ = '\0';
+		if (!unquote_c_style(&msg_buf, msg, &end))
+			msg = strbuf_detach(&msg_buf, NULL);
+		else
+			msg = xstrdup(msg);
+		strbuf_release(&msg_buf);
+
+		if (!strcmp(msg, "no match")) {
+			status = REF_STATUS_NONE;
+			free(msg);
+			msg = NULL;
+		}
+		else if (!strcmp(msg, "up to date")) {
+			status = REF_STATUS_UPTODATE;
+			free(msg);
+			msg = NULL;
+		}
+		else if (!strcmp(msg, "non-fast forward")) {
+			status = REF_STATUS_REJECT_NONFASTFORWARD;
+			free(msg);
+			msg = NULL;
+		}
+	}
+
+	if (*ref)
+		*ref = find_ref_by_name(*ref, refname);
+	if (!*ref)
+		*ref = find_ref_by_name(remote_refs, refname);
+	if (!*ref) {
+		warning("helper reported unexpected status of %s", refname);
+		return;
+	}
+
+	if ((*ref)->status != REF_STATUS_NONE) {
+		/*
+		 * Earlier, the ref was marked not to be pushed, so ignore the ref
+		 * status reported by the remote helper if the latter is 'no match'.
+		 */
+		if (status == REF_STATUS_NONE)
+			return;
+	}
+
+	(*ref)->status = status;
+	(*ref)->remote_status = msg;
+}
+
+static void push_update_refs_status(struct helper_data *data,
+				    struct ref *remote_refs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct ref *ref = remote_refs;
+	for (;;) {
+		recvline(data, &buf);
+		if (!buf.len)
+			break;
+
+		push_update_ref_status(&buf, &ref, remote_refs);
+	}
+	strbuf_release(&buf);
+}
+
 static int push_refs_with_push(struct transport *transport,
 		struct ref *remote_refs, int flags)
 {
@@ -613,76 +695,9 @@ static int push_refs_with_push(struct transport *transport,
 
 	strbuf_addch(&buf, '\n');
 	sendline(data, &buf);
-
-	ref = remote_refs;
-	while (1) {
-		char *refname, *msg;
-		int status;
-
-		recvline(data, &buf);
-		if (!buf.len)
-			break;
-
-		if (!prefixcmp(buf.buf, "ok ")) {
-			status = REF_STATUS_OK;
-			refname = buf.buf + 3;
-		} else if (!prefixcmp(buf.buf, "error ")) {
-			status = REF_STATUS_REMOTE_REJECT;
-			refname = buf.buf + 6;
-		} else
-			die("expected ok/error, helper said '%s'\n", buf.buf);
-
-		msg = strchr(refname, ' ');
-		if (msg) {
-			struct strbuf msg_buf = STRBUF_INIT;
-			const char *end;
-
-			*msg++ = '\0';
-			if (!unquote_c_style(&msg_buf, msg, &end))
-				msg = strbuf_detach(&msg_buf, NULL);
-			else
-				msg = xstrdup(msg);
-			strbuf_release(&msg_buf);
-
-			if (!strcmp(msg, "no match")) {
-				status = REF_STATUS_NONE;
-				free(msg);
-				msg = NULL;
-			}
-			else if (!strcmp(msg, "up to date")) {
-				status = REF_STATUS_UPTODATE;
-				free(msg);
-				msg = NULL;
-			}
-			else if (!strcmp(msg, "non-fast forward")) {
-				status = REF_STATUS_REJECT_NONFASTFORWARD;
-				free(msg);
-				msg = NULL;
-			}
-		}
-
-		if (ref)
-			ref = find_ref_by_name(ref, refname);
-		if (!ref)
-			ref = find_ref_by_name(remote_refs, refname);
-		if (!ref) {
-			warning("helper reported unexpected status of %s", refname);
-			continue;
-		}
-
-		if (ref->status != REF_STATUS_NONE) {
-			/*
-			 * Earlier, the ref was marked not to be pushed, so ignore the ref
-			 * status reported by the remote helper if the latter is 'no match'.
-			 */
-			if (status == REF_STATUS_NONE)
-				continue;
-		}
-
-		ref->status = status;
-		ref->remote_status = msg;
-	}
 	strbuf_release(&buf);
+
+	push_update_refs_status(data, remote_refs);
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
