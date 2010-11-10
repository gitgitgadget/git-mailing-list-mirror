From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 3/3] Submodules: Add the "fetchRecurseSubmodules" config
 option
Date: Thu, 11 Nov 2010 00:55:41 +0100
Message-ID: <4CDB30FD.80003@web.de>
References: <4CDB3063.5010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 00:55:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGKW4-00021h-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 00:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab0KJXzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 18:55:43 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:38893 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0KJXzm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 18:55:42 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 068D017756E54;
	Thu, 11 Nov 2010 00:55:42 +0100 (CET)
Received: from [93.246.41.165] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGKVx-0004ZE-00; Thu, 11 Nov 2010 00:55:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CDB3063.5010801@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+Wf0sRkQcCthEixBKwLZ8v0xf3WMao83Yl1/Oh
	sk4uVRr1zuquFmMfXfiG4KpgA6xCqk89bz3t9Za5Jl1XJ+/5j8
	Y8YpDg20MEHBwRV9vfsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161195>

The new boolean "fetchRecurseSubmodules" config option controls the
behavior for "git fetch" and "git pull". It specifies if these commands
should recurse into submodules and fetch new commits there too and can be
set separately for each submodule.

In the .gitmodules file "submodule.<name>.fetchRecurseSubmodules" entries
are read before looking for them in .git/config. Thus settings found in
.git/config will override those from .gitmodules, thereby allowing the
user to ignore settings given by the remote side while also letting
upstream set reasonable defaults for those users who don't have special
needs.

This configuration can be overridden by the command line option
"--[no-]recurse-submodules" of "git fetch" and "git pull".

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/config.txt        |    7 +++++
 Documentation/fetch-options.txt |    2 +-
 Documentation/gitmodules.txt    |    8 ++++++
 submodule.c                     |   20 ++++++++++++++-
 t/t5526-fetch-submodules.sh     |   50 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 453c1eb..cad9658 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1796,6 +1796,13 @@ submodule.<name>.update::
 	URL and other values found in the `.gitmodules` file.  See
 	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.

+submodule.<name>.fetchRecurseSubmodules::
+	This option can be used to enable/disable recursive fetching of this
+	submodule. It can be overriden by using the --[no-]recurse-submodules
+	command line option to "git fetch" and "git pull".
+	This setting will override that from in the linkgit:gitmodules[5]
+	file.
+
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6aea5f6..dea7a29 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -68,7 +68,7 @@ endif::git-pull[]

 --[no-]recurse-submodules::
 	This option controls if new commits of all populated submodules should
-	be fetched too (see linkgit:git-config[1]).
+	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).

 ifndef::git-pull[]
 --submodule-prefix::
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index bcffd95..6c93202 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -44,6 +44,14 @@ submodule.<name>.update::
 	This config option is overridden if 'git submodule update' is given
 	the '--merge' or '--rebase' options.

+submodule.<name>.fetchRecurseSubmodules::
+	This option can be used to enable/disable recursive fetching of this
+	submodule. If this option is also present in the submodules entry in
+	.git/config of the superproject, the setting there will override the
+	one found in .gitmodules.
+	Both settings can be overriden on the command line by using the
+	"--[no-]recurse-submodules" option to "git fetch" and "git pull"..
+
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
 	a submodule as modified. When set to "all", it will never be considered
diff --git a/submodule.c b/submodule.c
index 01d75f5..4e62900 100644
--- a/submodule.c
+++ b/submodule.c
@@ -10,6 +10,7 @@
 #include "string-list.h"

 struct string_list config_name_for_path;
+struct string_list config_fetch_recurse_submodules_for_name;
 struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules;

@@ -105,6 +106,14 @@ int parse_submodule_config_option(const char *var, const char *value)
 			config = string_list_append(&config_name_for_path, xstrdup(value));
 		config->util = strbuf_detach(&submodname, NULL);
 		strbuf_release(&submodname);
+	} else if ((len > 23) && !strcmp(var + len - 23, ".fetchrecursesubmodules")) {
+		strbuf_add(&submodname, var, len - 23);
+		config = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, submodname.buf);
+		if (!config)
+			config = string_list_append(&config_fetch_recurse_submodules_for_name,
+						    strbuf_detach(&submodname, NULL));
+		config->util = git_config_bool(var, value) ? (void *)1 : NULL;
+		strbuf_release(&submodname);
 	} else if ((len > 7) && !strcmp(var + len - 7, ".ignore")) {
 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
 		    strcmp(value, "all") && strcmp(value, "none")) {
@@ -283,8 +292,15 @@ int fetch_populated_submodules(int num_options, const char **options,
 			name = name_for_path->util;

 		if (!ignore_config) {
-			if (!config_fetch_recurse_submodules)
-				continue;
+			struct string_list_item *fetch_recurse_submodules_option;
+			fetch_recurse_submodules_option = unsorted_string_list_lookup(&config_fetch_recurse_submodules_for_name, name);
+			if (fetch_recurse_submodules_option) {
+				if (!fetch_recurse_submodules_option->util)
+					continue;
+			} else {
+				if (!config_fetch_recurse_submodules)
+					continue;
+			}
 		}

 		strbuf_addf(&submodule_path, "%s/%s", work_tree, ce->name);
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 69ed3e2..c070faf 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -81,6 +81,56 @@ test_expect_success "fetch alone only fetches superproject" '
 	! test -s actual.err
 '

+test_expect_success "fetch --no-recurse-submodules only fetches superproject" '
+	(
+		cd downstream &&
+		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "using fetchRecurseSubmodules=true in .gitmodules recurses into submodules" '
+	(
+		cd downstream &&
+		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "--no-recurse-submodules overrides .gitmodules config" '
+	add_upstream_commit &&
+	(
+		cd downstream &&
+		git fetch --no-recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "using fetchRecurseSubmodules=false in .git/config overrides setting in .gitmodules" '
+	(
+		cd downstream &&
+		git config submodule.submodule.fetchRecurseSubmodules false &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	! test -s actual.err
+'
+
+test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setting from .git/config" '
+	(
+		cd downstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
+		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
+		git config --unset submodule.submodule.fetchRecurseSubmodules
+	) &&
+	test_cmp expect.out actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_expect_success "--quiet propagates to submodules" '
 	(
 		cd downstream &&
-- 
1.7.3.2.337.g9376c
