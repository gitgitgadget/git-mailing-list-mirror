From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] strbuf_readlink semantics update.
Date: Tue, 23 Dec 2008 11:21:27 +0100
Message-ID: <20081223102127.GA21485@artemis.corp>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <1230026749-25360-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="IS0zKkzwUGydFO0o";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 11:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF4eP-00082U-8G
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 11:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbYLWKgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 05:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbYLWKgs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 05:36:48 -0500
Received: from pan.madism.org ([88.191.52.104]:39021 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYLWKgr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 05:36:47 -0500
X-Greylist: delayed 916 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Dec 2008 05:36:46 EST
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 13B1032355;
	Tue, 23 Dec 2008 11:21:28 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 82FCA2AFDF; Tue, 23 Dec 2008 11:21:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1230026749-25360-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103807>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

when readlink fails, the strbuf shall not be destroyed. It's not how
read_file_or_gitlink works for example.

Fix strbuf_readlink callers to destroy the buffer when appropriate.

Fix read_old_data possible leaks in case of errors, since even when no
data has been read, the strbufs may have grown to prepare the reads.
strbuf_release must be called on them.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  I know it somehow add lines to the callers, but it's actually more
  important to keep consistency among the strbuf APIs than to save 10
  SLOCs.


 builtin-apply.c |    8 ++++++--
 combine-diff.c  |    1 +
 diff.c          |    4 +++-
 read-cache.c    |    4 +++-
 sha1_file.c     |    1 +
 strbuf.c        |    2 +-
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 07244b0..c1fe9ca 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2306,8 +2306,10 @@ static int apply_data(struct patch *patch, struct st=
at *st, struct cache_entry *
 		/* We have a patched copy in memory use that */
 		strbuf_add(&buf, tpatch->result, tpatch->resultsize);
 	} else if (cached) {
-		if (read_file_or_gitlink(ce, &buf))
+		if (read_file_or_gitlink(ce, &buf)) {
+			strbuf_release(&buf);
 			return error("read of %s failed", patch->old_name);
+		}
 	} else if (patch->old_name) {
 		if (S_ISGITLINK(patch->old_mode)) {
 			if (ce) {
@@ -2320,8 +2322,10 @@ static int apply_data(struct patch *patch, struct st=
at *st, struct cache_entry *
 				patch->fragments =3D NULL;
 			}
 		} else {
-			if (read_old_data(st, patch->old_name, &buf))
+			if (read_old_data(st, patch->old_name, &buf)) {
+				strbuf_release(&buf);
 				return error("read of %s failed", patch->old_name);
+			}
 		}
 	}
=20
diff --git a/combine-diff.c b/combine-diff.c
index bccc018..674745d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -706,6 +706,7 @@ static void show_patch_diff(struct combine_diff_path *e=
lem, int num_parent,
 			struct strbuf buf =3D STRBUF_INIT;
=20
 			if (strbuf_readlink(&buf, elem->path, st.st_size) < 0) {
+				strbuf_release(&buf);
 				error("readlink(%s): %s", elem->path,
 				      strerror(errno));
 				return;
diff --git a/diff.c b/diff.c
index b57d9ac..41f7e1c 100644
--- a/diff.c
+++ b/diff.c
@@ -1778,8 +1778,10 @@ int diff_populate_filespec(struct diff_filespec *s, =
int size_only)
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb =3D STRBUF_INIT;
=20
-			if (strbuf_readlink(&sb, s->path, s->size))
+			if (strbuf_readlink(&sb, s->path, s->size)) {
+				strbuf_release(&sb);
 				goto err_empty;
+			}
 			s->size =3D sb.len;
 			s->data =3D strbuf_detach(&sb, NULL);
 			s->should_free =3D 1;
diff --git a/read-cache.c b/read-cache.c
index db166da..9673d91 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -104,8 +104,10 @@ static int ce_compare_link(struct cache_entry *ce, siz=
e_t expected_size)
 	enum object_type type;
 	struct strbuf sb =3D STRBUF_INIT;
=20
-	if (strbuf_readlink(&sb, ce->name, expected_size))
+	if (strbuf_readlink(&sb, ce->name, expected_size)) {
+		strbuf_release(&sb);
 		return -1;
+	}
=20
 	buffer =3D read_sha1_file(ce->sha1, &type, &size);
 	if (buffer) {
diff --git a/sha1_file.c b/sha1_file.c
index 52d1ead..a62b53d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2538,6 +2538,7 @@ int index_path(unsigned char *sha1, const char *path,=
 struct stat *st, int write
 	case S_IFLNK:
 		if (strbuf_readlink(&sb, path, st->st_size)) {
 			char *errstr =3D strerror(errno);
+			strbuf_release(&sb);
 			return error("readlink(\"%s\"): %s", path,
 			             errstr);
 		}
diff --git a/strbuf.c b/strbuf.c
index 254a7ee..b1f2a97 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -311,7 +311,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path=
, size_t hint)
 		/* .. the buffer was too small - try again */
 		hint *=3D 2;
 	}
-	strbuf_release(sb);
+	sb->buf[sb->len] =3D '\0';
 	return -1;
 }
=20
--=20
1.6.1.rc4.306.g849c2


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklQu6UACgkQvGr7W6HudhzgVgCffbymAtaMsjRn7ax/FgxKa4Pq
Z3QAn2OuEXxcFtoo3ReMxl3F+uGRIFms
=yotO
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
