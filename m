From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 10/11] column: support piping stdout to external git-column process
Date: Sat, 25 Feb 2012 18:41:17 +0700
Message-ID: <1330170078-29353-11-git-send-email-pclouds@gmail.com>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 12:40:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1FzC-0002Ur-Im
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 12:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab2BYLkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 06:40:09 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44098 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab2BYLkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 06:40:07 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so3436768dae.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 03:40:07 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.230.201 as permitted sender) client-ip=10.68.230.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.230.201 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.230.201])
        by 10.68.230.201 with SMTP id ta9mr18668933pbc.74.1330170007569 (num_hops = 1);
        Sat, 25 Feb 2012 03:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7uQXk2iWAH1BQJyfUHZsOscedlyiVAgSCliVRB6gW7w=;
        b=qVVGs7JEDVzRXmEYgy3KLGP0U1NmaXJ085nIjHfe0kaexnQR53q9AfyEHBM7zgOob1
         KDjbBfYEso1Z3YYUx6p7UNrW5iKz380tuyZcUcAy5STYlCIlsJ+B0MHf5ztEzJ4bsMeE
         3UXS5ndJembd5Fl4BjXmDUvJ9RBZYsOyAVn9I=
Received: by 10.68.230.201 with SMTP id ta9mr15519505pbc.74.1330170007530;
        Sat, 25 Feb 2012 03:40:07 -0800 (PST)
Received: from tre ([115.74.53.120])
        by mx.google.com with ESMTPS id k6sm7012236pbl.27.2012.02.25.03.40.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 03:40:06 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 25 Feb 2012 18:42:26 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191532>

=46or too complicated output handling, it'd be easier to just spawn
git-column and redirect stdout to it. This patch provides helpers
to do that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h |    3 ++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 94fd1a1..ecf2d14 100644
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
@@ -407,3 +408,71 @@ int parseopt_column_callback(const struct option *=
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
