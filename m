From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 2/9] Teach reset the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 20:49:25 +0100
Message-ID: <52EFF2C5.3090705@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:49:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPWO-0000DB-3D
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:49:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbaBCTt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:49:28 -0500
Received: from mout.web.de ([212.227.15.4]:55122 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbaBCTt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:49:27 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MJTdf-1W7ORy1ssd-0033uG for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:B5seiBew0bYiXqHaLbeGbHHeA21w/c4KMCHvfpwT+I4N2n/JpoM
 GOCtMt8rayYORHJSNjK1jxaKIUTpwxxGb2csCrmf9NJwv9rn9sHUyxzZBxQRHoflzL20Cfn
 GBupaIrPYtv88N4n99utM8fVai7cxTbGnuqqB6O7ZCUt/BclWJOXLAiLImxozdul7vZNMZs
 YcBr3M4xw1BbXOSxJRwwQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241457>

This new option will allow the user to not only reset the work tree of
the superproject but to also update the work tree of all initialized
submodules (so they match the SHA-1 recorded in the superproject) when
used together with --hard or --merge. But this commit only adds the
option without any functionality, that will be added to unpack_trees()
in subsequent commits.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-reset.txt |  4 ++++
 builtin/reset.c             | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f445cb3..8f833f4 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -94,6 +94,10 @@ OPTIONS
 --quiet::
 	Be quiet, only report errors.

+include::recurse-submodules-update.txt[]
++
+This option only makes sense together with `--hard` and `--merge` and is
+ignored when used without these options.

 EXAMPLES
 --------
diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..adf372e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "submodule.h"

 static const char * const git_reset_usage[] = {
 	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
@@ -255,6 +256,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 {
 	int reset_type = NONE, update_ref_status = 0, quiet = 0;
 	int patch_mode = 0, unborn;
+	const char *recurse_submodules_default = "off";
+	int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 	const char *rev;
 	unsigned char sha1[20];
 	struct pathspec pathspec;
@@ -270,13 +273,24 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			"checkout", "control recursive updating of submodules",
+			PARSE_OPT_OPTARG, option_parse_update_submodules },
+		{ OPTION_STRING, 0, "recurse-submodules-default",
+			&recurse_submodules_default, NULL,
+			"default mode for recursion", PARSE_OPT_HIDDEN },
 		OPT_END()
 	};

+	gitmodules_config();
 	git_config(git_default_config, NULL);

 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
+	set_config_update_recurse_submodules(
+		parse_update_recurse_submodules_arg("--recurse-submodules-default",
+						    recurse_submodules_default),
+		recurse_submodules);
 	parse_args(&pathspec, argv, prefix, patch_mode, &rev);

 	unborn = !strcmp(rev, "HEAD") && get_sha1("HEAD", sha1);
-- 
1.9.rc0.28.ge3363ff
