From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 06/10] fast-export: add new --refspec option
Date: Mon, 11 Nov 2013 16:55:02 -0600
Message-ID: <1384210507-26561-6-git-send-email-felipe.contreras@gmail.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 00:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg0Ux-0006Pi-Le
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab3KKXCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:02:19 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:41122 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3KKXCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:02:12 -0500
Received: by mail-ob0-f179.google.com with SMTP id wn1so3798201obc.38
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 15:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkS4SoLzZ9JA9YrrQg565Z5QVGwAoAqU6aaWDVc0uMw=;
        b=PlfGhdD/BhpJd8qc+oaK4lcxoa056JfBW+BnqM+p02bJD4+DhFVLwaVX8h5c6kafNW
         fj8uXXY7uFxG3n6nfgDWCz5oOVErMQNVNAeVoVM5GksQ+Ms2MXwQnsjWLF53KTCmszrq
         ff01kYy97N71uQUC3dBMglNlmi89llDRQuZap1vzpTEO6mnUBbPgOp0qlQ8NTgWj3e6p
         jmgyk1MlyZKppT0zNnVfwNWxIAeldZ+lRd9mEysyYavC0s5O3aclNm3pyq40PQgpR6aq
         LN7wv86nH02pizyNwYxvJwXgsuJcf8lc+2NO05ELsZr8Gc4WrgH7lnaGdY7vWaaoncWM
         RKiQ==
X-Received: by 10.182.131.196 with SMTP id oo4mr6681120obb.50.1384210931475;
        Mon, 11 Nov 2013 15:02:11 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm29306879obc.2.2013.11.11.15.02.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2013 15:02:10 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237668>

So that we can convert the exported ref names.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-fast-export.txt |  4 ++++
 builtin/fast-export.c             | 32 ++++++++++++++++++++++++++++++++
 t/t9350-fast-export.sh            |  7 +++++++
 3 files changed, 43 insertions(+)

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
index eea5b8c..cf745ec 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -17,6 +17,7 @@
 #include "utf8.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "remote.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -31,6 +32,8 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
+static struct refspec *refspecs;
+static int refspecs_nr;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -525,6 +528,15 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
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
 		commit = get_commit(e, full_name);
 		if (!commit) {
 			warning("%s: Unexpected object of type %s, skipping.",
@@ -668,6 +680,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	uint32_t lastimportid;
+	struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_INTEGER(0, "progress", &progress,
 			    N_("show progress after <n> objects")),
@@ -688,6 +701,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
+		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
+			     N_("Apply refspec to exported refs")),
 		OPT_END()
 	};
 
@@ -707,6 +722,21 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
+	if (refspecs_list.nr) {
+		const char **refspecs_str;
+		int i;
+
+		refspecs_str = xmalloc(sizeof(*refspecs_str) * refspecs_list.nr);
+		for (i = 0; i < refspecs_list.nr; i++)
+			refspecs_str[i] = refspecs_list.items[i].string;
+
+		refspecs_nr = refspecs_list.nr;
+		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
+
+		string_list_clear(&refspecs_list, 1);
+		free(refspecs_str);
+	}
+
 	if (use_done_feature)
 		printf("feature done\n");
 
@@ -741,5 +771,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (use_done_feature)
 		printf("done\n");
 
+	free_refspec(refspecs_nr, refspecs);
+
 	return 0;
 }
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 2312dec..3d475af 100755
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
1.8.4.2+fc1
