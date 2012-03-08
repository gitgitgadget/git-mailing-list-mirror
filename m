From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] daemon: make host resolution a separate function
Date: Thu, 8 Mar 2012 07:05:05 -0600
Message-ID: <20120308130505.GB9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:05:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5d20-0002AU-Me
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759Ab2CHNFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:05:11 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:39552 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757754Ab2CHNFK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 08:05:10 -0500
Received: by obbuo6 with SMTP id uo6so636022obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HaEnKbwaE4GuHigmZVCvEK5/bLdRi3nX7Bsi4SVHjLg=;
        b=Q50B4sEes8EQaCiyZf8CEAtQ1wA8YoXZqJ5T0fJ8C03oWc5VNzbCnGXVVfV9vU9izs
         mH+u2fOwOWniMjI3cdsrJBnExymkmGZsz32iOey35wdRoYZ+KIsVB0Xr/H5PDa0HJjt3
         jdliaol5kjTUu8RMBYTcMtaAbi6qeAWXthbUGi/Ol0yQyj7Tq3QIVo42WzElU4Aj5pil
         ztgYcb6HkBjRrntHRuZzAo8mpQIyWTlWrPVI2s6SIRO2Nu0r1VDWcy6zE12PL0/QBPeZ
         kBNhD44aiSkgkzWqmqB9Fts33alWJPiwYixDJOVRzBqhSfne7JetWQGgvUU1l5ogBrS5
         +R3g==
Received: by 10.182.1.4 with SMTP id 4mr2253375obi.67.1331211910068;
        Thu, 08 Mar 2012 05:05:10 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g4sm911286oeg.5.2012.03.08.05.05.09
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:05:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192591>

Date: Mon, 6 Jun 2011 04:38:45 -0500

The locate_host() function looks up the IP address and canonical
hostname of the host named by its argument.  If it succeeds,
*ip_address and *canon_hostname are freed and replaced by the hosts'
IP address and canonical hostname, respectively, as strings.  If it
fails, *ip_address and *canon_hostname are left alone.

The git daemon uses this functionality to support the %IP and %CH
placeholders for its --interpolated-path feature.  Splitting it out as
a separate function would make it easier to tweak, for example to
unify the ipv6 and ipv4 code paths or to share code with other parts
of git that make DNS queries.

Signed-off-by; Jonathan Nieder <jrnieder@gmail.com>
---
From http://thread.gmane.org/gmane.comp.version-control.git/175106/focus=175108

The commit message was tweaked, but the patch is the same as before.

 daemon.c |  112 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/daemon.c b/daemon.c
index 15ce918a..2a9dfea0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -441,6 +441,65 @@ static void parse_host_and_port(char *hostport, char **host,
 	}
 }
 
+#ifndef NO_IPV6
+
+static void locate_host(const char *hostname, char **ip_address,
+						char **canon_hostname)
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
+#else
+
+static void locate_host(const char *hostname, char **ip_address,
+						char **canon_hostname)
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
+#endif
+
 /*
  * Read the host as supplied by the client connection.
  */
@@ -476,56 +535,11 @@ static void parse_host_arg(char *extra_args, int buflen)
 	}
 
 	/*
-	 * Locate canonical hostname and its IP address.
+	 * Locate canonical hostname and its IP address,
+	 * if possible.
 	 */
-	if (hostname) {
-#ifndef NO_IPV6
-		struct addrinfo hints;
-		struct addrinfo *ai;
-		int gai;
-		static char addrbuf[HOST_NAME_MAX + 1];
-
-		memset(&hints, 0, sizeof(hints));
-		hints.ai_flags = AI_CANONNAME;
-
-		gai = getaddrinfo(hostname, NULL, &hints, &ai);
-		if (!gai) {
-			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
-
-			inet_ntop(AF_INET, &sin_addr->sin_addr,
-				  addrbuf, sizeof(addrbuf));
-			free(ip_address);
-			ip_address = xstrdup(addrbuf);
-
-			free(canon_hostname);
-			canon_hostname = xstrdup(ai->ai_canonname ?
-						 ai->ai_canonname : ip_address);
-
-			freeaddrinfo(ai);
-		}
-#else
-		struct hostent *hent;
-		struct sockaddr_in sa;
-		char **ap;
-		static char addrbuf[HOST_NAME_MAX + 1];
-
-		hent = gethostbyname(hostname);
-
-		ap = hent->h_addr_list;
-		memset(&sa, 0, sizeof sa);
-		sa.sin_family = hent->h_addrtype;
-		sa.sin_port = htons(0);
-		memcpy(&sa.sin_addr, *ap, hent->h_length);
-
-		inet_ntop(hent->h_addrtype, &sa.sin_addr,
-			  addrbuf, sizeof(addrbuf));
-
-		free(canon_hostname);
-		canon_hostname = xstrdup(hent->h_name);
-		free(ip_address);
-		ip_address = xstrdup(addrbuf);
-#endif
-	}
+	if (hostname)
+		locate_host(hostname, &ip_address, &canon_hostname);
 }
 
 
-- 
1.7.9.2
