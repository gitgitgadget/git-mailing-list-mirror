From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Doesn't disambiguate between 'external command failed' and 'command
 not found'
Date: Fri, 08 Jul 2011 12:08:49 +0200
Message-ID: <4E16D731.5020904@elegosoft.com>
References: <1309884564.18513.12.camel@umgah> <4E137701.1020007@elegosoft.com> <20110705231604.GC12085@sigill.intra.peff.net> <4E144B55.8020907@elegosoft.com> <20110706175803.GB17978@sigill.intra.peff.net> <20110706180026.GC17978@sigill.intra.peff.net> <7vei23htzz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 12:09:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qf7zg-0005lb-BY
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 12:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab1GHKJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 06:09:01 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:49648 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866Ab1GHKJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 06:09:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id CFB7ADE81B;
	Fri,  8 Jul 2011 12:08:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8wdaWWyVZWg0; Fri,  8 Jul 2011 12:08:55 +0200 (CEST)
Received: from [192.168.1.101] (g225028043.adsl.alicedsl.de [92.225.28.43])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id B7C5FDE80B;
	Fri,  8 Jul 2011 12:08:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110628 Thunderbird/5.0
In-Reply-To: <7vei23htzz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176797>

On 07/07/2011 01:25 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> One minor nit, though. I haven't been paying attention to the progress
>> of the gettext topics, but should this message:
>>
>>> +static const char bad_interpreter_advice[] =
>>> +	"'%s' appears to be a git command, but we were not\n"
>>> +	"able to execute it. Maybe git-%s is broken?";
>>
>> Actually be inside _() for gettext?
> 
> I would mark it with N_() and then the calling site inside die() with _()
> if I were doing this.

Sorry for the delay.

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
index 7654f1b..4219355 100644
--- a/help.c
+++ b/help.c
@@ -302,6 +302,10 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 #define SIMILARITY_FLOOR 7
 #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
 
+static const char bad_interpreter_advice[] =
+	N_("'%s' appears to be a git command, but we were not\n"
+	"able to execute it. Maybe git-%s is broken?");
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
+			die(_(bad_interpreter_advice), cmd, cmd);
+
 		/* Does the candidate appear in common_cmds list? */
 		while (n < ARRAY_SIZE(common_cmds) &&
 		       (cmp = strcmp(common_cmds[n].name, candidate)) < 0)
-- 
1.7.6.132.g91c244.dirty
