From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 7/9] daemonize(): set a flag before exiting the main process
Date: Mon, 28 Jul 2014 19:03:13 +0700
Message-ID: <1406548995-28549-8-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjfM-00035r-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbaG1ME2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:04:28 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:52995 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1ME1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:04:27 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so10344992pab.15
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PmSUbgTXNlo2LX76yDncB5QPiMmflgar1O/Iso2H7vw=;
        b=gM56tyAKbNJZ5CiTPpHb1dhXKRXInY9mTIfH78AWzVfM4aFP2fCt8cfojIQYfXTrCt
         ldJ9iagjNq3zEBop9Ee5HYrGj6OfRFnE9sNxxj+IxnCfO6B/Mg7dCqeWeYCa3NJzD19V
         sT35BXvqhpQbEe9ngIOd8DaQ4u9UM0nni8KDkqX2tMrAmLsTNpsQM+ZYdhiA1YEU8Ac4
         Zs9Dvfy+ht+vukRdo+Q0uPtcruYFBSkq7z9/dnImPontv/mjKyNnJdQt7zIVXUmdgjGy
         lkk1MzunfVdZUGgs/KHbcHiFMgMxo7I4YDdEHCQ1LXdeBDCcH33pPh0WPoKiP+vFVkWp
         deZA==
X-Received: by 10.66.192.73 with SMTP id he9mr38384214pac.88.1406549067281;
        Mon, 28 Jul 2014 05:04:27 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id dw8sm35140887pab.35.2014.07.28.05.04.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:04:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:29 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254321>

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
index 8d219d8..f120b4f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -341,7 +341,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonize();
+			daemonize(NULL);
 		}
 	} else
 		add_repack_all_option();
diff --git a/cache.h b/cache.h
index 0f515e5..f568c8a 100644
--- a/cache.h
+++ b/cache.h
@@ -467,7 +467,7 @@ extern int set_git_dir_init(const char *git_dir, co=
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
index e6b51ed..cfdf0f6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1306,7 +1306,7 @@ int main(int argc, char **argv)
 		return execute();
=20
 	if (detach) {
-		if (daemonize())
+		if (daemonize(NULL))
 			die("--detach not supported on this platform");
 	} else
 		sanitize_stdfds();
diff --git a/setup.c b/setup.c
index 0a22f8b..b509395 100644
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
2.1.0.rc0.66.gb9187ad
