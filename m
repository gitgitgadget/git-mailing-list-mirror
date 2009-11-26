From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH] Improve the mingw getaddrinfo stub to handle more use
 cases
Date: Thu, 26 Nov 2009 12:43:44 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911261241590.14228@cone.home.martin.st>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-2-git-send-email-kusmabite@gmail.com> <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	dotzenlabs@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 11:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDbpf-0005aC-Kb
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 11:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZKZKn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 05:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbZKZKnz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 05:43:55 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:33481 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbZKZKnz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 05:43:55 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4A77692A0468D50D; Thu, 26 Nov 2009 12:43:59 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133781>

Allow the node parameter to be null, which is used for getting
the default bind address.

Also allow the hints parameter to be null, to improve standard
conformance of the stub implementation a little.

Signed-off-by: Martin Storsjo <martin@martin.st>
---

This patch adds support for the getaddrinfo parameters used by git-daemon, 
as mentioned earlier.

 compat/mingw.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0653560..17d1314 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -913,19 +913,22 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 				   const struct addrinfo *hints,
 				   struct addrinfo **res)
 {
-	struct hostent *h = gethostbyname(node);
+	struct hostent *h = NULL;
 	struct addrinfo *ai;
 	struct sockaddr_in *sin;
 
-	if (!h)
-		return WSAGetLastError();
+	if (node) {
+		h = gethostbyname(node);
+		if (!h)
+			return WSAGetLastError();
+	}
 
 	ai = xmalloc(sizeof(struct addrinfo));
 	*res = ai;
 	ai->ai_flags = 0;
 	ai->ai_family = AF_INET;
-	ai->ai_socktype = hints->ai_socktype;
-	switch (hints->ai_socktype) {
+	ai->ai_socktype = hints ? hints->ai_socktype : 0;
+	switch (ai->ai_socktype) {
 	case SOCK_STREAM:
 		ai->ai_protocol = IPPROTO_TCP;
 		break;
@@ -937,14 +940,17 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 		break;
 	}
 	ai->ai_addrlen = sizeof(struct sockaddr_in);
-	ai->ai_canonname = strdup(h->h_name);
+	ai->ai_canonname = h ? strdup(h->h_name) : NULL;
 
 	sin = xmalloc(ai->ai_addrlen);
 	memset(sin, 0, ai->ai_addrlen);
 	sin->sin_family = AF_INET;
 	if (service)
 		sin->sin_port = htons(atoi(service));
-	sin->sin_addr = *(struct in_addr *)h->h_addr;
+	if (h)
+		sin->sin_addr = *(struct in_addr *)h->h_addr;
+	else
+		sin->sin_addr.s_addr = INADDR_ANY;
 	ai->ai_addr = (struct sockaddr *)sin;
 	ai->ai_next = 0;
 	return 0;
-- 
1.6.4.4
