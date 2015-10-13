From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 25/26] mailinfo: remove calls to exit() and die() deep in the callchain
Date: Tue, 13 Oct 2015 16:16:46 -0700
Message-ID: <1444778207-859-26-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:17:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pH-0006XH-RP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbJMXRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:45 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36246 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbbJMXRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:19 -0400
Received: by pacex6 with SMTP id ex6so34355321pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=wYHnbopDPLhofKub6TVuXOWP6XncCQr1GvGtK/P4bTo=;
        b=rMYneZKsQuc3PxsTEQ162sKJ4FI8/rOhw461ZkBoJcbOoTqEAXEuSEG+hyqK2wCRJI
         L5fAwv7ohAj5iBvtQTjhHmYfTvMCppbSGSQ8mZhn798Qwn/xyd8ng79oCgPJnlInxPRQ
         O/6QVdI6GaQ2aPoX3AhkW8TK49jEIHAzTMON80JrZT9SCpRW1wIqSoOysxOnl+jNEgvM
         AzE/QJ7lp4bw7aa/u9yYCLgZRhXD5Fr9volDHg16PY9UfUOdsc//j7LQiQ0ajQtVH5py
         5UFBJngVrY//5EWpWQREIKZrILWMfLYj/BMt2NHuVOQBh8vWXmFjERUfTqu7JMK+b/Zy
         Ch5Q==
X-Received: by 10.68.57.238 with SMTP id l14mr31203pbq.150.1444778238936;
        Tue, 13 Oct 2015 16:17:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id zn9sm5859093pac.48.2015.10.13.16.17.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:18 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279546>

The top-level mailinfo() would instead punt when the code in the
deeper part of the callchain detects an unrecoverable error in the
input.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index f14c504..eb9ff96 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -37,6 +37,7 @@ struct mailinfo {
 	struct strbuf **s_hdr_data;
 
 	struct strbuf log_message;
+	int input_error;
 };
 
 #define MAX_HDR_PARSED 10
@@ -192,8 +193,10 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
 		if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
-			fprintf(stderr, "Too many boundaries to handle\n");
-			exit(1);
+			error("Too many boundaries to handle");
+			mi->input_error = -1;
+			mi->content_top = mi->content + MAX_BOUNDARIES - 1;
+			return;
 		}
 		*(mi->content_top) = boundary;
 		boundary = NULL;
@@ -532,9 +535,11 @@ static int convert_to_utf8(struct mailinfo *mi,
 	if (same_encoding(mi->metainfo_charset, charset))
 		return 0;
 	out = reencode_string(line->buf, mi->metainfo_charset, charset);
-	if (!out)
+	if (!out) {
+		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
+	}
 	strbuf_attach(line, out, strlen(out), strlen(out));
 	return 0;
 }
@@ -781,7 +786,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 
 	/* normalize the log message to UTF-8. */
 	if (convert_to_utf8(mi, line, mi->charset.buf))
-		exit(128);
+		return 0; /* the caller will reject this input */
 
 	if (mi->use_scissors && is_scissors_line(line)) {
 		int i;
@@ -820,6 +825,9 @@ static void handle_patch(struct mailinfo *mi, const struct strbuf *line)
 
 static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 {
+	if (mi->input_error)
+		return;
+
 	switch (mi->filter_stage) {
 	case 0:
 		if (!handle_commit_msg(mi, line))
@@ -858,12 +866,15 @@ again:
 		   will fail first.  But just in case..
 		 */
 		if (--mi->content_top < mi->content) {
-			fprintf(stderr, "Detected mismatched boundaries, "
-					"can't recover\n");
-			exit(1);
+			error("Detected mismatched boundaries, can't recover");
+			mi->input_error = -1;
+			mi->content_top = mi->content;
+			return 0;
 		}
 		handle_filter(mi, &newline);
 		strbuf_release(&newline);
+		if (mi->input_error)
+			return 0; /* punt to the end */
 
 		/* skip to the next boundary */
 		if (!find_boundary(mi, line))
@@ -948,6 +959,8 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			handle_filter(mi, line);
 		}
 
+		if (mi->input_error)
+			break;
 	} while (!strbuf_getwholeline(line, mi->input, '\n'));
 
 handle_body_out:
@@ -1035,12 +1048,13 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		check_header(mi, &line, mi->p_hdr_data, 1);
 
 	handle_body(mi, &line);
-	handle_info(mi);
-
-	fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
+	if (!mi->input_error) {
+		handle_info(mi);
+		fwrite(mi->log_message.buf, 1, mi->log_message.len, cmitmsg);
+	}
 	fclose(cmitmsg);
 
-	return 0;
+	return mi->input_error;
 }
 
 static int git_mailinfo_config(const char *var, const char *value, void *mi_)
-- 
2.6.1-320-g86a1181
