From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] daemonize(): set a flag before exiting the main process
Date: Tue, 10 Jun 2014 20:24:24 +0700
Message-ID: <1402406665-27988-5-git-send-email-pclouds@gmail.com>
References: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:26:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuM4g-0004Lz-VU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 15:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaFJN0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 09:26:46 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51160 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaFJN0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 09:26:45 -0400
Received: by mail-pd0-f176.google.com with SMTP id p10so6101367pdj.21
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 06:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=YtxahA2R+rrxaouyyt8EO+qM9iUDaQO0JgWGrVkxnwo=;
        b=Wp2AUUI1A+DKFZu7aKjbHwP2nXb+rTV6jecZRw5cdNhHBwr/Xh5CbTnUAPFnLeUFJj
         It8x94dYTFfSafEYmkc6NbgivOseqblfnBGvyhH0fiEcDUySoBtQdvARTryqGQqAUHXA
         EeTcqaTx92E2hO8M3ZxVbmo/j4Csvtlhi4/ASF/wuizmky94jpGV8n9gXgTLXwJoUomM
         3ntuQb/TrAYC20RKM8RA79p1rk320O8kV6Dn3V59Nzeec/6VoIMGxNkzvd2HUTEBEJ3l
         1EzrvgMJAPMHqaf6ks0qwkQfU9SUEyzXeC/lxNxNuVo020NetQ0wuPZPui8iXB3XBeXH
         tAfg==
X-Received: by 10.68.229.36 with SMTP id sn4mr9348189pbc.51.1402406805063;
        Tue, 10 Jun 2014 06:26:45 -0700 (PDT)
Received: from lanh ([115.73.243.79])
        by mx.google.com with ESMTPSA id oa3sm69637571pbb.15.2014.06.10.06.26.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 06:26:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Jun 2014 20:26:39 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251190>

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
index f05e062..6f4b863 100644
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
