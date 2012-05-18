From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Add comment lines to patch format
Date: Fri, 18 May 2012 20:22:28 +0700
Message-ID: <20120518132228.GA27970@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 15:26:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVNCO-0002O2-PP
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 15:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762146Ab2ERN0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 09:26:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33197 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761866Ab2ERN0U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 09:26:20 -0400
Received: by pbbrp8 with SMTP id rp8so3948872pbb.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=MaS/sMVymOIaDzJHBAzCONi7USeViIB0k7JoBPouSKc=;
        b=bqbpFdIDbGwQKCXxpkzqcYZyolnhs9SFVqkriTI4CxAmizc20Vmixy9Xzg04MIuPJd
         GfiAZOifexlzkK3eu2a1QR3qBEfDzKWPQQk3QdvaSakR4KeVV3mHwRP1uABnW9r/AWjL
         USKXyqGI78xQR6l1rwiNUJbgStyhBCrQ0LqwP/2O2Wz92LqRtwZp89WphLSKrs5PklBw
         QKhzV7RaPs/hNSFK+6OQIv7Gas6HeXXD2LNwWVwJdWgx8xellI7rQfyCVw8YxeW3AWVN
         wwKpW/SnBKJGa+Pzmo/xnFdQfgIo2GmszSPIIIiGnjSlXGfpt7MZe98zUiKiJBx7cN+a
         3w/w==
Received: by 10.68.197.166 with SMTP id iv6mr39747318pbc.40.1337347579984;
        Fri, 18 May 2012 06:26:19 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.36.213])
        by mx.google.com with ESMTPS id rt4sm12818666pbc.3.2012.05.18.06.26.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 06:26:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 18 May 2012 20:22:28 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197954>

Hi,

This is just an idea to help spot subtle changes in patch form
(e.g. visible over email). A line starting with '=' (or something
else) is treated like a comment line and ignored by "git apply". We
could use this line to mark special things in the previous line.

One thing is trailing space, like demonstrated in the patch below,
because trailing spaces may be intentional sometimes. But I'd like to
incorporate some word-diff goodness in patch format using this comment
line to spot few/single character addition/removal.

For example, instead of showing

-  "this is a  string"
+  N_("this is a string")

we could show

-  "this is a  string"
=  ..... .. . ^.......
+  N_("this is a string")
=  ^^^..... .. . .......^

If anyone knows a tool with similar feature, I'd greatly appreciate it
(as the Internet taught me, everything I think of is already thought
of/implemented by someone)

-- 8< --
diff --git a/diff.c b/diff.c
index 77edd50..09d8c19 100644
--- a/diff.c
+++ b/diff.c
@@ -1110,6 +1110,30 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 	ecbdata->lno_in_postimage = strtol(p + 1, NULL, 10);
 }
 
+static void annotate_line(struct emit_callback *ecbdata,
+			  const char *line, unsigned long len)
+{
+	char *buf, *s;
+	int trailing = 1;
+	if (!isspace(line[len-2]))   
=	.. .......................^^^
+		return;
+	buf = malloc(len);
+	memcpy(buf, line, len);
+	buf[0] = '=';
+	for (s = buf + len - 2; s > buf; s--) {
+		if (trailing && isspace(*s))
+			*s = '^';
+		else
+			trailing = 0;
+		if (!trailing && !isspace(*s))
+			*s = '.';
+	}
+	emit_line(ecbdata->opt,
+		  diff_get_color(ecbdata->color_diff, DIFF_PLAIN),
+		  diff_get_color(ecbdata->color_diff, DIFF_RESET), buf, len);
+	free(buf);
+}
+
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
@@ -1208,17 +1232,26 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		return;
 	}
 
-	if (line[0] != '+') {
-		const char *color =
-			diff_get_color(ecbdata->color_diff,
-				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
+	switch (line[0]) {
+	case '-':
 		ecbdata->lno_in_preimage++;
-		if (line[0] == ' ')
-			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->opt, color, reset, line, len);
-	} else {
+		emit_line(ecbdata->opt,
+			  diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD),
+			  reset, line, len);
+		annotate_line(ecbdata, line, len);
+		break;
+	case '+':
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
+		annotate_line(ecbdata, line, len);
+		break;
+	case ' ':
+		ecbdata->lno_in_preimage++;
+			ecbdata->lno_in_postimage++;
+		emit_line(ecbdata->opt, plain, reset, line, len);
+		break;
+	default:
+		die("huh? a diff line starting with '%c'??", line[0]);
 	}
 }
 
-- 8< --
-- 
Duy

-- 
Duy
