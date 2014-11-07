From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH] imap-send: use libcurl for implementation
Date: Fri, 07 Nov 2014 13:46:35 +0100
Message-ID: <545CBF2B.3050607@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 13:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmiwE-0006qg-5h
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 13:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbaKGMqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 07:46:46 -0500
Received: from mhub.domainplanet.at ([92.43.99.110]:39076 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaKGMqg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 07:46:36 -0500
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 0D66B9C4DFB;
	Fri,  7 Nov 2014 13:46:31 +0100 (CET)
Received: from [10.0.0.25] (213-33-0-57.adsl.highway.telekom.at [213.33.0.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id B93A9BF42A;
	Fri,  7 Nov 2014 13:47:24 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zitat von Junio C Hamano <gitster@pobox.com>:

> Bernhard Reiter <ockham@raz.or.at> writes:
>
>> @@ -25,7 +25,6 @@ Typical usage is something like:
>>
>>  git format-patch --signoff --stdout --attach origin | git imap-send
>>
>> -
>>  OPTIONS
>
> Why?

By mistake when rebasing. Sorry, fixed. (Same for previous -1360,12 hunk.)

>> @@ -37,6 +36,17 @@ OPTIONS
>>  --quiet::
>>  	Be quiet.
>>
>> +--curl::
>> +	Use libcurl to communicate with the IMAP server, unless tunneling
>> +	into it.  Only available if git was built with the
>> +	USE_CURL_FOR_IMAP_SEND option set, in which case this is the
>> +	default behavior.
>> +
>> +--no-curl::
>> +	Talk to the IMAP server using git's own IMAP routines instead of
>> +	using libcurl.  Only available git was built with the
>> +	USE_CURL_FOR_IMAP_SEND option set; implicitly assumed otherwise.
>> +
>
> I think we tend to spell "Git" not "git" when we refer to the
> software suite as a whole.
>
> More importantly, the description on these two items are no longer
> in line with the implementation, aren't they?  We accept these
> options but warn and a build without libcurl ignores --curl with a
> warning, and --curl is not default in any build.

Fixed.

>> @@ -87,7 +97,9 @@ imap.preformattedHTML::
>>
>>  imap.authMethod::
>>  	Specify authenticate method for authentication with IMAP server.
>> -	Current supported method is 'CRAM-MD5' only. If this is not set
>> +	If git was built with the NO_CURL option, or if your curl version is
>> +	< 7.34.0, or if you're running git-imap-send with the --no-curl
>
> s/< /older than /;
>
> Also quote --no-curl inside bq-pair, i.e. `--no-curl`, as that is
> something the user will type as-is.

Fixed.

> [...]
>
>> diff --git a/imap-send.c b/imap-send.c
>> index 7f9d30e..01ce175 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -30,13 +30,18 @@
>>  #ifdef NO_OPENSSL
>>  typedef void *SSL;
>>  #endif
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +#include "http.h"
>> +#endif
>>
>>  static int verbosity;
>> +static int use_curl; /* strictly opt in */
>>
>> -static const char * const imap_send_usage[] = { "git imap-send [-v] 
>> [-q] < <mbox>", NULL };
>> +static const char * const imap_send_usage[] = { "git imap-send [-v] 
>> [-q] [--[no-]curl] < <mbox>", NULL };
>>
>>  static struct option imap_send_options[] = {
>>  	OPT__VERBOSITY(&verbosity),
>> +	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with 
>> the IMAP server"),
>>  	OPT_END()
>>  };
>>
>> @@ -1344,14 +1349,138 @@ static void git_imap_config(void)
>>  	git_config_get_string("imap.authmethod", &server.auth_method);
>>  }
>>
>> -int main(int argc, char **argv)
>> -{
>> -	struct strbuf all_msgs = STRBUF_INIT;
>> +static int append_msgs_to_imap(struct imap_server_conf *server, 
>> struct strbuf* all_msgs, int total) {
>
> The opening brace sits on its own line by itself, so

Fixed (I hope there wasn't more...)

>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +static CURL *setup_curl(struct imap_server_conf *srvc)
>> +{
>> +	CURL *curl;
>> +	struct strbuf path = STRBUF_INIT;
>> +	struct strbuf auth = STRBUF_INIT;
>> +
>> +	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>> +		die("curl_global_init failed");
>> +
>> +	curl = curl_easy_init();
>> +
>> +	if (!curl)
>> +		die("curl_easy_init failed");
>> +
>> +	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
>> +	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
>> +
>> +	strbuf_addstr(&path, server.host);
>> +	if (!path.len || path.buf[path.len - 1] != '/')
>> +		strbuf_addch(&path, '/');
>> +	strbuf_addstr(&path, server.folder);
>> +
>> +	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
>> +	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
>> +
>> +	if (server.auth_method) {
>> +		strbuf_addstr(&auth, "AUTH=");
>> +		strbuf_addstr(&auth, server.auth_method);
>> +		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
>> +	}
>
> Are path.buf and auth.buf leaked here, or does CURL *curl take
> possession of them by curl_easy_setopt() and not freeing them
> ourselves is the right thing to do?  Assuming that is the case,
> perhaps we would want to use strbuf_detach() on &path and &auth
> to make it clear that is what is going on?

I looked it up at http://curl.haxx.se/libcurl/c/curl_easy_setopt.html --
char* parameters are actually string copied by curl_easy_setopt(),
so I'm now strbuf_release()ing path and auth after use.

Bernhard

-- >8 --

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
 Documentation/git-imap-send.txt |  15 +++-
 INSTALL                         |  15 ++--
 Makefile                        |  16 +++-
 imap-send.c                     | 174 ++++++++++++++++++++++++++++++++++------
 4 files changed, 184 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 0897131..77aacf1 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q]
+'git imap-send' [-v] [-q] [--[no-]curl]
 
 
 DESCRIPTION
@@ -37,6 +37,15 @@ OPTIONS
 --quiet::
 	Be quiet.
 
+--curl::
+	Use libcurl to communicate with the IMAP server, unless tunneling
+	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	option set.
+
+--no-curl::
+	Talk to the IMAP server using git's own IMAP routines instead of
+	using libcurl.
+
 
 CONFIGURATION
 -------------
@@ -87,7 +96,9 @@ imap.preformattedHTML::
 
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only. If this is not set
+	If Git was built with the NO_CURL option, or if your curl version is older
+	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
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
index 827006b..fb954a9 100644
--- a/Makefile
+++ b/Makefile
@@ -995,6 +995,9 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
 
+IMAP_SEND_BUILDDEPS =
+IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
@@ -1029,6 +1032,15 @@ else
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
@@ -1895,9 +1907,9 @@ endif
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
index 7f9d30e..78fba00 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -30,13 +30,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
+#ifdef USE_CURL_FOR_IMAP_SEND
+#include "http.h"
+#endif
 
 static int verbosity;
+static int use_curl; /* strictly opt in */
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] < <mbox>", NULL };
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
+	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
 	OPT_END()
 };
 
@@ -1344,14 +1349,141 @@ static void git_imap_config(void)
 	git_config_get_string("imap.authmethod", &server.auth_method);
 }
 
-int main(int argc, char **argv)
+static int append_msgs_to_imap(struct imap_server_conf *server, struct strbuf* all_msgs, int total)
 {
-	struct strbuf all_msgs = STRBUF_INIT;
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
+	strbuf_release(&path);
+	curl_easy_setopt(curl, CURLOPT_PORT, server.port);
+
+	if (server.auth_method) {
+		strbuf_addstr(&auth, "AUTH=");
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
@@ -1366,6 +1498,13 @@ int main(int argc, char **argv)
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
+#ifndef USE_CURL_FOR_IMAP_SEND
+	if (use_curl) {
+		warning("--use-curl not supported in this build");
+		use_curl = 0;
+	}
+#endif
+
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
@@ -1399,29 +1538,12 @@ int main(int argc, char **argv)
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
+	if (server.tunnel)
+		return append_msgs_to_imap(&server, &all_msgs, total);
 
-	imap_close_store(ctx);
+	if (use_curl)
+		return curl_append_msgs_to_imap(&server, &all_msgs, total);
 
-	return 0;
+	return append_msgs_to_imap(&server, &all_msgs, total);
 }
-- 
2.2.0.rc0.4.gb4b9e19.dirty
