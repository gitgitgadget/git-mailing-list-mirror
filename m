From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 05/10] fast-export: add new --refspec option
Date: Sat, 12 Oct 2013 02:05:25 -0500
Message-ID: <1381561533-20381-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMb-0004MJ-TD
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab3JLHLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:44 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:61673 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3JLHLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:39 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3483136obc.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQ9DZpYRwPbvac6TlG1QsYXlQDHedj60SsxhxaazZjQ=;
        b=UYqwOq0LkrhOJ+ZZ1A3z/U1anfKrJ6LjywdeM7AEoKIPRzXpAhHVAuIkN3TOj8pKTp
         7caVwjtsNSbLConQd3wHfbzAaN7d949SiJJ5rrZTiewrLhnlEqHlduM3WJBvABkJ1XTw
         kmp/IGyM9qZqx2VZ0YTjpuZEhmGeIt5hVSrfqzi0r8Z82WNib7yRun6KElnu7R2hYY5F
         Tq/7ssHqktBNePvxPFNkiQHFXG9oGxkQWe1ul8lKwTTaQ3XKBjs/E5DSJjgRu5ME11R0
         SvsH9BH2zia5bR0kAYXNNellifUGdISypqW6x2EctkciLroSLGoVYK6J3Ldxe1iFwQ+9
         MwNQ==
X-Received: by 10.182.104.36 with SMTP id gb4mr18269obb.43.1381561899458;
        Sat, 12 Oct 2013 00:11:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm28626809obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235971>

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
