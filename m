From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 09/10] Add time-stamping functionality to git verify-tag
Date: Thu, 17 Mar 2016 19:47:00 +0100
Message-ID: <1458240421-3593-10-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:47:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxa-0007X0-QE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936608AbcCQSrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:47 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43333 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936553AbcCQSrn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:43 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 4078358C4CC;
	Thu, 17 Mar 2016 19:47:41 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:41 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289143>

This commit introduces command line options for git verify-tag to allow
verification of RFC3161 time-stamped tags.

To keep consistent with the current behavior of verifying gpg signature=
s, the
return value of `git verify-tag` still indicates only the success of gp=
g
signature verification by default. To influence this behavior, the conf=
iguration
variable `ts.failonverify` is introduced.

ts.failonverify set to 0: use default behavior
	Return 1 if gpg verification failed or no signature was found
	Return 0 on success.

If config variable ts.failonverify is set, the return value includes th=
e status
of time-stamp verification in the second lowest bit. Possible return va=
lues are:
	0 - both gpg and time stamp verification succeeded
	1 - gpg failed, time stamp succeeded
	2 - gpg succeeded, time stamp failed
	3 - both gpg and time stamp verification failed

Command line parameters `-s` or `-t` override the configuration
variable mentioned above.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 builtin/verify-tag.c | 61 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 00663f6..67fd464 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -12,9 +12,15 @@
 #include <signal.h>
 #include "parse-options.h"
 #include "gpg-interface.h"
+#include "rfc3161.h"
+
+#define GPG_VERIFY_RET 4
+#define TS_VERIFY_RET 8
+
+static const char *config_key_verify_ts =3D "ts.failonverify";
=20
 static const char * const verify_tag_usage[] =3D {
-		N_("git verify-tag [-v | --verbose] <tag>..."),
+		N_("git verify-tag [-s | --signature] [-t | --timestamp] [-v | --ver=
bose] [--raw] <tag>..."),
 		NULL
 };
=20
@@ -31,7 +37,8 @@ static int run_gpg_verify(const char *buf, unsigned l=
ong size, unsigned flags)
 	if (size =3D=3D len) {
 		if (flags & GPG_VERIFY_VERBOSE)
 			write_in_full(1, buf, len);
-		return error("no signature found");
+		printf("pgp: no signature found\n");
+		return 1;
 	}
=20
 	ret =3D check_signature(buf, len, buf + len, size - len, &sigc);
@@ -47,7 +54,12 @@ static int verify_tag(const char *name, unsigned fla=
gs)
 	unsigned char sha1[20];
 	char *buf;
 	unsigned long size;
-	int ret;
+	int gpg_had_error =3D 0;
+	int ret =3D 0;
+	int config_failonverify =3D 0;
+	int ts_had_error =3D 0;
+
+	git_config_get_bool(config_key_verify_ts, &config_failonverify);
=20
 	if (get_sha1(name, sha1))
 		return error("tag '%s' not found.", name);
@@ -61,9 +73,48 @@ static int verify_tag(const char *name, unsigned fla=
gs)
 	if (!buf)
 		return error("%s: unable to read file.", name);
=20
-	ret =3D run_gpg_verify(buf, size, flags);
+	if (run_gpg_verify(buf, size, flags))
+		gpg_had_error =3D 1;
+
+#if defined(NO_CURL) || defined(NO_OPENSSL)
+	fputs("git has been compiled without RFC3161 time-stamp support. "
+	      "NO_CURL and NO_OPENSSL must not be defined", stderr);
+#else
+	if (verify_time_signature(buf, size))
+		ts_had_error =3D 1;
+#endif
=20
 	free(buf);
+
+	/*
+	 * If the config variable ts.failonverify is not set, behave like old=
er
+	 * versions of git verify-tag:
+	 * Return 1 if gpg verification failed or no signature was found
+	 * Return 0 on success.
+	 *
+	 * If the config variable ts.failonverify is set and neither -s nor -=
t
+	 * are set as command line parameters, the return value includes the
+	 * status of time-stamp verification in the second lowest bit. Possib=
le
+	 * return values are:
+	 * 0 - both gpg and time stamp verification succeeded
+	 * 1 - gpg failed, time stamp succeeded
+	 * 2 - gpg succeeded, time stamp failed
+	 * 3 - both gpg and time stamp verification failed
+	 *
+	 * Command line parameters `-s` or `-t` override the configuration
+	 * variable mentioned above.
+	 */
+	if (flags & (GPG_VERIFY_RET | TS_VERIFY_RET)) {
+		if (flags & GPG_VERIFY_RET)
+			ret =3D gpg_had_error;
+		if (flags & TS_VERIFY_RET)
+			ret |=3D (ts_had_error << 1);
+	} else {
+		ret =3D gpg_had_error;
+
+		if (config_failonverify)
+			ret |=3D (ts_had_error << 1);
+	}
 	return ret;
 }
=20
@@ -82,6 +133,8 @@ int cmd_verify_tag(int argc, const char **argv, cons=
t char *prefix)
 	const struct option verify_tag_options[] =3D {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VER=
IFY_RAW),
+		OPT_BIT('s', "signature", &flags, N_("report return value of gpg sig=
nature"), GPG_VERIFY_RET),
+		OPT_BIT('t', "timestamp", &flags, N_("report return value of time-st=
amp signature"), TS_VERIFY_RET),
 		OPT_END()
 	};
=20
--=20
2.8.0.rc0.62.gfc8aefa.dirty
