From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] checkout-index: allow checking out from higher stages.
Date: Wed, 07 Dec 2005 02:01:39 -0800
Message-ID: <7vwtihted8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 11:03:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejw7X-0006Rg-FY
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 11:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVLGKBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 05:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVLGKBm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 05:01:42 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35296 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750767AbVLGKBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 05:01:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207100017.TRGL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 05:00:17 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13321>

The new option, --stage=<n>, lets you copy out from an unmerged,
higher stage.  This is to help the new merge world order during
a nontrivial merge.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-checkout-index.txt |    6 +++
 checkout-index.c                     |   61 ++++++++++++++++++++++++----------
 2 files changed, 48 insertions(+), 19 deletions(-)

3bd348aeea24709cd9be4b9d741f79b6014cd7e3
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 97eef22..9f32c65 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -9,7 +9,7 @@ git-checkout-index - Copy files from the
 SYNOPSIS
 --------
 'git-checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
-	           [--] <file>...
+	[--stage=<number>] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -40,6 +40,10 @@ OPTIONS
 	When creating files, prepend <string> (usually a directory
 	including a trailing /)
 
+--stage=<number>::
+	Instead of checking out unmerged entries, copy out the
+	files from named stage.  <number> must be between 1 and 3.
+
 --::
 	Do not interpret any more arguments as options.
 
diff --git a/checkout-index.c b/checkout-index.c
index f1e716d..1e1c972 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -36,6 +36,7 @@
 
 static const char *prefix;
 static int prefix_length;
+static int checkout_stage; /* default to checkout stage0 */
 
 static struct checkout state = {
 	.base_dir = "",
@@ -48,20 +49,36 @@ static struct checkout state = {
 
 static int checkout_file(const char *name)
 {
-	int pos = cache_name_pos(name, strlen(name));
-	if (pos < 0) {
-		if (!state.quiet) {
-			pos = -pos - 1;
-			fprintf(stderr,
-				"git-checkout-index: %s is %s.\n",
-				name,
-				(pos < active_nr &&
-				 !strcmp(active_cache[pos]->name, name)) ?
-				"unmerged" : "not in the cache");
-		}
-		return -1;
+	int namelen = strlen(name);
+	int pos = cache_name_pos(name, namelen);
+	int has_same_name = 0;
+
+	if (pos < 0)
+		pos = -pos - 1;
+
+	while (pos < active_nr) {
+		struct cache_entry *ce = active_cache[pos];
+		if (ce_namelen(ce) != namelen &&
+		    memcmp(ce->name, name, namelen))
+			break;
+		has_same_name = 1;
+		if (checkout_stage == ce_stage(ce))
+			return checkout_entry(ce, &state);
+		pos++;
+	}
+
+	if (!state.quiet) {
+		fprintf(stderr, "git-checkout-index: %s ", name);
+		if (!has_same_name)
+			fprintf(stderr, "is not in the cache");
+		else if (checkout_stage)
+			fprintf(stderr, "does not exist at stage %d",
+				checkout_stage);
+		else
+			fprintf(stderr, "is unmerged");
+		fputc('\n', stderr);
 	}
-	return checkout_entry(active_cache[pos], &state);
+	return -1;
 }
 
 static int checkout_all(void)
@@ -70,11 +87,11 @@ static int checkout_all(void)
 
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
-		if (ce_stage(ce))
+		if (ce_stage(ce) != checkout_stage)
 			continue;
 		if (prefix && *prefix &&
-		    ( ce_namelen(ce) <= prefix_length ||
-		      memcmp(prefix, ce->name, prefix_length) ))
+		    (ce_namelen(ce) <= prefix_length ||
+		     memcmp(prefix, ce->name, prefix_length)))
 			continue;
 		if (checkout_entry(ce, &state) < 0)
 			errs++;
@@ -88,7 +105,7 @@ static int checkout_all(void)
 }
 
 static const char checkout_cache_usage[] =
-"git-checkout-index [-u] [-q] [-a] [-f] [-n] [--prefix=<string>] [--] <file>...";
+"git-checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]] [--prefix=<string>] [--] <file>...";
 
 static struct cache_file cache_file;
 
@@ -138,11 +155,19 @@ int main(int argc, char **argv)
 				die("cannot open index.lock file.");
 			continue;
 		}
-		if (!memcmp(arg, "--prefix=", 9)) {
+		if (!strncmp(arg, "--prefix=", 9)) {
 			state.base_dir = arg+9;
 			state.base_dir_len = strlen(state.base_dir);
 			continue;
 		}
+		if (!strncmp(arg, "--stage=", 8)) {
+			int ch = arg[8];
+			if ('1' <= ch && ch <= '3')
+				checkout_stage = arg[8] - '0';
+			else
+				die("stage should be between 1 and 3");
+			continue;
+		}
 		if (arg[0] == '-')
 			usage(checkout_cache_usage);
 		break;
-- 
0.99.9.GIT
