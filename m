From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/8] fast-export: add new --refspec option
Date: Sun, 20 Apr 2014 13:59:24 -0500
Message-ID: <1398020370-11406-3-git-send-email-felipe.contreras@gmail.com>
References: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 21:10:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbx8O-0005mr-6s
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbaDTTKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:10:24 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:56972 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbaDTTJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:09:57 -0400
Received: by mail-yh0-f52.google.com with SMTP id 29so999648yhl.25
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5VBr550tqJtZdFl9iFuf88g7TERZ376IVFF/Qd7CaE=;
        b=Baf7yvwIzVYFAbNyFE3C7nGkjzGL8Zcsua74rNc+/oJfqw1lWvLDVl1mV473zotjuv
         huaIHTXGoHNcS8LO+g8pMY9aGVvStb/ne/YVHlLvpXDFoCo3ETguIZs0dFQm3BLJYg0+
         QhPK+Mrf6SF+ruejg+Gc3nlfbFc9ivj7TbgPQLzAmX0EJVZsBshtHtFirTsRnre7pIpn
         bEHeY+P2Bf6P6M5uKKhET/vmdRM/pxbE7Y5s435czlcKYMSQ4aSER2dgd6+qBpTigF/k
         E/Ks50TsrxXiy920wrV8Yx1ANAj5o1DnhbrlvMQED9L/mbxiksP0OsmEqAOH4eVB4u/g
         Qygg==
X-Received: by 10.236.206.166 with SMTP id l26mr2515581yho.105.1398020997305;
        Sun, 20 Apr 2014 12:09:57 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id o62sm65401363yha.27.2014.04.20.12.09.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 12:09:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398020370-11406-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246560>

So that we can convert the exported ref names.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index bc3490c..ad9c17e 100644
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
1.9.1+fc3.9.gc73078e
