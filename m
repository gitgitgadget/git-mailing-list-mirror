From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 10/10] Add time-stamping functionality to git tag
Date: Thu, 17 Mar 2016 19:47:01 +0100
Message-ID: <1458240421-3593-11-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxh-0007em-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031495AbcCQSrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:52 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43319 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936594AbcCQSro (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:44 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 5DF4F58C4CE;
	Thu, 17 Mar 2016 19:47:42 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:42 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289146>

This commit introduces command line options for git tag to allow adding=
 trusted
time-stamps from a Time Stamping Authority according to RFC3161.

The SHA-1 has used for a time-stamp signature is generated from the hea=
der data
and the tag message, if present. After obtaining the time-stamp signatu=
re, it is
inserted into the object header under the `timesig`-key in a custom PEM=
-like
format. If the tag is also GPG-signed, the GPG signature includes the t=
ime-stamp
signature to prevent attackers from altering the time-stamp signature o=
r
replacing it.

However, it is still possible to create tags with only a GPG signature =
or only a
time-stamp, although it is recommended to additionally GPG-sign time-st=
amp
signatures for the reasons stated above.

In contrast to the GPG signature, the time-stamp signatures are part of
the header, emulating the way GPG signatures of signed commits are stor=
ed. This
facilitates implementing RFC3161 time-stamps for commits eventually.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 builtin/tag.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..9b3d2a1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -18,9 +18,10 @@
 #include "sha1-array.h"
 #include "column.h"
 #include "ref-filter.h"
+#include "rfc3161.h"
=20
 static const char * const git_tag_usage[] =3D {
-	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagn=
ame> [<head>]"),
+	N_("git tag [-a | -s | -u <key-id> | -t] [-f] [-m <msg> | -F <file>] =
<tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object=
>]"
 		"\n\t\t[--format=3D<format>] [--[no-]merged [<commit>]] [<pattern>..=
=2E]"),
@@ -118,6 +119,39 @@ static int do_sign(struct strbuf *buffer)
 	return sign_buffer(buffer, buffer, get_signing_key());
 }
=20
+static int do_timesig(struct strbuf *buffer)
+{
+	struct strbuf sig =3D STRBUF_INIT;
+	int inspos, copypos;
+
+	/* find the end of the header */
+	inspos =3D strstr(buffer->buf, "\n\n") - buffer->buf + 1;
+
+	if (create_time_signature(buffer, &sig)) {
+		strbuf_release(&sig);
+		return -1;
+	}
+
+	for (copypos =3D 0; sig.buf[copypos]; ) {
+		const char *bol =3D sig.buf + copypos;
+		const char *eol =3D strchrnul(bol, '\n');
+		int len =3D (eol - bol) + !!*eol;
+
+		if (!copypos) {
+			strbuf_insert(buffer, inspos, time_sig_header,
+				      time_sig_header_len);
+			inspos +=3D time_sig_header_len;
+		}
+		strbuf_insert(buffer, inspos++, " ", 1);
+		strbuf_insert(buffer, inspos, bol, len);
+		inspos +=3D len;
+		copypos +=3D len;
+	}
+	strbuf_release(&sig);
+
+	return 0;
+}
+
 static const char tag_template[] =3D
 	N_("\nWrite a message for tag:\n  %s\n"
 	"Lines starting with '%c' will be ignored.\n");
@@ -193,8 +227,11 @@ static void write_tag_body(int fd, const unsigned =
char *sha1)
 	free(buf);
 }
=20
-static int build_tag_object(struct strbuf *buf, int sign, unsigned cha=
r *result)
+static int build_tag_object(struct strbuf *buf, int sign, int timesig,
+			    unsigned char *result)
 {
+	if (timesig && do_timesig(buf) < 0)
+		return error(_("unable to generate time-stamp signature"));
 	if (sign && do_sign(buf) < 0)
 		return error(_("unable to sign the tag"));
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
@@ -205,6 +242,7 @@ static int build_tag_object(struct strbuf *buf, int=
 sign, unsigned char *result)
 struct create_tag_options {
 	unsigned int message_given:1;
 	unsigned int sign;
+	unsigned int timesig;
 	enum {
 		CLEANUP_NONE,
 		CLEANUP_SPACE,
@@ -276,7 +314,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
=20
 	strbuf_insert(buf, 0, header_buf, header_len);
=20
-	if (build_tag_object(buf, opt->sign, result) < 0) {
+	if (build_tag_object(buf, opt->sign, opt->timesig, result) < 0) {
 		if (path)
 			fprintf(stderr, _("The tag message has been left in %s\n"),
 				path);
@@ -350,6 +388,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 			     N_("tag message"), parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag"))=
,
+		OPT_BOOL('t', "timestamp", &opt.timesig, N_("add trusted RFC3161 tim=
e-stamp")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
@@ -387,6 +426,16 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
 	}
 	if (opt.sign)
 		annotate =3D 1;
+
+#if defined(NO_CURL) || defined(NO_OPENSSL)
+	if (opt.timesig)
+		return error("git has been compiled without RFC3161 time-stamp suppo=
rt. "
+			     "NO_CURL and NO_OPENSSL must not be defined");
+#else
+	if (opt.timesig)
+		annotate =3D 1;
+#endif
+
 	if (argc =3D=3D 0 && !cmdmode)
 		cmdmode =3D 'l';
=20
--=20
2.8.0.rc0.62.gfc8aefa.dirty
