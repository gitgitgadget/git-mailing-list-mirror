From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/31] mailinfo: move [ps]_hdr_data to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:47 -0700
Message-ID: <1444855557-2127-22-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyF-0003N6-V1
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbbJNUsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:48:19 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34017 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbbJNUq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:26 -0400
Received: by payp3 with SMTP id p3so16211276pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=OjoqqOfCk6R2ltc81EFXxsw4msPdJlIncydGJCrFnms=;
        b=ZMXOcTwHDXvy09cgGl5DPlPlej9bT1S8Bco5x53rPAFBazuPMAC2oiY5V+L09+buxW
         0seDfqn7LItviWf5JFUwKLotU8Z2xRtAtuVwrpFOMi4fBgIQUy7M6xj/tucKmaHgU4Lf
         gb02n4jA4pRtr327DVKYIp4n+RmdY8tiEOuzc30Bq2Bgw6YGFU1FA381QSoLh5Aix3Bk
         FwaAHB/jpp/1UmUnW8vlIgbr4uFQHi5+DKMqbzXX/ZNvvQg08E0GgFvdzxJwQWX5C144
         klIQj8vHqHhCQnYrwAJmQcBhWsDcZ2muhq0KPWbqTJND6X/4KagMs/iAPyIIjNWhX/lD
         WuVA==
X-Received: by 10.68.57.238 with SMTP id l14mr5703639pbq.150.1444855585855;
        Wed, 14 Oct 2015 13:46:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id or6sm11342623pac.32.2015.10.14.13.46.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:25 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279617>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5809e13..aa17c77 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -30,10 +30,10 @@ struct mailinfo {
 	int patch_lines;
 	int filter_stage; /* still reading log or are we copying patch? */
 	int header_stage; /* still checking in-body headers? */
+	struct strbuf **p_hdr_data;
+	struct strbuf **s_hdr_data;
 };
 
-static struct strbuf **p_hdr_data, **s_hdr_data;
-
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
 
@@ -732,7 +732,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {
-		mi->header_stage = check_header(mi, line, s_hdr_data, 0);
+		mi->header_stage = check_header(mi, line, mi->s_hdr_data, 0);
 		if (mi->header_stage)
 			return 0;
 	} else
@@ -757,9 +757,9 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		 * them to give ourselves a clean restart.
 		 */
 		for (i = 0; header[i]; i++) {
-			if (s_hdr_data[i])
-				strbuf_release(s_hdr_data[i]);
-			s_hdr_data[i] = NULL;
+			if (mi->s_hdr_data[i])
+				strbuf_release(mi->s_hdr_data[i]);
+			mi->s_hdr_data[i] = NULL;
 		}
 		return 0;
 	}
@@ -841,7 +841,7 @@ again:
 
 	/* slurp in this section's info */
 	while (read_one_header_line(line, mi->input))
-		check_header(mi, line, p_hdr_data, 0);
+		check_header(mi, line, mi->p_hdr_data, 0);
 
 	strbuf_release(&newline);
 	/* replenish line */
@@ -942,10 +942,10 @@ static void handle_info(struct mailinfo *mi)
 
 	for (i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
-		if (mi->patch_lines && s_hdr_data[i])
-			hdr = s_hdr_data[i];
-		else if (p_hdr_data[i])
-			hdr = p_hdr_data[i];
+		if (mi->patch_lines && mi->s_hdr_data[i])
+			hdr = mi->s_hdr_data[i];
+		else if (mi->p_hdr_data[i])
+			hdr = mi->p_hdr_data[i];
 		else
 			continue;
 
@@ -985,8 +985,8 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 		return -1;
 	}
 
-	p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*p_hdr_data));
-	s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*s_hdr_data));
+	mi->p_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->p_hdr_data)));
+	mi->s_hdr_data = xcalloc(MAX_HDR_PARSED, sizeof(*(mi->s_hdr_data)));
 
 	do {
 		peek = fgetc(mi->input);
@@ -995,10 +995,10 @@ static int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	/* process the email header */
 	while (read_one_header_line(&line, mi->input))
-		check_header(mi, &line, p_hdr_data, 1);
+		check_header(mi, &line, mi->p_hdr_data, 1);
 
 	handle_body(mi, &line);
-	fclose(patchfile);
+	fclose(mi->patchfile);
 
 	handle_info(mi);
 
-- 
2.6.1-320-g86a1181
