From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/18] rerere: lift PATH_MAX limitation
Date: Fri, 17 Jul 2015 15:24:25 -0700
Message-ID: <1437171880-21590-4-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4o-0004ZO-4Z
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbbGQWYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:24:51 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35346 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbbGQWYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:47 -0400
Received: by pdrg1 with SMTP id g1so67944428pdr.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=9VshzGNwJ3h7MkeCB0PJPJ65eOtZv3NYJuXY3f01c6w=;
        b=1C31NPJ/x4eHTx7Fep6E1An/1dbL6pmvbwQMj95PBDhjg3LkqXZ1gWsrU8QAlo8VM4
         Ll8Dlgrndv5AWhM5lDv2L6rg50YMUPKwIGqf4Yriib6Gcj6NPPZnr2712Si2Kc4VuPg8
         +saY69Hnsp4DIn+H8Lq7LSeSmcPUGkNDP9DASZeIJDmgGIHeM2JsMQ4zksO0fnxj4w7L
         K//j2AGhWXcvyWJh1kAy9hAZSSrRhLopatsQqC0Bor5rNQe010p+HhfKUw/G3WwDNRK3
         /l1T/lmHzB6vxjYIQKbwqylyQIX45zZOWL8juNuKNW4Zvu5RvMttiNSJtxZ5l+rD1uV3
         ql7g==
X-Received: by 10.66.221.39 with SMTP id qb7mr33679456pac.59.1437171887582;
        Fri, 17 Jul 2015 15:24:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id xo3sm12291565pbb.74.2015.07.17.15.24.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274125>

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
2.5.0-rc2-340-g0cccc16
