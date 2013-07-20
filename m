From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/16] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Sat, 20 Jul 2013 16:57:57 +0700
Message-ID: <1374314290-5976-4-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tvo-0001Gz-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab3GTJ6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:20 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:58117 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3GTJ6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:15 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so11278014ief.40
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xCCK98ai9PmkNhgzELmaLSN4no5da2yuIwV+qX3QexQ=;
        b=wtfUjI5JGkBq0MJGpkc5WHzPtJ8AaeYEZKvVlqoDiZvvRD1agrNkc+lWXjAf09+xai
         i1esxDv5yqZYP7h6xEzaPT9Z40oMAAf1xkMNzZr8N4DMjJp2W6NshDL0QoI4+s+JYoZw
         bgT5EL0Y4h6/cCzvxi5dcJ4JVKdhrdpqfrvyPKpvPwYeJKaHPVjMEMLW00Wq16d0JQLZ
         eIs6CPmUJRy94LYi9adRQTA8bBTDsk/8LxTEpPHV+5bLQfqZAlqnZDBiD91xMUbfEF7q
         UJ1wTxBG2Ugl6j0fneY+cMXfpUoGm7nK8dyoblJxKhD7lt9alVHWPYPxmexs4bte4NEN
         HE4Q==
X-Received: by 10.50.20.232 with SMTP id q8mr5480371ige.0.1374314294595;
        Sat, 20 Jul 2013 02:58:14 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id w5sm44184712igz.10.2013.07.20.02.58.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:33 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230879>

No callers pass a non-empty pointer as shallow_points at this
stage. As a result, all clients still refuse to talk to shallow
repository on the other end.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c |  2 +-
 builtin/send-pack.c  |  2 +-
 cache.h              |  3 ++-
 connect.c            | 12 +++++++++++-
 remote-curl.c        |  2 +-
 transport.c          |  7 ++++---
 6 files changed, 20 insertions(+), 8 deletions(-)

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
index d4cbf64..4be5931 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -210,7 +210,7 @@ int cmd_send_pack(int argc, const char **argv, cons=
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
index dd0fb33..7f17228 100644
--- a/cache.h
+++ b/cache.h
@@ -1091,7 +1091,8 @@ struct extra_have_objects {
 };
 extern struct ref **get_remote_heads(int in, char *src_buf, size_t src=
_len,
 				     struct ref **list, unsigned int flags,
-				     struct extra_have_objects *);
+				     struct extra_have_objects *have,
+				     struct extra_have_objects *shallow);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *fea=
ture);
 extern const char *server_feature_value(const char *feature, int *len_=
ret);
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
