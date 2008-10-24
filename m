From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] git-daemon: set REMOTE_ADDR to client address
Date: Fri, 24 Oct 2008 01:48:50 -0400
Message-ID: <20081024054849.GA29048@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 07:50:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtFYk-0003Rx-ML
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 07:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbYJXFsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 01:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbYJXFsy
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 01:48:54 -0400
Received: from wren.kitenet.net ([80.68.85.49]:48580 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbYJXFsx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 01:48:53 -0400
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 87F9E3142E1
	for <git@vger.kernel.org>; Fri, 24 Oct 2008 01:48:51 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 3F234114025; Fri, 24 Oct 2008 01:48:50 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8483/Thu Oct 23 23:01:54 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99009>

This allows hooks like pre-receive to look at the client's IP
address.

Of course the IP address can't be used to get strong security;
git-daemon isn't the right thing to use if you need that. However,
basic IP address checking can be good enough in some situations.

REMOTE_ADDR is the same environment variable used to communicate the
client's address to CGI scripts.

Signed-off-by: Joey Hess <joey@kitenet.net>
---

Real world example: ikiwiki can use pre-receive to check that the pushed
changes are ones that anyone could make to the wiki's source via the web
interface, and thus safe to accept. It's useful to be able to ban IP
addresses from editing a wiki on the web, as a first line of defence to
guard against spammers etc. With this patch the same IP guards can be
applied to changes pushed in via git-daemon.

 Documentation/git-daemon.txt |    9 +++++++++
 daemon.c                     |    4 ++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index b08a08c..f1a570a 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -270,6 +270,15 @@ selectively enable/disable services per repository::
 ----------------------------------------------------------------
 
 
+ENVIRONMENT
+-----------
+'git-daemon' will set REMOTE_ADDR to the IP address of the client
+that connected to it, if the IP address is available. REMOTE_ADDR will
+be available in the environment of hooks called when
+services are performed.
+
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
diff --git a/daemon.c b/daemon.c
index 3e5582d..b9ba44c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -537,6 +537,10 @@ static int execute(struct sockaddr *addr)
 #endif
 		}
 		loginfo("Connection from %s:%d", addrbuf, port);
+		setenv("REMOTE_ADDR", addrbuf, 1);
+	}
+	else {
+		unsetenv("REMOTE_ADDR");
 	}
 
 	alarm(init_timeout ? init_timeout : timeout);

-- 
1.5.6.5
