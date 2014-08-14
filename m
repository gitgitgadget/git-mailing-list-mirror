From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Thu, 14 Aug 2014 23:46:46 +0200
Message-ID: <53ED2E46.5020403@raz.or.at>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010507040003080006030902"
Cc: git@vger.kernel.org, 434599@bugs.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 23:47:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI2rL-0006uk-8Q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 23:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbaHNVqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 17:46:54 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:40868 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbaHNVqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 17:46:53 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 123139D3E3A;
	Thu, 14 Aug 2014 23:46:48 +0200 (CEST)
Received: from [90.0.0.2] (178-190-245-239.adsl.highway.telekom.at [178.190.245.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id A44A2BFBA4;
	Thu, 14 Aug 2014 23:46:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255275>

This is a multi-part message in MIME format.
--------------010507040003080006030902
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


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
Am 2014-08-13 um 03:59 schrieb Jonathan Nieder:
> Bernhard Reiter wrote:
>> [...]
>
> Wow!  This sounds lovely.  Thanks for working on this.

Well thanks for the friendly welcome and the helpful comments!

I'm attaching a patch where I've applied the fixes you suggested, plus:

* I added the lf_to_crlf conversion to the curl codepath as
communication with another IMAP server I tried was broken without it.

* I added STARTTLS. (That's just the
curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_ALL);
line)

* I tested (and fixed) authentication, i.e. the auth_method stuff. As
the corresponding CURLOPT_LOGIN_OPTIONS flag has only been available
starting with curl 7.35.0, I've bumped the required version to that.
(Apparently it was possible to achieve the same effect with a different
option in between versions 7.31.0 and 7.34.0 [1], but I haven't found
yet how. Is it worth the effort?)

* I made that file scope imap_folder a member of struct imap_server_conf
(named folder), which makes some things easier.

>> @@ -1417,31 +269,89 @@ int main(int argc, char **argv)
>>  		return 1;
>>  	}
>>
>> +	curl_global_init(CURL_GLOBAL_ALL);
>
> http.c seems to make the same mistake,

Patch at http://permalink.gmane.org/gmane.comp.version-control.git/255221

> [...]
>> +	if (server.tunnel) {
>> +		const char *argv[] = { server.tunnel, NULL };
>> +		struct child_process tunnel = {NULL};
>
> (not about this patch) Could use the child_proccess's internal
> argv_array:
>
> 		struct child_process tunnel = {NULL};
> 		argv_array_push(&tunnel.args, server.tunnel);

Patch at
http://permalink.gmane.org/gmane.comp.version-control.git/255220 (The
patch attached to this mail depends on that one.)

No comments on those patches yet, though.

