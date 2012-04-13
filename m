From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v9 8/9] column: support piping stdout to external git-column process
Date: Fri, 13 Apr 2012 17:54:40 +0700
Message-ID: <1334314481-14470-9-git-send-email-pclouds@gmail.com>
References: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 12:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIeBT-0007VY-0s
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 12:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935246Ab2DMK4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 06:56:50 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:37934 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758525Ab2DMK4s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 06:56:48 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so3768806dak.11
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WXXJIg4bfl1vbLtr2J9pNTCrHLg/Q7oihzl3/DwP5wM=;
        b=Y8X3cWy+ulhTkz6T4kXS+Mumd5ImDAbrUeI/rQFMPt0k6j+rNuoZnMrcEh1RC7BuMk
         3l1hUxClYY1PWLP//mtU0m43o9c6vJWufEcqOUOQlhnufPbLlHVmVAdB+SxBboW0uV9d
         vRfQLqPQc0lAQB/H876Oai5R1oSS1n0z0mVSMyooQuTqXRj7xi5zJV4RwmfvXznN4F6e
         iHT4/7wrHKpUErvYNyeFNVARn6HmH/byB8CW7h0Js9f+qYylToZprmXrW/9Ah/MGI5wG
         ASi7dYB9osXs6ZxsB/t72zO6RDgPv3EX2S4maGnLoiEGXo2OVQZFy7NZam7Y+DEF87xq
         aYHg==
Received: by 10.68.194.136 with SMTP id hw8mr4040693pbc.10.1334314608714;
        Fri, 13 Apr 2012 03:56:48 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wi8sm5295609pbc.11.2012.04.13.03.56.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 03:56:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 13 Apr 2012 17:56:00 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334314481-14470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195418>

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
index 0fb7582..952ab38 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "utf8.h"
=20
 #define XY2LINEAR(d, x, y) (COL_LAYOUT((d)->colopts) =3D=3D COL_COLUMN=
 ? \
@@ -364,3 +365,71 @@ int parseopt_column_callback(const struct option *=
opt,
=20
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
+	strbuf_addf(&sb_colopt, "--raw-mode=3D%d", colopts);
+	av[ac++] =3D sb_colopt.buf;
+	if (opts && opts->width) {
+		strbuf_addf(&sb_width, "--width=3D%d", opts->width);
+		av[ac++] =3D sb_width.buf;
+	}
+	if (opts && opts->indent) {
+		av[ac++] =3D "--indent";
+		av[ac++] =3D opts->indent;
+	}
+	if (opts && opts->padding) {
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
index 4f178d8..0a61917 100644
--- a/column.h
+++ b/column.h
@@ -39,4 +39,7 @@ static inline int column_active(unsigned int colopts)
 extern void print_columns(const struct string_list *list, unsigned int=
 colopts,
 			  const struct column_options *opts);
=20
+extern int run_column_filter(int colopts, const struct column_options =
*);
+extern int stop_column_filter(void);
+
 #endif
--=20
1.7.3.1.256.g2539c.dirty
