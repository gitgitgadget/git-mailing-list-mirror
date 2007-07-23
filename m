From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach "git stripspace" the --strip-comments option
Date: Mon, 23 Jul 2007 12:58:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231258100.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 23 13:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICwYm-0005kq-OF
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 13:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbXGWL6m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 07:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752597AbXGWL6m
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 07:58:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:51588 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751158AbXGWL6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 07:58:41 -0400
Received: (qmail invoked by alias); 23 Jul 2007 11:58:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 23 Jul 2007 13:58:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qCJBD2heqKHfoO2UCSZSkogqXX+a50xLww8gymG
	0qtYaeAFezQvlW
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53432>


With --strip-comments (or short -s), git stripspace now removes lines
beginning with a '#', too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-stripspace.txt |    5 ++++-
 builtin-stripspace.c             |    7 ++++++-
 t/t0030-stripspace.sh            |    5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 1306d7b..5212358 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -8,7 +8,7 @@ git-stripspace - Filter out empty lines
 
 SYNOPSIS
 --------
-'git-stripspace' < <stream>
+'git-stripspace' [-s | --strip-comments] < <stream>
 
 DESCRIPTION
 -----------
@@ -16,6 +16,9 @@ Remove multiple empty lines, and empty lines at beginning and end.
 
 OPTIONS
 -------
+-s\|--strip-comments::
+	In addition to empty lines, also strip lines starting with '#'.
+
 <stream>::
 	Byte stream to act on.
 
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 5571687..916355c 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -76,6 +76,11 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	char *buffer;
 	unsigned long size;
+	int strip_comments = 0;
+
+	if (argc > 1 && (!strcmp(argv[1], "-s") ||
+				!strcmp(argv[1], "--strip-comments")))
+		strip_comments = 1;
 
 	size = 1024;
 	buffer = xmalloc(size);
@@ -84,7 +89,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		die("could not read the input");
 	}
 
-	size = stripspace(buffer, size, 0);
+	size = stripspace(buffer, size, strip_comments);
 	write_or_die(1, buffer, size);
 	if (size)
 		putc('\n', stdout);
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index b1c9003..cad95f3 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -392,4 +392,9 @@ test_expect_success \
     git diff expect actual
 '
 
+test_expect_success 'strip comments, too' '
+	test ! -z "$(echo "# comment" | git stripspace)" &&
+	test -z "$(echo "# comment" | git stripspace -s)"
+'
+
 test_done
-- 
1.5.3.rc2.32.g35c5b
