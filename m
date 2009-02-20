From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-tag: don't use gpg's stdin, stdout when signing tags
Date: Fri, 20 Feb 2009 11:38:56 +0000
Message-ID: <20090220113856.6612.qmail@0bbdb5719a4668.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 12:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaTmh-0006bY-0a
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 12:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbZBTLjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2009 06:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZBTLjC
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 06:39:02 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:3685 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750951AbZBTLjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 06:39:00 -0500
Received: (qmail 6613 invoked by uid 1000); 20 Feb 2009 11:38:56 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110838>

When using gpg with some console based gpg-agent, acquiring the
passphrase through the agent fails if stdin and stdout of gpg are
redirected.  With this commit, git-tag uses temporary files instead
of standard input/output when signing a tag to support such gpg-agent
usage.

The problem was reported by Lo=EFc Minier through
 http://bugs.debian.org/507642

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 builtin-tag.c |   51 ++++++++++++++++++++++++++++++++++---------------=
--
 1 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..e350352 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -159,10 +159,15 @@ static int verify_tag(const char *name, const cha=
r *ref,
 static int do_sign(struct strbuf *buffer)
 {
 	struct child_process gpg;
-	const char *args[4];
+	const char *args[7];
 	char *bracket;
 	int len;
 	int i, j;
+	int fd;
+	char *unsignpath, *signpath;
+
+	unsignpath =3D git_pathdup("TAG_UNSIGNEDMSG");
+	signpath =3D git_pathdup("TAG_SIGNEDMSG");
=20
 	if (!*signingkey) {
 		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
@@ -179,27 +184,39 @@ static int do_sign(struct strbuf *buffer)
=20
 	memset(&gpg, 0, sizeof(gpg));
 	gpg.argv =3D args;
-	gpg.in =3D -1;
-	gpg.out =3D -1;
+	gpg.in =3D 0;
+	gpg.out =3D 1;
 	args[0] =3D "gpg";
 	args[1] =3D "-bsau";
 	args[2] =3D signingkey;
-	args[3] =3D NULL;
-
-	if (start_command(&gpg))
-		return error("could not run gpg.");
-
-	if (write_in_full(gpg.in, buffer->buf, buffer->len) !=3D buffer->len)=
 {
-		close(gpg.in);
-		close(gpg.out);
-		finish_command(&gpg);
-		return error("gpg did not accept the tag data");
+	args[3] =3D "-o";
+	args[4] =3D signpath;
+	args[5] =3D unsignpath;
+	args[6] =3D NULL;
+
+	fd =3D open(unsignpath, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+	if (fd < 0)
+		die("could not create file '%s': %s",
+					unsignpath, strerror(errno));
+	write_or_die(fd, buffer->buf, buffer->len);
+	close(fd);
+
+	if (run_command(&gpg)) {
+		unlink(unsignpath);
+		unlink(signpath);
+		return error("gpg failed.");
 	}
-	close(gpg.in);
-	len =3D strbuf_read(buffer, gpg.out, 1024);
-	close(gpg.out);
+	unlink(unsignpath);
+
+	fd =3D open(signpath, O_RDONLY);
+	if (fd < 0)
+		die ("could not open file '%s': %s",
+					signpath, strerror(errno));
+	len =3D strbuf_read(buffer, fd, 1024);
+	close(fd);
+	unlink(signpath);
=20
-	if (finish_command(&gpg) || !len || len < 0)
+	if (!len || len < 0)
 		return error("gpg failed to sign the tag");
=20
 	/* Strip CR from the line endings, in case we are on Windows. */
--=20
1.6.1.3
