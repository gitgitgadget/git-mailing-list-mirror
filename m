From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 4/9] Teach merge the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 20:50:41 +0100
Message-ID: <52EFF311.1090202@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:50:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPXg-0000yG-CC
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaBCTuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:50:44 -0500
Received: from mout.web.de ([212.227.17.12]:63573 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204AbaBCTun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:50:43 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LrK0u-1V7HwM0GB2-0132wX for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:50:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:pyPiClKPtpenyQSO9+4TIrTmLtn97tH2zfo9sKPGjECD/YnKwZr
 rqnKLLE/X4awKfLOFNASz0QJBc1GTfMA5BOTW9+86vUAxJgsYv0HIcy4uYYfFGfNnhOxzQ+
 XCwAOTSAbQgfjLHGIKn2T6TnoqHpzDmhh+07QwBdN0AEQjaFPVz6ZrUMetZYUAeBEGYvhwg
 c/8ABvT2erQcwyqTuCmRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241459>

This new option will allow the user to not only update the work tree of
the superproject according to the merge result but to also update the
work tree of all initialized submodules (so they match the SHA-1 recorded
in the superproject). But this commit only adds the option without any
functionality, that will be added to unpack_trees() in subsequent commits.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-merge.txt |  2 ++
 builtin/merge.c             | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4395459..9ed1655 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -96,6 +96,8 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.

+include::recurse-submodules-update.txt[]
+
 <commit>...::
 	Commits, usually other branch heads, to merge into our branch.
 	Specifying more than one commit will create a merge with
diff --git a/builtin/merge.c b/builtin/merge.c
index 4941a6c..a0eb665 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -28,6 +28,7 @@
 #include "remote.h"
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
+#include "submodule.h"

 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -65,6 +66,8 @@ static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
 static const char *sign_commit;
+static const char *recurse_submodules_default = "off";
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;

 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -223,6 +226,12 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+		"checkout", "control recursive updating of submodules",
+		PARSE_OPT_OPTARG, option_parse_update_submodules },
+	{ OPTION_STRING, 0, "recurse-submodules-default",
+		&recurse_submodules_default, NULL,
+		"default mode for recursion", PARSE_OPT_HIDDEN },
 	OPT_END()
 };

@@ -1113,6 +1122,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	else
 		head_commit = lookup_commit_or_die(head_sha1, "HEAD");

+	gitmodules_config();
 	git_config(git_merge_config, NULL);

 	if (branch_mergeoptions)
@@ -1121,6 +1131,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			builtin_merge_usage, 0);
 	if (shortlog_len < 0)
 		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
+	set_config_update_recurse_submodules(
+		parse_update_recurse_submodules_arg("--recurse-submodules-default",
+						    recurse_submodules_default),
+		recurse_submodules);

 	if (verbosity < 0 && show_progress == -1)
 		show_progress = 0;
-- 
1.9.rc0.28.ge3363ff
