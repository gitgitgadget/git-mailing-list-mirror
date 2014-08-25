From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Mon, 25 Aug 2014 22:11:11 +0200
Message-ID: <53FB985F.8080608@raz.or.at>
References: <53ED2E46.5020403@raz.or.at> <xmqq1tscwepa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:11:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM0bp-0000Pz-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 22:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbaHYULS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 16:11:18 -0400
Received: from mhub.domainplanet.at ([92.43.99.111]:42705 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbaHYULR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 16:11:17 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 3FCDA9D377B;
	Mon, 25 Aug 2014 22:11:12 +0200 (CEST)
Received: from [90.0.0.2] (213-33-7-233.adsl.highway.telekom.at [213.33.7.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 54EFDBF42A;
	Mon, 25 Aug 2014 22:11:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq1tscwepa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255862>

Am 2014-08-19 um 19:51 schrieb Junio C Hamano:
> This looks strange and stands out like a sore thumb.  Do any of our
> other sources do this kind of macro tweaking inside C source before
> including git-compat-util.h (or its equivalent like cache.h)?

I haven't checked, but I agree that it's desirable to avoid.

> I think what you are trying to do is to change the meaning of
> NO_OPENSSL, which merely means "we do not have OpenSSL library and
> do not want to link with it", locally to "we may or may not have and
> use OpenSSL library elsewhere in Git, but in the code below we do
> not want to use the code written to work on top of OpenSSL and
> instead use libcurl".  

"...and we don't want to link to OpenSSL in that case." Yeah.

> Because of that, you define NO_OPENSSL before
> including any of our headers to cause us not to include the headers,
> and typedef away SSL, for example.

The SSL un-typedef'ing was there before, but it's true that I'm defining
NO_OPENSSL on the very top so the included headers don't require OpenSSL
(and so we don't have to link to it later).

>>  #include "cache.h"
>>  #include "credential.h"
>>  #include "exec_cmd.h"
>> @@ -29,6 +33,9 @@
>>  #ifdef NO_OPENSSL
>>  typedef void *SSL;
>>  #endif
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +#include "http.h"
>> +#endif
> 
> But does it have to be that way?  For one thing, doing it this way,
> the user has to make a compilation-time choice, but if you separate
> these compilation time macro into two, one for "can we even link
> with and use OpenSSL?" (which is what NO_OPENSSL is about) and
> another for "do we want an ability to talk to imap via libcurl?",
> wouldn't it make it possible for you to switch between them at
> runtime (e.g. you might want to go over the direct connection when
> tunneling, while letting libcurl do the heavy lifting in
> non-tunneled operation)?

Yeah, but I still need to wrap the non-tunneled operation in #ifdefs in
case we don't USE_CURL_FOR_IMAP_SEND in which case we fall back to the
handwritten IMAP code, don't I?

Maybe I'm not getting you entirely right, but if I don't typedef
NO_OPENSSL if USE_CURL_FOR_IMAP_SEND is defined, I don't see any way to
not link to OpenSSL, even if it's not required. I'm including a slightly
modified patch which does that (hoping that I've finally managed to send
a usable patch). Sorry it's nothing breathtakingly better than before,
even after giving this some thought I didn't arrive at a very elegant
new solution... (see below for more on that)

>> @@ -1417,18 +1476,48 @@ int main(int argc, char **argv)
>>  	}
>>  
>>  	/* write it to the imap server */
>> +
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +	if (!server.tunnel) {
>> +		curl = setup_curl(&server);
>> +		curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
>> +	} else {
>> +#endif
>>  	ctx = imap_open_store(&server);
>>  	if (!ctx) {
>>  		fprintf(stderr, "failed to open store\n");
>>  		return 1;
>>  	}
>> +	ctx->name = server.folder;
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +	}
>> +#endif
>>  
>>  	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
>> -	ctx->name = imap_folder;
>>  	while (1) {
>>  		unsigned percent = n * 100 / total;
>>  
>>  		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +		if (!server.tunnel) {
>> ...
>> +			}
>> +		} else {
>> +#endif
>>  		if (!split_msg(&all_msgs, &msg, &ofs))
>>  			break;
>>  		if (server.use_html)
>> @@ -1436,11 +1525,19 @@ int main(int argc, char **argv)
>>  		r = imap_store_msg(ctx, &msg);
>>  		if (r != DRV_OK)
>>  			break;
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +		}
>> +#endif
>>  		n++;
>>  	}
>>  	fprintf(stderr, "\n");
>>  
>> +#ifdef USE_CURL_FOR_IMAP_SEND
>> +	curl_easy_cleanup(curl);
>> +	curl_global_cleanup();
>> +#else
>>  	imap_close_store(ctx);
>> +#endif
>>  
>>  	return 0;
>>  }
> 
> Ugly.  Can we do this with less #ifdef/#else/#endif in the primary
> code path?

It is ugly, but as much as I'd love to put e.g.

+#ifdef USE_CURL_FOR_IMAP_SEND
+	if (!server.tunnel) {
+		curl = setup_curl(&server);

etc into imap_open_store (and similarly for imap_store_msg etc), I don't
see any easy way to do it; imap_open_store's return type would still be
struct imap_store* in the non-tunneling case, and CURL* otherwise.

So the best I can come up with here is merging some of the #ifdef
blocks, but that means duplicating the code that applies in both cases.
But that isn't any better, is it?

> If we were to keep these two modes as a choice the users have to
> make at the compilation time, that is.

As stated above, I'm not sure how to do entirely without at least those
two compile time switches (NO_OPENSSL and USE_CURL_FOR_IMAP_SEND).

Sorry, perhaps I missed something obvious; grateful for any hints on how
to do it better.

Bernhard

 Documentation/git-imap-send.txt |  3 +-
 INSTALL                         | 15 ++++---
 Makefile                        | 16 ++++++-
 git.spec.in                     |  5 ++-
 imap-send.c                     | 96 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 125 insertions(+), 10 deletions(-)

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
index ad330a6..3343429 100644
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
 
@@ -1307,6 +1310,55 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 	return 1;
 }
 
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
+#endif
+
 static void git_imap_config(void)
 {
 	const char *val = NULL;
@@ -1347,6 +1399,11 @@ int main(int argc, char **argv)
 	int r;
 	int total, n = 0;
 	int nongit_ok;
+#ifdef USE_CURL_FOR_IMAP_SEND
+	struct buffer msgbuf = { STRBUF_INIT, 0 };
+	CURL *curl;
+	CURLcode res = CURLE_OK;
+#endif /* #ifndef USE_CURL_FOR_IMAP_SEND */
 
 	git_extract_argv0_path(argv[0]);
 
@@ -1391,17 +1448,48 @@ int main(int argc, char **argv)
 	}
 
 	/* write it to the imap server */
+
+#ifdef USE_CURL_FOR_IMAP_SEND
+	if (!server.tunnel) {
+		curl = setup_curl(&server);
+		curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
+	} else {
+#endif
 	ctx = imap_open_store(&server, server.folder);
 	if (!ctx) {
 		fprintf(stderr, "failed to open store\n");
 		return 1;
 	}
+	ctx->name = server.folder;
+#ifdef USE_CURL_FOR_IMAP_SEND
+	}
+#endif
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 
 		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
+#ifdef USE_CURL_FOR_IMAP_SEND
+		if (!server.tunnel) {
+			int prev_len = msgbuf.buf.len;
+			if (!split_msg(&all_msgs, &msgbuf.buf, &ofs))
+				break;
+			if (server.use_html)
+				wrap_in_html(&msgbuf.buf);
+			lf_to_crlf(&msgbuf.buf);
+
+			curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE, (curl_off_t)(msgbuf.buf.len-prev_len));
+
+			res = curl_easy_perform(curl);
+
+			if(res != CURLE_OK) {
+				fprintf(stderr, "curl_easy_perform() failed: %s\n",
+						curl_easy_strerror(res));
+				break;
+			}
+		} else {
+#endif
 		if (!split_msg(&all_msgs, &msg, &ofs))
 			break;
 		if (server.use_html)
@@ -1409,11 +1497,19 @@ int main(int argc, char **argv)
 		r = imap_store_msg(ctx, &msg);
 		if (r != DRV_OK)
 			break;
+#ifdef USE_CURL_FOR_IMAP_SEND
+		}
+#endif
 		n++;
 	}
 	fprintf(stderr, "\n");
 
+#ifdef USE_CURL_FOR_IMAP_SEND
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+#else
 	imap_close_store(ctx);
+#endif
 
 	return 0;
 }
-- 
2.1.0.372.g89e5a25
