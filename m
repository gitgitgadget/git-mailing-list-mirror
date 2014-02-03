From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 1/9] submodule: prepare for recursive checkout of submodules
Date: Mon, 03 Feb 2014 20:48:32 +0100
Message-ID: <52EFF290.5090501@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:48:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPVX-0008ES-B5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaBCTsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:48:35 -0500
Received: from mout.web.de ([212.227.15.14]:49801 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309AbaBCTse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:48:34 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MUFGo-1VjMDD08ws-00R1R9 for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:xfU57Zw1fTSkQ32CPdz/YZRqXNdHJpBjPM8v6HVq3YdxCSKx50/
 N04X2sF9zYe6XRxjyjeOkICXMX+qwbOX3Zne8ZYbcFyeoyFooJTyrI+SgKopkr7kk+M1Vhj
 WDHKxGa9NqhG3MGSL4NCo32oogr9iHxQnNcO0y5RxYw8G6CrKnvUuK+3YF0WkjOguXr+mGp
 UQYuKs9wIFeNggMW7Pn0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241456>

This commit adds the functions and files needed for configuration,
documentation, setting the default behavior and determining if a
submodule path should be updated automatically.

It won't really enable recursive submodule update. This will be done
by later commits.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/recurse-submodules-update.txt |  8 +++++
 submodule.c                                 | 50 +++++++++++++++++++++++++++++
 submodule.h                                 |  6 ++++
 3 files changed, 64 insertions(+)
 create mode 100644 Documentation/recurse-submodules-update.txt

diff --git a/Documentation/recurse-submodules-update.txt b/Documentation/recurse-submodules-update.txt
new file mode 100644
index 0000000..e57d452
--- /dev/null
+++ b/Documentation/recurse-submodules-update.txt
@@ -0,0 +1,8 @@
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the work tree of all
+	initialized submodules according to the commit recorded in the
+	superproject if their update configuration is set to checkout'. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail unless forced. Without this option or with
+	--no-recurse-submodules is, the work trees of submodules will not be
+	updated, only the hash recorded in the superproject will be updated.
diff --git a/submodule.c b/submodule.c
index 613857e..b3eb28d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -16,6 +16,8 @@ static struct string_list config_name_for_path;
 static struct string_list config_fetch_recurse_submodules_for_name;
 static struct string_list config_ignore_for_name;
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
+static int option_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
@@ -382,6 +384,48 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	}
 }

+int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (!strcmp(arg, "checkout"))
+			return RECURSE_SUBMODULES_ON;
+		die("bad %s argument: %s", opt, arg);
+	}
+}
+
+int option_parse_update_submodules(const struct option *opt,
+				   const char *arg, int unset)
+{
+	if (unset) {
+		*(int *)opt->value = RECURSE_SUBMODULES_OFF;
+	} else {
+		if (arg)
+			*(int *)opt->value = parse_update_recurse_submodules_arg(opt->long_name, arg);
+		else
+			*(int *)opt->value = RECURSE_SUBMODULES_ON;
+	}
+	return 0;
+}
+
+int submodule_needs_update(const char *path)
+{
+	struct string_list_item *path_option;
+	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
+	if (!path_option)
+		return 0;
+
+	/* update can't be "none", "merge" or "rebase" */
+
+	if (option_update_recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+		return 1;
+	return config_update_recurse_submodules != RECURSE_SUBMODULES_OFF;
+}
+
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
@@ -589,6 +633,12 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 	return ret;
 }

+void set_config_update_recurse_submodules(int default_value, int option_value)
+{
+	config_update_recurse_submodules = default_value;
+	option_update_recurse_submodules = option_value;
+}
+
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 {
 	int is_present = 0;
diff --git a/submodule.h b/submodule.h
index 7beec48..79b336b 100644
--- a/submodule.h
+++ b/submodule.h
@@ -3,6 +3,7 @@

 struct diff_options;
 struct argv_array;
+struct option;

 enum {
 	RECURSE_SUBMODULES_ON_DEMAND = -1,
@@ -22,12 +23,17 @@ void gitmodules_config(void);
 int parse_submodule_config_option(const char *var, const char *value);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+int option_parse_update_submodules(const struct option *opt,
+		const char *arg, int unset);
+int submodule_needs_update(const char *path);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
 void set_config_fetch_recurse_submodules(int value);
+void set_config_update_recurse_submodules(int default_value, int option_value);
 void check_for_new_submodule_commits(unsigned char new_sha1[20]);
 int fetch_populated_submodules(const struct argv_array *options,
 			       const char *prefix, int command_line_option,
-- 
1.9.rc0.28.ge3363ff
