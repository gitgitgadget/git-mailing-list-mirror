From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/32] read-cache: relocate and unexport commit_locked_index()
Date: Mon, 28 Apr 2014 17:55:26 +0700
Message-ID: <1398682553-11634-6-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejDQ-0001If-H8
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755059AbaD1KzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:55:03 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44433 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284AbaD1Ky7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:54:59 -0400
Received: by mail-pb0-f53.google.com with SMTP id jt11so3987239pbb.12
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SuXp4/U384uOLKhHwSoTWe0kT3NxnqdonY40Se1M9S8=;
        b=bAwATp0YkTHk5mAkuh5ZgiL4L/ozTYxwZy+uzHeLIMtT3sRp5QO27GZ7+d2q+f+4Jl
         ttVPjtpxrgP0b6tC45/KxdnbMhZo/Dx1gpEPRtQ7qD2tJOB7nKalViCtVK9F3jCi+OMk
         Baz1VTjNPbv6kYlRffdChydBvrm50j/uc/u9+d/Fnui4ZuWlN6+vreJmEmwF9N1r+PgI
         ttxxwdIzcR8PJMFkqnKBVzFFqS95qTyJF1jEU7kctSv4olpnikGGx53klE+Hbcwn6ydI
         THwsfSkAK6IfdcCPkXlEqMWVSY4urJkbpvBUVUxDxN8Tn7xTAncLVwgFKob+V5r/7TcG
         TM6Q==
X-Received: by 10.68.141.102 with SMTP id rn6mr24445935pbb.43.1398682499356;
        Mon, 28 Apr 2014 03:54:59 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id oa3sm34227845pbb.15.2014.04.28.03.54.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:54:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:27 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247272>

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
index 44d4732..576e506 100644
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
+	}
+	else
+		return commit_lock_file(lk);
+}
+
 static int do_write_locked_index(struct index_state *istate, struct lo=
ck_file *lock,
 				 unsigned flags)
 {
--=20
1.9.1.346.ga2b5940
