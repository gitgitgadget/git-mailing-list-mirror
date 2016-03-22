From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 08:01:22 +0000
Message-ID: <010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 09:18:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiHWZ-0000ad-3l
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 09:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305AbcCVISj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 04:18:39 -0400
Received: from a6-246.smtp-out.eu-west-1.amazonses.com ([54.240.6.246]:47787
	"EHLO a6-246.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752940AbcCVISc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 04:18:32 -0400
X-Greylist: delayed 1027 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Mar 2016 04:18:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458633682;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=4dAUJhQlmfbpsRXiReWlg1EeJAH35qjAk284cgwN1lQ=;
	b=bBEHu1WLQZOOo/Qj84AmwrTNz8Y6UZTPlQN+Z26Kxyf6jeIA8fn9rN/BdE8mNIks
	wePhmLyS3GfwrNQzNgYsUxZfMzutfjQjOV1z4Sjy4x/ShgxWUDzk/GOKugyG91nzfpr
	RtRzZJqObDn0zNKngCc17a7rLEkgl9PIab88a76w=
In-Reply-To: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.22-54.240.6.246
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289493>

Convert the code literally without changing its design even though it
seems that its obscure as to the use of comparing revision to different
bisect arguments which seems like a problem in shell because of the way
function arguments are handled.

The argument handling is kind of hard coded right now because it is not
really be meant to be used like this and this is just for testing
purposes whether this new method is as functional as its counter part.
The shell counter part of the method has been retained for historical
purposes.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 37 +++++++++++++++++++++++++++++++++++++
 git-bisect.sh            |  4 ++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..6cdae82 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,27 +2,64 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "refs.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
+	N_("git bisect--helper --check-term-format <term> <revision>"),
 	NULL
 };
 
+static int check_term_format(const char *term, const char *revision, int flags);
+
+static int check_term_format(const char *term, const char *revision, int flag) {
+	if (check_refname_format(term, flag))
+		die("'%s' is not a valid term", term);
+
+	if (!strcmp(term, "help") || !strcmp(term, "start") ||
+		!strcmp(term, "skip") || !strcmp(term, "next") ||
+		!strcmp(term, "reset") || !strcmp(term, "visualize") ||
+		!strcmp(term, "replay") || !strcmp(term, "log") ||
+		!strcmp(term, "run"))
+		die("can't use the builtin command '%s' as a term", term);
+
+	if (!strcmp(term, "bad") || !strcmp(term, "new"))
+		if(strcmp(revision, "bad"))
+			die("can't change the meaning of term '%s'", term);
+
+	if (!strcmp(term, "good") || !strcmp(term, "old"))
+		if (strcmp(revision, "good"))
+			die("can't change the meaning of term '%s'", term);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;
 	int no_checkout = 0;
+	const char *term;
 	struct option options[] = {
 		OPT_BOOL(0, "next-all", &next_all,
 			 N_("perform 'git bisect next'")),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
+		OPT_STRING(0, "check-term-format", &term, N_("term"),
+			 N_("check the format of the ref")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
+
+	if (term != NULL) {
+		if (argc > 0)
+			return check_term_format(term, argv[0], 0);
+		else
+			die("no revision provided with check_for_term");
+	}
+
 	if (!next_all)
 		usage_with_options(git_bisect_helper_usage, options);
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..ea237be 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -564,8 +564,8 @@ write_terms () {
 	then
 		die "$(gettext "please use two different terms")"
 	fi
-	check_term_format "$TERM_BAD" bad
-	check_term_format "$TERM_GOOD" good
+	git bisect--helper --check-term-format="$TERM_BAD" bad
+	git bisect--helper --check-term-format="$TERM_GOOD" good
 	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
 }
 

--
https://github.com/git/git/pull/216
