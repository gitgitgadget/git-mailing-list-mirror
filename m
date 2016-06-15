From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 1/2] daemon: use strbuf for hostname info
Date: Sat, 07 Mar 2015 11:50:29 +0100
Message-ID: <54FAD7F5.4030507@web.de>
References: <54F96BF2.5000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUCKD-0003kp-F6
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 11:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbbCGKvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 05:51:11 -0500
Received: from mout.web.de ([212.227.17.12]:58133 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbCGKvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 05:51:06 -0500
Received: from [192.168.178.27] ([79.250.190.19]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M5wzV-1XWqXJ2JZZ-00xpg2; Sat, 07 Mar 2015 11:50:48
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <54F96BF2.5000504@web.de>
X-Provags-ID: V03:K0:L20fL+v58iWDmo36evsnNlMcanuVlnkDQ+gyRVqbLVveiIDWyrP
 vDAohjV6LwjJcoRW62KLY7meUTMUkmGbL4PcwFr5gHPd7muiZbi4zUTiLT2QNENRVTsH1L6
 j7CqYsJOfEXiDTw/OdRkxjPZrKjyqoLRwNMP/+Eyxz8ObkjRgMQdrkYZPc9EfffhSR0fn6X
 LPxF2XpQM94XzNEucZpeQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264998>

Convert hostname, canon_hostname, ip_address and tcp_port to strbuf.
This allows to get rid of the helpers strbuf_addstr_or_null() and STRARG
because a strbuf always represents a valid (initially empty) string.

sanitize_client() is not needed anymore and sanitize_client_strbuf()
takes its place and name.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This one is the first patch + s/_strbuf// + s/_reset/_release/.

 daemon.c | 98 +++++++++++++++++++++++++++-------------------------------------
 1 file changed, 41 insertions(+), 57 deletions(-)

diff --git a/daemon.c b/daemon.c
index c3edd96..265c188 100644
--- a/daemon.c
+++ b/daemon.c
@@ -56,10 +56,10 @@ static const char *user_path;
 static unsigned int timeout;
 static unsigned int init_timeout;
 
-static char *hostname;
-static char *canon_hostname;
-static char *ip_address;
-static char *tcp_port;
+static struct strbuf hostname = STRBUF_INIT;
+static struct strbuf canon_hostname = STRBUF_INIT;
+static struct strbuf ip_address = STRBUF_INIT;
+static struct strbuf tcp_port = STRBUF_INIT;
 
 static int hostname_lookup_done;
 
@@ -68,13 +68,13 @@ static void lookup_hostname(void);
 static const char *get_canon_hostname(void)
 {
 	lookup_hostname();
-	return canon_hostname;
+	return canon_hostname.buf;
 }
 
 static const char *get_ip_address(void)
 {
 	lookup_hostname();
-	return ip_address;
+	return ip_address.buf;
 }
 
 static void logreport(int priority, const char *err, va_list params)
@@ -122,12 +122,6 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
-static void strbuf_addstr_or_null(struct strbuf *sb, const char *s)
-{
-	if (s)
-		strbuf_addstr(sb, s);
-}
-
 struct expand_path_context {
 	const char *directory;
 };
@@ -138,22 +132,22 @@ static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
 
 	switch (placeholder[0]) {
 	case 'H':
-		strbuf_addstr_or_null(sb, hostname);
+		strbuf_addbuf(sb, &hostname);
 		return 1;
 	case 'C':
 		if (placeholder[1] == 'H') {
-			strbuf_addstr_or_null(sb, get_canon_hostname());
+			strbuf_addstr(sb, get_canon_hostname());
 			return 2;
 		}
 		break;
 	case 'I':
 		if (placeholder[1] == 'P') {
-			strbuf_addstr_or_null(sb, get_ip_address());
+			strbuf_addstr(sb, get_ip_address());
 			return 2;
 		}
 		break;
 	case 'P':
-		strbuf_addstr_or_null(sb, tcp_port);
+		strbuf_addbuf(sb, &tcp_port);
 		return 1;
 	case 'D':
 		strbuf_addstr(sb, context->directory);
@@ -301,16 +295,14 @@ static int run_access_hook(struct daemon_service *service, const char *dir, cons
 	char *eol;
 	int seen_errors = 0;
 
-#define STRARG(x) ((x) ? (x) : "")
 	*arg++ = access_hook;
 	*arg++ = service->name;
 	*arg++ = path;
-	*arg++ = STRARG(hostname);
-	*arg++ = STRARG(get_canon_hostname());
-	*arg++ = STRARG(get_ip_address());
-	*arg++ = STRARG(tcp_port);
+	*arg++ = hostname.buf;
+	*arg++ = get_canon_hostname();
+	*arg++ = get_ip_address();
+	*arg++ = tcp_port.buf;
 	*arg = NULL;
-#undef STRARG
 
 	child.use_shell = 1;
 	child.argv = argv;
@@ -542,7 +534,7 @@ static void parse_host_and_port(char *hostport, char **host,
  * trailing and leading dots, which means that the client cannot escape
  * our base path via ".." traversal.
  */
-static void sanitize_client_strbuf(struct strbuf *out, const char *in)
+static void sanitize_client(struct strbuf *out, const char *in)
 {
 	for (; *in; in++) {
 		if (*in == '/')
@@ -556,23 +548,14 @@ static void sanitize_client_strbuf(struct strbuf *out, const char *in)
 		strbuf_setlen(out, out->len - 1);
 }
 
-static char *sanitize_client(const char *in)
-{
-	struct strbuf out = STRBUF_INIT;
-	sanitize_client_strbuf(&out, in);
-	return strbuf_detach(&out, NULL);
-}
-
 /*
  * Like sanitize_client, but we also perform any canonicalization
  * to make life easier on the admin.
  */
-static char *canonicalize_client(const char *in)
+static void canonicalize_client(struct strbuf *out, const char *in)
 {
-	struct strbuf out = STRBUF_INIT;
-	sanitize_client_strbuf(&out, in);
-	strbuf_tolower(&out);
-	return strbuf_detach(&out, NULL);
+	sanitize_client(out, in);
+	strbuf_tolower(out);
 }
 
 /*
@@ -595,11 +578,11 @@ static void parse_host_arg(char *extra_args, int buflen)
 				char *port;
 				parse_host_and_port(val, &host, &port);
 				if (port) {
-					free(tcp_port);
-					tcp_port = sanitize_client(port);
+					strbuf_reset(&tcp_port);
+					sanitize_client(&tcp_port, port);
 				}
-				free(hostname);
-				hostname = canonicalize_client(host);
+				strbuf_reset(&hostname);
+				canonicalize_client(&hostname, host);
 				hostname_lookup_done = 0;
 			}
 
@@ -616,7 +599,7 @@ static void parse_host_arg(char *extra_args, int buflen)
  */
 static void lookup_hostname(void)
 {
-	if (!hostname_lookup_done && hostname) {
+	if (!hostname_lookup_done && hostname.len) {
 #ifndef NO_IPV6
 		struct addrinfo hints;
 		struct addrinfo *ai;
@@ -626,19 +609,21 @@ static void lookup_hostname(void)
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		gai = getaddrinfo(hostname, NULL, &hints, &ai);
+		gai = getaddrinfo(hostname.buf, NULL, &hints, &ai);
 		if (!gai) {
 			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
 
 			inet_ntop(AF_INET, &sin_addr->sin_addr,
 				  addrbuf, sizeof(addrbuf));
-			free(ip_address);
-			ip_address = xstrdup(addrbuf);
+			strbuf_reset(&ip_address);
+			strbuf_addstr(&ip_address, addrbuf);
 
-			free(canon_hostname);
-			canon_hostname = ai->ai_canonname ?
-				sanitize_client(ai->ai_canonname) :
-				xstrdup(ip_address);
+			strbuf_reset(&canon_hostname);
+			if (ai->ai_canonname)
+				sanitize_client(&canon_hostname,
+						ai->ai_canonname);
+			else
+				strbuf_addbuf(&canon_hostname, &ip_address);
 
 			freeaddrinfo(ai);
 		}
@@ -648,7 +633,7 @@ static void lookup_hostname(void)
 		char **ap;
 		static char addrbuf[HOST_NAME_MAX + 1];
 
-		hent = gethostbyname(hostname);
+		hent = gethostbyname(hostname.buf);
 		if (hent) {
 			ap = hent->h_addr_list;
 			memset(&sa, 0, sizeof sa);
@@ -659,10 +644,10 @@ static void lookup_hostname(void)
 			inet_ntop(hent->h_addrtype, &sa.sin_addr,
 				  addrbuf, sizeof(addrbuf));
 
-			free(canon_hostname);
-			canon_hostname = sanitize_client(hent->h_name);
-			free(ip_address);
-			ip_address = xstrdup(addrbuf);
+			strbuf_reset(&canon_hostname);
+			sanitize_client(&canon_hostname, hent->h_name);
+			strbuf_reset(&ip_address);
+			strbuf_addstr(&ip_address, addrbuf);
 		}
 #endif
 		hostname_lookup_done = 1;
@@ -693,11 +678,10 @@ static int execute(void)
 		pktlen--;
 	}
 
-	free(hostname);
-	free(canon_hostname);
-	free(ip_address);
-	free(tcp_port);
-	hostname = canon_hostname = ip_address = tcp_port = NULL;
+	strbuf_release(&hostname);
+	strbuf_release(&canon_hostname);
+	strbuf_release(&ip_address);
+	strbuf_release(&tcp_port);
 
 	if (len != pktlen)
 		parse_host_arg(line + len + 1, pktlen - len - 1);
-- 
2.3.1
