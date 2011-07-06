From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and 'command
 not found'
Date: Wed, 06 Jul 2011 13:47:33 +0200
Message-ID: <4E144B55.8020907@elegosoft.com>
References: <1309884564.18513.12.camel@umgah> <4E137701.1020007@elegosoft.com> <20110705231604.GC12085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Alex Vandiver <alex@chmrr.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:47:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQa8-0001v9-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1GFLrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 07:47:47 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:42630 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983Ab1GFLrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 07:47:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id E0136DE856;
	Wed,  6 Jul 2011 13:47:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwZcRK70T0Uk; Wed,  6 Jul 2011 13:47:41 +0200 (CEST)
Received: from [10.10.10.197] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id EFA93DE855;
	Wed,  6 Jul 2011 13:47:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
In-Reply-To: <20110705231604.GC12085@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176696>


> So if you are going to follow this strategy, you are probably better to
> just skip the entry (or give it a high levenshtein distance) in the main
> loop where we calculate candidates.

Yes.

> But I wonder if we can do even better than just omitting it from the
> candidates list. I mentioned searching the PATH above; but that is
> exactly what load_command_list does to create this candidate list. So I
> think the only way we can have an exact match is one of:
> 
>   1. There is a race condition. We tried to exec the command, and it was
>      missing; meanwhile, another process created the command.
> 
>   2. Exec'ing the command returned ENOENT because of a bad interpreter.
> 
> Option (1) seems fairly unlikely; so maybe we should give the user some
> advice about (2)?

Like this? I've replaced "Check the #!-line of the git-%s script." with
"Maybe git-%s is broken?" to be less technical and specific..

-- >8 --

Subject: [PATCH] help_unknown_cmd: do not propose an "unknown" cmd

When executing an external shell script like `git foo` with the following
shebang "#!/usr/bin/not/existing", execvp returns 127 (ENOENT). Since
help_unknown_cmd proposes the use of all external commands similar to
the name of the "unknown" command, it suggests the just failed command
again. Stop it and give some advice to the user.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Schubert <mschub@elegosoft.com>
---
 help.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/help.c b/help.c
index 7654f1b..a5a0613 100644
--- a/help.c
+++ b/help.c
@@ -302,6 +302,10 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 #define SIMILARITY_FLOOR 7
 #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
 
+static const char bad_interpreter_advice[] =
+	"'%s' appears to be a git command, but we were not\n"
+	"able to execute it. Maybe git-%s is broken?";
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
@@ -326,6 +330,14 @@ const char *help_unknown_cmd(const char *cmd)
 		int cmp = 0; /* avoid compiler stupidity */
 		const char *candidate = main_cmds.names[i]->name;
 
+		/*
+		 * An exact match means we have the command, but
+		 * for some reason exec'ing it gave us ENOENT; probably
+		 * it's a bad interpreter in the #! line.
+		 */
+		if (!strcmp(candidate, cmd))
+			die(bad_interpreter_advice, cmd, cmd);
+
 		/* Does the candidate appear in common_cmds list? */
 		while (n < ARRAY_SIZE(common_cmds) &&
 		       (cmp = strcmp(common_cmds[n].name, candidate)) < 0)
-- 
1.7.6.132.g91c244
