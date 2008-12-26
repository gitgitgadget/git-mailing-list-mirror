From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] daemon: handle freopen() failure
Date: Fri, 26 Dec 2008 10:46:25 +0100
Message-ID: <1230284785.6728.26.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 10:47:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG9IR-00084q-NC
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 10:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYLZJqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 04:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbYLZJqd
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 04:46:33 -0500
Received: from india601.server4you.de ([85.25.151.105]:58326 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbYLZJqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 04:46:33 -0500
Received: from [10.0.1.101] (p57B7E108.dip.t-dialin.net [87.183.225.8])
	by india601.server4you.de (Postfix) with ESMTPSA id BC0DD2F8003;
	Fri, 26 Dec 2008 10:46:29 +0100 (CET)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103927>

Die if stderr couldn't be sent to /dev/null when operating in inetd
mode and report the error message from the OS.

This fixes a compiler warning about the return value of freopen()
being ignored on Ubuntu 8.10.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 daemon.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 1cef309..8c317be 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1118,7 +1118,9 @@ int main(int argc, char **argv)
 		struct sockaddr *peer = (struct sockaddr *)&ss;
 		socklen_t slen = sizeof(ss);
 
-		freopen("/dev/null", "w", stderr);
+		if (!freopen("/dev/null", "w", stderr))
+			die("failed to redirect stderr to /dev/null: %s",
+			    strerror(errno));
 
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
-- 
1.6.1
