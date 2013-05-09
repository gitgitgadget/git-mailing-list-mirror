From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] fast-export: add new --refspec option
Date: Wed,  8 May 2013 20:31:34 -0500
Message-ID: <1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 09 03:33:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaFjY-0007D4-JG
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 03:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab3EIBdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 21:33:09 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:37021 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab3EIBdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 21:33:08 -0400
Received: by mail-ob0-f181.google.com with SMTP id ta14so2362761obb.40
        for <git@vger.kernel.org>; Wed, 08 May 2013 18:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bmVRuB2rabL5l44P9aGczhouprk0WG9y2VY5mqFW890=;
        b=tC64iJSuCGEX4Z1ev+CNymXZAwufje16/z97NtKwIz29bIRWCSm7vmptaMMpOksJoM
         QKJlChcVhk5eisauC/ijXlFJqSrVBxsp8ZXH9g/cBpcj3RgNolkIAmkYDhVT3n47ZlIw
         BClE+AaCjRuemUlVW966zX5nuxGQwcW0vWn9unTcpCmC2JvYGMRq+vyzYbqqSGLxc40M
         xbj2GOEfApLwMNtbbOt40W76BpdjxqWZLiRETFvik0X5sF/gqT8JEjTMmsXHFeLbPddo
         8fY7HNUHqsh4lLnDRxErNrHnpvdbY2+EaA9u61y5JIUJKgcrnF6JEH0laIMJFgOrfbW8
         TaPw==
X-Received: by 10.60.80.33 with SMTP id o1mr3161350oex.116.1368063187687;
        Wed, 08 May 2013 18:33:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ku7sm1145166obc.6.2013.05.08.18.33.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 18:33:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223708>

So that we can covert the exported ref names.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-export.txt |  4 ++++
 builtin/fast-export.c             | 30 ++++++++++++++++++++++++++++++
 t/t9350-fast-export.sh            |  7 +++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 03fc8c3..d1985d3 100644
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
index 6e46057..0097103 100644
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
@@ -653,6 +665,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	uint32_t lastimportid;
+	struct string_list refspecs_list;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
 			    N_("show progress after <n> objects")),
@@ -673,6 +686,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
+		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
+			     N_("Apply refspec to exported refs")),
 		OPT_END()
 	};
 
@@ -692,6 +707,19 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
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
 
@@ -726,5 +754,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (use_done_feature)
 		printf("done\n");
 
+	free_refspec(refspecs_nr, refspecs);
+
 	return 0;
 }
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 2471bc6..ef2d76e 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -505,4 +505,11 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
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
1.8.3.rc1.553.gac13664
