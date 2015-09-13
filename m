From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4] gc: save log from daemonized gc --auto and print it next time
Date: Sun, 13 Sep 2015 08:36:42 +0700
Message-ID: <1442108202-25746-1-git-send-email-pclouds@gmail.com>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 03:36:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZawDl-0007i4-UU
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 03:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbbIMBgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 21:36:41 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36493 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbbIMBgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 21:36:41 -0400
Received: by padhk3 with SMTP id hk3so108910134pad.3
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 18:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rrLohUnR87X82ufzWPdgHovSYUs383HRQEyR8p4W1Sg=;
        b=vTMeGerwBO9hS2micMylePdkfYenIVJpegMHL5PIMEMcbsJdZXDi/fKWDrEtq0aDhk
         7eojUFBIY+6H/rrWKqfr1FxZjNwq6c3wrMBCIGTiX8YAK1wAfe7tTMsNUyktkccg8F5y
         VsmCmhFGRHrkKkzK0nSFjIdZO4E6A5/BHUeouk0w1c9FJQdTPBDg5fkWLhqJzbzHSuUv
         RxVBMbhby/4oGLBlmVQxB2dGvRCkfdtdkk2/01XewN1Klon39iMfMSkKe3YgBoZXRg1+
         GobaxiQhFthuWqyiucTbKeDbqd2i1nMLUbZwZUvFV1rhYgB0xoLnWrghNT5SxDd5QGui
         yI9A==
X-Received: by 10.68.213.200 with SMTP id nu8mr16419669pbc.35.1442108200610;
        Sat, 12 Sep 2015 18:36:40 -0700 (PDT)
Received: from lanh ([171.233.230.25])
        by smtp.gmail.com with ESMTPSA id uk6sm8081019pac.27.2015.09.12.18.36.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2015 18:36:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Sep 2015 08:36:59 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277753>

While commit 9f673f9 (gc: config option for running --auto in
background - 2014-02-08) helps reduce some complaints about 'gc
--auto' hogging the terminal, it creates another set of problems.

The latest in this set is, as the result of daemonizing, stderr is
closed and all warnings are lost. This warning at the end of cmd_gc()
is particularly important because it tells the user how to avoid "gc
--auto" running repeatedly. Because stderr is closed, the user does
not know, naturally they complain about 'gc --auto' wasting CPU.

Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc --auto
will not run and gc.log printed out until the user removes gc.log.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 When gc.log exists, gc --auto now simply exits

 builtin/gc.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bcc75d9..2c3aaeb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -43,9 +43,20 @@ static struct argv_array prune_worktrees =3D ARGV_AR=
RAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
 static char *pidfile;
+static struct strbuf log_filename =3D STRBUF_INIT;
+static int daemonized;
=20
 static void remove_pidfile(void)
 {
+	if (daemonized && log_filename.len) {
+		struct stat st;
+
+		close(2);
+		if (stat(log_filename.buf, &st) ||
+		    !st.st_size ||
+		    rename(log_filename.buf, git_path("gc.log")))
+			unlink(log_filename.buf);
+	}
 	if (pidfile)
 		unlink(pidfile);
 }
@@ -330,13 +341,21 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
 		}
 		if (detach_auto) {
+			struct strbuf sb =3D STRBUF_INIT;
+			if (strbuf_read_file(&sb, git_path("gc.log"), 0) > 0)
+				return error(_("last gc run reported:\n"
+					       "%s\n"
+					       "not running until %s is removed"),
+					     sb.buf, git_path("gc.log"));
+			strbuf_release(&sb);
+
 			if (gc_before_repack())
 				return -1;
 			/*
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonize();
+			daemonized =3D !daemonize();
 		}
 	} else
 		add_repack_all_option();
@@ -349,6 +368,18 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 		    name, (uintmax_t)pid);
 	}
=20
+	if (daemonized) {
+		int fd;
+
+		strbuf_addstr(&log_filename, git_path("gc.log_XXXXXX"));
+		fd =3D xmkstemp(log_filename.buf);
+		if (fd >=3D 0) {
+			dup2(fd, 2);
+			close(fd);
+		} else
+			strbuf_release(&log_filename);
+	}
+
 	if (gc_before_repack())
 		return -1;
=20
--=20
2.3.0.rc1.137.g477eb31
