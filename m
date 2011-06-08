From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 12/19] transport-helper: factor out push_update_refs_status
Date: Wed,  8 Jun 2011 20:48:43 +0200
Message-ID: <1307558930-16074-13-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:50:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNpM-00087c-4I
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab1FHStx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:49:53 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46492 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab1FHStp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:45 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so279690eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qmI1Nedb/0h/R/8gAsI5IYy7WB9cia2Q+mRvNQAZ6/o=;
        b=yBG0unM0DA04jkAPbBMFkIF4cSZZ9iv63G0AXn/9AxkuTH5UMddzCgJ6aI3PiO6TLP
         QNzwtdnDvbOfIzUTurtu9eodS/apwb2PJOgx6NeE+1dz1DKBfBM5TacRyTkk3eofswhN
         O1y7CTEiRxDnhyqkRTnVJuc0tmIrYQ5sydW9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qT2dG8gpFM/sUxEAxuvwOYuESoZueaDF11AxrSUnDpSbPy3QyPLsX5m0r4Z6mN4Dvq
         LtrHU07ntLyv0lspfuI0k5Vr9W9IqR6KdjudxVL8XhdMiUuvNaErWnsnOMLedpbS47nl
         JzM7FgOb6ezO3Y8zM0uX2nh0BDBLWoO5d0WNs=
Received: by 10.213.7.74 with SMTP id c10mr2147552ebc.4.1307558984847;
        Wed, 08 Jun 2011 11:49:44 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175426>

The update ref status part of push is useful for the export command
as well, factor it out into it's own function.

Also factor out push_update_ref_status to avoid a long loop without
an explicit condition with a non-trivial body.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Changed from the original addressing comments by Jonathan.

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
