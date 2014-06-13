From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/32] read-cache: relocate and unexport commit_locked_index()
Date: Fri, 13 Jun 2014 19:19:24 +0700
Message-ID: <1402661991-14977-6-git-send-email-pclouds@gmail.com>
References: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 14:20:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQTK-0002hs-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaFMMUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 08:20:37 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39046 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaFMMUg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:20:36 -0400
Received: by mail-pa0-f53.google.com with SMTP id kx10so2102970pab.40
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/n5HM5ROG3H/MAy1ulT0XJsmwQ7y4CwLry274J7Q/rk=;
        b=QaJA41Eol8guP6vi2vSs7nj3oXjftSg7JmlKpw7gAr3UlkoFv1VsCQsLZ22uvgxFNo
         8uAVRD1DPiZi5PD5kSSkXFjCCP9yG0ZXcYYX9OFc3zZcZvJlba42jWVaIBRttmhSgAJ5
         jOJi41Q9H6NX9DCQnyPpX3u9Xqejz799r1kaMhgN58UgoRO37RLvXclrOH2DZblUZaGE
         bL2YtBieLBYpzHdfl0NtoK4EixHWZ9lMSsY3OtrGpbV63JqN4b6qSRb3kVIppu7+qvEH
         IlEglZGiYpfpv+hEAwCKbK0O3jclUxJBWzH8XK57Yk3nwdIJ2+kBqBXSSUwjBlxFEaFB
         lZ/w==
X-Received: by 10.66.218.36 with SMTP id pd4mr2774346pac.141.1402662036145;
        Fri, 13 Jun 2014 05:20:36 -0700 (PDT)
Received: from lanh ([115.73.228.145])
        by mx.google.com with ESMTPSA id hk5sm3372556pbb.86.2014.06.13.05.20.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 05:20:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:20:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402661991-14977-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251561>

This function is now only used by write_locked_index(). Move it to
read-cache.c (because read-cache.c will need to be aware of
alternate_index_output later) and unexport it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h      |  1 -
 lockfile.c   | 20 --------------------
 read-cache.c | 20 ++++++++++++++++++++
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 9cc2b97..e44048c 100644
--- a/cache.h
+++ b/cache.h
@@ -552,7 +552,6 @@ extern int commit_lock_file(struct lock_file *);
 extern void update_index_if_able(struct index_state *, struct lock_fil=
e *);
=20
 extern int hold_locked_index(struct lock_file *, int);
-extern int commit_locked_index(struct lock_file *);
 extern void set_alternate_index_output(const char *);
 extern int close_lock_file(struct lock_file *);
 extern void rollback_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 8fbcb6a..b706614 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -5,7 +5,6 @@
 #include "sigchain.h"
=20
 static struct lock_file *lock_file_list;
-static const char *alternate_index_output;
=20
 static void remove_lock_file(void)
 {
@@ -252,25 +251,6 @@ int hold_locked_index(struct lock_file *lk, int di=
e_on_error)
 					 : 0);
 }
=20
-void set_alternate_index_output(const char *name)
-{
-	alternate_index_output =3D name;
-}
-
-int commit_locked_index(struct lock_file *lk)
-{
-	if (alternate_index_output) {
-		if (lk->fd >=3D 0 && close_lock_file(lk))
-			return -1;
-		if (rename(lk->filename, alternate_index_output))
-			return -1;
-		lk->filename[0] =3D 0;
-		return 0;
-	}
-	else
-		return commit_lock_file(lk);
-}
-
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
diff --git a/read-cache.c b/read-cache.c
index 44d4732..a7b48a9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -36,6 +36,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
 #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
=20
 struct index_state the_index;
+static const char *alternate_index_output;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1875,6 +1876,25 @@ static int do_write_index(struct index_state *is=
tate, int newfd)
 	return 0;
 }
=20
+void set_alternate_index_output(const char *name)
+{
+	alternate_index_output =3D name;
+}
+
+static int commit_locked_index(struct lock_file *lk)
+{
+	if (alternate_index_output) {
+		if (lk->fd >=3D 0 && close_lock_file(lk))
+			return -1;
+		if (rename(lk->filename, alternate_index_output))
+			return -1;
+		lk->filename[0] =3D 0;
+		return 0;
+	} else {
+		return commit_lock_file(lk);
+	}
+}
+
 static int do_write_locked_index(struct index_state *istate, struct lo=
ck_file *lock,
 				 unsigned flags)
 {
--=20
1.9.1.346.ga2b5940
