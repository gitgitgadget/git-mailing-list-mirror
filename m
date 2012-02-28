From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 09/10] column: support piping stdout to external git-column process
Date: Tue, 28 Feb 2012 18:58:50 +0700
Message-ID: <1330430331-19945-10-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 13:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2LkK-0006m8-7b
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 13:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965512Ab2B1MB1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 07:01:27 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58410 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965476Ab2B1MB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 07:01:26 -0500
Received: by pbcup15 with SMTP id up15so3215944pbc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 04:01:26 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.233.36 as permitted sender) client-ip=10.68.233.36;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.233.36 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.233.36])
        by 10.68.233.36 with SMTP id tt4mr53630721pbc.67.1330430486206 (num_hops = 1);
        Tue, 28 Feb 2012 04:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/SdjUmy98FtiEGdWFB1Lnpij6wrDd5aGonjfZJAziwI=;
        b=oou5A670lieRCjyqCCT1cclUCpZm4zKecA0hceiAlWTrus3c961jMR7Qt2OLU+UiPK
         0jDCnpKodbpeMgeIxWoOpYiTO6YwUzolA+WIhBH322SgkAo0DqzLceoowMZW8JJCtwLw
         l7JAk9oj2EjrRFDFsogtm/9LIhuE+JaGixMwo=
Received: by 10.68.233.36 with SMTP id tt4mr45286800pbc.67.1330430486152;
        Tue, 28 Feb 2012 04:01:26 -0800 (PST)
Received: from tre ([115.74.56.186])
        by mx.google.com with ESMTPS id o7sm15534318pbq.8.2012.02.28.04.01.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 04:01:24 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 28 Feb 2012 19:01:31 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330430331-19945-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191723>

=46or too complicated output handling, it'd be easier to just spawn
git-column and redirect stdout to it. This patch provides helpers
to do that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 column.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h |    3 ++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 67bfd06..103d98c 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "color.h"
 #include "utf8.h"
=20
@@ -405,3 +406,71 @@ int parseopt_column_callback(const struct option *=
opt,
 	*mode |=3D COL_ENABLED | COL_ENABLED_SET;
 	return 0;
 }
+
+static int fd_out =3D -1;
+static struct child_process column_process;
+
+int run_column_filter(int colopts, const struct column_options *opts)
+{
+	const char *av[10];
+	int ret, ac =3D 0;
+	struct strbuf sb_colopt  =3D STRBUF_INIT;
+	struct strbuf sb_width   =3D STRBUF_INIT;
+	struct strbuf sb_padding =3D STRBUF_INIT;
+
+	if (fd_out !=3D -1)
+		return -1;
+
+	av[ac++] =3D "column";
+	strbuf_addf(&sb_colopt, "--rawmode=3D%d", colopts);
+	av[ac++] =3D sb_colopt.buf;
+	if (opts->width) {
+		strbuf_addf(&sb_width, "--width=3D%d", opts->width);
+		av[ac++] =3D sb_width.buf;
+	}
+	if (opts->indent) {
+		av[ac++] =3D "--indent";
+		av[ac++] =3D opts->indent;
+	}
+	if (opts->padding) {
+		strbuf_addf(&sb_padding, "--padding=3D%d", opts->padding);
+		av[ac++] =3D sb_padding.buf;
+	}
+	av[ac] =3D NULL;
+
+	fflush(stdout);
+	memset(&column_process, 0, sizeof(column_process));
+	column_process.in =3D -1;
+	column_process.out =3D dup(1);
+	column_process.git_cmd =3D 1;
+	column_process.argv =3D av;
+
+	ret =3D start_command(&column_process);
+
+	strbuf_release(&sb_colopt);
+	strbuf_release(&sb_width);
+	strbuf_release(&sb_padding);
+
+	if (ret)
+		return -2;
+
+	fd_out =3D dup(1);
+	close(1);
+	dup2(column_process.in, 1);
+	close(column_process.in);
+	return 0;
+}
+
+int stop_column_filter(void)
+{
+	if (fd_out =3D=3D -1)
+		return -1;
+
+	fflush(stdout);
+	close(1);
+	finish_command(&column_process);
+	dup2(fd_out, 1);
+	close(fd_out);
+	fd_out =3D -1;
+	return 0;
+}
diff --git a/column.h b/column.h
index 43528da..cb81c8a 100644
--- a/column.h
+++ b/column.h
@@ -34,4 +34,7 @@ struct option;
 extern int parseopt_column_callback(const struct option *opt,
 				    const char *arg, int unset);
=20
+extern int run_column_filter(int colopts, const struct column_options =
*);
+extern int stop_column_filter();
+
 #endif
--=20
1.7.8.36.g69ee2
