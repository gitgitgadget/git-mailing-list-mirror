From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix "--abbrev=xyz" for revision listing
Date: Sat, 27 May 2006 12:24:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605271218310.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 27 21:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk4Ot-0001ek-8T
	for gcvg-git@gmane.org; Sat, 27 May 2006 21:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWE0TYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 15:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWE0TYg
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 15:24:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964946AbWE0TYg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 15:24:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4RJOV2g022247
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 May 2006 12:24:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4RJOVTE015402;
	Sat, 27 May 2006 12:24:31 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20870>


The revision argument parsing was happily parsing "--abbrev", but it 
didn't parse "--abbrev=<n>".

Which was hidden by the fact that the diff options _would_ parse 
--abbrev=<n>, so it would actually silently parse it, it just 
wouldn't use it for the same things that a plain "--abbrev" was 
used for.

Which seems a bit insane.

With this patch, if you do "git log --abbrev=10" it will abbreviate the 
merge parent commit ID's to ten hex characters, which was probably what 
you expected.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/revision.c b/revision.c
index 2294b16..42c077a 100644
--- a/revision.c
+++ b/revision.c
@@ -733,6 +733,14 @@ int setup_revisions(int argc, const char
 				revs->abbrev = DEFAULT_ABBREV;
 				continue;
 			}
+			if (!strncmp(arg, "--abbrev=", 9)) {
+				revs->abbrev = strtoul(arg + 9, NULL, 10);
+				if (revs->abbrev < MINIMUM_ABBREV)
+					revs->abbrev = MINIMUM_ABBREV;
+				else if (revs->abbrev > 40)
+					revs->abbrev = 40;
+				continue;
+			}
 			if (!strcmp(arg, "--abbrev-commit")) {
 				revs->abbrev_commit = 1;
 				continue;
