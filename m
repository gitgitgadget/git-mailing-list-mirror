From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] clone: allow initial sparse checkouts
Date: Sat, 22 Feb 2014 18:31:53 -0800
Message-ID: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 03:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHOri-00037L-Ci
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 03:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbaBWCcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 21:32:10 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:49176 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaBWCcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 21:32:08 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 1E3E633FA02
	for <git@vger.kernel.org>; Sun, 23 Feb 2014 02:32:07 +0000 (UTC)
Received: (qmail 11529 invoked by uid 129); 23 Feb 2014 02:32:05 -0000
X-Spam-Level: *****
X-Spam-Status: No, hits=5.8 required=10.0
	tests=BAYES_00,BOTNET_SHAWCABLE,FH_DATE_ISNT_2012,RCVD_IN_PBL,RCVD_IN_SORBS_DUL
X-Spam-Check-By: orbis-terrarum.net
Received: from S0106dc9fdb28b5c2.vc.shawcable.net (HELO bohr-int.orbis-terrarum.net) (24.85.140.46)
  (smtp-auth username robbat2-bohr@orbis-terrarum.net, mechanism plain)
  by orbis-terrarum.net (qpsmtpd/0.84) with (AES128-GCM-SHA256 encrypted) ESMTPSA; Sun, 23 Feb 2014 02:32:03 +0000
Received: (nullmailer pid 4419 invoked by uid 0);
	Sun, 23 Feb 2014 02:31:58 -0000
X-Mailer: git-send-email 1.9.0.291.g027825b.dirty
X-Virus-Checked: Checked by ClamAV on orbis-terrarum.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242533>

Presently if you want to perform a sparse checkout, you must either do a
full clone and then recheckout, or do a git init, manually set up
sparse, and then fetch and checkout.

This patch implements easily accessible sparse checkouts during clone,
in the --sparse-checkout option.

$ git clone REPO --sparse-checkout PATH

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 Documentation/git-clone.txt |  5 +++++
 builtin/clone.c             | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0363d00..1c21207 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
+	  [--sparse-checkout <path>]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
 
@@ -209,6 +210,10 @@ objects from the source repository into a pack in the cloned repository.
 	The result is Git repository can be separated from working
 	tree.
 
+--sparse-checkout <path>::
+	Perform the initial checkout as a sparse checkout, checking out only the
+	paths specified by this option. This option may occur multiple times, with
+	one path per instance.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin/clone.c b/builtin/clone.c
index 43e772c..1137371 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -48,6 +48,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static struct string_list option_config;
 static struct string_list option_reference;
+static struct string_list option_sparse_checkout_path;
 
 static int opt_parse_reference(const struct option *opt, const char *arg, int unset)
 {
@@ -97,6 +98,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST(0, "sparse-checkout", &option_sparse_checkout_path, N_("path"),
+			N_("set path for sparse checkout")),
 	OPT_END()
 };
 
@@ -270,6 +273,24 @@ static void setup_reference(void)
 	for_each_string_list(&option_reference, add_one_reference, NULL);
 }
 
+static void setup_sparse_checkout(void)
+{
+	FILE *info_sparse_checkout_fp;
+	struct string_list_item *item;
+	char *path = git_pathdup("info/sparse-checkout");
+	git_config_set("core.sparsecheckout", "true");
+	safe_create_leading_directories(path);
+	info_sparse_checkout_fp = fopen(path, "w");
+	if (!info_sparse_checkout_fp)
+		die(_("unable to create %s"), path);
+	for_each_string_list_item(item, &option_sparse_checkout_path) {
+		fprintf(info_sparse_checkout_fp, "%s\n", item->string);
+	}
+	fclose(info_sparse_checkout_fp);
+	adjust_shared_perm(path);
+	free(path);
+}
+
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 			    const char *src_repo)
 {
@@ -873,6 +894,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
 
+	if(option_sparse_checkout_path.nr)
+		setup_sparse_checkout();
+
 	git_config(git_default_config, NULL);
 
 	if (option_bare) {
-- 
1.9.0.291.g027825b.dirty
