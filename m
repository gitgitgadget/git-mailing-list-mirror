From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git commit: Repaint the output format bikeshed (again)
Date: Wed, 01 Oct 2008 23:06:54 +0200
Message-ID: <48E3E66E.7020501@op5.se>
References: <20081001154425.GE21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:08:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl8vl-0006Zv-PK
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 23:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYJAVHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 17:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYJAVHI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 17:07:08 -0400
Received: from mail.op5.se ([193.201.96.20]:59709 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbYJAVHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 17:07:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 385E61B80063;
	Wed,  1 Oct 2008 22:58:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.78
X-Spam-Level: 
X-Spam-Status: No, score=-2.78 tagged_above=-10 required=6.6
	tests=[AWL=-0.281, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJrjwLm9Fd13; Wed,  1 Oct 2008 22:58:25 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id CD5711B8005F;
	Wed,  1 Oct 2008 22:58:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001154425.GE21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97269>

Since we want the most important information furthest
left while at the same time preserving valuable screen
estate, we move the branch-name to the leftmost side
of the commit result output. To make it read properly
we get rid of "Created", which I just can't fit into
a sentence without putting the branch-name last.

Having taken inspiration from the "git reset" command,
output for the three conceivable cases now look thus:

  normal commit
  <branch> is now at b930c4a (i386: Snib the sprock)

  detached commit
  DETACHED HEAD is now at b930c4a (i386: Snib the sprock)

  initial commit
  History has begun anew. Root-commit created.
  <branch> is now at bc930c4a (i386: Snib the sprock)

As a nice side-effect, we can get rid of the get_commit_format
helper function and thereby remove more code than we add.

This is a substantial rewrite of a patch originally sent by
Jeff King <peff@peff.net>.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

"Created" is a problem when one wants to put branch-name before the
subject line, because the subject has to follow the hash (it doesn't
describe the pre-state of the branch/detached head), but the newly
added commit. "Created, on branch, hash (subject)" just looks
stilted and stupid, so I had to change it. Hopefully this can be
accepted. If not, count me out.

I'm not sure if the last "else" case setting branch = head; can
ever happen, but I figured it can't hurt to make sure. Feel free
to modify commentary around it or the entire section when applying.

This is based on current next (798a2a426a).

 builtin-commit.c |   47 ++++++++++++++++++-----------------------------
 1 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e4e1448..3b43344 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -878,35 +878,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
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
+	unsigned char head_sha1[20];
+	const char *branch, *head, *format = "format:%h (%s)";
 
 	commit = lookup_commit(sha1);
 	if (!commit)
@@ -931,15 +908,27 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	printf("Created %s", initial_commit ? "root-commit " : "");
+	/* a pretty rare occurrance, so let's celebrate it specially */
+	if (initial_commit)
+		printf("History has begun anew. Root-commit created.\n");
+
+	head = resolve_ref("HEAD", head_sha1, 0, NULL);
+	if (!strcmp(head, "HEAD"))
+		branch = "DETACHED HEAD";
+	else if (!prefixcmp(head, "refs/heads/"))
+		branch = &head[strlen("refs/heads/")];
+	else {
+		/* refs/git-svn, fe */
+		branch = head;
+	}
+
+	printf("%s is now at ", branch);
 
 	if (!log_tree_commit(&rev, commit)) {
 		struct strbuf buf = STRBUF_INIT;
 		format_commit_message(commit, format + 7, &buf, DATE_NORMAL);
-		printf("%s\n", buf.buf);
-		strbuf_release(&buf);
+		printf("%s\n", strbuf_detach(&buf, NULL));
 	}
-	free(format);
 }
 
 static int git_commit_config(const char *k, const char *v, void *cb)
-- 
1.6.0.2.529.g37dbc.dirty
