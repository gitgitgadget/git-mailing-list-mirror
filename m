From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 4/7] Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule'
 option
Date: Sun, 06 Mar 2011 23:12:19 +0100
Message-ID: <4D7406C3.7060109@web.de>
References: <4D74061C.5050908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:12:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMBf-0000KO-Bl
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab1CFWMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:12:21 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:35977 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab1CFWMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:12:21 -0500
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id F3E4419A200E4;
	Sun,  6 Mar 2011 23:12:19 +0100 (CET)
Received: from [93.246.45.11] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PwMBX-0003KE-00; Sun, 06 Mar 2011 23:12:19 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
In-Reply-To: <4D74061C.5050908@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19+pbxhtIhB/Y/RHnrRWYeQUk1Rg4+BWLUSSIVX
	Zq4mS7LlJg40Qb9k7+pHUQmBHYuVJG6XPF+oWBz6GaW8iKMami
	bNXTK5Ia20eib6WZoXHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168539>

Now the behavior of fetch and pull can be configured to the recently added
'on-demand' mode separately for each submodule too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt     |    2 +-
 Documentation/gitmodules.txt |    4 ++--
 submodule.c                  |    9 +++++++--
 t/t5526-fetch-submodules.sh  |   28 ++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 44c9a2a..4a7b177 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1824,7 +1824,7 @@ submodule.<name>.update::
 	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.

 submodule.<name>.fetchRecurseSubmodules::
-	This option can be used to enable/disable recursive fetching of this
+	This option can be used to control recursive fetching of this
 	submodule. It can be overridden by using the --[no-]recurse-submodules
 	command line option to "git fetch" and "git pull".
 	This setting will override that from in the linkgit:gitmodules[5]
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 6897794..25daee2 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -45,12 +45,12 @@ submodule.<name>.update::
 	the '--merge' or '--rebase' options.

 submodule.<name>.fetchRecurseSubmodules::
-	This option can be used to enable/disable recursive fetching of this
+	This option can be used to control recursive fetching of this
 	submodule. If this option is also present in the submodules entry in
 	.git/config of the superproject, the setting there will override the
 	one found in .gitmodules.
 	Both settings can be overridden on the command line by using the
-	"--[no-]recurse-submodules" option to "git fetch" and "git pull"..
+	"--[no-]recurse-submodules" option to "git fetch" and "git pull".

 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
diff --git a/submodule.c b/submodule.c
index afb0a0e..924b156 100644
--- a/submodule.c
+++ b/submodule.c
@@ -113,7 +113,7 @@ int parse_submodule_config_option(const char *var, const char *value)
 		if (!config)
 			config = string_list_append(&config_fetch_recurse_submodules_for_name,
 						    strbuf_detach(&submodname, NULL));
-		config->util = git_config_bool(var, value) ? (void *)1 : NULL;
+		config->util = (void *)(intptr_t)parse_fetch_recurse_submodules_arg(var, value);
 		strbuf_release(&submodname);
 	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
@@ -380,8 +380,13 @@ int fetch_populated_submodules(int num_options, const char **options,
 			struct string_list_item *fetch_recurse_submodules_option;
 			fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
 			if (fetch_recurse_submodules_option) {
-				if (!fetch_recurse_submodules_option->util)
+				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_OFF)
 					continue;
+				if ((intptr_t)fetch_recurse_submodules_option->util == RECURSE_SUBMODULES_ON_DEMAND) {
+					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+						continue;
+					default_argv = "on-demand";
+				}
 			} else {
 				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF)
 					continue;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index e6d873a..09701aa 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -400,4 +400,32 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	test_cmp expect.err.2 actual.err
 '

+test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' overrides fetch.recurseSubmodules" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules
+	) &&
+	add_upstream_commit &&
+	git config fetch.recurseSubmodules false &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err.2 &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err.2
+	head -2 expect.err >> expect.err.2 &&
+	(
+		cd downstream &&
+		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	git config --unset fetch.recurseSubmodules &&
+	(
+		cd downstream &&
+		git config --unset submodule.submodule.fetchRecurseSubmodules
+	) &&
+	test_cmp expect.out.sub actual.out &&
+	test_cmp expect.err.2 actual.err
+'
+
 test_done
-- 
1.7.4.1.300.g29eea0
