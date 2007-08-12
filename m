From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/2] attr: fix attribute handling if .gitattributes is involved
Date: Sun, 12 Aug 2007 22:34:34 +0200
Message-ID: <11869508753328-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: gitster@pobox.com, dmitry.kakurin@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 12 22:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKK98-00037K-Lx
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 22:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793AbXHLUen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbXHLUem
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 16:34:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:52552 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756188AbXHLUel (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 16:34:41 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CKYaBu004078;
	Sun, 12 Aug 2007 22:34:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CKYZst018009;
	Sun, 12 Aug 2007 22:34:35 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55723>

If we checkout .gitattributes, we must not try to parse
.gitattributes. If we tried to read it, it may not be
present because checkout_entry unlinks files before checkout.
But we would record that no attributes are present for this
directory, which is wrong. And worse, we would never try again.

This fix skips read_attr_from_file if the path triggering
the read ends with .gitattributes. This is a bit more than we
need, but it helps to checkout all .gitattributes before any
other file, without starting the attr machinery.

This solves part of the problem of correct attributes during
checkout. For example

   rm .gitattributes other
   git-checkout-index -f .gitattributes other

will work as expected, while

   rm .gitattributes other
   git-checkout-index -f other .gitattributes

will not. The problem in the second case is that .gitattributes
is not yet present when it is needed.

The second case could be fixed by ordering files such that
all .gitattributes are checked out before any other file. But
this is perhaps too expensive and not really needed. If the user
deliberately chooses to checkout .gitattributes after another
file, he will not benefit from the attr machinery.

However, for checkout-index --all we should fix the problem,
which is done by the next patch, building on top of this one.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 attr.c |   58 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 42 insertions(+), 16 deletions(-)

This together with the patch that follows fixes a problem, which
is most likely to bite Windows users. I recognized it by setting
autocrlf globally to true and doing a fresh checkout of msysgit.
The checkout contained etc/termcap converted to CRLF, although
is was marked as '-crlf' in etc/.gitattributes.

If we believe autocrlf is a reasonable default for Windows users,
we really should use it ourselves, to find such problems. 

The fixed problem is not really critical but may be quite annoying,
and complex to understand.

    Steffen

diff --git a/attr.c b/attr.c
index a071254..e942f6c 100644
--- a/attr.c
+++ b/attr.c
@@ -383,6 +383,18 @@ static void bootstrap_attr_stack(void)
 	}
 }
 
+static int ends_with_gitattributes (const char* path)
+{
+	int attributes_len = strlen (GITATTRIBUTES_FILE);
+	int path_len = strlen (path);
+	if (path_len >= attributes_len
+	     && strcmp (path + path_len - attributes_len, GITATTRIBUTES_FILE) == 0)
+	{
+		return 1;
+	}
+	return 0;
+}
+
 static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
@@ -430,23 +442,37 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
 	/*
 	 * Read from parent directories and push them down
+	 *
+	 * But don't try to read if path ends with .gitattributes.
+	 * In this case we could fail and record no attributes for
+	 * a directory. We better wait and see if we need the
+	 * attributes later.
+	 *
+	 * We skip all .gitattributes, even in higher directories.
+	 * Thus, we can checkout all .gitattributes in any order
+	 * before the attr machinery starts to work. .gitattributes
+	 * should not be controlled by .gitattributes in the working
+	 * tree anyway.
+	 *
 	 */
-	while (1) {
-		char *cp;
-
-		len = strlen(attr_stack->origin);
-		if (dirlen <= len)
-			break;
-		memcpy(pathbuf, path, dirlen);
-		memcpy(pathbuf + dirlen, "/", 2);
-		cp = strchr(pathbuf + len + 1, '/');
-		strcpy(cp + 1, GITATTRIBUTES_FILE);
-		elem = read_attr_from_file(pathbuf, 0);
-		*cp = '\0';
-		elem->origin = strdup(pathbuf);
-		elem->prev = attr_stack;
-		attr_stack = elem;
-		debug_push(elem);
+	if (!ends_with_gitattributes (path)) {
+		while (1) {
+			char *cp;
+
+			len = strlen(attr_stack->origin);
+			if (dirlen <= len)
+				break;
+			memcpy(pathbuf, path, dirlen);
+			memcpy(pathbuf + dirlen, "/", 2);
+			cp = strchr(pathbuf + len + 1, '/');
+			strcpy(cp + 1, GITATTRIBUTES_FILE);
+			elem = read_attr_from_file(pathbuf, 0);
+			*cp = '\0';
+			elem->origin = strdup(pathbuf);
+			elem->prev = attr_stack;
+			attr_stack = elem;
+			debug_push(elem);
+		}
 	}
 
 	/*
-- 
1.5.3.rc4.96.g6ceb
