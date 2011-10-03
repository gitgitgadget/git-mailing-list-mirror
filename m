From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] daemon: log errors if we could not use some sockets
Date: Tue,  4 Oct 2011 06:13:28 +1100
Message-ID: <1317669208-16340-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 21:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAnxT-0002Ws-Jh
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915Ab1JCTNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 15:13:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34802 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab1JCTNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:13:42 -0400
Received: by ywb5 with SMTP id 5so3737948ywb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0E6Oa6O6te9yLZAkhK5MoNxoxEqKnnni4Jx1lwXAhT0=;
        b=LG7tihHMIfBeDVYfoz17SQKF8+dFhBL8Whxs8bABbXVvL01DZz8s1P1+v9XN6mYhrh
         m5B9rbltd91hgkgCVDMA8YzYWSK2tCekt4pnQ7iUzmnu0PHaDFytGTnh15pzxX7UVDh/
         CYucpOzJ89f0Kpv6wJGMOYWVB4751XdnJNuts=
Received: by 10.236.187.35 with SMTP id x23mr2068955yhm.6.1317669222374;
        Mon, 03 Oct 2011 12:13:42 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id l75sm15212267yhj.24.2011.10.03.12.13.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 12:13:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 04 Oct 2011 06:13:29 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182697>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 daemon.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index cfd8cef..154d66e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -739,6 +739,29 @@ struct socketlist {
 	size_t alloc;
 };
=20
+static const char *ip2str(int family, struct sockaddr *sin, socklen_t =
len)
+{
+#ifdef NO_IPV6
+	static char ip[INET_ADDRSTRLEN];
+#else
+	static char ip[INET6_ADDRSTRLEN];
+#endif
+
+	switch (family) {
+#ifndef NO_IPV6
+	case AF_INET6:
+		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
+		break;
+#endif
+	case AF_INET:
+		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
+		break;
+	default:
+		strcpy(ip, "<unknown>");
+	}
+	return ip;
+}
+
 #ifndef NO_IPV6
=20
 static int setup_named_sock(char *listen_addr, int listen_port, struct=
 socketlist *socklist)
@@ -785,15 +808,22 @@ static int setup_named_sock(char *listen_addr, in=
t listen_port, struct socketlis
 #endif
=20
 		if (set_reuse_addr(sockfd)) {
+			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
 			close(sockfd);
 			continue;
 		}
=20
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			logerror("Could not bind to %s: %s",
+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 strerror(errno));
 			close(sockfd);
 			continue;	/* not fatal */
 		}
 		if (listen(sockfd, 5) < 0) {
+			logerror("Could not listen to %s: %s",
+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
+				 strerror(errno));
 			close(sockfd);
 			continue;	/* not fatal */
 		}
@@ -840,16 +870,23 @@ static int setup_named_sock(char *listen_addr, in=
t listen_port, struct socketlis
 		return 0;
=20
 	if (set_reuse_addr(sockfd)) {
+		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
 		close(sockfd);
 		return 0;
 	}
=20
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
+		logerror("Could not listen to %s: %s",
+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 strerror(errno));
 		close(sockfd);
 		return 0;
 	}
=20
 	if (listen(sockfd, 5) < 0) {
+		logerror("Could not listen to %s: %s",
+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
+			 strerror(errno));
 		close(sockfd);
 		return 0;
 	}
--=20
1.7.3.1.256.g2539c.dirty
