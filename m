Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDAC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 03:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjDRDjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjDRDjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 23:39:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A9B5274
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 20:39:05 -0700 (PDT)
Received: (qmail 32067 invoked by uid 109); 18 Apr 2023 03:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 03:39:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30185 invoked by uid 111); 18 Apr 2023 03:39:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Apr 2023 23:39:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Apr 2023 23:39:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Michael J Gruber <git@grubix.eu>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
Message-ID: <20230418033904.GA60552@coredump.intra.peff.net>
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com>
 <20230417073827.GA39931@coredump.intra.peff.net>
 <xmqq1qkio4cq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qkio4cq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 09:33:57AM -0700, Junio C Hamano wrote:

> > diff --git a/connect.c b/connect.c
> > index fd3179e545..1eba71e34c 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -753,7 +753,7 @@ static char *host_end(char **hoststart, int removebrackets)
> >  }
> >  
> >  #define STR_(s)	# s
> > -#define STR(s)	STR_(s)
> > +#define STR(s) (STR_(s) + BUILD_ASSERT_OR_ZERO(s))
> 
> OOoooh.  Clever.  A pointer plus N indexes into an array, but if the
> offset is N then the pointer is left intact so the caller does not
> see the difference.
> 
> > ... But the
> > BUILD_ASSERT doesn't seem too bad to me.
> 
> Indeed.

So I started to write this up as a patch, but there's another subtle
thing going on.

The BUILD_ASSERT is actually checking two things: that the result
compiles (which is what we care about here), and that the expression it
evaluates is nonzero (which we don't).

So this would fail for example with:

  #define ZERO 0
  const char *x = STR(ZERO);

That is OK for our purposes here (a zero port does not make any sense).
But it feels a bit weird for a macro as generically named as STR(). At
least it's local to the one file. But maybe it should be PORT_TO_STR()
or something.

All of that makes me wonder if we wouldn't be just as happy with it as a
string in the first place. In three out of four locations that use it,
they want the string anyway (to feed to getaddrinfo). And in the final
one (git-daemon), we need to convert from the user's "--port" anyway, so
there's always some string-to-int parsing. And depending on the #ifdefs,
in most cases we turn it back into a string anyway to feed to...you
guessed it, getaddrinfo!

The exception is when NO_IPV6 is defined, in which we do want the
numeric value. But we could delay parsing until that point (and
otherwise let getaddrinfo handle, which seems more correct anyway).

Something like this (though I'd probably split it into a few patches to
reason about the motivation and implications of each):

diff --git a/cache.h b/cache.h
index 2f21704da9..2ece09a2b8 100644
--- a/cache.h
+++ b/cache.h
@@ -58,7 +58,7 @@
  *
  * See http://www.iana.org/assignments/port-numbers
  */
-#define DEFAULT_GIT_PORT 9418
+#define DEFAULT_GIT_PORT "9418"
 
 /*
  * Basic data structures for the directory cache
diff --git a/connect.c b/connect.c
index fd3179e545..189367604c 100644
--- a/connect.c
+++ b/connect.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "cache.h" /* or protocol.h after Elijah's patch */
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
@@ -752,9 +753,6 @@ static char *host_end(char **hoststart, int removebrackets)
 	return end;
 }
 
