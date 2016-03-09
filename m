From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] add a commit.verbose config variable
Date: Wed, 9 Mar 2016 18:49:15 +0000
Message-ID: <010201535cb62b56-9aa72755-b730-478c-9244-41a1ee69e231-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 20:00:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adjLR-0000C3-D9
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 20:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933799AbcCITA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 14:00:26 -0500
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:39586
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932725AbcCITAY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 14:00:24 -0500
X-Greylist: delayed 667 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Mar 2016 14:00:24 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1457549355;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=imBO7utwsMx+mK09XW309GwBKDYDaE1+80n3N5NVJ5o=;
	b=QrQe7ZCn5ZhhvPqft+eiU7FTjwX1iM7fCix4KGPYMk0YGpgbwLCWYRRtAdgyegkX
	Ew2WKHNa9dHn+at+NC89GuAyrWBgCs93MvxQjKE88UQNNvgAsBngEEpgxZ0KtRSTME1
	6LtBul76+9ySFIQyeAbCUJfExDRLyw87ewMsI8bE=
X-SES-Outgoing: 2016.03.09-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288569>

Since many people always run the command with this option, and would
prefer not to use the argument again and again but instead specify it in
the configuration file.

Also add a override-verbose option in git-commit if no verbose is required
when the commit.verbose is true in the configuration file.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 Documentation/config.txt     | 4 ++++
 Documentation/git-commit.txt | 7 ++++++-
 builtin/commit.c             | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 01cca0a..cf2f48b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1110,6 +1110,10 @@ commit.template::
 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
 	specified user's home directory.
 
+commit.verbose::
+	A boolean to specify whether to always include the verbose option
+	with `git commit`. See linkgit:git-commit[1]
+
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9ec6b3c..0972b45 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -290,12 +290,17 @@ configuration variable documented in linkgit:git-config[1].
 	what changes the commit has.
 	Note that this diff output doesn't have its
 	lines prefixed with '#'. This diff will not be a part
-	of the commit message.
+	of the commit message. To activate this option permanently, the
+	configuration variable `commit.verbose` can be set to true.
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
 changes to tracked files.
 
+--override-verbose::
+	Disable verbose for the commit if you have activated it
+	permanently in the configuration variable `commit.verbose`.
+
 -q::
 --quiet::
 	Suppress commit summary message.
diff --git a/builtin/commit.c b/builtin/commit.c
index b3bd2d4..0577968 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -114,6 +114,7 @@ static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int override_verbose;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
@@ -1590,6 +1591,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
+		OPT_BOOL(0, "override-verbose", &override_verbose, N_("override the verbose setting in configuration file")),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		/* end commit message options */
@@ -1654,6 +1656,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
+	if( !override_verbose )
+		if( !verbose )
+			git_config_get_bool("commit.verbose", &verbose);
+
 	if (dry_run)
 		return dry_run_commit(argc, argv, prefix, current_head, &s);
 	index_file = prepare_index(argc, argv, prefix, current_head, 0);

--
https://github.com/git/git/pull/204
