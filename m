From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v3] bisect--helper: convert a function in shell to C
Date: Wed, 23 Mar 2016 07:16:06 +0000
Message-ID: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
References: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 08:24:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aid9M-0001fN-1p
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 08:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbcCWHYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 03:24:13 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:39524
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbcCWHYL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 03:24:11 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 03:24:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458717366;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=Su4W+Bq9/+4IvkSByHcNxUxAP9pUHp3SDGd2364xg6E=;
	b=RqWemgYVUb47bDAn8JlyZft+m7CHjhyTolfAMRvahWDyG2clfHuvMsx6HRQBb/S9
	awKyt1My5hmWRcpFBLD1l+aWlZKcultIhSCx67z37RD8WHAaNHBJO/pMzTPg4XOBhba
	gwhVbRLnYYPV/OhE/bPU+IRveVrTsKTlVvGdcXxM=
In-Reply-To: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.23-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289599>

Convert the code literally without changing its design even though it
seems that it is obscure as to the use of comparing revision to different
bisect arguments which seems like a problem in shell because of the way
function arguments are handled.

The argument handling is kind of hard coded right now because it is not
really be meant to be used like this and this is just for testing
purposes whether this new method is as functional as its counter part.
The shell counter part of the method has been retained for historical
purposes.

Also using OPT_CMDMODE() to handle check-term-format and next-all
because these sub commands are independent and error should be shown if used
together and should be handled independently.

This commit reduces the number of failed tests in
t6030-bisect-porcelain.sh and t6041-bisect-submodule.sh

The corresponding shell function is :
https://github.com/git/git/blob/v2.8.0-rc4/git-bisect.sh#L572-L597

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Changes wrt v1:
 - Remove the function declaration
 - Introduce another method one_of() to reduce the clutter in if
 - Add the documentation as to which part should remain untouched
 - Use OPT_CMDMODE() for --check-term-format and --next-all
 - Remove the '=' in git-bisect.sh
 - Respect the coding convention to indent when a line is spread across
   many lines
 - s/its/it is/g
 - Output of tests:
   - t6002 : http://paste.ubuntu.com/15477883/
   - t6030 : http://paste.ubuntu.com/15477887/
   - t6041 : http://paste.ubuntu.com/15477897/
 - Add the comment that a part shouldn't be touched
---
 builtin/bisect--helper.c | 73 ++++++++++++++++++++++++++++++++++++++++++++----
 git-bisect.sh            |  4 +--
 2 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..ab3891c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,30 +2,93 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "refs.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
+	N_("git bisect--helper --check-term-format <term> <revision>"),
 	NULL
 };
 
+static int one_of(const char *term, ...) {
+	va_list matches;
+	const char *match;
+
+	va_start(matches, term);
+	while ((match = va_arg(matches, const char *)) != NULL)
+		if (!strcmp(term, match))
+			return 1;
+
+	va_end(matches);
+
+	return 0;
+}
+
+static int check_term_format(const char *term, const char *revision, int flag) {
+	if (check_refname_format(term, flag))
+		die("'%s' is not a valid term", term);
+
+	if (one_of(term, "help", "start", "skip", "next", "reset", "visualize",
+	    "replay", "log", "run", NULL))
+		die("can't use the builtin command '%s' as a term", term);
+
+	/* In theory, nothing prevents swapping
+	 * completely good and bad, but this situation
+	 * could be confusing and hasn't been tested
+	 * enough. Forbid it for now.
+	 */
+
+	if (!strcmp(term, "bad") || !strcmp(term, "new"))
+		if (strcmp(revision, "bad"))
+			die("can't change the meaning of term '%s'", term);
+
+	if(!strcmp(term, "good") || !strcmp(term, "old"))
+		if (strcmp(revision, "good"))
+			die("can't change the meaning of term '%s'", term);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	int sub_command = 0;
 	int no_checkout = 0;
+
+	enum sub_commands {
+		NEXT_ALL,
+		CHECK_TERM_FMT
+	};
+
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &sub_command,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
+		OPT_CMDMODE(0, "check-term-format", &sub_command,
+			 N_("check the format of the ref"), CHECK_TERM_FMT),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (sub_command == CHECK_TERM_FMT) {
+		if (argc == 2) {
+			if (argv[0] != NULL && argv[1] != NULL)
+				return check_term_format(argv[0], argv[1], 0);
+			else
+				die("no revision or term provided with check_for_term");
+		}
+		else
+			die("--check-term-format expects 2 arguments");
+	}
+
+	if (sub_command != NEXT_ALL && sub_command != CHECK_TERM_FMT)
 		usage_with_options(git_bisect_helper_usage, options);
 
 	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	if (sub_command == NEXT_ALL)
+		return bisect_next_all(prefix, no_checkout);
+
+	return 1;
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..f63b83e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -564,8 +564,8 @@ write_terms () {
 	then
 		die "$(gettext "please use two different terms")"
 	fi
-	check_term_format "$TERM_BAD" bad
-	check_term_format "$TERM_GOOD" good
+	git bisect--helper --check-term-format "$TERM_BAD" bad
+	git bisect--helper --check-term-format "$TERM_GOOD" good
 	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
 }
 

--
https://github.com/git/git/pull/216