> (about this patch) Would there be a way to make this part reuse the
> existing code?  The only difference I see is that *srvc has been
> renamed to server, which doesn't seem to be related to the change of
> transport API from OpenSSL to libcurl.
>
> [...]
>> +		curl_socket_t sockfd = tunnel.out; // what about tunnel.in ?
>
> Hmm.  curl expects to get a socket it can send(), recv(), setsockopt(),
> etc on instead of a pair of fds to read() and write().
>
> I wonder why someone would want to use SSL through a tunnel, though.
> Currently it's impossible to get to the SSL codepath when a tunnel
> is active (it's in the 'else' block an 'if (srvc->tunnel)').  If that
> property is preserved, then we should be safe.

Now this turns out to be the one major annoyance left, because we only
have those two fds (actually pipes, right?), and not a socket that we
could pass to curl, so we can't use it to talk to the IMAP server. So if
the tunnel parameter is set, we're stuck with the old hand-written IMAP
handling routines, even with USE_CURL_FOR_IMAP set, meaning I can't wrap
as much in #ifdef...#endif blocks as I'd like. :-( BTW, due to two of
the blocks that I do add I get a compiler warning about the curl handle
remaining possibly unitialized :-/
I've removed the curl specific socket handling routines, as we can't use
them anyway for now.

I've asked about passing two pipes instead of a socket to curl on their
ML [1] as this has even been discussed before [2], but unfortunately,
there doesn't seem to be a solution as of yet. I've also asked on SO
[3], but no answers yet.

> To summarize:
> [...]
>
>  * As soon as you're ready to roll this out to a wider audience of
>    testers, let me know, and we can try to get it into shape for
>    Junio's "next" branch (and hence Debian experimental).

Is this one good enough already?

Bernhard

[1] http://sourceforge.net/p/curl/bugs/1372/
[2] http://curl.haxx.se/mail/lib-2014-08/0102.html
[3] http://curl.haxx.se/mail/lib-2011-05/0102.html
[4]
http://stackoverflow.com/questions/25306264/connect-in-and-out-pipes-to-network-socket

 Documentation/git-imap-send.txt |   3 +-
 INSTALL                         |  15 +++---
 Makefile                        |  16 +++++-
 git.spec.in                     |   5 +-
 imap-send.c                     | 109
+++++++++++++++++++++++++++++++++++++---
 5 files changed, 132 insertions(+), 16 deletions(-)



--------------010507040003080006030902
Content-Type: text/x-patch;
 name="0003-git-imap-send-use-libcurl-for-implementation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-git-imap-send-use-libcurl-for-implementation.patch"

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..abce2a6 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -76,7 +76,8 @@ imap.preformattedHTML::
 
 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only.
+	If you compiled git with the NO_CURL option or if your curl version is
+	< 7.35.0, the only supported method is 'CRAM-MD5'.
 
 Examples
 ~~~~~~~~
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
index 2320de5..a5e89ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1120,6 +1120,9 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS += -DHAVE_ALLOCA_H
 endif
 
+IMAP_SEND_BUILDDEPS =
+IMAP_SEND_LDFLAGS = $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
+
 ifdef NO_CURL
 	BASIC_CFLAGS += -DNO_CURL
 	REMOTE_CURL_PRIMARY =
@@ -1154,6 +1157,15 @@ else
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
+		IMAP_SEND_LDFLAGS = $(CURL_LIBCURL)
+	endif
 	ifndef NO_EXPAT
 		ifdef EXPATDIR
 			BASIC_CFLAGS += -I$(EXPATDIR)/include
@@ -2067,9 +2079,9 @@ endif
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
index fb01a9c..a45570d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -22,6 +22,10 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef USE_CURL_FOR_IMAP_SEND
+#define NO_OPENSSL
+#endif
+
 #include "cache.h"
 #include "credential.h"
 #include "exec_cmd.h"
@@ -29,6 +33,9 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
+#ifdef USE_CURL_FOR_IMAP_SEND
+#include "http.h"
+#endif
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
 
@@ -44,9 +51,7 @@ __attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
 __attribute__((format (printf, 1, 2)))
 static void imap_warn(const char *, ...);
-
 static char *next_arg(char **);
-
 __attribute__((format (printf, 3, 4)))
 static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
 
@@ -69,6 +74,7 @@ struct imap_server_conf {
 	char *tunnel;
 	char *host;
 	int port;
+	char *folder;
 	char *user;
 	char *pass;
 	int use_ssl;
@@ -82,6 +88,7 @@ static struct imap_server_conf server = {
 	NULL,	/* tunnel */
 	NULL,	/* host */
 	0,	/* port */
+	NULL,	/* folder */
 	NULL,	/* user */
 	NULL,	/* pass */
 	0,   	/* use_ssl */
@@ -1323,7 +1330,54 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
 	return 1;
 }
 
-static char *imap_folder;
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
 
 static int git_imap_config(const char *key, const char *val, void *cb)
 {
@@ -1339,7 +1393,7 @@ static int git_imap_config(const char *key, const char *val, void *cb)
 		return config_error_nonbool(key);
 
 	if (!strcmp("folder", key)) {
-		imap_folder = xstrdup(val);
+		server.folder = xstrdup(val);
 	} else if (!strcmp("host", key)) {
 		if (starts_with(val, "imap:"))
 			val += 5;
@@ -1373,6 +1427,11 @@ int main(int argc, char **argv)
 	int r;
 	int total, n = 0;
 	int nongit_ok;
+#ifdef USE_CURL_FOR_IMAP_SEND
+	struct buffer msgbuf = { STRBUF_INIT, 0 };
+	CURL *curl;
+	CURLcode res = CURLE_OK;
+#endif /* #ifndef USE_CURL_FOR_IMAP_SEND */
 
 	git_extract_argv0_path(argv[0]);
 
@@ -1387,7 +1446,7 @@ int main(int argc, char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-	if (!imap_folder) {
+	if (!server.folder) {
 		fprintf(stderr, "no imap store specified\n");
 		return 1;
 	}
@@ -1417,18 +1476,48 @@ int main(int argc, char **argv)
 	}
 
 	/* write it to the imap server */
+
+#ifdef USE_CURL_FOR_IMAP_SEND
+	if (!server.tunnel) {
+		curl = setup_curl(&server);
+		curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
+	} else {
+#endif
 	ctx = imap_open_store(&server);
 	if (!ctx) {
 		fprintf(stderr, "failed to open store\n");
 		return 1;
 	}
+	ctx->name = server.folder;
+#ifdef USE_CURL_FOR_IMAP_SEND
+	}
+#endif
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
-	ctx->name = imap_folder;
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
@@ -1436,11 +1525,19 @@ int main(int argc, char **argv)
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


--------------010507040003080006030902--
