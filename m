From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 13/20] transport-helper: factor out push_update_refs_status
Date: Sun, 19 Jun 2011 17:18:38 +0200
Message-ID: <1308496725-22329-14-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJnY-00042G-79
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1FSPUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:20:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:43954 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab1FSPUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:20:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so981189ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=pRCyiLV+CResUwsAwodS0FtOm7XeRdNG0q2IZx4kiCM=;
        b=YfSeYdCWzYNOO9/VI5NzWmq/znGT1UJb4Y1isiJLZkc6oLkpUxk9destVpGeMBhAaT
         qqTVb6Bpdi3yxq3g63YUUHnswv3te4MypxoOWmtWftsmLb2zKs9XWJJDAnz38nlAJeeM
         Ije7Uf+kxK83RPXZJrdGZdLwL0mtg//9/kfbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q7bUeQI1PXMmurGVFh7ZNU3uf+kq9M6X/Zm3e5brqUetzG9bTX8dPh2E1mMbtJltuE
         RlPitIng9laRXHWyM6s7xGafbzp+qGzGgxXh/lc9wsr+AhFFjnGHdI5va+EbE2M/23GA
         VTObA4crfVKV0VW7x3hjbFEXOecfOFKJ56ulk=
Received: by 10.213.106.204 with SMTP id y12mr1604029ebo.64.1308496800221;
        Sun, 19 Jun 2011 08:20:00 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176018>

The update ref status part of push is useful for the export command
as well, factor it out into it's own function.

Also factor out push_update_ref_status to avoid a long loop without
an explicit condition with a non-trivial body.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged.

 transport-helper.c |  153 ++++++++++++++++++++++++++++-----------------------
 1 files changed, 84 insertions(+), 69 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 34d18aa..ecb44f6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -554,6 +554,88 @@ static int fetch(struct transport *transport,
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
@@ -608,76 +690,9 @@ static int push_refs_with_push(struct transport *transport,
 
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
