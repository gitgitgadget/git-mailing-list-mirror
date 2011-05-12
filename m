From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 2/2] Submodules: Don't parse .gitmodules when it contains
 merge conflicts
Date: Thu, 12 May 2011 23:03:01 +0200
Message-ID: <4DCC4B05.9070205@web.de>
References: <4DCC4A9D.3060007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 23:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKd2N-0005kG-2Y
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 23:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670Ab1ELVDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 17:03:05 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49088 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659Ab1ELVDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 17:03:04 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 4C5FA18E8D66C;
	Thu, 12 May 2011 23:03:02 +0200 (CEST)
Received: from [93.240.105.8] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QKd2E-0004QG-00; Thu, 12 May 2011 23:03:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DCC4A9D.3060007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18Z6hVC+o2U7522jEOnWekWFefLuSortZk3bXzS
	/CxwlgoTs6QUcxxR36TOIb2MdI91bDTaN0nJRD8z+yC/U4PFG6
	cEPzt4+P1u+20D12GiJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173499>

Until now commands like "git status", "git diff" and "git fetch" would
fail when the .gitmodules file contained merge conflicts because the
config parser would call die() when hitting the conflict markers:

    "fatal: bad config file line <n> in <path>/.gitmodules"

While this was behavior was on the safe side, it is really unhelpful to
the user to have commands like status and diff fail, as these are needed
to find out what's going on. And the error message is only mildly helpful,
as it points to the right file but doesn't mention that it is unmerged.

Improve the situation by checking if the index records .gitmodules as
unmerged. When that is the case we can't make any assumptions about the
configuration to be found there after the merge conflict is resolved by
the user, so assume that all recursion is disabled unless .git/config or
the global config say otherwise.

As soon as the merge conflict is resolved and the .gitmodules file has
been staged subsequent commands again honor any configuration done there.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c                 |   23 +++++++++++++++++++++--
 t/t7506-status-submodule.sh |    6 +++---
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5294cef..cdf844c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -14,6 +14,13 @@ static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
 static struct string_list changed_submodule_paths;
+/* The following flag is set if the .gitmodules file is unmerged. We then
+ * disable recursion for all submodules where .git/config doesn't have a
+ * matching config entry because we can't guess what might be configured in
+ * .gitmodules unless the user resolves the conflict. When a command line
+ * option is given (which always overrides configuration) this flag will be
+ * ignored. */
+static int gitmodules_is_unmerged;

 static int add_submodule_odb(const char *path)
 {
@@ -63,6 +70,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		ignore_option = unsorted_string_list_lookup(&config_ignore_for_name, path_option->util);
 		if (ignore_option)
 			handle_ignore_submodules_arg(diffopt, ignore_option->util);
+		else if (gitmodules_is_unmerged)
+			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
 	}
 }

@@ -82,9 +91,18 @@ void gitmodules_config(void)
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
+		if (pos >= -1) {
+			/* We have a clean, untracked or missing .gitmodules, try to parse it */
+			git_config_from_file(submodule_config, gitmodules_path.buf, NULL);
+		} else {
+			gitmodules_is_unmerged = 1;
+		}
 		strbuf_release(&gitmodules_path);
 	}
 }
@@ -434,7 +452,8 @@ int fetch_populated_submodules(int num_options, const char **options,
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
index 3b1806c..b31b64e 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -204,7 +204,7 @@ cat > status_expect << EOF
 #
 EOF

-test_expect_failure 'status with merge conflict in .gitmodules' '
+test_expect_success 'status with merge conflict in .gitmodules' '
 	git clone . super &&
 	test_create_repo_with_commit sub1 &&
 	test_tick &&
@@ -263,7 +263,7 @@ index badaa4c,44f999a..0000000
 ++>>>>>>> add_sub1
 EOF

-test_expect_failure 'diff with merge conflict in .gitmodules' '
+test_expect_success 'diff with merge conflict in .gitmodules' '
 	(
 		cd super &&
 		git diff > ../diff_actual 2>&1
@@ -271,7 +271,7 @@ test_expect_failure 'diff with merge conflict in .gitmodules' '
 	test_cmp diff_actual diff_expect
 '

-test_expect_failure 'diff --submodule with merge conflict in .gitmodules' '
+test_expect_success 'diff --submodule with merge conflict in .gitmodules' '
 	(
 		cd super &&
 		git diff --submodule > ../diff_submodule_actual 2>&1
-- 
1.7.5.1.251.ga75dd
