From: Cyril Roelandt <tipecaml@gmail.com>
Subject: [PATCH] Allow --pretty to be passed to git-describe.
Date: Tue, 25 Mar 2014 02:04:04 +0100
Message-ID: <1395709444-11220-1-git-send-email-tipecaml@gmail.com>
Cc: Cyril Roelandt <tipecaml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 02:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSFsF-0002gi-67
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 02:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaCYBJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 21:09:47 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:53063 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaCYBJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 21:09:46 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr14so1499894wib.10
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 18:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LRQtUCDe9+hmKw5cvr9rOy0L2rRVXf9TLao69BHhB4A=;
        b=h/BcTZ2VoFe0EI0UVsA0jzKZIvO6PDOyR1ON+Mu90ucr5NkOgM1N9fiwZN2FewXY0F
         gJxRi/df93tykkZ5/Fr6t/kxUQvByUYuy7oVVlMudvILn6ORU/XSQ11PmBFvgx50klht
         NsbUZ/uLKAZanaIdD5um6YG7g7B7X6SO2BkmKV+cp0dZgzvkuo+GNiITJC1+eGN1VL1e
         voIlvPn602izXMYbff805Go1x+Xk9qS/fdsOtxaH5lDvxcA47+YCbol2/ZOYybdrXfcb
         svFYkw6uCV06JOZPlSti5QTKzeJi8a1u0ap7zCgXIaJFGROM/kTKay+MYzL7TBUjuZJ/
         6R1Q==
X-Received: by 10.181.13.112 with SMTP id ex16mr19488329wid.23.1395709784970;
        Mon, 24 Mar 2014 18:09:44 -0700 (PDT)
Received: from localhost.localdomain (tal33-3-82-233-82-24.fbx.proxad.net. [82.233.82.24])
        by mx.google.com with ESMTPSA id ee5sm44770635wib.8.2014.03.24.18.09.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Mar 2014 18:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244900>

In some cases, ony may want to find the the most recent tag that is reachable
from a commit and have it pretty printed, using the formatting options available
in git-log and git-show.

Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
---
 Documentation/git-describe.txt |  4 ++++
 builtin/describe.c             | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index d20ca40..fae4713 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -93,6 +93,10 @@ OPTIONS
 	This is useful when you wish to not match tags on branches merged
 	in the history of the target commit.
 
+include::pretty-options.txt[]
+
+include::pretty-formats.txt[]
+
 EXAMPLES
 --------
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 24d740c..4c0ebae 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -8,8 +8,8 @@
 #include "diff.h"
 #include "hashmap.h"
 #include "argv-array.h"
+#include "revision.h"
 
-#define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
@@ -30,6 +30,8 @@ static int have_util;
 static const char *pattern;
 static int always;
 static const char *dirty;
+static const char *fmt_pretty;
+static enum cmit_fmt commit_format;
 
 /* diff-index command arguments to check if working tree is dirty. */
 static const char *diff_index_args[] = {
@@ -266,8 +268,14 @@ static void describe(const char *arg, int last_one)
 		 * Exact match to an existing ref.
 		 */
 		display_name(n);
-		if (longformat)
+		if (longformat) {
 			show_suffix(0, n->tag ? n->tag->tagged->sha1 : sha1);
+		} else if (fmt_pretty) {
+			struct strbuf buf = STRBUF_INIT;
+			pp_commit_easy(commit_format, cmit, &buf);
+			printf("%s", buf.buf);
+			strbuf_release(&buf);
+		}
 		if (dirty)
 			printf("%s", dirty);
 		printf("\n");
@@ -386,9 +394,16 @@ static void describe(const char *arg, int last_one)
 		}
 	}
 
-	display_name(all_matches[0].name);
-	if (abbrev)
-		show_suffix(all_matches[0].depth, cmit->object.sha1);
+	if (fmt_pretty) {
+		struct strbuf buf = STRBUF_INIT;
+		pp_commit_easy(commit_format, cmit, &buf);
+		printf("%s", buf.buf);
+		strbuf_release(&buf);
+	} else {
+		display_name(all_matches[0].name);
+		if (abbrev)
+			show_suffix(all_matches[0].depth, cmit->object.sha1);
+	}
 	if (dirty)
 		printf("%s", dirty);
 	printf("\n");
@@ -419,6 +434,10 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
+		OPT_STRING(0, "pretty",      &fmt_pretty, N_("pattern"),
+			   N_("pretty print")),
+		OPT_STRING(0, "format",      &fmt_pretty, N_("pattern"),
+			   N_("pretty print")),
 		OPT_END(),
 	};
 
@@ -437,6 +456,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (longformat && abbrev == 0)
 		die(_("--long is incompatible with --abbrev=0"));
 
+	if (longformat && fmt_pretty)
+		die(_("--long is incompatible with --pretty"));
+
 	if (contains) {
 		struct argv_array args;
 
@@ -458,6 +480,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		return cmd_name_rev(args.argc, args.argv, prefix);
 	}
 
+	if (fmt_pretty) {
+		struct rev_info rev;
+		init_revisions(&rev, prefix);
+		get_commit_format(fmt_pretty, &rev);
+		commit_format = rev.commit_format;
+	}
+
 	hashmap_init(&names, (hashmap_cmp_fn) commit_name_cmp, 0);
 	for_each_rawref(get_name, NULL);
 	if (!names.size && !always)
-- 
1.9.1
