From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 12:51:56 +0300
Message-ID: <20070510095156.GC13655@mellanox.co.il>
References: <20070506195230.GA30339@mellanox.co.il>
	<7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 11:52:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm5Jb-0007zR-Ii
	for gcvg-git@gmane.org; Thu, 10 May 2007 11:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbXEJJv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 05:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754720AbXEJJv5
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 05:51:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:13852 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511AbXEJJv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 05:51:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so480798wxd
        for <git@vger.kernel.org>; Thu, 10 May 2007 02:51:55 -0700 (PDT)
Received: by 10.82.126.5 with SMTP id y5mr2664501buc.1178790713894;
        Thu, 10 May 2007 02:51:53 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id c24sm7786196ika.2007.05.10.02.51.52;
        Thu, 10 May 2007 02:51:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46852>

Make git notify the user about host resolution/connection attempts.  This
is useful both as a progress indicator on slow links, and helps reassure the
user there are no DNS/firewall problems.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

> > I find the following useful.
> > This currently only covers native git protocol. I expect it would
> > be easy to extend this to other protocols, if there's interest.
> > Opinions?
> 
> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] connect: display connection progress
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> I think giving this kind of feedback makes a lot of sense, from
> both the "assurance" point of view and also debuggability.
> 
> But please do this only under verbose, or squelch it if "quiet"
> is asked.

Here's an updated patch. Please comment.

diff --git a/builtin-archive.c b/builtin-archive.c
index 7f4e409..5312e89 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -45,7 +45,7 @@ static int run_remote_archiver(const char *remote, int argc,
 	}
 
 	url = xstrdup(remote);
-	pid = git_connect(fd, url, exec);
+	pid = git_connect(fd, url, exec, NET_QUIET);
 	if (pid < 0)
 		return pid;
 
diff --git a/cache.h b/cache.h
index 8e76152..232faa7 100644
--- a/cache.h
+++ b/cache.h
@@ -462,7 +462,8 @@ struct ref {
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
-extern pid_t git_connect(int fd[2], char *url, const char *prog);
+#define NET_QUIET       (1u << 0)
+extern pid_t git_connect(int fd[2], char *url, const char *prog, int flags);
 extern int finish_connect(pid_t pid);
 extern int path_match(const char *path, int nr, char **match);
 extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
diff --git a/connect.c b/connect.c
index da89c9c..fd4718a 100644
--- a/connect.c
+++ b/connect.c
@@ -394,7 +394,7 @@ static enum protocol get_protocol(const char *name)
 /*
  * Returns a connected socket() fd, or else die()s.
  */
-static int git_tcp_connect_sock(char *host)
+static int git_tcp_connect_sock(char *host, int flags)
 {
 	int sockfd = -1, saved_errno = 0;
 	char *colon, *end;
@@ -425,10 +425,16 @@ static int git_tcp_connect_sock(char *host)
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
 
+	if (!(flags & NET_QUIET))
+		fprintf(stderr, "Looking up %s ... ", host);
+
 	gai = getaddrinfo(host, port, &hints, &ai);
 	if (gai)
 		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
 
+	if (!(flags & NET_QUIET))
+		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+
 	for (ai0 = ai; ai; ai = ai->ai_next) {
 		sockfd = socket(ai->ai_family,
 				ai->ai_socktype, ai->ai_protocol);
@@ -450,6 +456,9 @@ static int git_tcp_connect_sock(char *host)
 	if (sockfd < 0)
 		die("unable to connect a socket (%s)", strerror(saved_errno));
 
+	if (!(flags & NET_QUIET))
+		fprintf(stderr, "done.\n");
+
 	return sockfd;
 }
 
@@ -458,7 +467,7 @@ static int git_tcp_connect_sock(char *host)
 /*
  * Returns a connected socket() fd, or else die()s.
  */
-static int git_tcp_connect_sock(char *host)
+static int git_tcp_connect_sock(char *host, int flags)
 {
 	int sockfd = -1, saved_errno = 0;
 	char *colon, *end;
@@ -485,6 +494,9 @@ static int git_tcp_connect_sock(char *host)
 		port = colon + 1;
 	}
 
+	if (!(flags & NET_QUIET))
+		fprintf(stderr, "Looking up %s ... ", host);
+
 	he = gethostbyname(host);
 	if (!he)
 		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
@@ -497,6 +509,9 @@ static int git_tcp_connect_sock(char *host)
 		nport = se->s_port;
 	}
 
+	if (!(flags & NET_QUIET))
+		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+
 	for (ap = he->h_addr_list; *ap; ap++) {
 		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
 		if (sockfd < 0) {
@@ -521,15 +536,18 @@ static int git_tcp_connect_sock(char *host)
 	if (sockfd < 0)
 		die("unable to connect a socket (%s)", strerror(saved_errno));
 
+	if (!(flags & NET_QUIET))
+		fprintf(stderr, "done.\n");
+
 	return sockfd;
 }
 
 #endif /* NO_IPV6 */
 
 
-static void git_tcp_connect(int fd[2], char *host)
+static void git_tcp_connect(int fd[2], char *host, int flags)
 {
-	int sockfd = git_tcp_connect_sock(host);
+	int sockfd = git_tcp_connect_sock(host, flags);
 
 	fd[0] = sockfd;
 	fd[1] = dup(sockfd);
@@ -646,7 +664,7 @@ static void git_proxy_connect(int fd[2], char *host)
  *
  * Does not return a negative value on error; it just dies.
  */
-pid_t git_connect(int fd[2], char *url, const char *prog)
+pid_t git_connect(int fd[2], char *url, const char *prog, int flags)
 {
 	char *host, *path = url;
 	char *end;
@@ -719,7 +737,7 @@ pid_t git_connect(int fd[2], char *url, const char *prog)
 		if (git_use_proxy(host))
 			git_proxy_connect(fd, host);
 		else
-			git_tcp_connect(fd, host);
+			git_tcp_connect(fd, host, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended components with a NUL byte.
diff --git a/fetch-pack.c b/fetch-pack.c
index 06f4aec..050b01d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -733,7 +733,7 @@ int main(int argc, char **argv)
 	}
 	if (!dest)
 		usage(fetch_pack_usage);
-	pid = git_connect(fd, dest, uploadpack);
+	pid = git_connect(fd, dest, uploadpack, quiet ? NET_QUIET : 0);
 	if (pid < 0)
 		return 1;
 	if (heads && nr_heads)
diff --git a/peek-remote.c b/peek-remote.c
index 96bfac4..a5e0fc1 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -64,7 +64,7 @@ int main(int argc, char **argv)
 	if (!dest || i != argc - 1)
 		usage(peek_remote_usage);
 
-	pid = git_connect(fd, dest, uploadpack);
+	pid = git_connect(fd, dest, uploadpack, NET_QUIET);
 	if (pid < 0)
 		return 1;
 	ret = peek_remote(fd, flags);
diff --git a/send-pack.c b/send-pack.c
index d5b5162..5d99b25 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -393,7 +393,7 @@ int main(int argc, char **argv)
 		usage(send_pack_usage);
 	verify_remote_names(nr_heads, heads);
 
-	pid = git_connect(fd, dest, receivepack);
+	pid = git_connect(fd, dest, receivepack, verbose ? 0 : NET_QUIET);
 	if (pid < 0)
 		return 1;
 	ret = send_pack(fd[0], fd[1], nr_heads, heads);


-- 
MST
