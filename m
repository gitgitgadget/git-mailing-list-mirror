From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/15] pretty: introduce get_pretty_userformat
Date: Tue,  9 Jul 2013 16:02:25 +0530
Message-ID: <1373365946-9230-15-git-send-email-artagnon@gmail.com>
References: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVI3-0007Kh-0h
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679Ab3GIKgx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 06:36:53 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:58734 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab3GIKgt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:36:49 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so5088321pdi.35
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FOo3m2eCUURGI7jYHvmiqZw2It+4sh/TOtYElsfkbYk=;
        b=M6TXkKIJdNoYC1EfXwjfelRv4nk7aRn91pCFD6HCoDXwmyx+Wd2ZLz+2dZlD3LCqJ+
         5lx1R47O6MkdsM3TA0v8c7UMV+oAEYKIFXznT652wtLex8JuNMNOlGY2HnYfN24cnPyQ
         z34zB8qf/uyeigVZ95DpXQX/KlJQFxA0WSLQwNEXgleVYTl5TPCNoEcDegWv5XU9yR2F
         CpllMu87OlSKZr622SpD6wE2B81uH7XMiX7ErP23eO5Jy7iFFzdq5D5g/NX/b9xRQKb1
         NwZNsQPmy2vSSrvAKPcV/BaeJWsWYzOgpIwHGNNNwdKC45gxN6y5nGOXElGY/BMqCtbM
         KnLA==
X-Received: by 10.67.2.71 with SMTP id bm7mr26711251pad.144.1373366208725;
        Tue, 09 Jul 2013 03:36:48 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id fr1sm27553398pbb.26.2013.07.09.03.36.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 03:36:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.736.g869de25
In-Reply-To: <1373365946-9230-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229941>

This helper function is intended to be used by callers implementing
--pretty themselves; it parses pretty.* configuration variables
recursively and hands the user-defined format back to the caller.  No
builtins are supported, as CMT_FMT_* are really only useful when
displaying commits.  Callers might like to define their own builtins in
the future.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h |  1 +
 pretty.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/commit.h b/commit.h
index ced7100..331a2db 100644
--- a/commit.h
+++ b/commit.h
@@ -113,6 +113,7 @@ extern char *logmsg_reencode(const struct commit *c=
ommit,
 			     const char *output_encoding);
 extern void logmsg_free(char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
+extern const char *get_pretty_userformat(const char *arg);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
 extern void userformat_find_requirements(const char *fmt, struct userf=
ormat_want *w);
diff --git a/pretty.c b/pretty.c
index 28c0a72..70e4e44 100644
--- a/pretty.c
+++ b/pretty.c
@@ -174,6 +174,31 @@ void get_commit_format(const char *arg, struct rev=
_info *rev)
 }
=20
 /*
+ * Function to parse --pretty string, lookup pretty.* configuration
+ * variables and return the format string, assuming no builtin
+ * formats.  Not limited to commits, unlike get_commit_format().
+ */
+const char *get_pretty_userformat(const char *arg)
+{
+	struct cmt_fmt_map *commit_format;
+
+	if (!arg || !*arg)
+		return NULL;
+
+	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:"))
+		return xstrdup(strchr(arg, ':' + 1));
+
+	if (strchr(arg, '%'))
+		return xstrdup(arg);
+
+	commit_format =3D find_commit_format(arg);
+	if (!commit_format || commit_format->format !=3D CMIT_FMT_USERFORMAT)
+		die("invalid --pretty format: %s", arg);
+
+	return xstrdup(commit_format->user_format);
+}
+
+/*
  * Generic support for pretty-printing the header
  */
 static int get_one_line(const char *msg)
--=20
1.8.3.2.736.g869de25
