From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] credential-cache--daemon: change to the socket dir on
 startup
Date: Tue, 23 Feb 2016 02:16:04 -0500
Message-ID: <20160223071604.GC8395@sigill.intra.peff.net>
References: <20160223071427.GA7489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Griffiths <jon_p_griffiths@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 08:16:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY7Ce-0001AT-61
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 08:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbcBWHQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 02:16:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:47363 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932108AbcBWHQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 02:16:07 -0500
Received: (qmail 12295 invoked by uid 102); 23 Feb 2016 07:16:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:16:07 -0500
Received: (qmail 26323 invoked by uid 107); 23 Feb 2016 07:16:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:16:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 02:16:04 -0500
Content-Disposition: inline
In-Reply-To: <20160223071427.GA7489@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287032>

From: Jon Griffiths <jon_p_griffiths@yahoo.com>

Changing to the socket path stops the daemon holding open
the directory the user was in when it was started,
preventing umount from working. We're already holding open a
socket in that directory, so there's no downside.

Thanks-to: Jeff King <peff@peff.net>
Signed-off-by: Jon Griffiths <jon_p_griffiths@yahoo.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 credential-cache--daemon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 7cfcd37..776f315 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -236,6 +236,14 @@ static void init_socket_directory(const char *path)
 		if (mkdir(dir, 0700) < 0)
 			die_errno("unable to mkdir '%s'", dir);
 	}
+
+	/*
+	 * We don't actually care what our cwd is; we chdir here just to
+	 * be a friendly daemon and avoid tying up our original cwd.
+	 * If this fails, it's OK to just continue without that benefit.
+	 */
+	chdir(dir);
+
 	free(path_copy);
 }
 
-- 
2.7.2.645.g4e1306c
