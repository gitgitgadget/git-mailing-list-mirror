From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [RFC PATCH] gpg: add support for gpgsm
Date: Thu, 31 Mar 2016 15:51:44 +0200
Message-ID: <1459432304-35779-1-git-send-email-cmn@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 15:51:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ald0v-0006jx-PO
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 15:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbcCaNvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 09:51:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41767 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755383AbcCaNvq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 09:51:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id A8BD722192
	for <git@vger.kernel.org>; Thu, 31 Mar 2016 09:51:45 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 31 Mar 2016 09:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=SDv
	Mql1UhDnI/YXD31G4nXaa338=; b=l4iwbNOYUiwjJFpCS1mxSHMfvR65QxU0sL+
	qDjtIqRXL+onMFoUJJmh6DN0pH5CJkb0tt8QckSpvK48HZFbvIUoSCUThuI6E5qu
	JrFB6qxtTBg5uvEZjXmtGyXtiOOqyoVcLquTg7rUqOWi37vQ8uk38pFibvQ2PLwE
	QHn2ZuLc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=SDvMql1UhDnI/YXD31G4nXaa338=; b=F3lnn
	ftcV/RIvlxtpTs4jBfYOaiXuU9/1l4fWBk5IifZtv2nAXRzlHDI9SY9n7ILRJFge
	2IqfIem/SGBqz3aCoVJrNUsfhi1KJQ1/W1ewA5udjPxFuziUyPxlWOpT+tOupy4T
	EXh8Drh4ZYesOOdWrO5Lu2uD7ra3EHFaBf6RwE=
X-Sasl-enc: gzL/a1YuD0K/DV9sULNhCFBXnPkcaMSILGT4cnCiZBSL 1459432305
Received: from cmartin.tk (ip5b40609c.dynamic.kabel-deutschland.de [91.64.96.156])
	by mail.messagingengine.com (Postfix) with ESMTPA id 17F796800A2
	for <git@vger.kernel.org>; Thu, 31 Mar 2016 09:51:44 -0400 (EDT)
Received: (nullmailer pid 35822 invoked by uid 1000);
	Thu, 31 Mar 2016 13:51:44 -0000
X-Mailer: git-send-email 2.8.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290381>

Detect the gpgsm block header and run this command instead of gpg.
On the signing side, ask gpgsm if it knows the signing key we're trying
to use and fall back to gpg if it does not.

This lets the user more easily combine signing and verifying X509 and
PGP signatures without having to choose a default for a particular
repository that may need to be occasionally overridden.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>

---

Out there in the so-called "real world", companies like using X509 to
sign things. Currently you can set 'gpg.program' to gpgsm to get
gpg-compatible verification, but if you're changing it to swap between
PGP and X509, it's an extra variable to keep in mind when working with
signed commits and tags.

While this does let us sign and verify, the probing is a bit
awkward. gpgsm returns 0 regardless of whether it found the key, and if
you pass in an id for which you have the public key, it'll still output=
 the
filename as a heading, so we would consider it known. I'm not aware of =
a
way around that which doesn't involve parsing the output, which would
probably be even more fragile.

 Documentation/config.txt | 11 ++++++++
 gpg-interface.c          | 65 ++++++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..40f3912 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1484,6 +1484,17 @@ gpg.program::
 	signed, and the program is expected to send the result to its
 	standard output.
=20
+gpgsm.program::
+	Use this custom program instead of "gpgsm" found on $PATH when
+	making or verifying a gpsm signature. The program must support the
+	same command-line interface as GPG, namely, to verify a detached
+	signature, "gpgsm --verify $file - <$signature" is run, and the
+	program is expected to signal a good signature by exiting with
+	code 0, and to generate an ASCII-armored detached signature, the
+	standard input of "gpgsm -bsau $key" is fed with the contents to be
+	signed, and the program is expected to send the result to its
+	standard output.
+
 gui.commitMsgWidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/gpg-interface.c b/gpg-interface.c
