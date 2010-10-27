From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/34] builtins: print setup info if repo is found
Date: Wed, 27 Oct 2010 21:49:04 +0700
Message-ID: <1288190977-30875-2-git-send-email-pclouds@gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 16:49:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7K9-00064J-Iu
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 16:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445Ab0J0Otv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 10:49:51 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61352 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760628Ab0J0Ott (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 10:49:49 -0400
Received: by mail-yx0-f174.google.com with SMTP id 8so64577yxk.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=03dUfx7jjeX/CS84vY077VyLG0mSLZ/BxTeOSfxlIro=;
        b=tHJkCQatHVcey/KDC72bB/p9b9TemC417OzcdpUXUQmiGCkLbMSm4Pfqa16vqqbMoe
         0isB08l87+6ANB7wGNt/6qqxi1Cml8gkRaPe8+LlLIFspg0QEfzVsYEUKtmJUIRtE5Hj
         8pUFnHeuuUmiBN2SMEMCHaBqf2VGjYtBdxd4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EsjdmR4IiLJhUVpOKEWDe/qwRrDnE5/ngF0OU2gnJWn8BIEui10Rnoob3BY+3YWodF
         1TSEMYF9xcwIpS5ciNtN24gc6KxHTKEMOyCgzBQoNeXiUpH3LzvZqWks7m/BDsImIlUA
         4oRhWR6lJHmKuy7cVMmZM+hUcLKUzyg3/2F3Y=
Received: by 10.151.157.21 with SMTP id j21mr5359825ybo.50.1288190989108;
        Wed, 27 Oct 2010 07:49:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id q36sm8779344ybk.6.2010.10.27.07.49.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 07:49:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 27 Oct 2010 21:49:46 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288190977-30875-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160040>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 It's not perfect. "setup: " lines won't always appear. That can be
 done once setup code is cleaned up a bit.

 cache.h |    1 +
 git.c   |   36 ++++++++++++++++++++++++++++++++++++
 trace.c |   11 +++++++++++
 3 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..d5ccf40 100644
--- a/cache.h
+++ b/cache.h
@@ -1058,6 +1058,7 @@ extern void *alloc_object_node(void);
 extern void alloc_report(void);
=20
 /* trace.c */
+int has_trace_fd();
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
 __attribute__((format (printf, 2, 3)))
diff --git a/git.c b/git.c
index 50a1401..22ade18 100644
--- a/git.c
+++ b/git.c
@@ -244,6 +244,29 @@ struct cmd_struct {
 	int option;
 };
=20
+static const char *quote_crnl(const char *path)
+{
+	static char new_path[PATH_MAX];
+	const char *p2 =3D path;
+	char *p1 =3D new_path;
+
+	if (!path)
+		return NULL;
+
+	while (*p2) {
+		switch (*p2) {
+		case '\\': *p1++ =3D '\\'; *p1++ =3D '\\'; break;
+		case '\n': *p1++ =3D '\\'; *p1++ =3D 'n'; break;
+		case '\r': *p1++ =3D '\\'; *p1++ =3D 'r'; break;
+		default:
+			*p1++ =3D *p2;
+		}
+		p2++;
+	}
+	*p1 =3D '\0';
+	return new_path;
+}
+
 static int run_builtin(struct cmd_struct *p, int argc, const char **ar=
gv)
 {
 	int status, help;
@@ -264,6 +287,19 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 			use_pager =3D check_pager_config(p->cmd);
 		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
 			use_pager =3D 1;
+
+		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
+		    startup_info->have_repository && /* get_git_dir() may set up rep=
o, avoid that */
+		    has_trace_fd()) {
+			char cwd[PATH_MAX];
+			if (!getcwd(cwd, PATH_MAX))
+				die("Unable to get current working directory");
+
+			trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+			trace_printf("setup: worktree: %s\n", quote_crnl(get_git_work_tree(=
)));
+			trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
+			trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
+		}
 	}
 	commit_pager_choice();
=20
diff --git a/trace.c b/trace.c
index 1e560cb..fbf7de0 100644
--- a/trace.c
+++ b/trace.c
@@ -29,6 +29,17 @@ void do_nothing(size_t unused)
 {
 }
=20
+int has_trace_fd()
+{
+	char *trace =3D getenv("GIT_TRACE");
+
+	if (!trace || !strcmp(trace, "") ||
+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+		return 0;
+
+	return 1;
+}
+
 /* Get a trace file descriptor from GIT_TRACE env variable. */
 static int get_trace_fd(int *need_close)
 {
--=20
1.7.0.2.445.gcbdb3
