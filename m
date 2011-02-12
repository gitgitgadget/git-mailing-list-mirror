From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH 4/4] Replace pointer arithmetic with strbuf
Date: Sun, 13 Feb 2011 00:38:31 +0200
Message-ID: <1297550311-17723-5-git-send-email-vvavrychuk@gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Cc: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 12 23:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoO7K-00033k-8N
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 23:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab1BLWi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 17:38:56 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1BLWio (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 17:38:44 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so3929984fxm.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 14:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Zh5jXqMF8+N9OeJPu80+39gDwB3e8KbeHhbWm6MSPmI=;
        b=c6xUGJjz1vnN3g98Qznn0lh7J0DyQdvbLZHak/7zbUBpzz+Pi0H2Xq0KJIxj3LsDSS
         JaN6WXiJJCUSb3QTw30puAI8+YJy7ysNgAt/hQiMyb1OLXXd4hNojv4gPlSpNvgg16XG
         yng9KLs62DswTkSB77zWtq34+P16NkUuyTdyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gCcUm+slrlxZAm40NwczsY9XToN/6W6TmtktL6erCS34qrZdhSZTBf210/Q+nCvldU
         B8q4Y2RkElFIswp7VG/qO2Ucne/zLVXmUYbAcZQ3Xk5vfRy3BQcyKf3F1Ffk9JBiwP5G
         znC7XiM7O1dPfuXTiPcD44IYiIz6j37AiKwLA=
Received: by 10.223.86.140 with SMTP id s12mr8132829fal.145.1297550323849;
        Sat, 12 Feb 2011 14:38:43 -0800 (PST)
Received: from localhost.localdomain ([91.200.115.239])
        by mx.google.com with ESMTPS id n7sm369494fam.35.2011.02.12.14.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 14:38:43 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.ga83dc
In-Reply-To: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166627>

Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
---
 builtin/fetch.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ddb40c6..eaea475 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -342,8 +342,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 {
 	FILE *fp;
 	struct commit *commit;
-	int i, note_len, shown_url = 0, rc = 0;
-	char note[1024], display[1024];
+	int i, shown_url = 0, rc = 0;
+	struct strbuf note = STRBUF_INIT;
+	char display[1024];
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
@@ -394,19 +395,20 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			what = rm->name;
 		}
 
-		note_len = 0;
 		if (*what) {
-			if (*kind)
-				note_len += sprintf(note + note_len, "%s ",
-						    kind);
-			note_len += sprintf(note + note_len, "'%s' of ", what);
+			if (*kind) {
+				strbuf_addstr(&note, kind);
+				strbuf_addch(&note, ' ');
+			}
+			strbuf_addf(&note, "'%s' of ", what);
 		}
-		note[note_len] = '\0';
 		fprintf(fp, "%s\t%s\t%s",
 			sha1_to_hex(commit ? commit->object.sha1 :
 				    rm->old_sha1),
 			rm->merge ? "" : "not-for-merge",
-			note);
+			note.buf);
+		strbuf_reset(&note);
+
 		for (i = 0; url[i]; ++i)
 			if ('\n' == url[i])
 				fputs("\\n", fp);
@@ -431,6 +433,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				fprintf(stderr, " %s\n", display);
 		}
 	}
+	strbuf_release(&note);
 	free(url);
 	fclose(fp);
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
-- 
1.7.1
