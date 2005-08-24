From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Rationalize output selection in rev-parse.
Date: Wed, 24 Aug 2005 14:40:24 -0700
Message-ID: <7vek8jc8tz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org>
	<7v4q9fdv5w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508241200500.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:40:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E82z0-0005fz-0q
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 23:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHXVk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 17:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVHXVk1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 17:40:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35746 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932283AbVHXVk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 17:40:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824214024.PQD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 17:40:24 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7732>

Earlier rounds broke 'whatchanged -p'.  In attempting to fix this,
make two axis of output selection in rev-parse orthogonal:

  --revs-only	tells it not to output things that are not revisions nor
		flags that rev-list would take.
  --no-revs	tells it not to output things that are revisions or
		flags that rev-list would take.
  --flags	tells it not to output parameters that do not start with
		a '-'.
  --no-flags	tells it not to output parameters that starts with a '-'.

So for example 'rev-parse --no-revs -p arch/i386' would yield '-p arch/i386',
while 'rev-parse --no-revs --flags -p arch/i386' would give just '-p'.

Also the meaning of --verify has been made stronger.  It now rejects
anything but a single valid rev argument.  Earlier it passed some flags
through without complaining.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Linus Torvalds <torvalds@osdl.org> writes:

  > Fair enough. However, there are two kinds of flags: the
  > "revision flags", and the "-p" kind of flags.
  >
  > And the problem was that "git-whatchanged -p" didn't work any more,
  > because we passed "-p" along to "git-rev-list". Gaah.

  Thanks for noticing.

 rev-parse.c |  121 ++++++++++++++++++++++++++---------------------------------
 1 files changed, 54 insertions(+), 67 deletions(-)

4866ccf0f434db118c4dcdeeab840eb4844d50a4
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -7,20 +7,21 @@
 #include "commit.h"
 #include "refs.h"
 
+#define DO_REVS		1
+#define DO_NOREV	2
+#define DO_FLAGS	4
+#define DO_NONFLAGS	8
+static int filter = ~0;
+
 static char *def = NULL;
-static int no_revs = 0;
-static int single_rev = 0;
-static int revs_only = 0;
-static int do_rev_argument = 1;
-static int output_revs = 0;
-static int flags_only = 0;
-static int no_flags = 0;
-static int output_sq = 0;
-static int symbolic = 0;
 
 #define NORMAL 0
 #define REVERSED 1
 static int show_type = NORMAL;
+static int symbolic = 0;
+static int output_sq = 0;
+
+static int revs_count = 0;
 
 /*
  * Some arguments are relevant "revision" arguments,
@@ -30,13 +31,19 @@ static int show_type = NORMAL;
 static int is_rev_argument(const char *arg)
 {
 	static const char *rev_args[] = {
-		"--max-count=",
+		"--bisect",
+		"--header",
 		"--max-age=",
-		"--min-age=",
+		"--max-count=",
 		"--merge-order",
-		"--topo-order",
-		"--bisect",
+		"--min-age=",
 		"--no-merges",
+		"--objects",
+		"--parents",
+		"--pretty",
+		"--show-breaks",
+		"--topo-order",
+		"--unpacked",
 		NULL
 	};
 	const char **p = rev_args;
@@ -47,11 +54,13 @@ static int is_rev_argument(const char *a
 		if (!str)
 			return 0;
 		len = strlen(str);
-		if (!strncmp(arg, str, len))
+		if (!strcmp(arg, str) ||
+		    (str[len-1] == '=' && !strncmp(arg, str, len)))
 			return 1;
 	}
 }
 
+/* Output argument as a string, either SQ or normal */
 static void show(const char *arg)
 {
 	if (output_sq) {
@@ -70,11 +79,13 @@ static void show(const char *arg)
 		puts(arg);
 }
 
+/* Output a revision, only if filter allows it */
 static void show_rev(int type, const unsigned char *sha1, const char *name)
 {
-	if (no_revs)
+	if (!(filter & DO_REVS))
 		return;
-	output_revs++;
+	def = NULL;
+	revs_count++;
 
 	if (type != show_type)
 		putchar('^');
@@ -84,29 +95,12 @@ static void show_rev(int type, const uns
 		show(sha1_to_hex(sha1));
 }
 
-static void show_rev_arg(char *rev)
+/* Output a flag, only if filter allows it. */
+static void show_flag(char *arg)
 {
-	if (no_revs)
+	if (!(filter & DO_FLAGS))
 		return;
-	show(rev);
-}
-
-static void show_norev(char *norev)
-{
-	if (flags_only)
-		return;
-	if (revs_only)
-		return;
-	show(norev);
-}
-
-static void show_arg(char *arg)
-{
-	if (no_flags)
-		return;
-	if (do_rev_argument && is_rev_argument(arg))
-		show_rev_arg(arg);
-	else
+	if (filter & (is_rev_argument(arg) ? DO_REVS : DO_NOREV))
 		show(arg);
 }
 
@@ -122,7 +116,6 @@ static void show_default(void)
 			show_rev(NORMAL, sha1, s);
 			return;
 		}
-		show_norev(s);
 	}
 }
 
