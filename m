From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/9] fast-export: add new --refspec option
Date: Thu, 29 Aug 2013 10:23:23 -0500
Message-ID: <1377789808-2213-5-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF49Y-0000M4-1V
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab3H2P2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:49 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:39635 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab3H2P2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:47 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so771622oag.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQ9DZpYRwPbvac6TlG1QsYXlQDHedj60SsxhxaazZjQ=;
        b=HoDY67pwnYuOFm2ZhErO4k+Tzcop5qC3KrIFY/CgbyUIMaaSiCfRuFlz8n7LFhcQes
         Jlot25cAzSG6XcB/N2Vi2l5xfnn2cNGeocTFtvEL7norLmyKXzzdjbJIdglF5fpLmjFC
         unGVNay7UQMH5+kPLoJmH6xkRYXIl05mgPjyeQDBaBwlqm5ONmoq4ZpfwiXcvT5Fha6j
         P/M0hyLCSWGu8QRmADjhUqh99/8IUNmAc1k2fItfOGvNND7vgYQkUAFctnyO5Gsmwzau
         UoSJrN8GjLxDuTZ+OGC4QgDuiQcK/egSX5ciSTyaS306HsDj8xR4D1qxXD+9rH4hrOtA
         NocQ==
X-Received: by 10.60.60.5 with SMTP id d5mr3020518oer.0.1377790127390;
        Thu, 29 Aug 2013 08:28:47 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm31895474obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233271>

So that we can covert the exported ref names.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-export.txt |  4 ++++
 builtin/fast-export.c             | 30 ++++++++++++++++++++++++++++++
 t/t9350-fast-export.sh            |  7 +++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 85f1f30..221506b 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -105,6 +105,10 @@ marks the same across runs.
 	in the commit (as opposed to just listing the files which are
 	different from the commit's first parent).
 
+--refspec::
+	Apply the specified refspec to each ref exported. Multiple of them can
+	be specified.
+
 [<git-rev-list-args>...]::
 	A list of arguments, acceptable to 'git rev-parse' and
 	'git rev-list', that specifies the specific objects and references
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 91114f4..7f314f0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -17,6 +17,7 @@
 #include "utf8.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "remote.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -30,6 +31,8 @@ static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
 static int full_tree;
+static struct refspec *refspecs;
+static int refspecs_nr;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -502,6 +505,15 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
 			continue;
 
+		if (refspecs) {
+			char *private;
+			private = apply_refspecs(refspecs, refspecs_nr, full_name);
+			if (private) {
+				free(full_name);
+				full_name = private;
+			}
+		}
+
 		switch (e->item->type) {
 		case OBJ_COMMIT:
 			commit = (struct commit *)e->item;
@@ -661,6 +673,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	uint32_t lastimportid;
+	struct string_list refspecs_list;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
 			    N_("show progress after <n> objects")),
@@ -681,6 +694,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
+		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
+			     N_("Apply refspec to exported refs")),
 		OPT_END()
 	};
 
@@ -700,6 +715,19 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
+	if (refspecs_list.nr) {
+		const char *refspecs_str[refspecs_list.nr];
+		int i;
+
+		for (i = 0; i < refspecs_list.nr; i++)
+			refspecs_str[i] = refspecs_list.items[i].string;
+
+		refspecs_nr = refspecs_list.nr;
+		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
+
+		string_list_clear(&refspecs_list, 1);
+	}
+
 	if (use_done_feature)
 		printf("feature done\n");
 
@@ -734,5 +762,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (use_done_feature)
 		printf("done\n");
 
+	free_refspec(refspecs_nr, refspecs);
+
 	return 0;
 }
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 34c2d8f..dc6666f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -504,4 +504,11 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
 	test_cmp expected actual
 '
 
+test_expect_success 'use refspec' '
+	git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
+		grep "^commit " | sort | uniq > actual &&
+	echo "commit refs/heads/foobar" > expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.8.4-fc
