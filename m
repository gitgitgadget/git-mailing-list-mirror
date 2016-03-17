From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 06/10] Add basic RFC3161 functionality
Date: Thu, 17 Mar 2016 19:46:57 +0100
Message-ID: <1458240421-3593-7-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxa-0007X0-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936606AbcCQSrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:46 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43333 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935230AbcCQSrk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:40 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id E6A8258C4CE;
	Thu, 17 Mar 2016 19:47:37 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:37 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289145>

This commit adds basic RFC3161 functionality, which is linked to the ma=
in git
binary. It is used for interaction with git objects by parsing data fro=
m and
writing data to it. Moreover, it is responsible for passing data to the=
 external
helper tool `git-timestamp-util`, which does the actual work of creatin=
g and
verifying trusted time-stamps.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 Makefile  |   1 +
 rfc3161.c | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 rfc3161.h |  12 ++++
 3 files changed, 232 insertions(+)
 create mode 100644 rfc3161.c
 create mode 100644 rfc3161.h

diff --git a/Makefile b/Makefile
index 24bef8d..432c3de 100644
--- a/Makefile
+++ b/Makefile
@@ -792,6 +792,7 @@ LIB_OBJS +=3D replace_object.o
 LIB_OBJS +=3D rerere.o
 LIB_OBJS +=3D resolve-undo.o
 LIB_OBJS +=3D revision.o
+LIB_OBJS +=3D rfc3161.o
 LIB_OBJS +=3D run-command.o
 LIB_OBJS +=3D send-pack.o
 LIB_OBJS +=3D sequencer.o
