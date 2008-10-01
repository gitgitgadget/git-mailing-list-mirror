From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Wed, 1 Oct 2008 18:31:25 -0400
Message-ID: <20081001223125.GA25267@coredump.intra.peff.net>
References: <20081001154425.GE21310@spearce.org> <48E3E66E.7020501@op5.se> <20081001220604.GB18058@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 02 00:32:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlAFL-0001S6-Ck
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 00:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbYJAWb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 18:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbYJAWb3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 18:31:29 -0400
Received: from peff.net ([208.65.91.99]:3093 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752884AbYJAWb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 18:31:28 -0400
Received: (qmail 22275 invoked by uid 111); 1 Oct 2008 22:31:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 18:31:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 18:31:25 -0400
Content-Disposition: inline
In-Reply-To: <20081001220604.GB18058@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97277>

On Wed, Oct 01, 2008 at 06:06:04PM -0400, Jeff King wrote:

> I think I still like your other proposal:
> 
>   [branch] created b930c4a: "i386: Snib the sprock"

And here is the patch, since it was sitting uncommitted in my working
tree. Feel free to ignore.

BTW, we should apply _something_ since what is currently in next has a
bug: it lacks a space between "DETACHED commit" and the hash:

  Created DETACHED commit4fde0d0 (subject line)

-- >8 --
reformat informational commit message

When committing, we print a message like:

  Created [DETACHED commit] <hash> (<subject>) on <branch>

The most useful bit of information there (besides the
detached status, if it is present) is which branch you made
the commit on. However,  it is sometimes hard to see because
the subject dominates the line.

Instead, let's put the most useful information (detached
status and commit branch) on the far left, with the subject
(which is least likely to be interesting) on the far right.

We'll use brackets to offset the branch name so the line is
not mistaken for an error line of the form "program: some
sort of error". E.g.,:

  [jk/bikeshed] created bd8098f: "reformat informational commit message"
---
 builtin-commit.c |   37 ++++++++++---------------------------
 1 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e4e1448..7a66e5a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -878,35 +878,13 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	return commitable ? 0 : 1;
 }
 
-static char *get_commit_format_string(void)
-{
-	unsigned char sha[20];
-	const char *head = resolve_ref("HEAD", sha, 0, NULL);
-	struct strbuf buf = STRBUF_INIT;
-
-	/* use shouty-caps if we're on detached HEAD */
-	strbuf_addf(&buf, "format:%s", strcmp("HEAD", head) ? "" : "DETACHED commit");
-	strbuf_addstr(&buf, "%h (%s)");
-
-	if (!prefixcmp(head, "refs/heads/")) {
-		const char *cp;
-		strbuf_addstr(&buf, " on ");
-		for (cp = head + 11; *cp; cp++) {
-			if (*cp == '%')
-				strbuf_addstr(&buf, "%x25");
-			else
-				strbuf_addch(&buf, *cp);
-		}
-	}
-
-	return strbuf_detach(&buf, NULL);
-}
-
 static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	char *format = get_commit_format_string();
+	static const char *format = "format:%h: \"%s\"";
+	unsigned char junk_sha1[20];
+	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
 
 	commit = lookup_commit(sha1);
 	if (!commit)
@@ -931,7 +909,13 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	printf("Created %s", initial_commit ? "root-commit " : "");
+	printf("[%s%s]: created ",
+		!prefixcmp(head, "refs/heads/") ?
+			head + 11 :
+			!strcmp(head, "HEAD") ?
+				"detached HEAD" :
+				head,
+		initial_commit ? " (root-commit)" : "");
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
@@ -939,7 +923,6 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		printf("%s\n", buf.buf);
 		strbuf_release(&buf);
 	}
-	free(format);
 }
 
 static int git_commit_config(const char *k, const char *v, void *cb)
-- 
1.6.0.2.570.g2c958