index 3dc2fe3..194a6c6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -6,10 +6,13 @@
=20
 static char *configured_signing_key;
 static const char *gpg_program =3D "gpg";
+static const char *gpgsm_program =3D "gpgsm";
=20
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
=20
+#define GPGSM_MESSAGE "-----BEGIN SIGNED MESSAGE-----"
+
 void signature_check_clear(struct signature_check *sigc)
 {
 	free(sigc->payload);
@@ -24,6 +27,20 @@ void signature_check_clear(struct signature_check *s=
igc)
 	sigc->key =3D NULL;
 }
=20
+/*
+ * Guess which program this signature was made with based on the block=
 start.
+ * Right now we just detect a gpgsm block and fall back to gpg otherwi=
se.
+ */
+static const char *guess_program(const char *message, size_t message_l=
en)
+{
+	size_t gpgsm_len =3D strlen(GPGSM_MESSAGE);
+
+	if (message_len > gpgsm_len && !strncmp(message, GPGSM_MESSAGE, gpgsm=
_len))
+		return gpgsm_program;
+
+	return gpg_program;
+}
+
 static struct {
 	char result;
 	const char *check;
@@ -131,6 +148,11 @@ int git_gpg_config(const char *var, const char *va=
lue, void *cb)
 			return config_error_nonbool(var);
 		gpg_program =3D xstrdup(value);
 	}
+	if (!strcmp(var, "gpgsm.program")) {
+		if (!value)
+			return config_error_nonbool(var);
+		gpgsm_program =3D xstrdup(value);
+	}
 	return 0;
 }
=20
@@ -142,6 +164,41 @@ const char *get_signing_key(void)
 }
=20
 /*
+ * Try to figure out if the given program contains given the key. Both
+ * gpg and gpgsm have keys in hex format, so we don't necessarily know
+ * which one to use.
+ */
+static int program_knows_key(const char *program, const char *signing_=
key)
+{
+	struct child_process gpg =3D CHILD_PROCESS_INIT;
+	struct strbuf output =3D STRBUF_INIT;
+	const char *args[4];
+	size_t len;
+
+	gpg.argv =3D args;
+	gpg.in =3D -1;
+	gpg.out =3D -1;
+	args[0] =3D program;
+	args[1] =3D "-K";
+	args[2] =3D signing_key;
+	args[3] =3D NULL;
+
+	if (start_command(&gpg))
+		return error(_("could not run '%s'"), program);
+
+	close(gpg.in);
+	len =3D strbuf_read(&output, gpg.out, 1024);
+	close(gpg.out);
+
+	/* If the command exits with an error, consider it as not found */
+	if (finish_command(&gpg))
+		return 0;
+
+	/* If the command showed the key we wanted, use it. */
+	return !!len;
+}
+
+/*
  * Create a detached signature for the contents of "buffer" and append
  * it after "signature"; "buffer" and "signature" can be the same
  * strbuf instance, which would cause the detached signature appended
@@ -154,10 +211,14 @@ int sign_buffer(struct strbuf *buffer, struct str=
buf *signature, const char *sig
 	ssize_t len;
 	size_t i, j, bottom;
=20
+	if (program_knows_key(gpgsm_program, signing_key))
+		args[0] =3D gpgsm_program;
+	else
+		args[0] =3D gpg_program;
+
 	gpg.argv =3D args;
 	gpg.in =3D -1;
 	gpg.out =3D -1;
-	args[0] =3D gpg_program;
 	args[1] =3D "-bsau";
 	args[2] =3D signing_key;
 	args[3] =3D NULL;
@@ -216,7 +277,7 @@ int verify_signed_buffer(const char *payload, size_=
t payload_size,
 	struct strbuf buf =3D STRBUF_INIT;
 	struct strbuf *pbuf =3D &buf;
=20
-	args_gpg[0] =3D gpg_program;
+	args_gpg[0] =3D guess_program(signature, signature_size);
 	fd =3D git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
 		return error(_("could not create temporary file '%s': %s"),
--=20
2.8.0.rc3