diff --git a/rfc3161.c b/rfc3161.c
new file mode 100644
index 0000000..21a386f
--- /dev/null
+++ b/rfc3161.c
@@ -0,0 +1,219 @@
+#include "cache.h"
+#include "commit.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "gpg-interface.h"
+#include "rfc3161.h"
+
+static const char *timeutil_cmd =3D "timestamp-util";
+static const char *ts_signature_begin =3D "-----BEGIN RFC3161-----";
+static const char *ts_signature_end =3D "-----END RFC3161-----";
+
+static void sha1_from_strbuf(struct strbuf *buf, unsigned char sha1[20=
]);
+static void sha1_in_hex(struct strbuf *buf, char sha1_hex[40]);
+
+static int verify_tsr(char *sha1, struct strbuf *base64);
+
+/*
+ * To create a time-stamp signature, get the SHA1 hash of buffer and p=
ass it to
+ * git-timestamp-util. This helper program returns a minimalized TSR w=
hich is
+ * appended with some metadata and stored to the git object.
+ */
+int create_time_signature(struct strbuf *buffer, struct strbuf *sig)
+{
+	ssize_t len;
+	char sha1_hex[40];
+	struct strbuf tsr =3D STRBUF_INIT;
+	struct child_process timeutil =3D CHILD_PROCESS_INIT;
+	const char *args[] =3D {
+		timeutil_cmd,
+		"-c",
+		sha1_hex,
+		NULL
+	};
+
+	timeutil.argv =3D args;
+	timeutil.in =3D 0;
+	timeutil.out =3D -1;
+	timeutil.git_cmd =3D 1;
+
+	sha1_in_hex(buffer, sha1_hex);
+
+	if (start_command(&timeutil))
+		return error(_("could not run git-%s"), timeutil_cmd);
+
+	len =3D strbuf_read(&tsr, timeutil.out, 1024);
+	close(timeutil.out);
+
+	if (finish_command(&timeutil) || len <=3D 0)
+		return 1;
+
+	strbuf_addf(sig, "%s\n", ts_signature_begin);
+	strbuf_addf(sig, "Version: 1\n\n");
+	strbuf_addbuf(sig, &tsr);
+	strbuf_addf(sig, "%s\n", ts_signature_end);
+
+	strbuf_release(&tsr);
+	return 0;
+}
+
+/*
+ * To verify a time-stamp signature, extract the time-stamp from a git=
 object,
+ * extract the object id and pass the prepared data to git-timestamp-u=
til, which
+ * will do the verification for us.
+ */
+int verify_time_signature(const char *buf, unsigned long size)
+{
+	char sha1_hex[40];
+	struct strbuf timesig_base64 =3D STRBUF_INIT;
+	struct strbuf payload =3D STRBUF_INIT;
+	int ret =3D 1;
+
+	printf("\n");
+
+	if (!parse_timestamp(buf, size, &timesig_base64, &payload)) {
+		printf("time-stamp: no signature found\n");
+		return 1;
+	}
+
+	/*
+	 * Remove possible inline GPG signature from git object. Note that gi=
t
+	 * tags do not use inline signatures for historical reasons, so check=
ing
+	 * the return value of remove_signature would be useless.
+	 * Any tag-like signatures outside of the object header are already
+	 * removed by parse_timestamp.
+	 */
+	remove_signature(&payload);
+	sha1_in_hex(&payload, sha1_hex);
+
+	if (verify_tsr(sha1_hex, &timesig_base64))
+		goto err;
+
+	ret =3D 0;
+err:
+	strbuf_release(&timesig_base64);
+	strbuf_release(&payload);
+	return ret;
+}
+
+int parse_timestamp(const char *buffer, size_t size, struct strbuf *ti=
mestamp,
+		    struct strbuf *payload)
+{
+	int saw_timestamp =3D -1;
+	const char *line, *tail, *next;
+
+	line =3D buffer;
+	tail =3D buffer + size;
+	saw_timestamp =3D 0;
+
+	/* Search for beginning of time-stamp. */
+	while (line < tail) {
+		next =3D memchr(line, '\n', tail - line);
+
+		next =3D next ? next + 1 : tail;
+		if (starts_with(line, time_sig_header) &&
+		    line[time_sig_header_len] =3D=3D ' ')
+			break;
+
+		strbuf_add(payload, line, next - line);
+		line =3D next;
+	}
+
+	if (line >=3D tail)
+		return saw_timestamp;
+
+	/*
+	 * Found beginning of time-stamp.  Do not add -----BEGIN RFC3161-----=
,
+	 * version information and the separating newline to the buffer.
+	 */
+	line =3D memchr(line, '\n', tail - line) + 1;
+	line =3D memchr(line, '\n', tail - line) + 1;
+	line =3D memchr(line, '\n', tail - line) + 1;
+	saw_timestamp =3D 1;
+
+	/* Read in time-stamp data. */
+	while (line < tail) {
+		next =3D memchr(line, '\n', tail - line);
+
+		next =3D next ? next + 1 : tail;
+		if (line[0] =3D=3D ' ')
+			line =3D line + 1;
+		else
+			break;
+
+		/* do not add -----END RFC3161----- to buffer */
+		if (starts_with(line, ts_signature_end)) {
+			line =3D next;
+			break;
+		}
+
+		strbuf_add(timestamp, line, next - line);
+		line =3D next;
+	}
+
+	while (line < tail) {
+		next =3D memchr(line, '\n', tail - line);
+		next =3D next ? next + 1 : tail;
+
+		if (starts_with(line, PGP_SIGNATURE))
+			break;
+
+		strbuf_add(payload, line, next - line);
+		line =3D next;
+	}
+
+	return saw_timestamp;
+}
+
+/* Pass the prepared data to git-timestamp-util */
+static int verify_tsr(char *sha1, struct strbuf *base64)
+{
+	struct child_process timeutil =3D CHILD_PROCESS_INIT;
+	const char *args[] =3D {
+		timeutil_cmd,
+		"-v",
+		sha1,
+		NULL
+	};
+
+	timeutil.argv =3D args;
+	timeutil.in =3D -1;
+	timeutil.out =3D 0;
+	timeutil.git_cmd =3D 1;
+
+	if (start_command(&timeutil))
+		return error(_("could not run git-%s"), timeutil_cmd);
+
+	if (write_in_full(timeutil.in, base64->buf, base64->len)
+			  !=3D base64->len) {
+		close(timeutil.in);
+		finish_command(&timeutil);
+		return 1;
+	}
+	close(timeutil.in);
+
+	if (finish_command(&timeutil))
+		return 1;
+
+	return 0;
+}
+
+static void sha1_from_strbuf(struct strbuf *buf, unsigned char sha1[20=
])
+{
+	git_SHA_CTX c;
+
+	git_SHA1_Init(&c);
+	git_SHA1_Update(&c, buf->buf, buf->len);
+	git_SHA1_Final(sha1, &c);
+}
+
+static void sha1_in_hex(struct strbuf *buf, char sha1_hex[40])
+{
+	char *tmp;
+	unsigned char sha1[20];
+
+	sha1_from_strbuf(buf, sha1);
+	tmp =3D sha1_to_hex(sha1);
+	strcpy(sha1_hex, tmp);
+}
+
diff --git a/rfc3161.h b/rfc3161.h
new file mode 100644
index 0000000..eac91ae
--- /dev/null
+++ b/rfc3161.h
@@ -0,0 +1,12 @@
+#ifndef RFC3161_H
+#define RFC3161_H
+
+#define time_sig_header "timesig"
+#define time_sig_header_len (sizeof(time_sig_header) - 1)
+
+int create_time_signature(struct strbuf *buffer, struct strbuf *sig);
+int verify_time_signature(const char *buf, unsigned long size);
+int parse_timestamp(const char *buffer, size_t size, struct strbuf *ti=
mestamp,
+		    struct strbuf *payload);
+
+#endif
--=20
2.8.0.rc0.62.gfc8aefa.dirty
