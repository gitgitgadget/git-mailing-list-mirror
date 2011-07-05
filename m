From: Jeff King <peff@peff.net>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Tue, 5 Jul 2011 19:16:05 -0400
Message-ID: <20110705231604.GC12085@sigill.intra.peff.net>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 01:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeEqt-0005hE-QO
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 01:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab1GEXQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 19:16:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48108
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab1GEXQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 19:16:09 -0400
Received: (qmail 13211 invoked by uid 107); 5 Jul 2011 23:16:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jul 2011 19:16:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jul 2011 19:16:05 -0400
Content-Disposition: inline
In-Reply-To: <4E137701.1020007@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176631>

On Tue, Jul 05, 2011 at 10:41:37PM +0200, Michael Schubert wrote:

> Subject: [PATCH] help_unknown_cmd: do not propose an "unknown" cmd
> 
> When executing an external shell script like `git foo` with the following
> shebang "#!/usr/bin/not/existing", execvp returns 127 (ENOENT). Since
> help_unknown_cmd proposes the use of all external commands similar to
> the name of the "unknown" command, it suggests the just failed command
> again. Stop it.

Yeah, I don't think we can distinguish "not there" versus "bad
interpreter" just from the exec return. We would have to then search the
PATH to see if the file actually exists.

> -	if (SIMILAR_ENOUGH(best_similarity)) {
> +	if (n==1 && !strcmp(cmd, main_cmds.names[0]->name))
> +		;
> +		/*
> +		 * This avoids proposing the use of a command
> +		 * which apparently just didn't work, e.g.
> +		 * when executing a shell script git-foo with
> +		 * the following shebang:
> +		 *
> +		 * 	#!/usr/bin/not/here
> +		 *
> +		 */
> +	else if (SIMILAR_ENOUGH(best_similarity)) {

This misses the "autocorrect" case just above, which should not
autocorrect a command to itself (and I didn't try, but I assume it makes
more a really slow infinite loop).

So if you are going to follow this strategy, you are probably better to
just skip the entry (or give it a high levenshtein distance) in the main
loop where we calculate candidates.

But I wonder if we can do even better than just omitting it from the
candidates list. I mentioned searching the PATH above; but that is
exactly what load_command_list does to create this candidate list. So I
think the only way we can have an exact match is one of:

  1. There is a race condition. We tried to exec the command, and it was
     missing; meanwhile, another process created the command.

  2. Exec'ing the command returned ENOENT because of a bad interpreter.

Option (1) seems fairly unlikely; so maybe we should give the user some
advice about (2)?

Something like:

diff --git a/help.c b/help.c
index e925ca1..522b2ba 100644
--- a/help.c
+++ b/help.c
@@ -305,6 +305,10 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 #define SIMILARITY_FLOOR 7
 #define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
 
+static const char bad_interpreter_advice[] =
+"'%s' appears to be a git command, but we were not able to\n"
+"execute it. Check the #!-line of the git-%s script.";
+
 const char *help_unknown_cmd(const char *cmd)
 {
 	int i, n, best_similarity = 0;
@@ -329,6 +333,14 @@ const char *help_unknown_cmd(const char *cmd)
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

I'm not all that happy with the advice, though. It's pretty technical
and specific. I'm not sure whether it would be helpful to most users or
not.

-Peff
