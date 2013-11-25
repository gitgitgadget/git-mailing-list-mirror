From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/28] fetch-pack.c: move shallow update code out of fetch_pack()
Date: Mon, 25 Nov 2013 10:55:36 +0700
Message-ID: <1385351754-9954-11-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDq-0001q6-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab3KYDw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:26 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48937 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:26 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so4738264pbc.26
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=G8NGkTCeKcimOyjxthtDryW5CdTqwFiY8KirAvEQurw=;
        b=oAIVKfUPOuDIL8nfSEMnHLsXUSKC9q7n1zR/zYf9TQgvm2JObUOQWLhFo39iwH7imH
         wbd8KD601bQY0RdyYuSIljPi+BMDKiRKuSLuoWJL6LY7L/K+dkc5eEsb56N3csBskoFb
         8dBnxFaGOzKS8CLXoINWql34TlJt+3VALuLcoYV6RaKdEBB1BkpMj4uglGWhxEAZmVyO
         eeseCVsSRWfA9L2kqwVASCz8hjEnQClq0dhcUCauOYbU9nXThmlWZAxMdWoNjzGq7Er2
         HSboYo4aBTG2skpBQ8f7xUSZhEvXGNJgIvx9Jvs/DKVXO7xxJbyRF3qqq9WUA2xflyvA
         7g7w==
X-Received: by 10.66.149.231 with SMTP id ud7mr25823780pab.8.1385351545634;
        Sun, 24 Nov 2013 19:52:25 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id gh3sm69728935pbb.2.2013.11.24.19.52.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:58 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238282>


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
1.8.2.83.gc99314b
