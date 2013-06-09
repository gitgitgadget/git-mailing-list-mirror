From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 14/15] pretty: introduce get_pretty_userformat
Date: Sun,  9 Jun 2013 23:24:33 +0530
Message-ID: <1370800474-8940-15-git-send-email-artagnon@gmail.com>
References: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:57:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uljrl-0006hW-Ms
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab3FIR5Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:57:16 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:40593 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab3FIR5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:57:09 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so1514479pab.27
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yWjfxytNNWn23IZEVYeX+XG+rCPRu4u3qh09bqpVcMQ=;
        b=V02HYTOIpiHdZUHvhIEgPIOUAcq2JpoUptdF1Fe0VC2NhczALsijJui0FA0IL44vNO
         fdECCTgwRUtlfRcwitaBMx1L+Q38uk+aSc+D5Y4AbxSY2r+Y1VS86FKQ6k2zFrQ1Ybn2
         7y/l3MLH+94GKlvDIIOITzPhmcgTK/z8Voe7fTiN7HXm5fum+xoQmDQrKaYrxwKvUM3+
         okR++IyyGbghTb38lYdbAvRmnWonAVHUN+Zxcjq6dpF/QvQExb8dklUpFjf/LXNum39a
         5fm5IWCPA+aSuWqdLkPkE53RHPO1h8siAZv0FOSUW4wFEj6d+le1EDSzY2fqCTExIvn7
         x82w==
X-Received: by 10.66.150.40 with SMTP id uf8mr11094362pab.66.1370800629423;
        Sun, 09 Jun 2013 10:57:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id qp4sm7275815pbc.41.2013.06.09.10.57.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 10:57:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.247.g485169c
In-Reply-To: <1370800474-8940-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227071>

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
index 38dc0c0..7755282 100644
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
1.8.3.247.g485169c
