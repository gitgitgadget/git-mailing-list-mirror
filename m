From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] daemon: check for errors retrieving IP address
Date: Thu, 8 Mar 2012 07:11:53 -0600
Message-ID: <20120308131153.GE9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:12:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5d8V-0001bw-Tw
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab2CHNL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:11:59 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:54022 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751404Ab2CHNL6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 08:11:58 -0500
Received: by obbuo6 with SMTP id uo6so643778obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ybDdJheYBcqJtqB5SNciH/uVTP0MQ9xMqj8PfaTOtHg=;
        b=UYUh2zs2jpA4y0PgTiZ3+s8+GlJgeP2hZNP52DjesnFDyXvfqVC34eAKO7UWBVGnGv
         j66ReRDD1g4rC3WULA/mgT+xnppzjqBOwQb7ZNgFIGCD2xhjAELjl8xa3MdcovuenR9c
         I/WDWYQVK10+m7r3mf/LaeoRW9G/Zx2T59zACVZkXM+3WNm4r496z3sUOcigTu3tqLC0
         MiLYriHAWJZgLq4bcHa58doFdMF8vHV/ffDiqx7tM+liDE6pg+HsmEc5AYfHt0HBEWxz
         ziX1p8D3Zyqi2KuaZJgcOUGunVJbeneYBawDG9F3awPuMsvzkv5P2ujyEHy9FdxZX9hp
         Owjw==
Received: by 10.182.183.40 with SMTP id ej8mr1040612obc.41.1331212317727;
        Thu, 08 Mar 2012 05:11:57 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n7sm920685oeh.4.2012.03.08.05.11.56
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:11:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192594>

Date: Fri, 17 Jun 2011 05:26:05 -0500

To retrieve a canonical IP address for possible use in a
--interpolated-path=%IP string, the git daemon calls inet_ntop to fill
a buffer of size HOST_NAME_MAX+1, ignoring errors, and copies the
result.  If the address has length > HOST_NAME_MAX (which was as low
as 8 in ancient times) then inet_ntop could error out, leading the git
daemon to copy uninitialized data.

This probably never happens in practice because modern systems allow
such long hostnames as 64 chars (POSIX requires at least 255) or have
no compile-time maximum at all and let git fall back to a buffer size
of 256.  But it is more comforting not to rely on that.  So:

 - in "ipv4" code, which uses inet_ntop, use a buffer size of 64 (long
   enough to hold an ipv6 address if needed).

 - in ipv6 code, use the "getnameinfo" function that is already being
   used to convert addresses to text in error messages.  It uses a
   buffer of length NI_MAXHOST.

 - check for errors and make dns_ip_address() and git_locate_host()
   return NULL when they occur.  strbuf_expand_dict_cb treats NULL as
   an empty substitution string.

As a nice side effect, the fallback definition of HOST_NAME_MAX for
platforms that don't define it is no longer needed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This patch allows getnameinfo and inet_ntop to use a larger buffer or
fail.  (I was mostly nervous because HOST_NAME_MAX is not guaranteed
to be large enough to hold an IP address.)

That's the end of the series.  Thanks for reading.

 dns-ipv4.h |   11 +++++------
 dns-ipv6.c |   16 ++++++++--------
 tcp.c      |    6 ++++--
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/dns-ipv4.h b/dns-ipv4.h
index 6803bcba..c5f1778f 100644
--- a/dns-ipv4.h
+++ b/dns-ipv4.h
@@ -1,9 +1,7 @@
 #ifndef DNS_IPV4_H
 #define DNS_IPV4_H
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
-#endif
+#define ADDRBUFLEN 64	/* 46 for an ipv6 address, plus a little extra */
 
 struct ipv4_address {
 	char **ap;
@@ -33,9 +31,10 @@ static inline const char *dns_name(const resolved_address *addr)
 static inline char *dns_ip_address(const resolved_address *addr,
 					const resolver_result *ai)
 {
-	char addrbuf[HOST_NAME_MAX + 1];
-	inet_ntop(ai->he->h_addrtype, &addr->sa.sin_addr,
-		  addrbuf, sizeof(addrbuf));
+	char addrbuf[ADDRBUFLEN];
+	if (!inet_ntop(ai->he->h_addrtype, &addr->sa.sin_addr,
+		  addrbuf, sizeof(addrbuf)))
+		return NULL;
 	return xstrdup(addrbuf);
 }
 
diff --git a/dns-ipv6.c b/dns-ipv6.c
index ca59ff91..f2325681 100644
--- a/dns-ipv6.c
+++ b/dns-ipv6.c
@@ -1,8 +1,9 @@
 #include "cache.h"
 #include "dns-ipv6.h"
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
+/* from RFC 2553 */
+#ifndef NI_MAXHOST
+#define NI_MAXHOST 1025
 #endif
 
 const char *dns_name(const resolved_address *i)
@@ -19,12 +20,11 @@ const char *dns_name(const resolved_address *i)
 char *dns_ip_address(const resolved_address *i, const resolver_result *ai0)
 {
 	const struct addrinfo *ai = *i;
-	char addrbuf[HOST_NAME_MAX + 1];
-	struct sockaddr_in *sin_addr;
-
-	sin_addr = (void *)ai->ai_addr;
-	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-	return xstrdup(addrbuf);
+	char addr[NI_MAXHOST];
+	if (getnameinfo(ai->ai_addr, ai->ai_addrlen, addr, sizeof(addr),
+			NULL, 0, NI_NUMERICHOST))
+		return NULL;
+	return xstrdup(addr);
 }
 
 int dns_resolve(const char *host, const char *port, int flags,
diff --git a/tcp.c b/tcp.c
index 4239daf3..83f0313a 100644
--- a/tcp.c
+++ b/tcp.c
@@ -56,8 +56,10 @@ void git_locate_host(const char *hostname, char **ip_address,
 		*ip_address = dns_ip_address(&i, &ai);
 
 		free(*canon_hostname);
-		*canon_hostname = xstrdup(dns_canonname(i, ai) ?
-					dns_canonname(i, ai) : *ip_address);
+		*canon_hostname =
+			dns_canonname(i, ai) ? xstrdup(dns_canonname(i, ai)) :
+			*ip_address ? xstrdup(*ip_address) :
+			NULL;
 		break;
 	}
 
-- 
1.7.9.2
