From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] daemon: move daemonize() to libgit.a
Date: Sat,  8 Feb 2014 14:08:51 +0700
Message-ID: <1391843332-20583-1-git-send-email-pclouds@gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, jugg@hotmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 08:08:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC225-0000sw-Ux
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 08:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbaBHHIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 02:08:53 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:63564 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaBHHIw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 02:08:52 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so4050460pde.14
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 23:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ai/U/2yg7VZkyFY3HdBuXWwXUJqOD7JyYKKVz9k+sow=;
        b=OVu8NKMjTGXDDgkPvbzjx/oajnpHOU42K9ilUh6xDhxjAeFsEEr+0onFdgEb1gJcC8
         5lGz+TAL4TBb2vTgkWHJcZe8AAk44lnESQvcU0L3gpLFFEISYUNIuOfxeM180jgKCfzA
         BgXb1yNoTBu323mR5+5MoFm5AR/HXfnmU0pgwSGa4ocz1pO1kO2UXymgUcB2JeJ6ewkC
         k9B6AlaX9JNvAVGFJta1TIGU+4R3VDDUwxXvVWoWlm8qJACiS8a2hnMardvKawiBG2IG
         FzBYIlj9xgWXaZ0844iYbvYsVVt83oOSOVLsLOdng/LRLVrWrJIaax04LpmDa4ZCpFWz
         kJAg==
X-Received: by 10.68.201.10 with SMTP id jw10mr24661870pbc.25.1391843331848;
        Fri, 07 Feb 2014 23:08:51 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id da3sm20465868pbc.30.2014.02.07.23.08.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 23:08:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 14:08:54 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241820>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h  |  1 +
 daemon.c | 30 ++++--------------------------
 setup.c  | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/cache.h b/cache.h
index dc040fb..264b6f1 100644
--- a/cache.h
+++ b/cache.h
@@ -434,6 +434,7 @@ extern int set_git_dir_init(const char *git_dir, co=
nst char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 extern void sanitize_stdfds(void);
+extern int daemonize(void);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
diff --git a/daemon.c b/daemon.c
index 503e039..eba1255 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1056,11 +1056,6 @@ static void drop_privileges(struct credentials *=
cred)
 	/* nothing */
 }
=20
-static void daemonize(void)
-{
-	die("--detach not supported on this platform");
-}
-
 static struct credentials *prepare_credentials(const char *user_name,
     const char *group_name)
 {
@@ -1102,24 +1097,6 @@ static struct credentials *prepare_credentials(c=
onst char *user_name,
=20
 	return &c;
 }
-
-static void daemonize(void)
-{
-	switch (fork()) {
-		case 0:
-			break;
-		case -1:
-			die_errno("fork failed");
-		default:
-			exit(0);
-	}
-	if (setsid() =3D=3D -1)
-		die_errno("setsid failed");
-	close(0);
-	close(1);
-	close(2);
-	sanitize_stdfds();
-}
 #endif
=20
 static void store_pid(const char *path)
@@ -1333,9 +1310,10 @@ int main(int argc, char **argv)
 	if (inetd_mode || serve_mode)
 		return execute();
=20
-	if (detach)
-		daemonize();
-	else
+	if (detach) {
+		if (daemonize())
+			die("--detach not supported on this platform");
+	} else
 		sanitize_stdfds();
=20
 	if (pid_file)
diff --git a/setup.c b/setup.c
index 6c3f85f..b09a412 100644
--- a/setup.c
+++ b/setup.c
@@ -787,3 +787,27 @@ void sanitize_stdfds(void)
 	if (fd > 2)
 		close(fd);
 }
+
+int daemonize(void)
+{
+#ifdef NO_POSIX_GOODIES
+	errno =3D -ENOSYS;
+	return -1;
+#else
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			die_errno("fork failed");
+		default:
+			exit(0);
+	}
+	if (setsid() =3D=3D -1)
+		die_errno("setsid failed");
+	close(0);
+	close(1);
+	close(2);
+	sanitize_stdfds();
+	return 0;
+#endif
+}
--=20
1.8.5.2.240.g8478abd
