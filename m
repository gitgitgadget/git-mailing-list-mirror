From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH 1/2] Refactor winsock initialization into a separate
 function
Date: Tue, 24 Nov 2009 00:55:12 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0911240054420.14228@cone.home.martin.st>
References: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 23:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NChog-0000l8-Pf
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 23:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbZKWWzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 17:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756867AbZKWWzH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 17:55:07 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:57363 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756875AbZKWWzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 17:55:06 -0500
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4A77692A044959A8; Tue, 24 Nov 2009 00:55:12 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <alpine.DEB.2.00.0911240052440.14228@cone.home.martin.st>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133539>

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 compat/mingw.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 15fe33e..f9d82ff 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -903,16 +903,25 @@ char **make_augmented_environ(const char *const *vars)
 	return env;
 }
 
-/* this is the first function to call into WS_32; initialize it */
-#undef gethostbyname
-struct hostent *mingw_gethostbyname(const char *host)
+static void ensure_socket_initialization(void)
 {
 	WSADATA wsa;
+	static int initialized = 0;
+
+	if (initialized)
+		return;
 
 	if (WSAStartup(MAKEWORD(2,2), &wsa))
 		die("unable to initialize winsock subsystem, error %d",
 			WSAGetLastError());
 	atexit((void(*)(void)) WSACleanup);
+	initialized = 1;
+}
+
+#undef gethostbyname
+struct hostent *mingw_gethostbyname(const char *host)
+{
+	ensure_socket_initialization();
 	return gethostbyname(host);
 }
 
-- 
1.6.4.4
