From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/28] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Mon, 25 Nov 2013 10:55:32 +0700
Message-ID: <1385351754-9954-7-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDU-0001in-LT
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab3KYDwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:07 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:53017 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:03 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so4642704pdj.12
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pvi97PPxaCxBlg0FywjtIvPGw0XxLqK+SuFRjKk7i/o=;
        b=ZmDj3w+FPD5P4QAeQYmy8ZcJpxUNEhiDLeN/FaDy9dHcX1vAFgR1+OvvjMIzLdaSyT
         dqk4ZGhr0mAZ4OSbpve2u3/E/SYnQsTVhDYd7BOrSRCjqPP/LfUNEuJBSlGeQKvowWWA
         pzg3/14lXwxNcBG638RDC7yRul6hDouXbIWCOi9TYUmFxhAuEuGGdmUr82GfcPHOeB5J
         w0pS+H+L5uh95T6neU1Pfs5e5nznDgubSJOJjUQy2/aYHgyiYUWTqVW3BBXFHZi6uYNM
         vgnNRahGxlXjzi8ZlfB1Dsx2xht6eCc+ydYjPeIoTjS2d2W6Trw1/82FI3xcNluUv5ml
         n4SQ==
X-Received: by 10.66.141.165 with SMTP id rp5mr25634182pab.90.1385351523189;
        Sun, 24 Nov 2013 19:52:03 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ki1sm69728919pbd.1.2013.11.24.19.52.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:36 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238277>

No callers pass a non-empty pointer as shallow_points at this
stage. As a result, all clients still refuse to talk to shallow
repository on the other end.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  2 +-
 connect.c            | 12 +++++++++++-
 remote-curl.c        |  2 +-
 remote.h             |  3 ++-
 transport.c          |  7 ++++---
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c8e8582..c1d918f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -150,7 +150,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
+	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, NULL);
=20
 	ref =3D fetch_pack(&args, fd, conn, ref, dest,
 			 sought, nr_sought, pack_lockfile_ptr);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 51121f2..bfa9253 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -233,7 +233,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
=20
 	memset(&extra_have, 0, sizeof(extra_have));
=20
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e, NULL);
=20
 	transport_verify_remote_names(nr_refspecs, refspecs);
=20
diff --git a/connect.c b/connect.c
index 06e88b0..d0602b0 100644
--- a/connect.c
+++ b/connect.c
@@ -122,7 +122,8 @@ static void annotate_refs_with_symref_info(struct r=
ef *ref)
  */
 struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
-			      struct extra_have_objects *extra_have)
+			      struct extra_have_objects *extra_have,
+			      struct extra_have_objects *shallow_points)
 {
 	struct ref **orig_list =3D list;
 	int got_at_least_one_head =3D 0;
@@ -148,6 +149,15 @@ struct ref **get_remote_heads(int in, char *src_bu=
f, size_t src_len,
 		if (len > 4 && !prefixcmp(buffer, "ERR "))
 			die("remote error: %s", buffer + 4);
=20
+		if (len =3D=3D 48 && !prefixcmp(buffer, "shallow ")) {
+			if (get_sha1_hex(buffer + 8, old_sha1))
+				die("protocol error: expected shallow sha, got '%s'", buffer + 8);
+			if (!shallow_points)
+				die("repository on the other end cannot be shallow");
+			add_extra_have(shallow_points, old_sha1);
+			continue;
+		}
+
 		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] !=3D ' =
')
 			die("protocol error: expected sha/ref, got '%s'", buffer);
 		name =3D buffer + 41;
diff --git a/remote-curl.c b/remote-curl.c
index c9b891a..222210f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -107,7 +107,7 @@ static struct ref *parse_git_refs(struct discovery =
*heads, int for_push)
 {
 	struct ref *list =3D NULL;
 	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL);
+			 for_push ? REF_NORMAL : 0, NULL, NULL);
 	return list;
 }
=20
diff --git a/remote.h b/remote.h
index 131130a..773faa9 100644
--- a/remote.h
+++ b/remote.h
@@ -143,7 +143,8 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src=
_len,
 				     struct ref **list, unsigned int flags,
-				     struct extra_have_objects *);
+				     struct extra_have_objects *have,
+				     struct extra_have_objects *shallow);
=20
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_=
sha1);
diff --git a/transport.c b/transport.c
index 7202b77..9c51767 100644
--- a/transport.c
+++ b/transport.c
@@ -511,7 +511,7 @@ static struct ref *get_refs_via_connect(struct tran=
sport *transport, int for_pus
=20
 	connect_setup(transport, for_push, 0);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0, &data->extra_have);
+			 for_push ? REF_NORMAL : 0, &data->extra_have, NULL);
 	data->got_remote_heads =3D 1;
=20
 	return refs;
@@ -541,7 +541,8 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
-		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0, NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
+				 NULL, NULL);
 		data->got_remote_heads =3D 1;
 	}
=20
@@ -805,7 +806,7 @@ static int git_transport_push(struct transport *tra=
nsport, struct ref *remote_re
 		struct ref *tmp_refs;
 		connect_setup(transport, 1, 0);
=20
-		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL);
+		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL, NULL, =
NULL);
 		data->got_remote_heads =3D 1;
 	}
=20
--=20
1.8.2.83.gc99314b
