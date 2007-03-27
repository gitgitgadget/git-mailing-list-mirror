From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix "getaddrinfo()" buglet
Date: Tue, 27 Mar 2007 09:50:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703270938380.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:50:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWEsO-00080a-UP
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbXC0QuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933271AbXC0QuY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:50:24 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33634 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226AbXC0QuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 12:50:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2RGoKU2006277
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Mar 2007 09:50:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2RGoK4V020904;
	Tue, 27 Mar 2007 09:50:20 -0700
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43283>


At least in Linux glibc, "getaddrinfo()" has a very irritating feature (or 
bug, who knows..).

Namely if you pass it in an empty string for the service name, it will 
happily and quietly consider it identical to a NULL port pointer, and 
return port number zero and no errors. Which obviously will not work.

Maybe that's what it's really expected to do, although the man-page for 
getaddrinfo() certainly implies that it's a bug.

So when somebody passes me a "please pull" request pointing to something 
like the following

	git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

(note the extraneous colon at the end of the host name), git would happily 
try to connect to port 0, which would generally just cause the remote to 
not even answer, and the "connect()" will take a long time to time out.

So to work around the glibc feature/bug, just notice this empty port case 
automatically. Also, add the port information to the error information 
when it fails to look up (maybe it's the host-name that fails, maybe it's 
the port-name - we should print out both).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

 connect.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 5048653..da89c9c 100644
--- a/connect.c
+++ b/connect.c
@@ -417,6 +417,8 @@ static int git_tcp_connect_sock(char *host)
 	if (colon) {
 		*colon = 0;
 		port = colon + 1;
+		if (!*port)
+			port = "<none>";
 	}
 
 	memset(&hints, 0, sizeof(hints));
@@ -425,7 +427,7 @@ static int git_tcp_connect_sock(char *host)
 
 	gai = getaddrinfo(host, port, &hints, &ai);
 	if (gai)
-		die("Unable to look up %s (%s)", host, gai_strerror(gai));
+		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
 
 	for (ai0 = ai; ai; ai = ai->ai_next) {
 		sockfd = socket(ai->ai_family,
