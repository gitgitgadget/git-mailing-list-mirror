From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Make builtin-commit.c export GIT_INDEX_FILE for launch_editor as well.
Date: Mon, 26 Nov 2007 09:59:27 +0100
Message-ID: <20071126085927.GC23373@artemis.corp>
References: <20071125211831.GA21121@artemis.corp> <20071126002519.GA11133@efreet.light.src> <20071126084731.GB23373@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZwgA9U+XZDXt4+m+";
	protocol="application/pgp-signature"; micalg=SHA1
To: Jan Hudec <bulb@ucw.cz>, Git ML <git@vger.kernel.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 09:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZoi-0001nW-BO
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 09:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXKZI73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 03:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXKZI73
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 03:59:29 -0500
Received: from pan.madism.org ([88.191.52.104]:57272 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbXKZI72 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 03:59:28 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AABAAEE;
	Mon, 26 Nov 2007 09:59:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 37EEA2E33; Mon, 26 Nov 2007 09:59:27 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Jan Hudec <bulb@ucw.cz>, Git ML <git@vger.kernel.org>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20071126084731.GB23373@artemis.corp>
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66057>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  And here's the fix for this tiny problem =E2=80=A6



 builtin-commit.c |    9 ++++++---
 builtin-tag.c    |    6 +++---
 strbuf.h         |    2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 5d27102..6e6b9f2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -748,9 +748,12 @@ int cmd_commit(int argc, const char **argv, const char=
 *prefix)
=20
 	/* Get the commit message and validate it */
 	header_len =3D sb.len;
-	if (!no_edit)
-		launch_editor(git_path(commit_editmsg), &sb);
-	else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
+	if (!no_edit) {
+		char index[PATH_MAX];
+		const char *env[2] =3D { index, NULL };
+		snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
+		launch_editor(git_path(commit_editmsg), &sb, env);
+	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
 		die("could not read commit message\n");
 	}
diff --git a/builtin-tag.c b/builtin-tag.c
index e89b201..8cc7f9c 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -23,7 +23,7 @@ static const char * const git_tag_usage[] =3D {
=20
 static char signingkey[1000];
=20
-void launch_editor(const char *path, struct strbuf *buffer)
+void launch_editor(const char *path, struct strbuf *buffer, const char *co=
nst *env)
 {
 	const char *editor, *terminal;
=20
@@ -49,7 +49,7 @@ void launch_editor(const char *path, struct strbuf *buffe=
r)
 	if (strcmp(editor, ":")) {
 		const char *args[] =3D { editor, path, NULL };
=20
-		if (run_command_v_opt(args, 0))
+		if (run_command_v_opt_cd_env(args, 0, NULL, env))
 			die("There was a problem with the editor %s.", editor);
 	}
=20
@@ -318,7 +318,7 @@ static void create_tag(const unsigned char *object, con=
st char *tag,
 			write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
=20
-		launch_editor(path, buf);
+		launch_editor(path, buf, NULL);
=20
 		unlink(path);
 		free(path);
diff --git a/strbuf.h b/strbuf.h
index 8334a9b..36d61db 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -117,6 +117,6 @@ extern int strbuf_read_file(struct strbuf *sb, const ch=
ar *path, size_t hint);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
=20
 extern void stripspace(struct strbuf *buf, int skip_comments);
-extern void launch_editor(const char *path, struct strbuf *buffer);
+extern void launch_editor(const char *path, struct strbuf *buffer, const c=
har *const *env);
=20
 #endif /* STRBUF_H */
--=20
1.5.3.6.2015.g9baba-dirty


--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHSorvvGr7W6HudhwRAvo5AKCJUPcMdNP6rdg3Djsx6jIHdCqUowCfcnV5
VH0keORQFsobcceOm368HHU=
=lo8l
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
