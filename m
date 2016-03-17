From: Anton Wuerfel <anton.wuerfel@fau.de>
Subject: [PATCH 07/10] Add git-http-timestamp helper tool
Date: Thu, 17 Mar 2016 19:46:58 +0100
Message-ID: <1458240421-3593-8-git-send-email-anton.wuerfel@fau.de>
References: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, i4passt@cs.fau.de,
	Phillip Raffeck <phillip.raffeck@fau.de>,
	Anton Wuerfel <anton.wuerfel@fau.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:48:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcxj-0007em-BF
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935870AbcCQSr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 14:47:57 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:43319 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935720AbcCQSrl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 14:47:41 -0400
Received: from faui49man2 (faui49man2.informatik.uni-erlangen.de [131.188.42.190])
	by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 1472A58C4DA;
	Thu, 17 Mar 2016 19:47:39 +0100 (CET)
Received: by faui49man2 (sSMTP sendmail emulation); Thu, 17 Mar 2016 19:47:39 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458240421-3593-1-git-send-email-anton.wuerfel@fau.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289149>

This commit adds the git-http-timestamp helper tool. It does all the
communication to a Time Stamping Authority via libcurl and passes the r=
eceived
data to the caller via stdout.

Libcurl by default depends on GnuTLS, the new RFC3161 time-stamping
functionality depends on libcrypto (OpenSSL) as GnuTLS does not support=
 RFC3161
time-stamps. The git-http-timestamp helper tool is introduced to avoid =
linking
OpenSSL and GnuTLS together in a single binary.

Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
---
 .gitignore       |  1 +
 Makefile         |  7 ++++++
 command-list.txt |  1 +
 http-timestamp.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 http-timestamp.c

diff --git a/.gitignore b/.gitignore
index 5087ce1..a3b270d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -70,6 +70,7 @@
 /git-http-backend
 /git-http-fetch
 /git-http-push
+/git-http-timestamp
 /git-imap-send
 /git-index-pack
 /git-init
diff --git a/Makefile b/Makefile
index 432c3de..c717af7 100644
--- a/Makefile
+++ b/Makefile
@@ -1116,6 +1116,9 @@ else
 			BASIC_CFLAGS +=3D -DEXPAT_NEEDS_XMLPARSE_H
 		endif
 	endif
+
+	PROGRAM_OBJS +=3D http-timestamp.o
+	PROGRAMS +=3D git-http-timestamp$X
 endif
 IMAP_SEND_LDFLAGS +=3D $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPT=
O)
=20
@@ -2018,6 +2021,10 @@ git-remote-testsvn$X: remote-testsvn.o GIT-LDFLA=
GS $(GITLIBS) $(VCSSVN_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS) \
 	$(VCSSVN_LIB)
=20
+git-http-timestamp$X: http.o http-timestamp.o GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
+		$(CURL_LIBCURL) $(LIBS)
+
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	$(QUIET_LNCP)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
diff --git a/command-list.txt b/command-list.txt
index 2a94137..3e279c1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -68,6 +68,7 @@ git-help                                ancillaryinte=
rrogators
 git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
+git-http-timestamp                      purehelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
diff --git a/http-timestamp.c b/http-timestamp.c
new file mode 100644
index 0000000..86b42e0
--- /dev/null
+++ b/http-timestamp.c
@@ -0,0 +1,76 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "http.h"
+
+static int obtain_tsr(struct strbuf *tsq, struct strbuf *tsr);
+
+static void usage_and_die(const char *name);
+
+static const char *config_tsa_url_key =3D "ts.tsaurl";
+
+int main(int argc, const char *argv[])
+{
+	struct strbuf tsr =3D STRBUF_INIT;
+	struct strbuf tsq =3D STRBUF_INIT;
+	int ret;
+
+	if (argc !=3D 1)
+		usage_and_die(argv[0]);
+
+	if (strbuf_fread(&tsq, 1024, stdin) < 0) {
+		strbuf_release(&tsq);
+		return error(_("strbuf_fread failed: %s"), strerror(errno));
+	}
+
+	ret =3D obtain_tsr(&tsq, &tsr);
+
+	if (!ret)
+		write_in_full(fileno(stdout), tsr.buf, tsr.len);
+
+	strbuf_release(&tsr);
+	strbuf_release(&tsq);
+	return ret;
+}
+
+static int obtain_tsr(struct strbuf *tsq, struct strbuf *tsr)
+{
+	struct strbuf content_type =3D STRBUF_INIT;
+	struct http_request_options options =3D {0};
+
+	char *config_tsa_url;
+
+	if (git_config_get_string(config_tsa_url_key, &config_tsa_url)) {
+		die(_("git config option '%s' must be set"),
+		      config_tsa_url_key);
+	}
+
+	/* libcurl stuff */
+
+	http_init(NULL, config_tsa_url, 0);
+
+	strbuf_addstr(&content_type, "application/timestamp-query");
+	options.post_content_type =3D &content_type;
+	options.postfields =3D tsq;
+
+	if (http_get_strbuf(config_tsa_url, tsr, &options)) {
+		strbuf_release(&content_type);
+		return error(_("sending time-stamp query failed"));
+	}
+
+	strbuf_release(&content_type);
+	free(config_tsa_url);
+	http_cleanup();
+
+	return 0;
+}
+
+static void usage_and_die(const char *name)
+{
+	fprintf(stderr, "Usage: %s\n\n", name);
+	fputs("Obtain a trusted time-stamp from the Time Stamping Authority\n=
"
+	      "specified in configuration variable `ts.tsaurl` and write the\=
n"
+	      "result to stdout.\n",
+	      stderr);
+
+	exit(EXIT_FAILURE);
+}
--=20
2.8.0.rc0.62.gfc8aefa.dirty
