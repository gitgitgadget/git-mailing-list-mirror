From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 2/2] daemon: deglobalize hostname information
Date: Sat, 07 Mar 2015 11:50:37 +0100
Message-ID: <54FAD7FD.1020102@web.de>
References: <54F96BF2.5000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:51:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUCK8-0003gH-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 11:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbbCGKvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 05:51:07 -0500
Received: from mout.web.de ([212.227.17.12]:49490 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbbCGKvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 05:51:05 -0500
Received: from [192.168.178.27] ([79.250.190.19]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M6E6g-1XW1SP4ABe-00yAhB; Sat, 07 Mar 2015 11:50:56
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <54F96BF2.5000504@web.de>
X-Provags-ID: V03:K0:XeLWwhGhlE3+k0vK+aS53pA6ZHQJu2NGmJ5BUce7mCGa08DGT4A
 bUwByVo8T+cKMAvY9gNwn2BngkY6v/gQNLd5Rc5Xt1lPJeprTcDwdSsRMrD37RwybH8Jh8z
 7djYgxKWhMj94jIOUCSktx5SlvpDAY1zEGXz+K5WHL48QsGIDbrXTrvqa/Yi4/BJX4ITj6K
 jsiMnFFPWxPyTth3615nQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264997>

Move the variables related to the client-supplied hostname into its own
struct, let execute() own an instance of that instead of storing the
information in global variables and pass the struct to any function that
needs to access it as a parameter.

The lifetime of the variables is easier to see this way.  Allocated
memory is released within execute().  The strbufs don't have to be reset
anymore because they are written to only once at most: parse_host_arg()
is only called once by execute() and lookup_hostname() guards against
being called twice using hostname_lookup_done.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 133 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 74 insertions(+), 59 deletions(-)

diff --git a/daemon.c b/daemon.c
index 265c188..9ee2187 100644
--- a/daemon.c
+++ b/daemon.c
@@ -43,9 +43,6 @@ static const char *base_path;
 static const char *interpolated_path;
 static int base_path_relaxed;
 
-/* Flag indicating client sent extra args. */
-static int saw_extended_args;
-
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
  * go to /home/alice/pub_git/frotz with --user-path=pub_git.
@@ -56,25 +53,27 @@ static const char *user_path;
 static unsigned int timeout;
 static unsigned int init_timeout;
 
-static struct strbuf hostname = STRBUF_INIT;
-static struct strbuf canon_hostname = STRBUF_INIT;
-static struct strbuf ip_address = STRBUF_INIT;
-static struct strbuf tcp_port = STRBUF_INIT;
-
-static int hostname_lookup_done;
+struct hostinfo {
+	struct strbuf hostname;
+	struct strbuf canon_hostname;
+	struct strbuf ip_address;
+	struct strbuf tcp_port;
+	unsigned int hostname_lookup_done:1;
+	unsigned int saw_extended_args:1;
+};
 
-static void lookup_hostname(void);
+static void lookup_hostname(struct hostinfo *hi);
 
-static const char *get_canon_hostname(void)
+static const char *get_canon_hostname(struct hostinfo *hi)
 {
-	lookup_hostname();
-	return canon_hostname.buf;
+	lookup_hostname(hi);
+	return hi->canon_hostname.buf;
 }
 
-static const char *get_ip_address(void)
+static const char *get_ip_address(struct hostinfo *hi)
 {
-	lookup_hostname();
-	return ip_address.buf;
+	lookup_hostname(hi);
+	return hi->ip_address.buf;
 }
 
 static void logreport(int priority, const char *err, va_list params)
@@ -124,30 +123,32 @@ static void NORETURN daemon_die(const char *err, va_list params)
 
 struct expand_path_context {
 	const char *directory;
+	struct hostinfo *hostinfo;
 };
 
 static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
 {
 	struct expand_path_context *context = ctx;
+	struct hostinfo *hi = context->hostinfo;
 
 	switch (placeholder[0]) {
 	case 'H':
-		strbuf_addbuf(sb, &hostname);
+		strbuf_addbuf(sb, &hi->hostname);
 		return 1;
 	case 'C':
 		if (placeholder[1] == 'H') {
-			strbuf_addstr(sb, get_canon_hostname());
+			strbuf_addstr(sb, get_canon_hostname(hi));
 			return 2;
 		}
 		break;
 	case 'I':
 		if (placeholder[1] == 'P') {
-			strbuf_addstr(sb, get_ip_address());
+			strbuf_addstr(sb, get_ip_address(hi));
 			return 2;
 		}
 		break;
 	case 'P':
-		strbuf_addbuf(sb, &tcp_port);
+		strbuf_addbuf(sb, &hi->tcp_port);
 		return 1;
 	case 'D':
 		strbuf_addstr(sb, context->directory);
@@ -156,7 +157,7 @@ static size_t expand_path(struct strbuf *sb, const char *placeholder, void *ctx)
 	return 0;
 }
 
-static const char *path_ok(const char *directory)
+static const char *path_ok(const char *directory, struct hostinfo *hi)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
@@ -192,11 +193,12 @@ static const char *path_ok(const char *directory)
 			dir = rpath;
 		}
 	}
-	else if (interpolated_path && saw_extended_args) {
+	else if (interpolated_path && hi->saw_extended_args) {
 		struct strbuf expanded_path = STRBUF_INIT;
 		struct expand_path_context context;
 
 		context.directory = directory;
+		context.hostinfo = hi;
 
 		if (*dir != '/') {
 			/* Allow only absolute */
@@ -286,7 +288,8 @@ static int daemon_error(const char *dir, const char *msg)
 
 static const char *access_hook;
 
-static int run_access_hook(struct daemon_service *service, const char *dir, const char *path)
+static int run_access_hook(struct daemon_service *service, const char *dir,
+			   const char *path, struct hostinfo *hi)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
@@ -298,10 +301,10 @@ static int run_access_hook(struct daemon_service *service, const char *dir, cons
 	*arg++ = access_hook;
 	*arg++ = service->name;
 	*arg++ = path;
-	*arg++ = hostname.buf;
-	*arg++ = get_canon_hostname();
-	*arg++ = get_ip_address();
-	*arg++ = tcp_port.buf;
+	*arg++ = hi->hostname.buf;
+	*arg++ = get_canon_hostname(hi);
+	*arg++ = get_ip_address(hi);
+	*arg++ = hi->tcp_port.buf;
 	*arg = NULL;
 
 	child.use_shell = 1;
@@ -346,7 +349,8 @@ error_return:
 	return -1;
 }
 
-static int run_service(const char *dir, struct daemon_service *service)
+static int run_service(const char *dir, struct daemon_service *service,
+		       struct hostinfo *hi)
 {
 	const char *path;
 	int enabled = service->enabled;
@@ -360,7 +364,7 @@ static int run_service(const char *dir, struct daemon_service *service)
 		return daemon_error(dir, "service not enabled");
 	}
 
-	if (!(path = path_ok(dir)))
+	if (!(path = path_ok(dir, hi)))
 		return daemon_error(dir, "no such repository");
 
 	/*
@@ -396,7 +400,7 @@ static int run_service(const char *dir, struct daemon_service *service)
 	 * Optionally, a hook can choose to deny access to the
 	 * repository depending on the phase of the moon.
 	 */
-	if (access_hook && run_access_hook(service, dir, path))
+	if (access_hook && run_access_hook(service, dir, path, hi))
 		return -1;
 
 	/*
@@ -561,14 +565,14 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 /*
  * Read the host as supplied by the client connection.
  */
-static void parse_host_arg(char *extra_args, int buflen)
+static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
 	char *end = extra_args + buflen;
 
 	if (extra_args < end && *extra_args) {
-		saw_extended_args = 1;
+		hi->saw_extended_args = 1;
 		if (strncasecmp("host=", extra_args, 5) == 0) {
 			val = extra_args + 5;
 			vallen = strlen(val) + 1;
@@ -577,13 +581,10 @@ static void parse_host_arg(char *extra_args, int buflen)
 				char *host;
 				char *port;
 				parse_host_and_port(val, &host, &port);
-				if (port) {
-					strbuf_reset(&tcp_port);
-					sanitize_client(&tcp_port, port);
-				}
-				strbuf_reset(&hostname);
-				canonicalize_client(&hostname, host);
-				hostname_lookup_done = 0;
+				if (port)
+					sanitize_client(&hi->tcp_port, port);
+				canonicalize_client(&hi->hostname, host);
+				hi->hostname_lookup_done = 0;
 			}
 
 			/* On to the next one */
@@ -597,9 +598,9 @@ static void parse_host_arg(char *extra_args, int buflen)
 /*
  * Locate canonical hostname and its IP address.
  */
-static void lookup_hostname(void)
+static void lookup_hostname(struct hostinfo *hi)
 {
-	if (!hostname_lookup_done && hostname.len) {
+	if (!hi->hostname_lookup_done && hi->hostname.len) {
 #ifndef NO_IPV6
 		struct addrinfo hints;
 		struct addrinfo *ai;
@@ -609,21 +610,20 @@ static void lookup_hostname(void)
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		gai = getaddrinfo(hostname.buf, NULL, &hints, &ai);
+		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
 		if (!gai) {
 			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
 
 			inet_ntop(AF_INET, &sin_addr->sin_addr,
 				  addrbuf, sizeof(addrbuf));
-			strbuf_reset(&ip_address);
-			strbuf_addstr(&ip_address, addrbuf);
+			strbuf_addstr(&hi->ip_address, addrbuf);
 
-			strbuf_reset(&canon_hostname);
 			if (ai->ai_canonname)
-				sanitize_client(&canon_hostname,
+				sanitize_client(&hi->canon_hostname,
 						ai->ai_canonname);
 			else
-				strbuf_addbuf(&canon_hostname, &ip_address);
+				strbuf_addbuf(&hi->canon_hostname,
+					      &hi->ip_address);
 
 			freeaddrinfo(ai);
 		}
@@ -644,22 +644,39 @@ static void lookup_hostname(void)
 			inet_ntop(hent->h_addrtype, &sa.sin_addr,
 				  addrbuf, sizeof(addrbuf));
 
-			strbuf_reset(&canon_hostname);
-			sanitize_client(&canon_hostname, hent->h_name);
-			strbuf_reset(&ip_address);
-			strbuf_addstr(&ip_address, addrbuf);
+			sanitize_client(&hi->canon_hostname, hent->h_name);
+			strbuf_addstr(&hi->ip_address, addrbuf);
 		}
 #endif
-		hostname_lookup_done = 1;
+		hi->hostname_lookup_done = 1;
 	}
 }
 
+static void hostinfo_init(struct hostinfo *hi)
+{
+	memset(hi, 0, sizeof(*hi));
+	strbuf_init(&hi->hostname, 0);
+	strbuf_init(&hi->canon_hostname, 0);
+	strbuf_init(&hi->ip_address, 0);
+	strbuf_init(&hi->tcp_port, 0);
+}
+
+static void hostinfo_clear(struct hostinfo *hi)
+{
+	strbuf_release(&hi->hostname);
+	strbuf_release(&hi->canon_hostname);
+	strbuf_release(&hi->ip_address);
+	strbuf_release(&hi->tcp_port);
+}
 
 static int execute(void)
 {
 	char *line = packet_buffer;
 	int pktlen, len, i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
+	struct hostinfo hi;
+
+	hostinfo_init(&hi);
 
 	if (addr)
 		loginfo("Connection from %s:%s", addr, port);
@@ -678,13 +695,8 @@ static int execute(void)
 		pktlen--;
 	}
 
-	strbuf_release(&hostname);
-	strbuf_release(&canon_hostname);
-	strbuf_release(&ip_address);
-	strbuf_release(&tcp_port);
-
 	if (len != pktlen)
-		parse_host_arg(line + len + 1, pktlen - len - 1);
+		parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
@@ -697,10 +709,13 @@ static int execute(void)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(arg, s);
+			int rc = run_service(arg, s, &hi);
+			hostinfo_clear(&hi);
+			return rc;
 		}
 	}
 
+	hostinfo_clear(&hi);
 	logerror("Protocol error: '%s'", line);
 	return -1;
 }
-- 
2.3.1
