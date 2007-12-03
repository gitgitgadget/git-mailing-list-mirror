From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC] Use regex for :/ matching
Date: Sun, 2 Dec 2007 23:32:58 -0500
Message-ID: <20071203043258.GA16658@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 05:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz2zk-0006Hf-Sp
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 05:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbXLCEdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 23:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbXLCEdD
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 23:33:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbXLCEdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 23:33:01 -0500
Received: (qmail 25966 invoked by uid 111); 3 Dec 2007 04:32:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 23:32:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 23:32:58 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66858>

The sha1 syntax :/ used to be a strict prefix match.
Instead, let's use a regular expression, which can save on
typing. E.g.,

  git show :/"object name: introduce ':/<oneline prefix>'"

vs

  git show :/introduce..:/.oneline

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this changes the semantics of existing queries.
Specifically:

  - regex metacharacters are now interpreted
  - the pattern is no longer anchored at the start

I find it much more useful than the original, but perhaps it deserves
its own syntax instead?

I also considered that it might be much slower than the original, but it
is not:

  # original
  $ time git log :/notfound >/dev/null
  real    0m1.055s
  user    0m1.020s
  sys     0m0.024s

  # regex
  $ time git log :/notfound >/dev/null
  real    0m1.065s
  user    0m1.028s
  sys     0m0.036s

Curiously, both are much slower than --grep:

  $ time git log --grep=notfound >/dev/null
  real    0m0.677s
  user    0m0.640s
  sys     0m0.036s

And finally, if accepted, a followup patch should change the "prefix"
variable to "search" or similar; putting it in here made the diff a bit
noisy.

 Documentation/git-rev-parse.txt |    4 ++--
 sha1_name.c                     |   25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 329fce0..41dd684 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -208,8 +208,8 @@ blobs contained in a commit.
   and dereference the tag recursively until a non-tag object is
   found.
 
-* A colon, followed by a slash, followed by a text: this names
-  a commit whose commit message starts with the specified text.
+* A colon, followed by a slash, followed by a regular expression: this names
+  a commit whose commit message starts with a line matching the expression.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
diff --git a/sha1_name.c b/sha1_name.c
index d364244..2ad91a3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -588,8 +588,8 @@ static int handle_one_ref(const char *path,
 
 /*
  * This interprets names like ':/Initial revision of "git"' by searching
- * through history and returning the first commit whose message starts
- * with the given string.
+ * through history and returning the first commit whose first line
+ * matches the given regex.
  *
  * For future extension, ':/!' is reserved. If you want to match a message
  * beginning with a '!', you have to repeat the exclamation mark.
@@ -600,12 +600,22 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 {
 	struct commit_list *list = NULL, *backup = NULL, *l;
 	int retval = -1;
+	regex_t re;
+	int r;
 
 	if (prefix[0] == '!') {
 		if (prefix[1] != '!')
 			die ("Invalid search pattern: %s", prefix);
 		prefix++;
 	}
+
+	r = regcomp(&re, prefix, REG_NOSUB);
+	if (r != 0) {
+		char errbuf[256];
+		regerror(r, &re, errbuf, sizeof(errbuf));
+		return error("unable to compile regex: %s", errbuf);
+	}
+
 	if (!save_commit_buffer)
 		return error("Could not expand oneline-name.");
 	for_each_ref(handle_one_ref, &list);
@@ -613,13 +623,21 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 		commit_list_insert(l->item, &backup);
 	while (list) {
 		char *p;
+		char *end;
 		struct commit *commit;
 
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		parse_object(commit->object.sha1);
 		if (!commit->buffer || !(p = strstr(commit->buffer, "\n\n")))
 			continue;
-		if (!prefixcmp(p + 2, prefix)) {
+		p += 2;
+		end = strchr(p, '\n');
+		if (end)
+			*end = '\0';
+		r = regexec(&re, p, 0, NULL, 0);
+		if (end)
+			*end = '\n';
+		if (r == 0) {
 			hashcpy(sha1, commit->object.sha1);
 			retval = 0;
 			break;
@@ -628,6 +646,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	free_commit_list(list);
 	for (l = backup; l; l = l->next)
 		clear_commit_marks(l->item, ONELINE_SEEN);
+	regfree(&re);
 	return retval;
 }
 
-- 
1.5.3.7.2068.g5949-dirty
