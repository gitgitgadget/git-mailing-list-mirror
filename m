From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 10/28] fetch-pack.c: move shallow update code out of fetch_pack()
Date: Thu,  5 Dec 2013 20:02:37 +0700
Message-ID: <1386248575-10206-11-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWZ-0001sE-BG
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab3LEM7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:19 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62325 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156Ab3LEM7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:18 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so25784683pbb.18
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ib/G37Thnv//gmfhyMfgtnmmiacCI6JmiWnI+7LXbdY=;
        b=Gh7qvGE0+QfIE2+piuLZuJCJL9Z441fD+bC9+ocmE/gxu+mbN9ym6AmOsj2qOFHtqw
         zyFpYChWdQzw6W6xcZb14No/kxase9oFj6ZLd1FzxSuP65nSLtkmIugB0igUHMfjkxeq
         VippUwvqH+xEbWRFGAce/7AcpU5mDHoGFG0H+TPmjPxWUzq9OpGCWuIkyq+Hj1yDdjBm
         WyV3o5JqC4+V9rEOa1YcCqkikU7CQ708kY5WiLSvJmk0siHa63c0IDd8e/3LDckfBV6s
         +a068/vBM7Ie5Vf6dNE2j9AhWJ+YNQ00w05SOlDBHLu1FNrq93ohtqhK3/31HWO2TCq9
         Y5FA==
X-Received: by 10.67.5.233 with SMTP id cp9mr19945505pad.147.1386248357747;
        Thu, 05 Dec 2013 04:59:17 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id iu7sm144587341pbc.45.2013.12.05.04.59.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:02 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238866>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0e7483e..35d097e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -925,6 +925,18 @@ static int remove_duplicates_in_refs(struct ref **=
ref, int nr)
 	return dst;
 }
=20
+static void update_shallow(struct fetch_pack_args *args)
+{
+	if (args->depth > 0 && alternate_shallow_file) {
+		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
+			unlink_or_warn(git_path("shallow"));
+			rollback_lock_file(&shallow_lock);
+		} else
+			commit_lock_file(&shallow_lock);
+		return;
+	}
+}
+
 struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
@@ -943,15 +955,7 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
s,
 		die("no matching remote head");
 	}
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
-
-	if (args->depth > 0 && alternate_shallow_file) {
-		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
-			unlink_or_warn(git_path("shallow"));
-			rollback_lock_file(&shallow_lock);
-		} else
-			commit_lock_file(&shallow_lock);
-	}
-
+	update_shallow(args);
 	reprepare_packed_git();
 	return ref_cpy;
 }
--=20
1.8.5.1.25.g8667982
