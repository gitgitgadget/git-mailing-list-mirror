From: Bernhard Reiter <ockham@raz.or.at>
Subject: [PATCH] git-imap-send: use libcurl for implementation
Date: Wed, 27 Aug 2014 00:40:17 +0200
Message-ID: <53FD0CD1.7030801@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 00:40:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMPPg-0004fk-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 00:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbaHZWkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 18:40:24 -0400
Received: from mhub.domainplanet.at ([92.43.99.111]:35348 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756052AbaHZWkX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 18:40:23 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 101CB9D3415;
	Wed, 27 Aug 2014 00:40:19 +0200 (CEST)
Received: from [90.0.0.2] (93-82-40-175.adsl.highway.telekom.at [93.82.40.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 9E89EBFB92;
	Wed, 27 Aug 2014 00:40:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255954>

Use libcurl's high-level API functions to implement git-imap-send
instead of the previous low-level OpenSSL-based functions.

Since version 7.30.0, libcurl's API has been able to communicate with
IMAP servers. Using those high-level functions instead of the current
ones would reduce imap-send.c by some 1200 lines of code. For now,
the old ones are wrapped in #ifdefs, and the new functions are enabled
by make if curl's version is >= 7.35.0, from which version on curl's
CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
available.

As I don't have access to that many IMAP servers, I haven't been able to
test the new code with a wide variety of parameter combinations. I did
test both secure and insecure (imaps:// and imap://) connections and
values of "PLAIN" and "LOGIN" for the authMethod.

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
I rebased the patch on the pu branch, hope that was the right thing to do.

Bernhard

 Documentation/git-imap-send.txt |   3 +-
 INSTALL                         |  15 ++--
 Makefile                        |  16 +++-
 git.spec.in                     |   5 +-
 imap-send.c                     | 165 +++++++++++++++++++++++++++++++++-------
 5 files changed, 167 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 7d991d9..9d244c4 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -75,7 +75,8 @@ imap.preformattedHTML::
 
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only. If this is not set
+	If you compiled git with the NO_CURL option or if your curl version is
+	< 7.35.0, the only supported method is 'CRAM-MD5'. If this is not set
 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
 
 Examples
diff --git a/INSTALL b/INSTALL
index 6ec7a24..e2770a0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -108,18 +108,21 @@ Issues of note:
 	  so you might need to install additional packages other than Perl
 	  itself, e.g. Time::HiRes.
 
-	- "openssl" library is used by git-imap-send to use IMAP over SSL.
-	  If you don't need it, use NO_OPENSSL.
+	- "openssl" library is used by git-imap-send to use IMAP over SSL,
+	  unless you're using curl >= 7.35.0, in which case that will be
+	  used. If you don't need git-imap-send, you can use NO_OPENSSL.
 
 	  By default, git uses OpenSSL for SHA1 but it will use its own
 	  library (inspired by Mozilla's) with either NO_OPENSSL or
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
 
-	- "libcurl" library is used by git-http-fetch and git-fetch.  You
-	  might also want the "curl" executable for debugging purposes.
-	  If you do not use http:// or https:// repositories, you do not
-	  have to have them (use NO_CURL).
+	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
+	  the curl version >= 7.35.0, for git-imap-send.  You might also
+	  want the "curl" executable for debugging purposes. If you do not
+	  use http:// or https:// repositories, and do not want to put
+	  patches into an IMAP mailbox, you do not have to have them
+	  (use NO_CURL).
 
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
diff --git a/Makefile b/Makefile
index 237bc05..c08963c 100644
--- a/Makefile
+++ b/Makefile
@@ -1133,6 +1133,9 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
 
+IMAP_SEND_BUILDDEPS =
+IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
@@ -1167,6 +1170,15 @@ else
 			PROGRAM_OBJS += http-push.o
 		endif
 	endif
+	curl_check := $(shell (echo 072300; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
+	ifeq "$(curl_check)" "072300"
+		USE_CURL_FOR_IMAP_SEND = YesPlease
+	endif
+	ifdef USE_CURL_FOR_IMAP_SEND
+		BASIC_CFLAGS += -DUSE_CURL_FOR_IMAP_SEND
+		IMAP_SEND_BUILDDEPS = http.o
+		IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
+	endif
 	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS += -I$(EXPATDIR)/include
@@ -2084,9 +2096,9 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+		$(LIBS) $(IMAP_SEND_LDFLAGS)
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
diff --git a/git.spec.in b/git.spec.in
index d61d537..9535cc3 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -8,7 +8,7 @@ License: 	GPL
 Group: 		Development/Tools
 URL: 		http://kernel.org/pub/software/scm/git/
 Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
-BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
+BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel >= 7.35.0, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 
 Requires:	perl-Git = %{version}-%{release}
@@ -214,6 +214,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Mon Aug 11 2014 Bernhard Reiter <ockham@raz.or.at>
+- Require version >= 7.35.0 of curl-devel for IMAP functions.
+
 * Sun Sep 18 2011 Jakub Narebski <jnareb@gmail.com>
 - Add gitweb manpages to 'gitweb' subpackage
 
diff --git a/imap-send.c b/imap-send.c
index ad330a6..a170cbb 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,6 +29,9 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
+#ifdef USE_CURL_FOR_IMAP_SEND
+#include "http.h"
+#endif
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
 
@@ -1338,14 +1341,138 @@ static void git_imap_config(void)
 	git_config_get_string("imap.authmethod", &server.auth_method);
 }
 
-int main(int argc, char **argv)
-{
-	struct strbuf all_msgs = STRBUF_INIT;
+static int append_msgs_to_imap(struct imap_server_conf *server, struct strbuf* all_msgs, int total) {
 	struct strbuf msg = STRBUF_INIT;
 	struct imap_store *ctx = NULL;
 	int ofs = 0;
 	int r;
-	int total, n = 0;
+	int n = 0;
+
+	ctx = imap_open_store(server, server->folder);
+	if (!ctx) {
+		fprintf(stderr, "failed to open store\n");
+		return 1;
+	}
+	ctx->name = server->folder;
+
+	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	while (1) {
+		unsigned percent = n * 100 / total;
+
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+
+		if (!split_msg(all_msgs, &msg, &ofs))
+			break;
+		if (server->use_html)
+			wrap_in_html(&msg);
+		r = imap_store_msg(ctx, &msg);
+		if (r != DRV_OK)
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
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf auth = STRBUF_INIT;
+
+	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
+		die("curl_global_init failed");
+
+	curl = curl_easy_init();
+
+	if (!curl)
+		die("curl_easy_init failed");
+
+	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
+	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
+
+	strbuf_addstr(&path, server.host);
+	if (!path.len || path.buf[path.len - 1] != '/')
+		strbuf_addch(&path, '/');
+	strbuf_addstr(&path, server.folder);
+
+	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
+	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
+
+	if (server.auth_method) {
+		strbuf_addstr(&auth, "AUTH=");
+		strbuf_addstr(&auth, server.auth_method);
+		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+	}
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
+	if (Verbose)
+		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
+
+	return curl;
+}
+
+static int curl_append_msgs_to_imap(struct imap_server_conf *server, struct strbuf* all_msgs, int total) {
+	int ofs = 0;
+	int n = 0;
+	struct buffer msgbuf = { STRBUF_INIT, 0 };
+	CURL *curl;
+	CURLcode res = CURLE_OK;
+
+	curl = setup_curl(server);
+	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
+
+	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	while (1) {
+		unsigned percent = n * 100 / total;
+
+		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+
+		int prev_len = msgbuf.buf.len;
+		if (!split_msg(all_msgs, &msgbuf.buf, &ofs))
+			break;
+		if (server->use_html)
+			wrap_in_html(&msgbuf.buf);
+		lf_to_crlf(&msgbuf.buf);
+
+		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE, (curl_off_t)(msgbuf.buf.len-prev_len));
+
+		res = curl_easy_perform(curl);
+
+		if(res != CURLE_OK) {
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
+	struct strbuf all_msgs = STRBUF_INIT;
+	int total;
 	int nongit_ok;
 
 	git_extract_argv0_path(argv[0]);
@@ -1391,29 +1518,13 @@ int main(int argc, char **argv)
 	}
 
 	/* write it to the imap server */
-	ctx = imap_open_store(&server, server.folder);
-	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
-		return 1;
-	}
-
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	while (1) {
-		unsigned percent = n * 100 / total;
-
-		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg, &ofs))
-			break;
-		if (server.use_html)
-			wrap_in_html(&msg);
-		r = imap_store_msg(ctx, &msg);
-		if (r != DRV_OK)
-			break;
-		n++;
-	}
-	fprintf(stderr, "\n");
 
-	imap_close_store(ctx);
+	if (server.tunnel)
+		return append_msgs_to_imap(&server, &all_msgs, total);
 
-	return 0;
+#ifndef USE_CURL_FOR_IMAP_SEND
+	return append_msgs_to_imap(&server, &all_msgs, total);
+#else
+	return curl_append_msgs_to_imap(&server, &all_msgs, total);
+#endif
 }
-- 
2.1.0.372.g32d59d1.dirty
