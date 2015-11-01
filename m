From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 7/9] daemonize(): set a flag before exiting the main process
Date: Sun,  1 Nov 2015 14:42:47 +0100
Message-ID: <1446385369-8669-8-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZssvE-0008Pu-Ej
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbbKANnm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:43:42 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32795 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbKANni (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:43:38 -0500
Received: by wmeg8 with SMTP id g8so40715531wme.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TBBVBIARgjf9d3UeI04lCU0a12FO6c5zbhfbz349uDs=;
        b=D/VPy2bq0H+E17a3j7KEK5ZYANeqSTTdkYhNgGkRfqiRRZxQGskhxtwohfGPFBqnoN
         9SzLBSExgD0eBDzxoVy0otRxZNZsANi4b52OzT8EI/pdsDUPOSDG8Ft/lkJhj0JX5M2p
         O+1OIEnk2BQ0zjSLjg4Lw1O28PnB7h2e82pGJeJN68ZwrJ7p/OvB/lqN/TJw5hPhGd/r
         4SidSJ5eBFcrupcBknGhEcyfSBdZzox03fh1XXlspx3RhvHUjXzLWc3o08mLZBVLwqiK
         /TO4U57taLo67dbeXHt/ag3aTN/gKHaUOA1sQmmn38fg+79xxshjObNrAevZMgctXvxg
         IIQQ==
X-Received: by 10.28.88.129 with SMTP id m123mr8528604wmb.76.1446385417509;
        Sun, 01 Nov 2015 05:43:37 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:36 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280622>

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
index df3e454..e59c9d2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -369,7 +369,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonized =3D !daemonize();
+			daemonized =3D !daemonize(NULL);
 		}
 	} else
 		add_repack_all_option();
diff --git a/cache.h b/cache.h
index dd3df26..9633acc 100644
--- a/cache.h
+++ b/cache.h
@@ -490,7 +490,7 @@ extern int set_git_dir_init(const char *git_dir, co=
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
index 56679a1..9f9f057 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1364,7 +1364,7 @@ int main(int argc, char **argv)
 		return execute();
=20
 	if (detach) {
-		if (daemonize())
+		if (daemonize(NULL))
 			die("--detach not supported on this platform");
 	} else
 		sanitize_stdfds();
diff --git a/setup.c b/setup.c
index d343725..968af3d 100644
--- a/setup.c
+++ b/setup.c
@@ -1015,7 +1015,7 @@ void sanitize_stdfds(void)
 		close(fd);
 }
=20
-int daemonize(void)
+int daemonize(int *daemonized)
 {
 #ifdef NO_POSIX_GOODIES
 	errno =3D ENOSYS;
@@ -1027,6 +1027,8 @@ int daemonize(void)
 		case -1:
 			die_errno("fork failed");
 		default:
+			if (daemonized)
+				*daemonized =3D 1;
 			exit(0);
 	}
 	if (setsid() =3D=3D -1)
--=20
2.2.0.513.g477eb31
