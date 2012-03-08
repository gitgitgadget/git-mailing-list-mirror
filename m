From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/5] tcp: make dns_resolve() return an error code
Date: Thu, 8 Mar 2012 07:16:20 -0600
Message-ID: <20120308131620.GF9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:16:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dCo-0006RH-PR
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab2CHNQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:16:26 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50571 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2CHNQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 08:16:25 -0500
Received: by yenl12 with SMTP id l12so160417yen.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Dg4EsWo1RyLTVF9UEliBssg1qoR0Tfgtt3RxqLwBgao=;
        b=I0vA8nWF7strydDZL2bivXKVxpajAlYYn8CJC1jweQYuefpHveX/rNveFmKySLI7Zy
         /P4ThRAMeCaf4mgmCBMy8bHOV/Kn5OZDfsbGQwuF0qrU8XiKf0THJ1iiV1PF/a+aPV1i
         LUJhySJiEXm4sXKKB5IGRuZ728pEtzSS3mLI31txVQdQJ7BTxEGBL9+ym+lzbOQVBMzv
         NKCHGLSylMGnAc25L02+QshN55eYHNHvl5wnyhrWSZvhD+hT4XyLqttR3zzzrmXyCMQS
         +DHMFRLjD6EKw1wwbXhJCz3qtiaWxuB6ss7U14YKANeamsnPtUNMScHbA6pTz33W2LOH
         r/9Q==
Received: by 10.60.29.68 with SMTP id i4mr2471632oeh.7.1331212584777;
        Thu, 08 Mar 2012 05:16:24 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n1sm2531770obm.11.2012.03.08.05.16.23
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:16:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192596>

Date: Thu, 23 Jun 2011 05:23:57 -0500

getaddrinfo() and gethostbyname() use error codes to describe their
errors.  Pass that error code back to the caller when dns_resolve()
fails and the RESOLVE_FAIL_QUIETLY flag is set, so callers can save
the diagnosis and print it later:

	int saved_rerrno = dns_resolve(...);
	...
	if (saved_rerrno)
		die("resolver failed: %s", dns_strerror(saved_rerrno));

In the ipv4 codepath, we assume that h_errno is never 0 on error.
POSIX.1-2004 does not specify whether 0 is a valid value for h_errno,
but luckily common practice is for h_errno to be a strictly positive
integer (HOST_NOT_FOUND = 1, NO_DATA = 2, NO_RECOVERY = 3, or
TRY_AGAIN = 4).  If gethostbyname errors out with h_errno == 0 on some
platform, just let git die with a message indicating a BUG so the bad
assumption can be corrected.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This makes saving up errors from a host resolution failure as in
v1.7.7-rc0~40^2 (connect: only log if all attempts failed, 2011-08-01)
possible.  By the way, this series is currently against "maint" for no
particular reason and presumably it would conflict with that patch. ;-)

I'll be happy to rebase against "master" some time soon.

 dns-ipv4.c |    7 +++++--
 dns-ipv4.h |    5 +++++
 dns-ipv6.c |    2 +-
 dns-ipv6.h |    1 +
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/dns-ipv4.c b/dns-ipv4.c
index 911a8569..8820c9e8 100644
--- a/dns-ipv4.c
+++ b/dns-ipv4.c
@@ -9,8 +9,11 @@ int dns_resolve(const char *host, const char *port, int flags,
 	unsigned int nport;
 
 	he = gethostbyname(host);
-	if (!he && (flags & RESOLVE_FAIL_QUIETLY))
-		return -1;
+	if (!he && (flags & RESOLVE_FAIL_QUIETLY)) {
+		if (!h_errno)
+			die("BUG: gethostbyname failed but h_errno == 0");
+		return h_errno;
+	}
 	if (!he)
 		die("Unable to look up %s (%s)", host, hstrerror(h_errno));
 
diff --git a/dns-ipv4.h b/dns-ipv4.h
index c5f1778f..6f70d639 100644
--- a/dns-ipv4.h
+++ b/dns-ipv4.h
@@ -18,6 +18,10 @@ typedef struct ipv4_address resolved_address;
 
 enum {
 	RESOLVE_CANONNAME = 1,
+	/*
+	 * Quietly return an error code instead of exiting on error.
+	 * Callers can use dns_strerror() to get an error string.
+	 */
 	RESOLVE_FAIL_QUIETLY = 2
 };
 extern int dns_resolve(const char *host, const char *port, int flags,
@@ -63,6 +67,7 @@ static inline int dns_fill_sockaddr_(char *ap,
 #define dns_addrlen(addr, ai) sizeof((addr).sa)
 #define dns_canonname(addr, ai) ((ai).he->h_name)
 
+#define dns_strerror(n) hstrerror(n)
 #define dns_free(ai) do { /* nothing */ } while (0)
 
 #endif
diff --git a/dns-ipv6.c b/dns-ipv6.c
index f2325681..0b0e0602 100644
--- a/dns-ipv6.c
+++ b/dns-ipv6.c
@@ -41,7 +41,7 @@ int dns_resolve(const char *host, const char *port, int flags,
 
 	gai = getaddrinfo(host, port, &hints, res);
 	if (gai && (flags & RESOLVE_FAIL_QUIETLY))
-		return -1;
+		return gai;
 	if (gai)
 		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
 
diff --git a/dns-ipv6.h b/dns-ipv6.h
index 16bf84b5..4211c9e2 100644
--- a/dns-ipv6.h
+++ b/dns-ipv6.h
@@ -26,6 +26,7 @@ extern char *dns_ip_address(const resolved_address *i,
 #define dns_addrlen(i, ai) ((i)->ai_addrlen)
 #define dns_canonname(i, ai) ((i)->ai_canonname)
 
+#define dns_strerror(gai) gai_strerror(gai)
 #define dns_free(ai) freeaddrinfo(ai)
 
 #endif
-- 
1.7.9.2
