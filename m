From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Wed, 17 Jul 2013 19:47:10 +0700
Message-ID: <1374065234-870-4-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR8h-0004zO-NE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819Ab3GQMrX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:23 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:34048 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab3GQMrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:22 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so1863457pbc.17
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=K3AyNL6A2rCT4wO/Vd9AsEA0yFK21RfOU2rzeEsrCYU=;
        b=jHvxCKE2pBlXdm6AmHG0qbBWuSahr3LJGA2dWglUf5Jccn1iMUY3VKppjSjBLb0Lm2
         ZyIHI7itFfzkB9+b25Iti9/SUUkuDmRNr/RIWqq5WgvTXG8AmbKh2femgVxb9ny9fZAd
         3qEYcfTubAF1kpPJowiQMPhx/zqBBOvoUJ/0guiPEXXg5/5y1/oW+WV5SIMANgv+R7cv
         CR3l+jeLTZgcx7tiX2tK6vwaOg0mPUl/t/W+YWZKzLyjtvSvRwMZ6kYtQlJTLj8QJONP
         rpfQ5ndJUzTAIzIW/VwzTNInVpzmVkrl8Ma2c6bwEPiRY2MaizfrECVI8rniWaSDOYFm
         14Ww==
X-Received: by 10.68.209.196 with SMTP id mo4mr6647267pbc.114.1374065242218;
        Wed, 17 Jul 2013 05:47:22 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id i16sm10335009pag.18.2013.07.17.05.47.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:47:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230615>

No callers pass a non-empty pointer as shallow_points at this
stage. As a result, all clients still refuse to talk to shallow
repository on the other end.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  2 +-
 cache.h              |  1 +
 connect.c            | 12 +++++++++++-
 remote-curl.c        |  2 +-
 transport.c          |  7 ++++---
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index aba4465..080e599 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -144,7 +144,7 @@ int cmd_fetch_pack(int argc, const char **argv, con=
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
index 152c4ea..f0ad0ce 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -207,7 +207,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
diff --git a/cache.h b/cache.h
index dd0fb33..7665e03 100644
--- a/cache.h
+++ b/cache.h
@@ -1091,6 +1091,7 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src=
_len,
 				     struct ref **list, unsigned int flags,
+				     struct extra_have_objects *,
 				     struct extra_have_objects *);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *fea=
ture);
diff --git a/connect.c b/connect.c
index a0783d4..1cba424 100644
--- a/connect.c
+++ b/connect.c
@@ -64,7 +64,8 @@ static void die_initial_contact(int got_at_least_one_=
head)
  */
 struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			      struct ref **list, unsigned int flags,
-			      struct extra_have_objects *extra_have)
+			      struct extra_have_objects *extra_have,
+			      struct extra_have_objects *shallow_points)
 {
 	int got_at_least_one_head =3D 0;
=20
@@ -89,6 +90,15 @@ struct ref **get_remote_heads(int in, char *src_buf,=
 size_t src_len,
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
index 5b3ce9e..c329bd3 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -86,7 +86,7 @@ static struct ref *parse_git_refs(struct discovery *h=
eads, int for_push)
 {
 	struct ref *list =3D NULL;
 	get_remote_heads(-1, heads->buf, heads->len, &list,
-			 for_push ? REF_NORMAL : 0, NULL);
+			 for_push ? REF_NORMAL : 0, NULL, NULL);
 	return list;
 }
=20
diff --git a/transport.c b/transport.c
index e15db98..10a8cb8 100644
--- a/transport.c
+++ b/transport.c
@@ -509,7 +509,7 @@ static struct ref *get_refs_via_connect(struct tran=
sport *transport, int for_pus
=20
 	connect_setup(transport, for_push, 0);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0, &data->extra_have);
+			 for_push ? REF_NORMAL : 0, &data->extra_have, NULL);
 	data->got_remote_heads =3D 1;
=20
 	return refs;
@@ -539,7 +539,8 @@ static int fetch_refs_via_pack(struct transport *tr=
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
@@ -799,7 +800,7 @@ static int git_transport_push(struct transport *tra=
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
