From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Revert be7c6d4 (pack-refs: remove newly empty directories)
Date: Sat, 11 Feb 2012 14:55:07 +0700
Message-ID: <1328946907-31650-2-git-send-email-pclouds@gmail.com>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
 <1328946907-31650-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 08:49:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw7hw-0002E5-4U
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 08:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab2BKHtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 02:49:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53599 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab2BKHtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 02:49:13 -0500
Received: by pbcun15 with SMTP id un15so3074102pbc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 23:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6memo3S8qNqRwOS8F/25T78T8VbYaBBWy7x0oejam24=;
        b=kFggMN7DfV0TRvwRmO1aFrhWIZ6Z4dV9fApUiRAkXaG/4kqjbKY0wd7RdeR+Mj5wvV
         q8M2e6N0xDknj8yxaAoFipPvNUUmIYwbxJnfvk0mWM7Kxdw0WxAHZrggSJZlIqpA2Eqz
         2GasMwPMEUJww3j5joPEIu+2bqyZpRkDA4JLM=
Received: by 10.68.218.231 with SMTP id pj7mr24487941pbc.63.1328946553400;
        Fri, 10 Feb 2012 23:49:13 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id a5sm19985026pbh.15.2012.02.10.23.49.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 23:49:12 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 11 Feb 2012 14:55:24 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328946907-31650-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190496>

The functionality is taken over by prune_empty_dirs. Only code is
reverted. The added test remains to verify.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pack-refs.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/pack-refs.c b/pack-refs.c
index bb3a9c4..746211e 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -60,37 +60,6 @@ static int handle_one_ref(const char *path, const un=
signed char *sha1,
 	return 0;
 }
=20
-/*
- * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
- */
-static void try_remove_empty_parents(char *name)
-{
-	char *p, *q;
-	int i;
-	p =3D name;
-	for (i =3D 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
-		while (*p && *p !=3D '/')
-			p++;
-		/* tolerate duplicate slashes; see check_refname_format() */
-		while (*p =3D=3D '/')
-			p++;
-	}
-	for (q =3D p; *q; q++)
-		;
-	while (1) {
-		while (q > p && *q !=3D '/')
-			q--;
-		while (q > p && *(q-1) =3D=3D '/')
-			q--;
-		if (q =3D=3D p)
-			break;
-		*q =3D '\0';
-		if (rmdir(git_path("%s", name)))
-			break;
-	}
-}
-
 static int prune_empty_dirs(const char *path)
 {
 	int nr_entries =3D 0, pathlen =3D strlen(path);
@@ -151,7 +120,6 @@ static void prune_ref(struct ref_to_prune *r)
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
 	}
 }
=20
--=20
1.7.8.36.g69ee2
