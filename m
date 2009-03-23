From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 4/6] format-patch: move get_patch_filename() into log-tree
Date: Sun, 22 Mar 2009 19:14:04 -0700
Message-ID: <e8e0dcc738decb5f70dbc8e835263d7dc2834407.1237773604.git.bebarino@gmail.com>
References: <1237696363-6819-1-git-send-email-bebarino@gmail.com>
 <cover.1237773604.git.bebarino@gmail.com>
 <baa327d88b54efae40b6d9df09a2fe482672101e.1237773604.git.bebarino@gmail.com>
 <616420f398701fafc45b5d5cebb1371534f88caa.1237773604.git.bebarino@gmail.com>
 <00c4e51c2ff7786be6aedb4a451b8d1ff269d7b3.1237773604.git.bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 03:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlZhx-0000lE-3J
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 03:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbZCWCO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 22:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbZCWCO0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 22:14:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:23531 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbZCWCOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 22:14:22 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1537512rvb.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=A0ydhIssCk6PwNf8TS8xf+m3/tCyuZA0XOSO88iX0cY=;
        b=FYGUbhgnzEbvbHr7IpUPYjcVUrg6IoDi50vy6j9bqA2RIK/o97isxnhvp2fanJjWPg
         7GdE+JN+eslfdncL95wD5FzNyqnfm2uF0MN3kE/crZ1h/4HqBnASG/nY6Iz+xxyHbB+4
         HyLYNze83U+sbOXqrby9ceH+yD9r6lQLQazPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JOL79nu/A2pTkOCNN0m53C/yrl749QJ/Kli3Y6MEbTVCJTiVnUWXB2XLyPy2XpF62i
         nte+O7iLSCx6JAZOT/KoDqIh140ra6QP3KGXpToapciP+pjPS7FPvXrnY4ko0+Xtfp6J
         pt5NXFTuhWR9tOZRIKXnUTnzcjbkCpH0R/3S4=
Received: by 10.142.237.19 with SMTP id k19mr2619429wfh.31.1237774461343;
        Sun, 22 Mar 2009 19:14:21 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm10388035wfd.15.2009.03.22.19.14.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 19:14:21 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sun, 22 Mar 2009 19:14:18 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <00c4e51c2ff7786be6aedb4a451b8d1ff269d7b3.1237773604.git.bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114228>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c |   25 -------------------------
 log-tree.c    |   23 +++++++++++++++++++++++
 log-tree.h    |    4 ++++
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 392b16a..a8d6037 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -417,7 +417,6 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 }
 
 /* format-patch */
-#define FORMAT_PATCH_NAME_MAX 64
 
 static const char *fmt_patch_suffix = ".patch";
 static int numbered = 0;
@@ -512,30 +511,6 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	return git_log_config(var, value, cb);
 }
 
-
-static void get_patch_filename(struct commit *commit, int nr,
-			       const char *suffix, struct strbuf *buf)
-{
-	int suffix_len = strlen(suffix) + 1;
-	int start_len = buf->len;
-
-	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
-	if (commit)
-	{
-		format_commit_message(commit, "%f", buf, DATE_NORMAL);
-		/*
-		 * Replace characters at the end with the suffix if the the
-		 * filename is too long
-		 */
-		if (buf->len + suffix_len > FORMAT_PATCH_NAME_MAX + start_len)
-			strbuf_splice(buf,
-				start_len + FORMAT_PATCH_NAME_MAX - suffix_len,
-				suffix_len, suffix, suffix_len);
-		else
-			strbuf_addstr(buf, suffix);
-	}
-}
-
 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;
diff --git a/log-tree.c b/log-tree.c
index 9565c18..9a790ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -179,6 +179,29 @@ static int has_non_ascii(const char *s)
 	return 0;
 }
 
+void get_patch_filename(struct commit *commit, int nr, const char *suffix,
+			struct strbuf *buf)
+{
+	int suffix_len = strlen(suffix) + 1;
+	int start_len = buf->len;
+
+	strbuf_addf(buf, commit ? "%04d-" : "%d", nr);
+	if (commit)
+	{
+		format_commit_message(commit, "%f", buf, DATE_NORMAL);
+		/*
+		 * Replace characters at the end with the suffix if the the
+		 * filename is too long
+		 */
+		if (buf->len + suffix_len > FORMAT_PATCH_NAME_MAX + start_len)
+			strbuf_splice(buf,
+				start_len + FORMAT_PATCH_NAME_MAX - suffix_len,
+				suffix_len, suffix, suffix_len);
+		else
+			strbuf_addstr(buf, suffix);
+	}
+}
+
 void log_write_email_headers(struct rev_info *opt, const char *name,
 			     const char **subject_p,
 			     const char **extra_headers_p,
diff --git a/log-tree.h b/log-tree.h
index f2a9008..78dc5be 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -19,4 +19,8 @@ void log_write_email_headers(struct rev_info *opt, const char *name,
 			     int *need_8bit_cte_p);
 void load_ref_decorations(void);
 
+#define FORMAT_PATCH_NAME_MAX 64
+void get_patch_filename(struct commit *commit, int nr, const char *suffix,
+			struct strbuf *buf);
+
 #endif
-- 
1.6.2
