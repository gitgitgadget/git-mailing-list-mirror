From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Wed, 30 Apr 2008 11:10:47 -0400
Message-ID: <20080430151047.GA3482@sigill.intra.peff.net>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com> <20080430145017.GA922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 17:12:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrDyA-0005y4-AA
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 17:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114AbYD3PKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbYD3PKv
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 11:10:51 -0400
Received: from peff.net ([208.65.91.99]:2770 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755510AbYD3PKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 11:10:50 -0400
Received: (qmail 19296 invoked by uid 111); 30 Apr 2008 15:10:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Apr 2008 11:10:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Apr 2008 11:10:47 -0400
Content-Disposition: inline
In-Reply-To: <20080430145017.GA922@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80839>

On Wed, Apr 30, 2008 at 10:50:17AM -0400, Jeff King wrote:

> It segfaults for me, since you try to strdup NULL. I think you want to
> return "" if there is no initial commit, so you can strcmp against the
> current committer (or alternatively, explicitly check for NULL).
> [...]
>     IOW, put in a blank line on either side, but not between the two
>     identities if both are shown.

Fixes for these are below (no commit message; I think you should respin
the series rather than making this a separate patch). I didn't look at
putting it into wt-status.c, but I think that is worth pursuing.

---
 builtin-commit.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 30828c5..4e62510 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -472,6 +472,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 	const char *author_ident;
 	const char *committer_ident;
 	const char *parent_ident;
+	int showed_ident = 0;
 
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -582,15 +583,20 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 					 getenv("GIT_COMMITTER_EMAIL")));
 		if (strcmp(author_ident, committer_ident))
 			fprintf(fp,
-				"# Author:    %s\n",
+				"%s# Author:    %s\n",
+				showed_ident++ ? "" : "#\n",
 				fmt_name(author_name, author_email));
 
-		parent_ident = xstrdup(get_parent_ident());
-		if (strcmp(parent_ident, committer_ident))
+		parent_ident = get_parent_ident();
+		if (!parent_ident || strcmp(parent_ident, committer_ident))
 			fprintf(fp,
-				"# Committer: %s\n",
+				"%s# Committer: %s\n",
+				showed_ident++ ? "" : "#\n",
 				committer_ident);
 
+		if (showed_ident)
+			fprintf(fp, "#\n");
+
 		saved_color_setting = wt_status_use_color;
 		wt_status_use_color = 0;
 		commitable = run_status(fp, index_file, prefix, 1);
-- 
1.5.5.1.183.g593d89.dirty
