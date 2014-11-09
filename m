From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Sun, 09 Nov 2014 15:55:53 +0100
Message-ID: <545F8079.7010806@raz.or.at>
References: <53FD0CD1.7030801@raz.or.at> <545F6586.109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 15:56:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnTuJ-0008EB-64
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 15:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbaKIOzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 09:55:55 -0500
Received: from mhub.domainplanet.at ([92.43.99.110]:55797 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaKIOzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 09:55:53 -0500
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id AD3AA9181BC;
	Sun,  9 Nov 2014 15:55:48 +0100 (CET)
Received: from [10.0.0.7] (91-114-128-205.adsl.highway.telekom.at [91.114.128.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 0E5EABF6D5;
	Sun,  9 Nov 2014 15:56:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <545F6586.109@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 2014-11-09 um 14:00 schrieb Torsten B=F6gershausen:
> On 2014-08-27 00.40, Bernhard Reiter wrote:
>> Use libcurl's high-level API functions to implement git-imap-send
>> instead of the previous low-level OpenSSL-based functions.
>>
> This doesn't seem to fully work under Debian 7:
> /home/tb/projects/git/git.pu/imap-send.c:1546: undefined reference to=
 `curl_append_msgs_to_imap'

Thx for the notice. I forgot to guard that with an #ifdef.

The new patch below includes that, and the fix sent by Ramsay; hopefull=
y the squashed/edited commit message is fine.

Bernhard

-- >8 --

Use libcurl's high-level API functions to implement git-imap-send
instead of the previous low-level OpenSSL-based functions.

Since version 7.30.0, libcurl's API has been able to communicate with
IMAP servers. Using those high-level functions instead of the current
ones would reduce imap-send.c by some 1200 lines of code. For now,
the old ones are wrapped in #ifdefs, and the new functions are enabled
by make if curl's version is >=3D 7.34.0, from which version on curl's
CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
available. The low-level functions will still be used for tunneling
into the server for now.

As I don't have access to that many IMAP servers, I haven't been able t=
o
test the new code with a wide variety of parameter combinations. I did
test both secure and insecure (imaps:// and imap://) connections and
values of "PLAIN" and "LOGIN" for the authMethod.

In order to suppress a sparse warning about "using sizeof on a
function", we use the same solution used in commit 9371322a6
("sparse: suppress some "using sizeof on a function" warnings",
06-10-2013) which solved exactly this problem for the other commands
using libcurl.

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Documentation/git-imap-send.txt |  15 +++-
 INSTALL                         |  15 ++--
 Makefile                        |  18 +++-
 imap-send.c                     | 176 ++++++++++++++++++++++++++++++++=
++------
 4 files changed, 187 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-s=
end.txt
index 0897131..77aacf1 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin=
 to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q]
+'git imap-send' [-v] [-q] [--[no-]curl]
=20
=20
 DESCRIPTION
@@ -37,6 +37,15 @@ OPTIONS
 --quiet::
 	Be quiet.
=20
+--curl::
+	Use libcurl to communicate with the IMAP server, unless tunneling
+	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	option set.
+
+--no-curl::
+	Talk to the IMAP server using git's own IMAP routines instead of
+	using libcurl.
+
=20
 CONFIGURATION
 -------------
@@ -87,7 +96,9 @@ imap.preformattedHTML::
=20
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only. If this is not set
+	If Git was built with the NO_CURL option, or if your curl version is =
older
+	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
+	option, the only supported method is 'CRAM-MD5'. If this is not set
 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
=20
 Examples
diff --git a/INSTALL b/INSTALL
index 6ec7a24..ffb071e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -108,18 +108,21 @@ Issues of note:
 	  so you might need to install additional packages other than Perl
 	  itself, e.g. Time::HiRes.
=20
-	- "openssl" library is used by git-imap-send to use IMAP over SSL.
-	  If you don't need it, use NO_OPENSSL.
+	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
+	  you are using libcurl older than 7.34.0.  Otherwise you can use
+	  NO_OPENSSL without losing git-imap-send.
=20
 	  By default, git uses OpenSSL for SHA1 but it will use its own
 	  library (inspired by Mozilla's) with either NO_OPENSSL or
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
=20
-	- "libcurl" library is used by git-http-fetch and git-fetch.  You
-	  might also want the "curl" executable for debugging purposes.
-	  If you do not use http:// or https:// repositories, you do not
-	  have to have them (use NO_CURL).
+	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
+	  the curl version >=3D 7.34.0, for git-imap-send.  You might also
+	  want the "curl" executable for debugging purposes. If you do not
+	  use http:// or https:// repositories, and do not want to put
+	  patches into an IMAP mailbox, you do not have to have them
+	  (use NO_CURL).
=20
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
diff --git a/Makefile b/Makefile
index 827006b..14d5ac1 100644
--- a/Makefile
+++ b/Makefile
@@ -995,6 +995,9 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS +=3D -DHAVE_ALLOCA_H
 endif
=20
+IMAP_SEND_BUILDDEPS =3D
+IMAP_SEND_LDFLAGS =3D $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO=
)
+
 ifdef NO_CURL
 	BASIC_CFLAGS +=3D -DNO_CURL
 	REMOTE_CURL_PRIMARY =3D
@@ -1029,6 +1032,15 @@ else
 			PROGRAM_OBJS +=3D http-push.o
 		endif
 	endif
+	curl_check :=3D $(shell (echo 072200; curl-config --vernum) 2>/dev/nu=
ll | sort -r | sed -ne 2p)
+	ifeq "$(curl_check)" "072200"
+		USE_CURL_FOR_IMAP_SEND =3D YesPlease
+	endif
+	ifdef USE_CURL_FOR_IMAP_SEND
+		BASIC_CFLAGS +=3D -DUSE_CURL_FOR_IMAP_SEND
+		IMAP_SEND_BUILDDEPS =3D http.o
+		IMAP_SEND_LDFLAGS +=3D $(CURL_LIBCURL)
+	endif
 	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS +=3D -I$(EXPATDIR)/include
@@ -1874,7 +1886,7 @@ gettext.sp gettext.s gettext.o: GIT-PREFIX
 gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS =3D \
 	-DGIT_LOCALE_PATH=3D'"$(localedir_SQ)"'
=20
-http-push.sp http.sp http-walker.sp remote-curl.sp: SPARSE_FLAGS +=3D =
\
+http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARS=
E_FLAGS +=3D \
 	-DCURL_DISABLE_TYPECHECK
=20
 ifdef NO_EXPAT
@@ -1895,9 +1907,9 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS)
=20
-git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITL=
IBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+		$(LIBS) $(IMAP_SEND_LDFLAGS)
=20
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITL=
IBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
diff --git a/imap-send.c b/imap-send.c
index 7f9d30e..08271d9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -30,13 +30,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
+#ifdef USE_CURL_FOR_IMAP_SEND
+#include "http.h"
+#endif
=20
 static int verbosity;
+static int use_curl; /* strictly opt in */
=20
-static const char * const imap_send_usage[] =3D { "git imap-send [-v] =
[-q] < <mbox>", NULL };
+static const char * const imap_send_usage[] =3D { "git imap-send [-v] =
[-q] [--[no-]curl] < <mbox>", NULL };
=20
 static struct option imap_send_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
+	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the I=
MAP server"),
 	OPT_END()
 };
=20
@@ -1344,14 +1349,141 @@ static void git_imap_config(void)
 	git_config_get_string("imap.authmethod", &server.auth_method);
 }
=20
-int main(int argc, char **argv)
+static int append_msgs_to_imap(struct imap_server_conf *server, struct=
 strbuf* all_msgs, int total)
 {
-	struct strbuf all_msgs =3D STRBUF_INIT;
 	struct strbuf msg =3D STRBUF_INIT;
 	struct imap_store *ctx =3D NULL;
 	int ofs =3D 0;
 	int r;
-	int total, n =3D 0;
+	int n =3D 0;
+
+	ctx =3D imap_open_store(server, server->folder);
+	if (!ctx) {
+		fprintf(stderr, "failed to open store\n");
+		return 1;
+	}
+	ctx->name =3D server->folder;
+
+	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
+	while (1) {
+		unsigned percent =3D n * 100 / total;
+
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+
+		if (!split_msg(all_msgs, &msg, &ofs))
+			break;
+		if (server->use_html)
+			wrap_in_html(&msg);
+		r =3D imap_store_msg(ctx, &msg);
+		if (r !=3D DRV_OK)
+			break;
+		n++;
+	}
+	fprintf(stderr, "\n");
+
+	imap_close_store(ctx);
+
+	return 0;
+}
+
+#ifdef USE_CURL_FOR_IMAP_SEND
+static CURL *setup_curl(struct imap_server_conf *srvc)
+{
+	CURL *curl;
+	struct strbuf path =3D STRBUF_INIT;
+	struct strbuf auth =3D STRBUF_INIT;
+
+	if (curl_global_init(CURL_GLOBAL_ALL) !=3D CURLE_OK)
+		die("curl_global_init failed");
+
+	curl =3D curl_easy_init();
+
+	if (!curl)
+		die("curl_easy_init failed");
+
+	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
+	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+
+	strbuf_addstr(&path, server.host);
+	if (!path.len || path.buf[path.len - 1] !=3D '/')
+		strbuf_addch(&path, '/');
+	strbuf_addstr(&path, server.folder);
+
+	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
+	strbuf_release(&path);
+	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
+
+	if (server.auth_method) {
+		strbuf_addstr(&auth, "AUTH=3D");
+		strbuf_addstr(&auth, server.auth_method);
+		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+	}
+	strbuf_release(&auth);
+
+	if (server.use_ssl)
+		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_ALL);
+
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, server.ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, server.ssl_verify);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
+	if (0 < verbosity)
+		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+
+	return curl;
+}
+
+static int curl_append_msgs_to_imap(struct imap_server_conf *server, s=
truct strbuf* all_msgs, int total) {
+	int ofs =3D 0;
+	int n =3D 0;
+	struct buffer msgbuf =3D { STRBUF_INIT, 0 };
+	CURL *curl;
+	CURLcode res =3D CURLE_OK;
+
+	curl =3D setup_curl(server);
+	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
+
+	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
+	while (1) {
+		unsigned percent =3D n * 100 / total;
+
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+
+		int prev_len =3D msgbuf.buf.len;
+		if (!split_msg(all_msgs, &msgbuf.buf, &ofs))
+			break;
+		if (server->use_html)
+			wrap_in_html(&msgbuf.buf);
+		lf_to_crlf(&msgbuf.buf);
+
+		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE, (curl_off_t)(msgbuf=
=2Ebuf.len-prev_len));
+
+		res =3D curl_easy_perform(curl);
+
+		if(res !=3D CURLE_OK) {
+			fprintf(stderr, "curl_easy_perform() failed: %s\n",
+					curl_easy_strerror(res));
+			break;
+		}
+
+		n++;
+	}
+	fprintf(stderr, "\n");
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	struct strbuf all_msgs =3D STRBUF_INIT;
+	int total;
 	int nongit_ok;
=20
 	git_extract_argv0_path(argv[0]);
@@ -1366,6 +1498,13 @@ int main(int argc, char **argv)
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
=20
+#ifndef USE_CURL_FOR_IMAP_SEND
+	if (use_curl) {
+		warning("--use-curl not supported in this build");
+		use_curl =3D 0;
+	}
+#endif
+
 	if (!server.port)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
@@ -1399,29 +1538,14 @@ int main(int argc, char **argv)
 	}
=20
 	/* write it to the imap server */
-	ctx =3D imap_open_store(&server, server.folder);
-	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
-		return 1;
-	}
-
-	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s"=
 : "");
-	while (1) {
-		unsigned percent =3D n * 100 / total;
=20
-		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg, &ofs))
-			break;
-		if (server.use_html)
-			wrap_in_html(&msg);
-		r =3D imap_store_msg(ctx, &msg);
-		if (r !=3D DRV_OK)
-			break;
-		n++;
-	}
-	fprintf(stderr, "\n");
+	if (server.tunnel)
+		return append_msgs_to_imap(&server, &all_msgs, total);
=20
-	imap_close_store(ctx);
+#ifdef USE_CURL_FOR_IMAP_SEND
+	if (use_curl)
+		return curl_append_msgs_to_imap(&server, &all_msgs, total);
+#endif
=20
-	return 0;
+	return append_msgs_to_imap(&server, &all_msgs, total);
 }
--=20
2.2.0.rc0.4.g1aeb70f.dirty
