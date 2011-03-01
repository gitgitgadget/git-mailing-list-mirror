From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] rerere forget: deprecate invocation without pathspec
Date: Tue, 01 Mar 2011 14:21:05 +0100
Message-ID: <4D6CF2C1.9070805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 14:21:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuPVr-00069N-Bv
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 14:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab1CANVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 08:21:10 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:41152 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1CANVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 08:21:09 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PuPVi-0008Gw-7Q
	for git@vger.kernel.org; Tue, 01 Mar 2011 14:21:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EDC061660F
	for <git@vger.kernel.org>; Tue,  1 Mar 2011 14:21:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168219>

From: Johannes Sixt <j6t@kdbg.org>

rerere forget is a destructive command. When invoked without a path, it
operates on the current directory, potentially deleting many recorded
conflict resolutions.

To make the command safer, a path must be specified as of git 1.8.0. Until
then, give users time to write 'git rerere forget .' if they really mean
the entire current directory.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I assume that 'rerere forget' is a rarely used command, we can afford
 to change its behavior without a lot of fuzz. Let's not dive into the
 discussion whether it should operate on the current directory or the
 entire repository; rather, require users to be explicit. After all,
 it is destructive!

 BTW, notice that documentation for 'remaining' is missing.

 -- Hannes

 Documentation/git-rerere.txt |    4 ++--
 builtin/rerere.c             |    7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index db99d47..484fdd5 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,7 +7,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 
 SYNOPSIS
 --------
-'git rerere' ['clear'|'forget' [<pathspec>]|'diff'|'status'|'gc']
+'git rerere' ['clear'|'forget' <pathspec>|'diff'|'status'|'gc']
 
 DESCRIPTION
 -----------
@@ -43,7 +43,7 @@ will automatically invoke this command.
 'forget' <pathspec>::
 
 This resets the conflict resolutions which rerere has recorded for the current
-conflict in <pathspec>.  The <pathspec> is optional.
+conflict in <pathspec>.
 
 'diff'::
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 67cbfeb..8235885 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -8,7 +8,7 @@
 #include "xdiff-interface.h"
 
 static const char * const rerere_usage[] = {
-	"git rerere [clear | status | remaining | diff | gc]",
+	"git rerere [clear | forget path... | status | remaining | diff | gc]",
 	NULL,
 };
 
@@ -136,7 +136,10 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		return rerere(flags);
 
 	if (!strcmp(argv[0], "forget")) {
-		const char **pathspec = get_pathspec(prefix, argv + 1);
+		const char **pathspec;
+		if (argc < 2)
+			warning("'git rerere forget' without paths is deprecated");
+		pathspec = get_pathspec(prefix, argv + 1);
 		return rerere_forget(pathspec);
 	}
 
-- 
1.7.4.rc3.76.gfb457d
