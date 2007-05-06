From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: [PATCH] connect: display connection progress
Date: Sun, 6 May 2007 22:52:30 +0300
Message-ID: <20070506195230.GA30339@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 21:52:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkmmc-0004ES-Oo
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179AbXEFTwe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755210AbXEFTwe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:52:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:35601 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbXEFTwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 15:52:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so990814uga
        for <git@vger.kernel.org>; Sun, 06 May 2007 12:52:28 -0700 (PDT)
Received: by 10.67.89.6 with SMTP id r6mr4343419ugl.1178481148462;
        Sun, 06 May 2007 12:52:28 -0700 (PDT)
Received: from ?127.0.0.1? ( [85.250.212.226])
        by mx.google.com with ESMTP id 54sm9839421ugp.2007.05.06.12.52.26;
        Sun, 06 May 2007 12:52:27 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46369>

Make git notify the user about host resolution/connection attempts.  This
is useful both as a progress indicator on slow links, and helps reassure the
user there are no DNS/firewall problems.

Signed-off-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>

---

I find the following useful.
This currently only covers native git protocol. I expect it would
be easy to extend this to other protocols, if there's interest.
Opinions?

diff --git a/connect.c b/connect.c
index da89c9c..f026713 100644
--- a/connect.c
+++ b/connect.c
@@ -425,9 +425,11 @@ static int git_tcp_connect_sock(char *host)
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
 
+	fprintf(stderr, "Looking up %s ... ", host);
 	gai = getaddrinfo(host, port, &hints, &ai);
 	if (gai)
 		die("Unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+	fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
 	for (ai0 = ai; ai; ai = ai->ai_next) {
 		sockfd = socket(ai->ai_family,
@@ -450,6 +452,8 @@ static int git_tcp_connect_sock(char *host)
 	if (sockfd < 0)
 		die("unable to connect a socket (%s)", strerror(saved_errno));
 
+	fprintf(stderr, "done.\n");
+
 	return sockfd;
 }
 
-- 
MST
