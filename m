From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 19/28] connected.c: add new variant that runs with --shallow-file
Date: Thu,  5 Dec 2013 20:02:46 +0700
Message-ID: <1386248575-10206-20-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXb-0002aR-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202Ab3LENAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:00:22 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:40669 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203Ab3LENAT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:00:19 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so24631285pde.34
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HFPUrFgiF5lxTc4hKPbbNQUp9ffXFfurCzaLrU3otS4=;
        b=d9PTaqWh02JkzfiBX20ph+Qf0qa2PLHJ0hVGAwcWnRbuhWyMSp4DSxKWvAea0M+ZB9
         JnT12e0dIhB5WsCldGWygJWXubkOVE5LhVYdi9Z1S27Pnf06Z4Rna7jZioFVgUfp9u4g
         p9tlf4VCQhrC9wCn5TpE+wXGELM2HsSUOoLgrdZ0ss2sn729ZMur2W+5TOVguUEW62Qs
         eiuEHPLDcCMC5wQvcWoFIKPRDs++KORUBYqVmCO1M5LK7ID1/CGHyG3xn9q6IpVdHqxS
         OV+QKyERfGm6XNJM2nGenVWhI/DGYpJHrmIr3j3AM2GmvXXPK3yP+QOCtrZlW8pUsJtN
         7rpw==
X-Received: by 10.68.139.233 with SMTP id rb9mr52344421pbb.29.1386248417625;
        Thu, 05 Dec 2013 05:00:17 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id oa3sm111497923pbb.15.2013.12.05.05.00.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:00:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:00 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238875>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 connected.c | 42 ++++++++++++++++++++++++++++++++++--------
 connected.h |  2 ++
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/connected.c b/connected.c
index fae8d64..427389d 100644
--- a/connected.c
+++ b/connected.c
@@ -19,17 +19,17 @@ int check_everything_connected(sha1_iterate_fn fn, =
int quiet, void *cb_data)
  *
  * Returns 0 if everything is connected, non-zero otherwise.
  */
-int check_everything_connected_with_transport(sha1_iterate_fn fn,
-					      int quiet,
-					      void *cb_data,
-					      struct transport *transport)
+static int check_everything_connected_real(sha1_iterate_fn fn,
+					   int quiet,
+					   void *cb_data,
+					   struct transport *transport,
+					   const char *shallow_file)
 {
 	struct child_process rev_list;
-	const char *argv[] =3D {"rev-list", "--objects",
-			      "--stdin", "--not", "--all", NULL, NULL};
+	const char *argv[9];
 	char commit[41];
 	unsigned char sha1[20];
-	int err =3D 0;
+	int err =3D 0, ac =3D 0;
 	struct packed_git *new_pack =3D NULL;
=20
 	if (fn(cb_data, sha1))
@@ -47,8 +47,18 @@ int check_everything_connected_with_transport(sha1_i=
terate_fn fn,
 		strbuf_release(&idx_file);
 	}
=20
+	if (shallow_file) {
+		argv[ac++] =3D "--shallow-file";
+		argv[ac++] =3D shallow_file;
+	}
+	argv[ac++] =3D "rev-list";
+	argv[ac++] =3D "--objects";
+	argv[ac++] =3D "--stdin";
+	argv[ac++] =3D "--not";
+	argv[ac++] =3D "--all";
 	if (quiet)
-		argv[5] =3D "--quiet";
+		argv[ac++] =3D "--quiet";
+	argv[ac] =3D NULL;
=20
 	memset(&rev_list, 0, sizeof(rev_list));
 	rev_list.argv =3D argv;
@@ -92,3 +102,19 @@ int check_everything_connected_with_transport(sha1_=
iterate_fn fn,
 	sigchain_pop(SIGPIPE);
 	return finish_command(&rev_list) || err;
 }
+
+int check_everything_connected_with_transport(sha1_iterate_fn fn,
+					      int quiet,
+					      void *cb_data,
+					      struct transport *transport)
+{
+	return check_everything_connected_real(fn, quiet, cb_data,
+					       transport, NULL);
+}
+
+int check_shallow_connected(sha1_iterate_fn fn, int quiet, void *cb_da=
ta,
+			    const char *shallow_file)
+{
+	return check_everything_connected_real(fn, quiet, cb_data,
+					       NULL, shallow_file);
+}
diff --git a/connected.h b/connected.h
index 0b060b7..071d408 100644
--- a/connected.h
+++ b/connected.h
@@ -18,6 +18,8 @@ typedef int (*sha1_iterate_fn)(void *, unsigned char =
[20]);
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
  */
 extern int check_everything_connected(sha1_iterate_fn, int quiet, void=
 *cb_data);
+extern int check_shallow_connected(sha1_iterate_fn, int quiet, void *c=
b_data,
+				   const char *shallow_file);
 extern int check_everything_connected_with_transport(sha1_iterate_fn, =
int quiet,
 						     void *cb_data,
 						     struct transport *transport);
--=20
1.8.5.1.25.g8667982
