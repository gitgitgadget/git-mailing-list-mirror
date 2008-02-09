From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH] Ignore duplicated slashes in git-log
Date: Sat, 9 Feb 2008 13:54:57 +0100
Message-ID: <20080209125457.GA5686@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 14:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpUk-0002C2-9p
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYBINLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbYBINLR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:11:17 -0500
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:47176 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYBINLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:11:16 -0500
X-Greylist: delayed 976 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2008 08:11:16 EST
Received: from out.alice-dsl.de ([192.168.125.60]) by smtp-out01.alice-dsl.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 9 Feb 2008 13:48:37 +0100
Received: from basil.firstfloor.org ([78.53.156.214]) by out.alice-dsl.de with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 9 Feb 2008 13:48:37 +0100
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 0FCCD1B41CF; Sat,  9 Feb 2008 13:54:57 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 09 Feb 2008 12:48:37.0697 (UTC) FILETIME=[16DD1B10:01C86B1A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73220>


When I use git-log ... path/name  I seem to regularly
typo path/name as path//name (with duplicated slashes)
The normal kernel ignores these duplicated slashes
according to POSIX so it's typically no problem, but git 
fails and cannot find the correct file name when this
happens.

This patch fixes this case for git-log at least, by
handling duplicated slashes as a single slash. I probably
didn't change all places where file names are parsed
in the source base, but this seems to be a relatively common
place used by several sub commands. And at least for me
fixing git-log is the most important case anyways.

Patch against git 1.5.4

-Andi

diff -u git-1.5.4/setup.c-o git-1.5.4/setup.c
--- git-1.5.4/setup.c-o	2008-02-09 13:35:21.000000000 +0100
+++ git-1.5.4/setup.c	2008-02-09 13:47:53.000000000 +0100
@@ -7,6 +7,11 @@
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
+	char *s;
+
+	while ((s = strstr(path, "//")) != NULL)
+		memmove(s, s + 1, strlen(s));
+
 	for (;;) {
 		char c;
 		if (*path != '.')
