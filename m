From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/6] daemon: make host resolution into a separate function
Date: Mon, 6 Jun 2011 04:38:45 -0500
Message-ID: <20110606093845.GG8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:38:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWGt-0002iL-00
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab1FFJiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:38:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33197 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab1FFJiu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:38:50 -0400
Received: by iwn34 with SMTP id 34so2970555iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MU1S7zPquCAkNSm2mzSbfcAytI3kEvjul6B9mS4ffZg=;
        b=ieQQP0KDjjIwRP2x8rBD+u9glU2+REdI2NS2bcosr01BkNIUI48OGoGZK+nKzyx4dE
         +oZJwPesk+ZsP3mhx/5HBjt4mshqMBzg7Th0eHTF6v72/3XXFJCKV3Kmke3curXppYpR
         HM8jn8j0vL77G+yMOko9t6vDVxhX4mtYwi67E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RMNGDHMPH/umoKu7l2Ec594U+Cj8A8Kcj1FP7xxKnwCOFeN+O58ZM13tlaP0kjE5rM
         R9S9aLFfJxzXRUCS5OY/A01nry7Xrynb4lwbAxB16F/OAxzbUZAUVoYCncb5Pi6rT5Xo
         ZfTE72yz3ox2zDjWDUCeBe1Ljn/r8k5waVOS4=
Received: by 10.42.132.129 with SMTP id d1mr7531273ict.526.1307353129488;
        Mon, 06 Jun 2011 02:38:49 -0700 (PDT)
Received: from elie ([68.255.97.40])
        by mx.google.com with ESMTPS id a9sm2647136icy.18.2011.06.06.02.38.47
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:38:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175108>

For each incoming connection, the git daemon runs a DNS query using
the client-supplied hostname parameter, to determine the canonical
hostname and IP address in case it is needed by the
--interpolated-path feature (to distinguish between virtual hosts).
Put the code for this in a separate function so the details of this
lookup can be easily tweaked.

Signed-off-by; Jonathan Nieder <jrnieder@gmail.com>
---
 daemon.c |  112 +++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4c8346d..3958cb6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -432,6 +432,65 @@ static void parse_host_and_port(char *hostport, char **host,
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
@@ -467,56 +526,11 @@ static void parse_host_arg(char *extra_args, int buflen)
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
1.7.5.3
