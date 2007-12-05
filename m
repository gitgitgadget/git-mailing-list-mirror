From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/6] DWIM "git add remote ..."
Date: Wed, 5 Dec 2007 19:03:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051902510.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:04:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzXF-0002CX-7i
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbXLETDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbXLETD3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:03:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:54647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751556AbXLETD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:03:29 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:03:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 05 Dec 2007 20:03:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qgU8TKlmqkaekM4ZqzItskUmOGBeJIvkUGCSy/S
	oYr+es7Togqr7M
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051858270.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67179>


It is wrong to divert to "git remote add" when you typed the
(more English) "git add remote".  But is it also pretty convenient.

So implement it, but do not document it ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-add.c     |    7 +++++++
 t/t5505-remote.sh |    6 ++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 5c29cc2..b5b4c2f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -196,6 +196,13 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	const char **pathspec;
 	struct dir_struct dir;
 
+	if (argc > 1 && !strcmp(argv[1], "remote") &&
+			access("remote", F_OK)) {
+		argv[1] = argv[0];
+		argv[0] = "remote";
+		return cmd_remote(argc, argv, prefix);
+	}
+
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
 	if (patch_interactive)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2376e0a..83ed70c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -147,4 +147,10 @@ test_expect_success 'add --mirror && prune' '
 	 git rev-parse --verify refs/heads/side)
 '
 
+test_expect_success 'add remote' '
+	(cd test &&
+	 git add remote -f another-one ../one &&
+	 git diff master remotes/another-one/master)
+'
+
 test_done
-- 
1.5.3.7.2157.g9598e
