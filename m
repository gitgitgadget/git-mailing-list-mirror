From: Jeff King <peff@peff.net>
Subject: [PATCH] git-remote: show all remotes with "git remote show"
Date: Wed, 9 Apr 2008 11:15:51 -0400
Message-ID: <20080409151551.GA30439@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 09 17:16:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjc2R-0007a0-LP
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 17:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbYDIPPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 11:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbYDIPPz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 11:15:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3592 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbYDIPPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 11:15:54 -0400
Received: (qmail 4322 invoked by uid 111); 9 Apr 2008 15:15:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 11:15:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 11:15:51 -0400
Content-Disposition: inline
In-Reply-To: <20080409145758.GB20874@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79116>

Many other commands use the "no arguments" form to show a
list (e.g., git-branch, git-tag). While we did show all
remotes for just "git remote", we displayed a usage error
for "git remote show" with no arguments. This is
counterintuitive, since by giving it _more_ information, we
get _less_ result.

The usage model can now be thought of as:

  - "git remote show <remote>": show a remote
  - "git remote show": show all remotes
  - "git remote": assume "show"; i.e., shorthand for "git remote show"

Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Apr 09, 2008 at 10:57:58AM -0400, Jeff King wrote:

> > then i tried git-remote show -a (to list all repositories, etc.) - what 
> > i didnt figure out was to show all repositories is to do a simple 
> > "git-remote". I think "git-remote show" should output all repositories, 
> > or at least indicate it in its help line what to do to get such a list. 
> > (for us poor sobs forgetting commandline details ;)
> 
> Yes, just showing the remotes would be consistent with what other
> commands do (e.g., git-branch, git-tag). I'll post a patch in a minute.

And here it is.

 builtin-remote.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d77f10a..06d33e5 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -19,6 +19,8 @@ static const char * const builtin_remote_usage[] = {
 
 static int verbose;
 
+static int show_all(void);
+
 static inline int postfixcmp(const char *string, const char *postfix)
 {
 	int len1 = strlen(string), len2 = strlen(postfix);
@@ -380,8 +382,11 @@ static int show_or_prune(int argc, const char **argv, int prune)
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
-	if (argc < 1)
+	if (argc < 1) {
+		if (!prune)
+			return show_all();
 		usage_with_options(builtin_remote_usage, options);
+	}
 
 	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
-- 
1.5.5.1.g272c
