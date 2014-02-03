From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 20/26] read-cache: new variable to verify file-watcher results
Date: Mon,  3 Feb 2014 11:29:08 +0700
Message-ID: <1391401754-15347-21-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABBo-0001V4-9T
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbaBCEbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:15 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:62927 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaBCEbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:14 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so6402378pde.7
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4U9R0OANM6c7wATQrc73ixoWficooHYUeMKT2s9GOCw=;
        b=tAU2bmD6Qxgo4TEckA5AkuKGdjbf4EETizL7jEGCpR+svojwdPbXHKgopQYi6mzvhA
         QNDtdFbDd/M1dsg6AoTaZzqQmhfht1KQv+eeW+obDXsZpCTwizNB8cvpu42D8KjVZZJz
         X4WQUjhfy6QZhLVWByMPnAirXD4yGZY6LnS1K323q2eFNKFrtlDvHC+2D9DuRHQbSvD1
         +DwgSI0V173Ibkf1Vtf/xugwItCLLm2ugJFXHYm+3t5GrYurVMjscBi5yyVS3VfFnpmV
         cY9IT71wou5v40G/vRgWQXhHbRjpRLqKy5N47q/tQwiLSxhHZKcy8FdXm1sOrB92vjN6
         PmAA==
X-Received: by 10.66.233.71 with SMTP id tu7mr34981221pac.22.1391401873819;
        Sun, 02 Feb 2014 20:31:13 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id ns7sm51408158pbc.32.2014.02.02.20.31.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:11 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241415>

If GIT_TEST_WATCHED is set to a non-zero value, Git still uses file
watcher if configured. But it does lstat() anyway and notifies the
user if a file is changed but the file watcher said otherwise.

Note that there is a race condition. Changed paths are retrieved at
time X, then refresh and validation at time Y. Even if X and Y are
very close, an update can happen between X and Y, causing a false
report.

If GIT_TEST_WATCHED is set greater than 1, git will abort instead of
just warn and move on.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-file-watcher.txt |  8 ++++++++
 cache.h                            |  5 ++++-
 read-cache.c                       | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-file-watcher.txt b/Documentation/git-fil=
e-watcher.txt
index d694fea..dd09e30 100644
--- a/Documentation/git-file-watcher.txt
+++ b/Documentation/git-file-watcher.txt
@@ -25,6 +25,14 @@ OPTIONS
 --detach::
 	Run in background.
=20
+TROUBLESHOOTING
+---------------
+Setting environment variable `GIT_TEST_WATCHED` to a non-zero number
+makes Git communicate with the file watcher, but do lstat anyway to
+verify that the file watcher results. Setting to 1 prints warning when
+file watcher fails to monitor files correctly. Setting to 2 aborts Git
+when it happens.
+
 BUGS
 ----
 On Linux, file watcher may fail to detect changes if you move the work
diff --git a/cache.h b/cache.h
index c229bf9..806c886 100644
--- a/cache.h
+++ b/cache.h
@@ -224,7 +224,10 @@ static inline unsigned create_ce_flags(unsigned st=
age)
 #define ce_mark_uptodate(ce) ((ce)->ce_flags |=3D CE_UPTODATE)
 static inline int ce_valid(const struct cache_entry *ce)
 {
-	return ce->ce_flags & CE_VALID;
+	extern int test_watched;
+	if (!test_watched)
+		return ce->ce_flags & CE_VALID;
+	return (ce->ce_flags & CE_VALID) && !(ce->ce_flags & CE_WATCHED);
 }
=20
 #define ce_permissions(mode) (((mode) & 0100) ? 0755 : 0644)
diff --git a/read-cache.c b/read-cache.c
index 95c9ccb..d5f084a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -37,6 +37,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce, int reall
 #define CACHE_EXT_WATCH 0x57415443	  /* "WATC" */
=20
 struct index_state the_index;
+int test_watched;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1117,6 +1118,16 @@ static void show_file(const char * fmt, const ch=
ar * name, int in_porcelain,
 	printf(fmt, name);
 }
=20
+static void report_bad_watcher(struct index_state *istate,
+			       struct cache_entry *ce)
+{
+	if (test_watched > 1)
+		die("%s is updated but file-watcher said no",
+		    ce->name);
+	warning("%s is updated but file-watcher said no",
+		ce->name);
+}
+
 int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
@@ -1188,6 +1199,9 @@ int refresh_index(struct index_state *istate, uns=
igned int flags,
 				ce->ce_flags &=3D ~CE_VALID;
 				istate->cache_changed =3D 1;
 			}
+			if (test_watched &&
+			    (ce->ce_flags & CE_WATCHED) && (ce->ce_flags & CE_VALID))
+				report_bad_watcher(istate, ce);
 			if (quiet)
 				continue;
=20
@@ -1460,6 +1474,9 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	if (getenv("GIT_TEST_WATCHED"))
+		test_watched =3D atoi(getenv("GIT_TEST_WATCHED"));
+
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
--=20
1.8.5.2.240.g8478abd
