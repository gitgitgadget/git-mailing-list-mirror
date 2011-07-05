From: Jeff King <peff@peff.net>
Subject: Re: Doesn't disambiguate between 'external command failed' and
 'command not found'
Date: Tue, 5 Jul 2011 19:22:00 -0400
Message-ID: <20110705232200.GD12085@sigill.intra.peff.net>
References: <1309884564.18513.12.camel@umgah>
 <4E137701.1020007@elegosoft.com>
 <20110705231604.GC12085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alex Vandiver <alex@chmrr.net>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 01:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeEwi-0007Vx-Mq
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 01:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab1GEXWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 19:22:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34545
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab1GEXWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 19:22:03 -0400
Received: (qmail 13250 invoked by uid 107); 5 Jul 2011 23:22:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jul 2011 19:22:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jul 2011 19:22:00 -0400
Content-Disposition: inline
In-Reply-To: <20110705231604.GC12085@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176632>

On Tue, Jul 05, 2011 at 07:16:05PM -0400, Jeff King wrote:

> So if you are going to follow this strategy, you are probably better to
> just skip the entry (or give it a high levenshtein distance) in the main
> loop where we calculate candidates.

And here's what that would look like.

diff --git a/help.c b/help.c
index e925ca1..15e6f0b 100644
--- a/help.c
+++ b/help.c
@@ -329,6 +329,11 @@ const char *help_unknown_cmd(const char *cmd)
 		int cmp = 0; /* avoid compiler stupidity */
 		const char *candidate = main_cmds.names[i]->name;
 
+		if (!strcmp(candidate, cmd)) {
+			main_cmds.names[i]->len = SIMILARITY_FLOOR + 1;
+			continue;
+		}
+
 		/* Does the candidate appear in common_cmds list? */
 		while (n < ARRAY_SIZE(common_cmds) &&
 		       (cmp = strcmp(common_cmds[n].name, candidate)) < 0)

I suspect it can create its own brand of confusion, though:

  $ cat `which git-broken`
  #!/bin/bogus
  $ git broken
  git: 'broken' is not a git command. See 'git --help'.

At which point I search through my PATH and confirm that indeed,
"git-broken" _is_ a git command. And I'm left on my own to figure out
that it's a broken #!-line.

So I think I prefer giving some more specific advice. Even if we don't
mention "#!" lines explicitly, saying "This exists, but exec didn't
work" is probably more helpful than pretending it's not there. It gives
clueful people an idea of where to start looking for the problem.

-Peff
