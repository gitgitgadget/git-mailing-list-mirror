From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/2] Submodules: Don't parse .gitmodules when it contains,
 merge conflicts
Date: Sat, 14 May 2011 18:26:58 +0200
Message-ID: <4DCEAD52.60707@web.de>
References: <4DCEACF8.50503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 18:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLHgc-0000va-BD
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 18:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488Ab1ENQ1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 12:27:07 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:56426 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758271Ab1ENQ1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 12:27:05 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id DDFB419F85493;
	Sat, 14 May 2011 18:26:58 +0200 (CEST)
Received: from [93.240.103.149] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QLHgA-0001SK-00; Sat, 14 May 2011 18:26:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DCEACF8.50503@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+stPiaciLof4E2HmGp0x/5ya4pFuvzIDYsZCA4
	QfOi+PbXleLYRWJ0t1QfkU9wJekLbx83/PddSBuc8ao46Bj9V3
	ctVvWYVzKNcakq4qOwvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173592>

Commands like "git status", "git diff" and "git fetch" would fail when the
.gitmodules file contained merge conflicts because the config parser would
call die() when hitting the conflict markers:

    "fatal: bad config file line <n> in <path>/.gitmodules"

While this behavior was on the safe side, it is really unhelpful to the
user to have commands like status and diff fail, as these are needed to
find out what's going on. And the error message is only mildly helpful,
as it points to the right file but doesn't mention that it is unmerged.
Users of git gui were not shown any conflicts at all when this happened.

Improve the situation by checking if the index records .gitmodules as
unmerged. When that is the case we can't make any assumptions about the
configuration to be found there after the merge conflict is resolved by
the user, so assume that all recursion is disabled unless .git/config or
the global config say otherwise.

As soon as the merge conflict is resolved and the .gitmodules file has
been staged subsequent commands again honor any configuration done there.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c                 |   31 +++++++++++++++++++++++++++++--
 t/t7506-status-submodule.sh |    6 +++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5294cef..b6dec70 100644
--- a/submodule.c
+++ b/submodule.c
@@ -14,6 +14,15 @@ static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
+/*
+ * The following flag is set if the .gitmodules file is unmerged. We then
+ * disable recursion for all submodules where .git/config doesn't have a
+ * matching config entry because we can't guess what might be configured in
+ * .gitmodules unless the user resolves the conflict. When a command line
+ * option is given (which always overrides configuration) this flag will be
+ * ignored.
+ */
+static int gitmodules_is_unmerged;

 static int add_submodule_odb(const char *path)
 {
@@ -63,6 +72,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		ignore_option = unsorted_string_list_lookup(&config_ignore_for_name, path_option->util);
 		if (ignore_option)
 			handle_ignore_submodules_arg(diffopt, ignore_option->util);
+		else if (gitmodules_is_unmerged)
+			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
 }

@@ -82,9 +93,24 @@ void gitmodules_config(void)
 	const char *work_tree = get_git_work_tree();
 	if (work_tree) {
 		struct strbuf gitmodules_path = STRBUF_INIT;
+		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
-		git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
+		if (read_cache() < 0)
+			die("index file corrupt");
+		pos = cache_name_pos(".gitmodules", 11);
+		if (pos < 0) { /* .gitmodules not found or isn't merged */
+			pos = -1 - pos;
+			if (active_nr > pos) {  /* there is a .gitmodules */
+				const struct cache_entry *ce = active_cache[pos];
+				if (ce_namelen(ce) == 11 &&
+				    !memcmp(ce->name, ".gitmodules", 11))
+					gitmodules_is_unmerged = 1;
+			}
+		}
+
+		if (!gitmodules_is_unmerged)
+			git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
 		strbuf_release(&gitmodules_path);
 	}
 }
@@ -434,7 +460,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 					default_argv = "on-demand";
 				}
 			} else {
-				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF)
+				if ((config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF) ||
+				    gitmodules_is_unmerged)
 					continue;
 				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
 					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 61a5680..d31b34d 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -196,7 +196,7 @@ AA .gitmodules
 A  sub1
 EOF

-test_expect_failure 'status with merge conflict in .gitmodules' '
+test_expect_success 'status with merge conflict in .gitmodules' '
 	git clone . super &&
 	test_create_repo_with_commit sub1 &&
 	test_tick &&
@@ -255,7 +255,7 @@ index badaa4c,44f999a..0000000
 ++>>>>>>> add_sub1
 EOF

-test_expect_failure 'diff with merge conflict in .gitmodules' '
+test_expect_success 'diff with merge conflict in .gitmodules' '
 	(
 		cd super &&
 		git diff >../diff_actual 2>&1
@@ -263,7 +263,7 @@ test_expect_failure 'diff with merge conflict in .gitmodules' '
 	test_cmp diff_actual diff_expect
 '

-test_expect_failure 'diff --submodule with merge conflict in .gitmodules' '
+test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 	(
 		cd super &&
 		git diff --submodule >../diff_submodule_actual 2>&1
-- 
1.7.5.1.291.g080bb
