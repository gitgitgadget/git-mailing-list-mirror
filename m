From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 19/28] connected.c: add new variant that runs with --shallow-file
Date: Mon, 25 Nov 2013 10:55:45 +0700
Message-ID: <1385351754-9954-20-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEm-00027m-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab3KYDxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:23 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:43097 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620Ab3KYDxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:21 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so4814882pbc.13
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZREguaXGNQjyB6bMMqa6xvVLdEOiBr8rRZkFA0+Z4NY=;
        b=0u13q62w/pIN5HLQaCD8jrFcpqNSLLCoLVtEbXfFAJKQJVYjW9xSBQnpUitGj1Ww8P
         2A6VtxyrHF3fjw7OLfGGKkk3IIvTJ/bRw+tDM6xoLUWfifW0OHDDR9QxH+qf6t2oWex6
         Q4o1+yrlHAmoNZFx2q8qayY0hAFSlYQWjlkDEvLpJoJF+QCjgR9ElNv8lBJbKWaTElQ8
         GGxBvNcfqK0NPYjdWLjg/NCvWk16ySJUdEJvTKm5uS/9PaXfp/RnNpE4LCZhOOSO36kD
         93vnqQYEB+BW5ts8Uxb0JOcMjfWjDZGcu3685O3k8KkSGxp8kADFsmEwqlqVbj0R9w7G
         vBKA==
X-Received: by 10.66.118.129 with SMTP id km1mr961076pab.127.1385351601031;
        Sun, 24 Nov 2013 19:53:21 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ha10sm69722065pbd.17.2013.11.24.19.53.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:53 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238290>


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
1.8.2.83.gc99314b
