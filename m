From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 1/3] sumodule--helper: fix submodule--helper clone usage and check argc count
Date: Fri, 26 Feb 2016 16:13:18 -0800
Message-ID: <1456532000-22971-2-git-send-email-jacob.e.keller@intel.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 01:13:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZSVl-0006yT-3a
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 01:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849AbcB0AN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 19:13:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:38260 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106AbcB0ANX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 19:13:23 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 26 Feb 2016 16:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,506,1449561600"; 
   d="scan'208";a="924835109"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by fmsmga002.fm.intel.com with ESMTP; 26 Feb 2016 16:13:22 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287645>

From: Jacob Keller <jacob.keller@gmail.com>

git submodule--helper clone usage specified that paths come after the --
as a sequence. However, the actual implementation does not, and requires
only a single path passed in via --path. In addition, argc was
unchecked. (allowing arbitrary extra arguments that were silently
ignored).

Fix the usage description to match implementation. Add an argc check to
enforce no extra arguments. Fix a bug in the argument passing in
git-submodule.sh which would pass --reference and --depth as empty
strings when they were unused, resulting in extra argc after parsing
options.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 git-submodule.sh            | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff179b5..072d9bbd12a8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -187,13 +187,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--url <url>]"
-		   "[--depth <depth>] [--] [<path>...]"),
+		   "[--depth <depth>] [--path <path>]"),
 		NULL
 	};
 
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
+	if (argc)
+		usage(*git_submodule_helper_usage);
+
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f94d1d..2dd29b3df0e6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -347,7 +347,7 @@ Use -f if you really want to add it." >&2
 				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 		(
 			clear_local_git_env
 			cd "$sm_path" &&
@@ -709,7 +709,7 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
+			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" ${reference:+"$reference"} ${depth:+"$depth"} || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
 		else
-- 
2.7.1.429.g45cd78e
