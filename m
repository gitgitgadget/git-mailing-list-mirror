From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] daemonize: set a flag before exiting the main process
Date: Tue, 13 May 2014 18:15:31 +0700
Message-ID: <1399979737-8577-5-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAgv-00005d-45
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760457AbaEMLQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:16:08 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50394 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbaEMLQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:07 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so165581pbb.28
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YG5ZTXoYC60TOKNEm8zCJDzFaM2d2o/jvLKU2SESZF4=;
        b=AEBLU1UaJ9qsPAFMX2sqJ5kUUy/80MLwbpkeiS+X6LsU4pe9IhYvvNAF/M4ed1zMnH
         czOzQuvxrquwJgZqUlN9W7bOeq6aNkpjdINK8Qs3AsgtD8L+dZnP75wJgaIzKZxSuYE+
         zJkXFin70XED8UQ4wDTyXwEBUTATaz/u3541lGsqZOQQ8zF1exjHuyhT5MKCd5Ynczkk
         mfslHuAHFU/AWlxYoPeKI1abT8OcsJEU9QYdZpho6w+ZHqZSd/dfq0foqeTKX9FW7sWP
         NfKN7qbctMyog4kdQmEG+fqOH2qhDpjgn8vzGgBl1EubhmrNZKkuUrSyq4e1kvjHbXHM
         tQmA==
X-Received: by 10.67.14.69 with SMTP id fe5mr63725876pad.120.1399979756056;
        Tue, 13 May 2014 04:15:56 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id bq4sm13181709pbb.60.2014.05.13.04.15.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:15:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:01 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248764>

This allows signal handlers and atexit functions to realize this
situation and not clean up.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 2 +-
 cache.h      | 2 +-
 daemon.c     | 2 +-
 setup.c      | 4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 85f5c2b..50275af 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -325,7 +325,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonize();
+			daemonize(NULL);
 	} else
 		add_repack_all_option();
=20
diff --git a/cache.h b/cache.h
index 6549e02..d0ff11c 100644
--- a/cache.h
+++ b/cache.h
@@ -450,7 +450,7 @@ extern int set_git_dir_init(const char *git_dir, co=
nst char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 extern void sanitize_stdfds(void);
-extern int daemonize(void);
+extern int daemonize(int *);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
diff --git a/daemon.c b/daemon.c
index eba1255..2650504 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1311,7 +1311,7 @@ int main(int argc, char **argv)
 		return execute();
=20
 	if (detach) {
-		if (daemonize())
+		if (daemonize(NULL))
 			die("--detach not supported on this platform");
 	} else
 		sanitize_stdfds();
diff --git a/setup.c b/setup.c
index 613e3b3..e8e129a 100644
--- a/setup.c
+++ b/setup.c
@@ -842,7 +842,7 @@ void sanitize_stdfds(void)
 		close(fd);
 }
=20
-int daemonize(void)
+int daemonize(int *daemonized)
 {
 #ifdef NO_POSIX_GOODIES
 	errno =3D ENOSYS;
@@ -854,6 +854,8 @@ int daemonize(void)
 		case -1:
 			die_errno("fork failed");
 		default:
+			if (daemonized)
+				*daemonized =3D 1;
 			exit(0);
 	}
 	if (setsid() =3D=3D -1)
--=20
1.9.1.346.ga2b5940
