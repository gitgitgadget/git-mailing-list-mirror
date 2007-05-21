From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] git-daemon: don't ignore pid-file write failure
Date: Mon, 21 May 2007 09:58:01 +0200
Message-ID: <878xbiboc6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 09:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2mN-00046K-QK
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXEUH6E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbXEUH6E
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:58:04 -0400
Received: from mx.meyering.net ([82.230.74.64]:35980 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbXEUH6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:58:03 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2EB9628E04; Mon, 21 May 2007 09:58:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47991>

Note: since the consequence of failure is to call die,
I don't bother to close "f".

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 daemon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index e74ecac..674e30d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -970,8 +970,8 @@ static void store_pid(const char *path)
 	FILE *f = fopen(path, "w");
 	if (!f)
 		die("cannot open pid file %s: %s", path, strerror(errno));
-	fprintf(f, "%d\n", getpid());
-	fclose(f);
+	if (fprintf(f, "%d\n", getpid()) < 0 || fclose(f) != 0)
+		die("failed to write pid file %s: %s", path, strerror(errno));
 }

 static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
--
1.5.2
