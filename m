From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 4/4] gc: remove broken symrefs
Date: Mon, 28 Sep 2015 16:02:08 +0200
Organization: gmx
Message-ID: <fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
 <cover.1443448748.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 16:02:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgZ0d-0005QE-FG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 16:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933940AbbI1OCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 10:02:22 -0400
Received: from mout.gmx.net ([212.227.15.19]:51516 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920AbbI1OCW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 10:02:22 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LgZRV-1aTyqK2mvt-00nyQU; Mon, 28 Sep 2015 16:02:09
 +0200
In-Reply-To: <cover.1443448748.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:WloaCnWWn7kzbya7+qJB54+k0gPFEpKGtpzTqVcQzKdKUYw6cBx
 +nZJ+YAThq77m3xYCMbh19SStqby3iJTY5x1Jh4Ia3QB4nkRTLDdJEjHNQ7yPMoD8qq3y19
 tNXfGde7EvY51moTul0xJVwrL3991T1/1j/JCbZ+CU1gMawtjPu/XtDY1yN8pPFYE+atdNm
 glP6TUAGetyFA61AfoEog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wkMhKfZi15A=:GxGMSGmwSZWaOE6KrXii1Z
 pJ/Agl07z5foWsvTjH9vv0UMtmH23qlTfj/Dm0GsBODwrrAFlb4xbCwbWeVrI8TBOt3ONckDL
 xqL9myVmIxovNnx9/pqTdjIxAHkHwc6asKM4MRTmlkrxZ8ymmcSbJSJtE5T2nKc084nO1f6Pf
 HRBRCQYNIf9hFpyh5Tw/E+W9kU1/Ld5edIb9lxP94Wg01EL09HGPQabl1vhMg7H+Y9El2Kbxs
 hvE5W609Xtgj7Gsg8Ke+K6UR5pyX0bS9Om1mds5UHt3SowoEt2lxFrw1jaCjYstcanxV5ARqb
 VnHOIbt0b7ZBOjR/4P+bioIOcrn1msfHiK+BEwBsM+mnHLGealcs//Ft6nKkaV4J8oM0H+cNd
 IQ6y1vD9IlDRPCl64ThIptSc9eMhfwyHI3FRJ5O5oh1ox2x8BFf357bD6Nzp5RKJIYkfRHVl1
 l6R8N27f/EptC5l3fKslSF/Mm2vb5BGIQq/O4O/eWdNEUZHv8ZpBAAmDH5paRy/0t7ZAz0kDf
 kpjsYD7chaVhXzW6oCrsa+vYV0UulnJBdoBWjp01es5KlbGEDjAGFX9dn5tnSt62iFfrLeCDr
 h+JZjriy/CKLRZpcue0/sCXiDv61Qe/aTT4/901WWdYRGS7elDYMfkWqMO64NFqzvBmzTP4fQ
 6hAI5WA5RtMx1yqvSIC+xH7qI4G8jiXLI4NmfTnOHemgNSE5D76VjLMamkLhgH16OrRDlX2mm
 Jr3VubpZZU7r8F9ji68oYg5XnUiVbQQicnCTlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278728>

When encountering broken symrefs, such as a stale remote HEAD (which can
happen if the active branch was renamed in the remote), it is more
helpful to remove those symrefs than to exit with an error.

This fixes https://github.com/git-for-windows/git/issues/423

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/prune.c | 12 +++++++++++-
 t/t6500-gc.sh   |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index d6f664f..337b12a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -6,6 +6,7 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
+#include "refs.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
@@ -100,6 +101,7 @@ static void remove_temporary_files(const char *path)
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
+	struct string_list broken_symrefs = STRING_LIST_INIT_DUP;
 	struct progress *progress = NULL;
 	const struct option options[] = {
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
@@ -110,6 +112,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	char *s;
+	int i;
 
 	expire = ULONG_MAX;
 	save_commit_buffer = 0;
@@ -136,7 +139,14 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_progress_delay(_("Checking connectivity"), 0, 0, 2);
 
-	mark_reachable_objects(&revs, 1, expire, progress, NULL);
+	revs.ignore_missing = 1;
+	mark_reachable_objects(&revs, 1, expire, progress, &broken_symrefs);
+	for (i = 0; i < broken_symrefs.nr; i++) {
+		char *path = broken_symrefs.items[i].string;
+		printf("Removing stale ref %s\n", path);
+		if (!show_only && delete_ref(path, NULL, REF_NODEREF))
+			die("Could not remove stale ref %s", path);
+	}
 	stop_progress(&progress);
 	for_each_loose_file_in_objdir(get_object_directory(), prune_object,
 				      prune_cruft, prune_subdir, NULL);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index b736774..0ae4271 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
-test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
+test_expect_success 'gc removes broken refs/remotes/<name>/HEAD' '
 	git init remote &&
 	(
 		cd remote &&
-- 
2.5.3.windows.1.3.gc322723
