From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/12] Add helpers to redirect stdout to "git column"
Date: Sun,  7 Mar 2010 19:09:39 +0700
Message-ID: <1267963785-473-7-git-send-email-pclouds@gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 13:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoFMb-0006M7-0F
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 13:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab0CGMNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 07:13:31 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:43117 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab0CGMN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 07:13:28 -0500
Received: by mail-pz0-f194.google.com with SMTP id 32so2186141pzk.4
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/wZcpSPykvefJ7ke6poH54vWeu0dVak1BVm1bTQA4T0=;
        b=Z+tvLyjTjjfwSscQNiwWVy1pLeNZ/eN3mhT13agtUsah+RxOSnYCy+gNUN+d4ks2OE
         5vvfY0z49G/R67fGDd8k2ryHOUKDSS9GLQroeFfxyqj8KcH2XBekJ7uOsIkACJx6dfyW
         5YN/dkT7Dq7JACexQJwrrHo4JQw6rgQTHir2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Oi/x8QWWnP1gflKXYZElkkUO26wcty8ZSTeimx+uzfpbvb63wOlqvoeJ97f4mByZUb
         jAjKBCrlmcKAjtkbhCPouOPEfe6B2EK8UTmSk7I05TOhSaGzgDxP7+a9kW3xITeCiwmV
         7SCCF1iP/4ZPPocvipABSoMBen7BOkbaoxwOY=
Received: by 10.143.21.18 with SMTP id y18mr2303202wfi.58.1267964008143;
        Sun, 07 Mar 2010 04:13:28 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3610583pzk.4.2010.03.07.04.13.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 04:13:27 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 19:10:12 +0700
X-Mailer: git-send-email 1.7.0.1.370.gd3c5
In-Reply-To: <1267963785-473-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141681>

While the columnizer can be used directly, it requires output code
change. The helpers instead redirect all output to "git column" and
let "git column" do all the layout work. This keeps code change
minimum. All we need is:

start_columnizer();
/* do some complex computation and output to stdout */
stop_columnizer();

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.h |    2 +
 pager.c  |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/column.h b/column.h
index 28122e0..6eb19e3 100644
--- a/column.h
+++ b/column.h
@@ -21,3 +21,5 @@ struct columnizer {
 };
=20
 extern int feed_columnizer(struct columnizer *cp, char *cell);
+extern int start_columnizer(const char **argv);
+extern int stop_columnizer();
diff --git a/pager.c b/pager.c
index ad447cf..9df727d 100644
--- a/pager.c
+++ b/pager.c
@@ -13,6 +13,8 @@
=20
 static int spawned_pager;
 static int max_columns;
+static int fd_out =3D -1;
+static struct child_process column_process;
=20
 #ifndef WIN32
 static void pager_preexec(void)
@@ -148,3 +150,64 @@ int term_columns()
 #endif
 	return 80;
 }
+
+int start_columnizer(const char **argv)
+{
+	int new_argc, argc =3D 0;
+	const char **column_argv;
+	char columns_param[32];
+
+	if (fd_out !=3D -1)
+		return -1;
+
+	if (argv) {
+		while (argv[argc])
+			argc++;
+	}
+	new_argc =3D argc + 1; /* argv[0] =3D "column" */
+	if (spawned_pager && max_columns) {
+		sprintf(columns_param, "--width=3D%d", max_columns);
+		new_argc++;
+	}
+
+	column_argv =3D xmalloc(sizeof(*column_argv)*(new_argc+1));
+	column_argv[0] =3D "column";
+	if (spawned_pager && max_columns)
+		column_argv[1] =3D columns_param;
+	if (argv)
+		memcpy(column_argv + (new_argc-argc), argv, argc*sizeof(*argv));
+	column_argv[new_argc] =3D NULL;
+
+	fflush(stdout);
+	memset(&column_process, 0, sizeof(column_process));
+	column_process.in =3D -1;
+	column_process.out =3D dup(1);
+	column_process.git_cmd =3D 1;
+	column_process.argv =3D column_argv;
+
+	if (start_command(&column_process)) {
+		free(column_argv);
+		return -2;
+	}
+	free(column_argv);
+
+	fd_out =3D dup(1);
+	close(1);
+	dup2(column_process.in, 1);
+	close(column_process.in);
+	return 0;
+}
+
+int stop_columnizer()
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
--=20
1.7.0.1.370.gd3c5
