From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/13] rerere: lift PATH_MAX limitation
Date: Tue, 30 Jun 2015 23:04:49 -0700
Message-ID: <1435730699-9124-4-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB93-0004E7-CL
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbbGAGFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:15 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35347 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbGAGFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:05 -0400
Received: by igblr2 with SMTP id lr2so90752414igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=c2D+dSBkY9bh+J7Zm1LNIq+kPFdPJ943bhiRBTm0yMY=;
        b=U51lEO0HaPFBGKASAO52Wo7LJSVvJauJjuJPBLS3J35EguU1LOuVvkWC0L5yTxB4zU
         1KtTf+lXEfRISdmQjiluwtuYVjoyyb4n4RTeoNyNXZs846f7s0WJv0j43PU/Pbak4jFA
         gJTQXhAFEPhO8XHThwE67NdL20emrgEKY9+pb2G8+CnhQya/h500v1mXh0AQvWt7rDQn
         CY4sWNOmw8USwpiBA2kVfKM5NCT+9q0QxficHVirszTGR5k2cDp7iVFJKNkp+uCNPEke
         H+Ev6zkOvAPGzUzFbKAhqYeNi4Cp1UmIRp8WTiQZoo1wdqva4phy2HLQ6BRxZm+5XCKq
         F1Fw==
X-Received: by 10.50.138.76 with SMTP id qo12mr2297481igb.38.1435730705277;
        Tue, 30 Jun 2015 23:05:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id q10sm9486245ige.16.2015.06.30.23.05.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273118>

The MERGE_RR file records a collection of NUL-terminated entries,
each of which consists of

 - a hash that identifies the conflict
 - a HT
 - the pathname

We used to read this piece-by-piece, and worse yet, read the
pathname part a byte at a time into a fixed buffer of size PATH_MAX.

Instead, read a whole entry using strbuf_getwholeline() and parse
out the fields.  This way, we issue fewer read(2) calls and more
importantly we do not have to limit the pathname to PATH_MAX.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/rerere.c b/rerere.c
index 3b9104d..e854985 100644
--- a/rerere.c
+++ b/rerere.c
@@ -35,32 +35,27 @@ static int has_rerere_resolution(const char *hex)
 
 static void read_rr(struct string_list *rr)
 {
-	unsigned char sha1[20];
-	char buf[PATH_MAX];
+	struct strbuf buf = STRBUF_INIT;
 	FILE *in = fopen(merge_rr_path, "r");
+
 	if (!in)
 		return;
-	while (fread(buf, 40, 1, in) == 1) {
-		int i;
-		char *name;
-		if (get_sha1_hex(buf, sha1))
+	while (!strbuf_getwholeline(&buf, in, '\0')) {
+		char *path;
+		unsigned char sha1[20];
+
+		/* There has to be the hash, tab, path and then NUL */
+		if (buf.len < 42 || get_sha1_hex(buf.buf, sha1))
 			die("corrupt MERGE_RR");
-		buf[40] = '\0';
-		name = xstrdup(buf);
-		if (fgetc(in) != '\t')
+
+		if (buf.buf[40] != '\t')
 			die("corrupt MERGE_RR");
-		for (i = 0; i < sizeof(buf); i++) {
-			int c = fgetc(in);
-			if (c < 0)
-				die("corrupt MERGE_RR");
-			buf[i] = c;
-			if (c == 0)
-				 break;
-		}
-		if (i == sizeof(buf))
-			die("filename too long");
-		string_list_insert(rr, buf)->util = name;
+		buf.buf[40] = '\0';
+		path = buf.buf + 41;
+
+		string_list_insert(rr, path)->util = xstrdup(buf.buf);
 	}
+	strbuf_release(&buf);
 	fclose(in);
 }
 
-- 
2.5.0-rc0-209-g5e1f148
