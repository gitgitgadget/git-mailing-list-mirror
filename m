From: Laurent Arnoud <laurent@spkdev.net>
Subject: [PATCH] Add the tag.gpgsign option to sign all created tags
Date: Sat, 19 Mar 2016 19:23:10 +0100
Message-ID: <20160319182310.GA23124@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 19 19:32:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahLfe-0007Ev-DC
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 19:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbcCSScN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 14:32:13 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:46022 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbcCSScL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 14:32:11 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Mar 2016 14:32:11 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id D0922FF00A;
	Sat, 19 Mar 2016 18:23:11 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289322>

The tag.gpgsign config option allows to sign all
commits automatically.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 Documentation/config.txt |  3 +++
 builtin/tag.c            | 19 ++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..076c68a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2729,6 +2729,9 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+tag.gpgSign::
+	A boolean to specify whether all tags created should be GPG signed.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..53cad28 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -29,6 +29,7 @@ static const char * const git_tag_usage[] = {
 };
 
 static unsigned int colopts;
+static const char *sign_tag;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
@@ -166,6 +167,11 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
+	if (!strcmp(var, "tag.gpgsign")) {
+		sign_tag = git_config_bool(var, value) ? "" : NULL;
+		return 0;
+	}
+
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
 	return git_default_config(var, value, cb);
@@ -381,14 +387,21 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (argc == 0 && !cmdmode)
+		cmdmode = 'l';
+
+	/* Remove config option when calling command other than create tag */
+	if (cmdmode != 0 && sign_tag)
+		sign_tag = NULL;
+
 	if (keyid) {
 		opt.sign = 1;
 		set_signing_key(keyid);
 	}
-	if (opt.sign)
+	if (opt.sign || sign_tag) {
+		opt.sign = 1;
 		annotate = 1;
-	if (argc == 0 && !cmdmode)
-		cmdmode = 'l';
+	}
 
 	if ((annotate || msg.given || msgfile || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
-- 
2.7.0


-- 
Laurent
