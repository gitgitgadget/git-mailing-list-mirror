From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] credential-cache--daemon: disallow relative socket path
Date: Tue, 23 Feb 2016 02:15:41 -0500
Message-ID: <20160223071541.GB8395@sigill.intra.peff.net>
References: <20160223071427.GA7489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jon Griffiths <jon_p_griffiths@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 08:15:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY7CF-0000pT-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 08:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbcBWHPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 02:15:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:47359 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751214AbcBWHPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 02:15:44 -0500
Received: (qmail 12229 invoked by uid 102); 23 Feb 2016 07:15:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:15:44 -0500
Received: (qmail 26306 invoked by uid 107); 23 Feb 2016 07:15:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 02:15:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 02:15:41 -0500
Content-Disposition: inline
In-Reply-To: <20160223071427.GA7489@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287031>

From: Jon Griffiths <jon_p_griffiths@yahoo.com>

Relative socket paths are dangerous since the user cannot generally
control when the daemon starts (initially, after a timeout, kill or
crash). Since the daemon creates but does not delete the socket
directory, this could lead to spurious directory creation relative
to the users cwd.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jon Griffiths <jon_p_griffiths@yahoo.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-credential-cache.txt | 2 +-
 credential-cache--daemon.c             | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index 89b7306..96208f8 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -36,7 +36,7 @@ OPTIONS
 	cache daemon if one is not started). Defaults to
 	`~/.git-credential-cache/socket`. If your home directory is on a
 	network-mounted filesystem, you may need to change this to a
-	local filesystem.
+	local filesystem. You must specify an absolute path.
 
 CONTROLLING THE DAEMON
 ----------------------
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 3403f48..7cfcd37 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -262,6 +262,9 @@ int main(int argc, const char **argv)
 	if (!socket_path)
 		usage_with_options(usage, options);
 
+	if (!is_absolute_path(socket_path))
+		die("socket directory must be an absolute path");
+
 	init_socket_directory(socket_path);
 	register_tempfile(&socket_file, socket_path);
 
-- 
2.7.2.645.g4e1306c
