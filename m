From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and 'command
 not found'
Date: Tue, 05 Jul 2011 22:41:37 +0200
Message-ID: <4E137701.1020007@elegosoft.com>
References: <1309884564.18513.12.camel@umgah>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Tue Jul 05 22:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeCRT-0007KP-LL
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jul 2011 22:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab1GEUly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 16:41:54 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:56029 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab1GEUlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 16:41:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 05C04DE7C6;
	Tue,  5 Jul 2011 22:41:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yFf1LSlmGdX; Tue,  5 Jul 2011 22:41:47 +0200 (CEST)
Received: from [192.168.1.101] (g230122106.adsl.alicedsl.de [92.230.122.106])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id CB36CDE7C1;
	Tue,  5 Jul 2011 22:41:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
In-Reply-To: <1309884564.18513.12.camel@umgah>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176624>

Hi,

here is a tiny patch; maybe there is a cleaner way doing this.?

-- >8 --

Subject: [PATCH] help_unknown_cmd: do not propose an "unknown" cmd

When executing an external shell script like `git foo` with the following
shebang "#!/usr/bin/not/existing", execvp returns 127 (ENOENT). Since
help_unknown_cmd proposes the use of all external commands similar to
the name of the "unknown" command, it suggests the just failed command
again. Stop it.

Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 help.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 7654f1b..10b98ba 100644
--- a/help.c
+++ b/help.c
@@ -383,12 +383,24 @@ const char *help_unknown_cmd(const char *cmd)
 
 	fprintf(stderr, "git: '%s' is not a git command. See 'git --help'.\n", cmd);
 
-	if (SIMILAR_ENOUGH(best_similarity)) {
+	if (n==1 && !strcmp(cmd, main_cmds.names[0]->name))
+		;
+		/*
+		 * This avoids proposing the use of a command
+		 * which apparently just didn't work, e.g.
+		 * when executing a shell script git-foo with
+		 * the following shebang:
+		 *
+		 * 	#!/usr/bin/not/here
+		 *
+		 */
+	else if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf(stderr, "\nDid you mean %s?\n",
 			n < 2 ? "this": "one of these");
 
 		for (i = 0; i < n; i++)
-			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
+			if (strcmp(cmd, main_cmds.names[i]->name))
+				fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
 	exit(1);
-- 
1.7.6.132.gdca5