-#define STR_(s)	# s
-#define STR(s)	STR_(s)
-
 static void get_host_and_port(char **host, const char **port)
 {
 	char *colon, *end;
@@ -798,7 +796,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 {
 	struct strbuf error_message = STRBUF_INIT;
 	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
+	const char *port = DEFAULT_GIT_PORT;
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 	int cnt = 0;
@@ -868,7 +866,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 {
 	struct strbuf error_message = STRBUF_INIT;
 	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
+	const char *port = DEFAULT_GIT_PORT;
 	char *ep;
 	struct hostent *he;
 	struct sockaddr_in sa;
@@ -1020,7 +1018,7 @@ static int git_use_proxy(const char *host)
 
 static struct child_process *git_proxy_connect(int fd[2], char *host)
 {
-	const char *port = STR(DEFAULT_GIT_PORT);
+	const char *port = DEFAULT_GIT_PORT;
 	struct child_process *proxy;
 
 	get_host_and_port(&host, &port);
diff --git a/daemon.c b/daemon.c
index db8a31a6ea..ce692bad35 100644
--- a/daemon.c
+++ b/daemon.c
@@ -984,22 +984,20 @@ static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
 
 #ifndef NO_IPV6
 
-static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
+static int setup_named_sock(char *listen_addr, const char *listen_port, struct socketlist *socklist)
 {
 	int socknum = 0;
-	char pbuf[NI_MAXSERV];
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 	long flags;
 
-	xsnprintf(pbuf, sizeof(pbuf), "%d", listen_port);
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_UNSPEC;
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
 	hints.ai_flags = AI_PASSIVE;
 
-	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
+	gai = getaddrinfo(listen_addr, listen_port, &hints, &ai0);
 	if (gai) {
 		logerror("getaddrinfo() for %s failed: %s", listen_addr, gai_strerror(gai));
 		return 0;
@@ -1065,15 +1063,27 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 #else /* NO_IPV6 */
 
-static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
+static int parse_port(const char *s)
+{
+	unsigned long ret;
+	char *end;
+
+	ret = strtoul(s, &end, 0);
+	if (!ret || ret > 65535 || *end)
+		die(_("invalid listen port: %s"), s);
+
+	return ret;
+}
+
+static int setup_named_sock(char *listen_addr, const char *listen_port, struct socketlist *socklist)
 {
 	struct sockaddr_in sin;
 	int sockfd;
 	long flags;
 
 	memset(&sin, 0, sizeof sin);
 	sin.sin_family = AF_INET;
-	sin.sin_port = htons(listen_port);
+	sin.sin_port = parse_port(listen_port);
 
 	if (listen_addr) {
 		/* Well, host better be an IP address here. */
@@ -1122,7 +1132,7 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 
 #endif
 
-static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
+static void socksetup(struct string_list *listen_addr, const char *listen_port, struct socketlist *socklist)
 {
 	if (!listen_addr->nr)
 		setup_named_sock(NULL, listen_port, socklist);
@@ -1133,7 +1143,7 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 						   listen_port, socklist);
 
 			if (socknum == 0)
-				logerror("unable to allocate any listen sockets for host %s on port %u",
+				logerror("unable to allocate any listen sockets for host %s on port %s",
 					 listen_addr->items[i].string, listen_port);
 		}
 	}
@@ -1246,14 +1256,14 @@ static struct credentials *prepare_credentials(const char *user_name,
 }
 #endif
 
-static int serve(struct string_list *listen_addr, int listen_port,
+static int serve(struct string_list *listen_addr, const char *listen_port,
     struct credentials *cred)
 {
 	struct socketlist socklist = { NULL, 0, 0 };
 
 	socksetup(listen_addr, listen_port, &socklist);
 	if (socklist.nr == 0)
-		die("unable to allocate any listen sockets on port %u",
+		die("unable to allocate any listen sockets on port %s",
 		    listen_port);
 
 	drop_privileges(cred);
@@ -1265,7 +1275,7 @@ static int serve(struct string_list *listen_addr, int listen_port,
 
 int cmd_main(int argc, const char **argv)
 {
-	int listen_port = 0;
+	const char *listen_port = NULL;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
 	int serve_mode = 0, inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
@@ -1282,13 +1292,8 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--port=", &v)) {
-			char *end;
-			unsigned long n;
-			n = strtoul(v, &end, 0);
-			if (*v && !*end) {
-				listen_port = n;
-				continue;
-			}
+			listen_port = v;
+			continue;
 		}
 		if (!strcmp(arg, "--serve")) {
 			serve_mode = 1;
@@ -1439,7 +1444,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
 		die("--listen= and --port= are incompatible with --inetd");
-	else if (listen_port == 0)
+	else if (!listen_port)
 		listen_port = DEFAULT_GIT_PORT;
 
 	if (group_name && !user_name)
