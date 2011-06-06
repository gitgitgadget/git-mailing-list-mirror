From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/6] daemon: move locate_host to tcp.c
Date: Mon, 6 Jun 2011 04:39:29 -0500
Message-ID: <20110606093929.GH8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:39:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWHa-0002xu-Sc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab1FFJjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:39:36 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39433 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab1FFJjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:39:33 -0400
Received: by iyb14 with SMTP id 14so2954356iyb.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gf9vMD1z5uEM41zBPGHFnUw6h9FkSb/maHgls0UUmy4=;
        b=NzjitqeSf0AABGFVGlvDQohRL+3lfb8dPI7SM+zz7eivV7Aj6RFEOYay3Ma4Je66i7
         8Fw1Lt4ddzHTghAERFYe4CopcUzipOuFA17VK99NYM5j5ApB5wjYYYJ3l9D43uS/VlZH
         6J63X5GHD0HGr76C2Hz7gZ82oySkHPou2R5R0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rHCGqqC7/Kkc2z52otfagQXQK9go2tDx8Keo66NzLiZ6AKLzXOorUHlpP77m9BaEHQ
         H1QEba1onaYIPt9YH7/iGIdKvihh3x1RM2IqLhS+GjnFMMEqj3tmIJcKQBXDmVFYbfLF
         FM1AG8znr+fC4FuGY5hTuKdmklwQd+t9kbqF4=
Received: by 10.231.123.141 with SMTP id p13mr8112872ibr.29.1307353173239;
        Mon, 06 Jun 2011 02:39:33 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id d10sm1612630ibb.66.2011.06.06.02.39.31
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175109>

Keep the different name resolution functions close together so they
can learn from each other and perhaps share code in the future.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    2 +-
 daemon.c |   62 ++------------------------------------------------------------
 tcp.c    |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcp.h    |    3 +++
 4 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/Makefile b/Makefile
index fa3a47f..df84157 100644
--- a/Makefile
+++ b/Makefile
@@ -1959,7 +1959,7 @@ builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
-connect.o tcp.o: tcp.h
+connect.o daemon.o tcp.o: tcp.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
diff --git a/daemon.c b/daemon.c
index 3958cb6..3261616 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "tcp.h"
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -432,65 +433,6 @@ static void parse_host_and_port(char *hostport, char **host,
 	}
 }
 
-#ifndef NO_IPV6
-
-static void locate_host(const char *hostname, char **ip_address,
-						char **canon_hostname)
-{
-	struct addrinfo hints;
-	struct addrinfo *ai;
-	int gai;
-	static char addrbuf[HOST_NAME_MAX + 1];
-	struct sockaddr_in *sin_addr;
-
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_flags = AI_CANONNAME;
-
-	gai = getaddrinfo(hostname, NULL, &hints, &ai);
-	if (gai)
-		return;
-
-	sin_addr = (void *)ai->ai_addr;
-	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-	free(*ip_address);
-	*ip_address = xstrdup(addrbuf);
-
-	free(*canon_hostname);
-	*canon_hostname = xstrdup(ai->ai_canonname ?
-				  ai->ai_canonname : *ip_address);
-
-	freeaddrinfo(ai);
-}
-
-#else
-
-static void locate_host(const char *hostname, char **ip_address,
-						char **canon_hostname)
-{
-	struct hostent *hent;
-	struct sockaddr_in sa;
-	char **ap;
-	static char addrbuf[HOST_NAME_MAX + 1];
-
-	hent = gethostbyname(hostname);
-
-	ap = hent->h_addr_list;
-	memset(&sa, 0, sizeof sa);
-	sa.sin_family = hent->h_addrtype;
-	sa.sin_port = htons(0);
-	memcpy(&sa.sin_addr, *ap, hent->h_length);
-
-	inet_ntop(hent->h_addrtype, &sa.sin_addr,
-		  addrbuf, sizeof(addrbuf));
-
-	free(*canon_hostname);
-	*canon_hostname = xstrdup(hent->h_name);
-	free(*ip_address);
-	*ip_address = xstrdup(addrbuf);
-}
-
-#endif
-
 /*
  * Read the host as supplied by the client connection.
  */
@@ -530,7 +472,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 	 * if possible.
 	 */
 	if (hostname)
-		locate_host(hostname, &ip_address, &canon_hostname);
+		git_locate_host(hostname, &ip_address, &canon_hostname);
 }
 
 
diff --git a/tcp.c b/tcp.c
index 89f5c62..2cb90db 100644
--- a/tcp.c
+++ b/tcp.c
@@ -97,6 +97,34 @@ static const char *ai_name(const struct addrinfo *ai)
 	return addr;
 }
 
+void git_locate_host(const char *hostname, char **ip_address,
+					char **canon_hostname)
+{
+	struct addrinfo hints;
+	struct addrinfo *ai;
+	int gai;
+	static char addrbuf[HOST_NAME_MAX + 1];
+	struct sockaddr_in *sin_addr;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_flags = AI_CANONNAME;
+
+	gai = getaddrinfo(hostname, NULL, &hints, &ai);
+	if (gai)
+		return;
+
+	sin_addr = (void *)ai->ai_addr;
+	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+	free(*ip_address);
+	*ip_address = xstrdup(addrbuf);
+
+	free(*canon_hostname);
+	*canon_hostname = xstrdup(ai->ai_canonname ?
+				  ai->ai_canonname : *ip_address);
+
+	freeaddrinfo(ai);
+}
+
 /*
  * Returns a connected socket() fd, or else die()s.
  */
@@ -162,6 +190,31 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 #else /* NO_IPV6 */
 
+void git_locate_host(const char *hostname, char **ip_address,
+					char **canon_hostname)
+{
+	struct hostent *hent;
+	struct sockaddr_in sa;
+	char **ap;
+	static char addrbuf[HOST_NAME_MAX + 1];
+
+	hent = gethostbyname(hostname);
+
+	ap = hent->h_addr_list;
+	memset(&sa, 0, sizeof sa);
+	sa.sin_family = hent->h_addrtype;
+	sa.sin_port = htons(0);
+	memcpy(&sa.sin_addr, *ap, hent->h_length);
+
+	inet_ntop(hent->h_addrtype, &sa.sin_addr,
+		  addrbuf, sizeof(addrbuf));
+
+	free(*canon_hostname);
+	*canon_hostname = xstrdup(hent->h_name);
+	free(*ip_address);
+	*ip_address = xstrdup(addrbuf);
+}
+
 /*
  * Returns a connected socket() fd, or else die()s.
  */
diff --git a/tcp.h b/tcp.h
index 4de5f71..bed3cdc 100644
--- a/tcp.h
+++ b/tcp.h
@@ -1,6 +1,9 @@
 #ifndef TCP_H
 #define TCP_H
 
+extern void git_locate_host(const char *hostname,
+			char **ip_address, char **canon_hostname);
+
 extern int git_use_proxy(const char *host);
 extern void git_tcp_connect(int fd[2], char *host, int flags);
 extern struct child_process *git_proxy_connect(int fd[2], char *host);
-- 
1.7.5.3
