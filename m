From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Sat, 19 Jul 2008 11:32:45 +0200
Message-ID: <200807191132.45648.johannes.sixt@telecom.at>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at> <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at> <7vk5fi67dx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 11:34:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK8pV-0006LC-0A
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 11:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYGSJcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 05:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYGSJcu
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 05:32:50 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:52345 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYGSJct (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 05:32:49 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 832C3BEEA1;
	Sat, 19 Jul 2008 11:32:46 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BAD181D3D4;
	Sat, 19 Jul 2008 11:32:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vk5fi67dx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89105>

On Samstag, 19. Juli 2008, Junio C Hamano wrote:
> Ok, but the surrounding code in this function look very suspicious.

How about this then?

-- snip --
builtin-clone: Rewrite guess_dir_name()

The function has to do three small and independent tasks, but all of them
were crammed into a single loop. This rewrites the function entirely by
unrolling these tasks.

We also now use is_dir_sep(c) instead of c == '/' to increase portability,
which actually was the primary reason to touch this code.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-clone.c |   55 ++++++++++++++++++++++++++-----------------------------
 1 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 8112716..91667d5 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -95,35 +95,32 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 
 static char *guess_dir_name(const char *repo, int is_bundle)
 {
-	const char *p, *start, *end, *limit;
-	int after_slash_or_colon;
-
-	/* Guess dir name from repository: strip trailing '/',
-	 * strip trailing '[:/]*.{git,bundle}', strip leading '.*[/:]'. */
-
-	after_slash_or_colon = 1;
-	limit = repo + strlen(repo);
-	start = repo;
-	end = limit;
-	for (p = repo; p < limit; p++) {
-		const char *prefix = is_bundle ? ".bundle" : ".git";
-		if (!prefixcmp(p, prefix)) {
-			if (!after_slash_or_colon)
-				end = p;
-			p += strlen(prefix) - 1;
-		} else if (!prefixcmp(p, ".bundle")) {
-			if (!after_slash_or_colon)
-				end = p;
-			p += 7;
-		} else if (*p == '/' || *p == ':') {
-			if (end == limit)
-				end = p;
-			after_slash_or_colon = 1;
-		} else if (after_slash_or_colon) {
-			start = p;
-			end = limit;
-			after_slash_or_colon = 0;
-		}
+	const char *end = repo + strlen(repo), *start, *dot;
+
+	/*
+	 * Strip trailing slashes
+	 */
+	while (repo < end && is_dir_sep(end[-1]))
+		end--;
+
+	/*
+	 * Find last component, but be prepared that repo could have
+	 * the form  "remote.example.com:foo.git", i.e. no slash
+	 * in the directory part.
+	 */
+	start = end;
+	while (repo < start && !is_dir_sep(start[-1]) && start[-1] != ':')
+		start--;
+
+	/*
+	 * Strip .{bundle,git}.
+	 */
+	if (is_bundle) {
+		if (end - start > 7 && !strcmp(end - 7, ".bundle"))
+			end -= 7;
+	} else {
+		if (end - start > 4 && !strcmp(end - 4, ".git"))
+			end -= 4;
 	}
 
 	return xstrndup(start, end - start);
-- 
1.5.6.3.443.g5f70e