@@ -134,7 +127,7 @@ static int show_reference(const char *re
 
 int main(int argc, char **argv)
 {
-	int i, as_is = 0;
+	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
 	const char *prefix = setup_git_directory();
 	
@@ -143,15 +136,13 @@ int main(int argc, char **argv)
 		char *dotdot;
 	
 		if (as_is) {
-			show_norev(arg);
+			show(arg);
 			continue;
 		}
 		if (*arg == '-') {
 			if (!strcmp(arg, "--")) {
-				show_default();
-				if (revs_only || flags_only)
-					break;
 				as_is = 1;
+				continue;
 			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[i+1];
@@ -159,25 +150,24 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(arg, "--revs-only")) {
-				revs_only = 1;
+				filter &= ~DO_NOREV;
 				continue;
 			}
 			if (!strcmp(arg, "--no-revs")) {
-				no_revs = 1;
+				filter &= ~DO_REVS;
 				continue;
 			}
 			if (!strcmp(arg, "--flags")) {
-				flags_only = 1;
+				filter &= ~DO_NONFLAGS;
 				continue;
 			}
 			if (!strcmp(arg, "--no-flags")) {
-				no_flags = 1;
+				filter &= ~DO_FLAGS;
 				continue;
 			}
 			if (!strcmp(arg, "--verify")) {
-				revs_only = 1;
-				do_rev_argument = 0;
-				single_rev = 1;
+				filter &= ~(DO_FLAGS|DO_NOREV);
+				verify = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
@@ -197,12 +187,17 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(arg, "--show-prefix")) {
-				puts(prefix);
+				if (prefix)
+					puts(prefix);
 				continue;
 			}
-			show_arg(arg);
+			if (verify)
+				die("Needed a single revision");
+			show_flag(arg);
 			continue;
 		}
+
+		/* Not a flag argument */
 		dotdot = strstr(arg, "..");
 		if (dotdot) {
 			unsigned char end[20];
@@ -212,9 +207,6 @@ int main(int argc, char **argv)
 				if (!*n)
 					n = "HEAD";
 				if (!get_sha1(n, end)) {
-					if (no_revs)
-						continue;
-					def = NULL;
 					show_rev(NORMAL, end, n);
 					show_rev(REVERSED, sha1, arg);
 					continue;
@@ -223,26 +215,21 @@ int main(int argc, char **argv)
 			*dotdot = '.';
 		}
 		if (!get_sha1(arg, sha1)) {
-			if (no_revs)
-				continue;
-			def = NULL;
 			show_rev(NORMAL, sha1, arg);
 			continue;
 		}
 		if (*arg == '^' && !get_sha1(arg+1, sha1)) {
-			if (no_revs)
-				continue;
-			def = NULL;
 			show_rev(REVERSED, sha1, arg+1);
 			continue;
 		}
-		show_default();
-		show_norev(arg);
+		if (verify)
+			die("Needed a single revision");
+		if ((filter & (DO_NONFLAGS|DO_NOREV)) ==
+		    (DO_NONFLAGS|DO_NOREV))
+			show(arg);
 	}
 	show_default();
-	if (single_rev && output_revs != 1) {
-		fprintf(stderr, "Needed a single revision\n");
-		exit(1);
-	}
+	if (verify && revs_count != 1)
+		die("Needed a single revision");
 	return 0;
 }
