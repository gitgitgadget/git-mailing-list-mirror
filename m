From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 06/28] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Thu,  5 Dec 2013 20:02:33 +0700
Message-ID: <1386248575-10206-7-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWA-0001Z1-0J
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab3LEM6y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:54 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:55077 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab3LEM6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:53 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so25633609pbc.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2XmwrIKt6pTEuDU43CP8+GuLM0xlMTNGXaORKqpT13M=;
        b=Ci4hABj4S2GyxjluRUlu4uQsocSUY3F0NX8GsOLtg7af8RPJl73xi0X060UMARUphx
         0HDVVUroUCA3IUzJOqU8eRF444RMt9UmYJ+xNvGGzmwCSL71MvGHyiAupV8oQCOPuAXF
         HrahekxzCI5Av7vI9N4jLtS/GATmnU/HwXLwKN04BtHBVSZoXq6hADsP20N4UxtfxtBW
         h0sApN1MErcExtnMKS2rzvvKu6/5S25iOK2wlLwu3/4aq8+F8Dzc9nIrj2Fm29KHKi5K
         YsSSibBDI1FuXDN9TgA41wANY3cfNzrMEVdM2dPemnfXtSxwPW6an9Q9qAthfLv9izrd
         ddIQ==
X-Received: by 10.68.29.72 with SMTP id i8mr52849969pbh.116.1386248332983;
        Thu, 05 Dec 2013 04:58:52 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id sd3sm144586481pbb.42.2013.12.05.04.58.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:36 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238862>

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
index 961df04..62cc4d3 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -232,7 +232,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
t char *prefix)
 			args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
-	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e);
+	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_hav=
e, NULL);
=20
 	transport_verify_remote_names(nr_refspecs, refspecs);
=20
diff --git a/connect.c b/connect.c
index 48eec41..efadd3c 100644
--- a/connect.c
+++ b/connect.c
@@ -116,7 +116,8 @@ static void annotate_refs_with_symref_info(struct r=
ef *ref)
  */
 struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
-			      struct sha1_array *extra_have)
+			      struct sha1_array *extra_have,
+			      struct sha1_array *shallow_points)
 {
 	struct ref **orig_list =3D list;
 	int got_at_least_one_head =3D 0;
@@ -142,6 +143,15 @@ struct ref **get_remote_heads(int in, char *src_bu=
f, size_t src_len,
 		if (len > 4 && !prefixcmp(buffer, "ERR "))
 			die("remote error: %s", buffer + 4);
=20
+		if (len =3D=3D 48 && !prefixcmp(buffer, "shallow ")) {
+			if (get_sha1_hex(buffer + 8, old_sha1))
+				die("protocol error: expected shallow sha-1, got '%s'", buffer + 8=
);
+			if (!shallow_points)
+				die("repository on the other end cannot be shallow");
+			sha1_array_append(shallow_points, old_sha1);
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
index 984519b..5d217d5 100644
--- a/remote.h
+++ b/remote.h
@@ -140,7 +140,8 @@ void free_refs(struct ref *ref);
 struct sha1_array;
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src=
_len,
 				     struct ref **list, unsigned int flags,
-				     struct sha1_array *extra_have);
+				     struct sha1_array *extra_have,
+				     struct sha1_array *shallow);
=20
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_=
sha1);
diff --git a/transport.c b/transport.c
index 12e46ad..90453df 100644
--- a/transport.c
+++ b/transport.c
@@ -512,7 +512,7 @@ static struct ref *get_refs_via_connect(struct tran=
sport *transport, int for_pus
=20
 	connect_setup(transport, for_push, 0);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0, &data->extra_have);
+			 for_push ? REF_NORMAL : 0, &data->extra_have, NULL);
 	data->got_remote_heads =3D 1;
=20
 	return refs;
@@ -542,7 +542,8 @@ static int fetch_refs_via_pack(struct transport *tr=
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
@@ -806,7 +807,7 @@ static int git_transport_push(struct transport *tra=
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
1.8.5.1.25.g8667982
