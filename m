From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH] git-imap-send: use libcurl for implementation
Date: Sun, 12 Oct 2014 17:22:20 +0200
Message-ID: <543A9CAC.5030404@raz.or.at>
References: <53FD0CD1.7030801@raz.or.at> <xmqqoav5etnb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, 434599@bugs.debian.org,
	=?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Tony Finch <dot@dotat.at>, Tanay Abhra <tanayabh@gmail.com>,
	Dan Albert <danalbert@google.com>,
	Jeremy Huddleston <jeremyhu@apple.com>,
	David Aguilar <davvid@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Oswald Buddenhagen <ossi@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:27:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdL3k-0005yk-0N
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 17:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaJLP1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 11:27:44 -0400
Received: from mhub.domainplanet.at ([92.43.99.117]:35434 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaJLP1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2014 11:27:43 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Oct 2014 11:27:42 EDT
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id AD0119D5693;
	Sun, 12 Oct 2014 17:21:57 +0200 (CEST)
Received: from [10.0.0.58] (194-118-230-205.adsl.highway.telekom.at [194.118.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 1FF00BF5DE;
	Sun, 12 Oct 2014 17:22:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqoav5etnb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for not getting back to this any sooner, I've been pretty busy
recently with Other Projects(tm).

Am 2014-08-27 um 19:20 schrieb Junio C Hamano:
> Bernhard Reiter <ockham@raz.or.at> writes:
> 
>> [...] For now,
>> the old ones are wrapped in #ifdefs, and the new functions are enabled
>> by make if curl's version is >= 7.35.0, from which version on curl's
>> CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
>> available.
> 
> https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions
> says that this was introduced as of 7.34.0, though.

Strange, I thought I recalled having seen that in
http://curl.haxx.se/libcurl/c/CURLOPT_LOGIN_OPTIONS.html but it clearly
says 7.34.0 there too. I've now changed all occurrences of 7.35.0 to
7.34.0 (and the corresponding hex value in the Makefile).

>> As I don't have access to that many IMAP servers, I haven't been able to
>> test the new code with a wide variety of parameter combinations. I did
>> test both secure and insecure (imaps:// and imap://) connections and
>> values of "PLAIN" and "LOGIN" for the authMethod.
> 
> Perhaps CC'ing those who have touched git-imap-send code over the
> years and asking for their help testing might help?

CC'ing them (going back about 2 years, which already makes the list
quite long) and the people who have taken part in the initial discussion
on this feature in August. And the related Debian bug.

Please test this, folks!

>> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
>> ---
>> I rebased the patch on the pu branch, hope that was the right thing to do.
> 
> Usually I would appreciate a patch for a new feature not meant for
> the maintenance tracks to be based on 'master', so that it can go to
> the next release without having to wait other changes that may
> conflict with it and that may not yet be ready.
> 
> I will try to apply this one to 'pu', rebase it on 'master' to make
> sure the result does not depend on the other topics in flight, and
> then merge it back to 'pu'.

Okay, I'll stick to master. I've rebased on master now that the first
couple related patches are there anyway.

> [...]
>>
>> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
>> index 7d991d9..9d244c4 100644
>> --- a/Documentation/git-imap-send.txt
>> +++ b/Documentation/git-imap-send.txt
>> @@ -75,7 +75,8 @@ imap.preformattedHTML::
>>  
>>  imap.authMethod::
>>  	Specify authenticate method for authentication with IMAP server.
>> -	Current supported method is 'CRAM-MD5' only. If this is not set
>> +	If you compiled git with the NO_CURL option or if your curl version is
>> +	< 7.35.0, the only supported method is 'CRAM-MD5'. If this is not set
>>  	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
> 
> Hmph, so there is no option that lets me say "I know my libcurl is
> new enough but I have some reason not to want to use the new code to
> interact with my imap server", at compile time or (more preferrably)
> at runtime?

Added a runtime option, see below.

>> diff --git a/INSTALL b/INSTALL
>> index 6ec7a24..e2770a0 100644
>> --- a/INSTALL
>> +++ b/INSTALL
>> @@ -108,18 +108,21 @@ Issues of note:
>>  	  so you might need to install additional packages other than Perl
>>  	  itself, e.g. Time::HiRes.
>>  
>> -	- "openssl" library is used by git-imap-send to use IMAP over SSL.
>> -	  If you don't need it, use NO_OPENSSL.
>> +	- "openssl" library is used by git-imap-send to use IMAP over SSL,
>> +	  unless you're using curl >= 7.35.0, in which case that will be
>> +	  used. If you don't need git-imap-send, you can use NO_OPENSSL.
> 
> The last sentence makes it unclear which of the following is true:
> 
>  - I have sufficiently new libcurl.  I cannot say NO_OPENSSL because
>    I do need git-imap-send.
> 
>  - I have sufficiently new libcurl, so "openssl" is not used by
>    git-imap send for me.  I can say NO_OPENSSL.
> 
> Perhaps
> 
>  - git-imap-send needs the OpenSSL library to talk IMAP over SSL if
>    you are using libCurl older than 7.35.0.  Otherwise you can use
>    NO_OPENSSL without losing git-imap-send.

Fixed.

>> diff --git a/git.spec.in b/git.spec.in
>> index d61d537..9535cc3 100644
>> --- a/git.spec.in
>> +++ b/git.spec.in
>> @@ -8,7 +8,7 @@ License: 	GPL
>>  Group: 		Development/Tools
>>  URL: 		http://kernel.org/pub/software/scm/git/
>>  Source: 	http://kernel.org/pub/software/scm/git/%{name}-%{version}.tar.gz
>> -BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
>> +BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel >= 7.35.0, expat-devel, gettext  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
> 
> This is very iffy.  It incompatible with the body of the patch where
> you allow older curl library and because you depend on openssl-devel
> you wouldn't lose imap-send.

Okay, removed the version requirement.

>> @@ -1391,29 +1518,13 @@ int main(int argc, char **argv)
>> [...]
> 
> Much more nicely done.  It appears that you could already turn these
> #ifndef/#else/#endif into a runtime conditional, allowing:
> 
>  - At compile-time, can be built with the four combinations
> 
>    (1) USE_CURL_FOR_IMAP_SEND=Yes    NO_OPENSSL=No
>    (2) USE_CURL_FOR_IMAP_SEND=Yes    NO_OPENSSL=Yes
>    (3) USE_CURL_FOR_IMAP_SEND=No     NO_OPENSSL=No
>    (4) USE_CURL_FOR_IMAP_SEND=No     NO_OPENSSL=Yes
> 
>  - The first two variants can support --with-curl/--without-curl and
>    choose between curl_append/append.  When run --without-curl, it
>    may lose some auth-methods and for variant (1) SSL is not
>    supported.
> 
> or am I mis-reading the patch?

You're reading it correctly; thanks for the hint about the runtime switch.

I've now implemented it using parse_options, so the switch is called
--[no-]curl. I hope parse_options isn't overkill, but as I wanted to
keep other options -- namely verbose and quiet switches, useful for
debugging curl -- I would've had to look through all argv[] items
manually, so I figured it made sense to us an already existing API for
that instead.

Bernhard

>From 218c47580330d5ac38875c30e14dc3049d1ce3c5 Mon Sep 17 00:00:00 2001
From: Bernhard Reiter <ockham@raz.or.at>
Date: Wed, 13 Aug 2014 23:41:40 +0200
Subject: [PATCH] git-imap-send: use libcurl for implementation

Use libcurl's high-level API functions to implement git-imap-send
instead of the previous low-level OpenSSL-based functions.

Since version 7.30.0, libcurl's API has been able to communicate with
IMAP servers. Using those high-level functions instead of the current
ones would reduce imap-send.c by some 1200 lines of code. For now,
the old ones are wrapped in #ifdefs, and the new functions are enabled
by make if curl's version is >= 7.34.0, from which version on curl's
CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
available. The low-level functions will still be used for tunneling
into the server for now.

As I don't have access to that many IMAP servers, I haven't been able to
test the new code with a wide variety of parameter combinations. I did
test both secure and insecure (imaps:// and imap://) connections and
values of "PLAIN" and "LOGIN" for the authMethod.

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
---
 Documentation/git-imap-send.txt |  26 +++++-
 INSTALL                         |  15 ++--
 Makefile                        |  16 +++-
 imap-send.c                     | 189 +++++++++++++++++++++++++++++++++-------
 4 files changed, 204 insertions(+), 42 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 7d991d9..1c24e1f 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send'
+'git imap-send' [-v] [-q] --[no-]curl
 
 
 DESCRIPTION
@@ -25,6 +25,26 @@ Typical usage is something like:
 
 git format-patch --signoff --stdout --attach origin | git imap-send
 
+OPTIONS
+-------
+-v::
+--verbose::
+	Be verbose.
+
+-q::
+--quiet::
+	Be quiet.
+
+--curl::
+	Use libcurl to communicate with the IMAP server, unless tunneling
+	into it.  Only available if git was built with the
+	USE_CURL_FOR_IMAP_SEND option set, in which case this is the
+	default behavior.
+
+--no-curl::
+	Talk to the IMAP server using git's own IMAP routines instead of
+	using libcurl.  Only available git was built with the
+	USE_CURL_FOR_IMAP_SEND option set; implicitly assumed otherwise.
 
 CONFIGURATION
 -------------
@@ -75,7 +95,9 @@ imap.preformattedHTML::
 
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only. If this is not set
+	If git was built with the NO_CURL option, or if your curl version is
+	< 7.34.0, or if you're running git-imap-send with the --no-curl
+	option, the only supported method is 'CRAM-MD5'. If this is not set
 	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
 
 Examples
diff --git a/INSTALL b/INSTALL
index 6ec7a24..ffb071e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -108,18 +108,21 @@ Issues of note:
 	  so you might need to install additional packages other than Perl
 	  itself, e.g. Time::HiRes.
 
-	- "openssl" library is used by git-imap-send to use IMAP over SSL.
-	  If you don't need it, use NO_OPENSSL.
+	- git-imap-send needs the OpenSSL library to talk IMAP over SSL if
+	  you are using libcurl older than 7.34.0.  Otherwise you can use
+	  NO_OPENSSL without losing git-imap-send.
 
 	  By default, git uses OpenSSL for SHA1 but it will use its own
 	  library (inspired by Mozilla's) with either NO_OPENSSL or
 	  BLK_SHA1.  Also included is a version optimized for PowerPC
 	  (PPC_SHA1).
 
-	- "libcurl" library is used by git-http-fetch and git-fetch.  You
-	  might also want the "curl" executable for debugging purposes.
-	  If you do not use http:// or https:// repositories, you do not
-	  have to have them (use NO_CURL).
+	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
+	  the curl version >= 7.34.0, for git-imap-send.  You might also
+	  want the "curl" executable for debugging purposes. If you do not
+	  use http:// or https:// repositories, and do not want to put
+	  patches into an IMAP mailbox, you do not have to have them
+	  (use NO_CURL).
 
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
diff --git a/Makefile b/Makefile
index f34a2d4..69b2fbf 100644
--- a/Makefile
+++ b/Makefile
@@ -992,6 +992,9 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
 
+IMAP_SEND_BUILDDEPS =
+IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
@@ -1026,6 +1029,15 @@ else
 			PROGRAM_OBJS += http-push.o
 		endif
 	endif
+	curl_check := $(shell (echo 072200; curl-config --vernum) 2>/dev/null | sort -r | sed -ne 2p)
+	ifeq "$(curl_check)" "072200"
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
@@ -1892,9 +1904,9 @@ endif
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
-git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
+git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+		$(LIBS) $(IMAP_SEND_LDFLAGS)
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
diff --git a/imap-send.c b/imap-send.c
index 70bcc7a..9cc80ae 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -26,11 +26,31 @@
 #include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "parse-options.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
+#ifdef USE_CURL_FOR_IMAP_SEND
+#include "http.h"
+#endif
 
-static const char imap_send_usage[] = "git imap-send < <mbox>";
+static int Verbose, Quiet;
+#ifdef USE_CURL_FOR_IMAP_SEND
+static int use_curl = 1; // on by default; set later by parse_options
+#else
+static int use_curl = 0; // not available
+#endif
+
+static const char * const imap_send_usage[] = { "git imap-send <options> < <mbox>", NULL };
+
+static struct option imap_send_options[] = {
+#ifdef USE_CURL_FOR_IMAP_SEND
+	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+#endif
+	OPT__VERBOSE(&Verbose, "be verbose"),
+	OPT__QUIET(&Quiet, "be quiet"),
+	OPT_END()
+};
 
 #undef DRV_OK
 #define DRV_OK          0
@@ -38,8 +58,6 @@ static const char imap_send_usage[] = "git imap-send < <mbox>";
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3
 
-static int Verbose, Quiet;
-
 __attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
 __attribute__((format (printf, 1, 2)))
@@ -1338,22 +1356,145 @@ static void git_imap_config(void)
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
 
-	git_setup_gettext();
+	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
-	if (argc != 1)
-		usage(imap_send_usage);
+	git_setup_gettext();
 
 	setup_git_directory_gently(&nongit_ok);
 	git_imap_config();
@@ -1391,29 +1532,13 @@ int main(int argc, char **argv)
 	}
 
 	/* write it to the imap server */
-	ctx = imap_open_store(&server, server.folder);
-	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
-		return 1;
-	}
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	while (1) {
-		unsigned percent = n * 100 / total;
+	if (server.tunnel)
+		return append_msgs_to_imap(&server, &all_msgs, total);
 
-		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
-		if (!split_msg(&all_msgs, &msg, &ofs))
-			break;
-		if (server.use_html)
-			wrap_in_html(&msg);
-		r = imap_store_msg(ctx, &msg);
-		if (r != DRV_OK)
-			break;
-		n++;
+	if (use_curl) {
+		return curl_append_msgs_to_imap(&server, &all_msgs, total);
+	} else {
+		return append_msgs_to_imap(&server, &all_msgs, total);
 	}
-	fprintf(stderr, "\n");
-
-	imap_close_store(ctx);
-
-	return 0;
 }
-- 
2.1.2.375.g218c475
