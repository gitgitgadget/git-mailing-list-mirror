From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v6 0/7] submodule--helper credential.* pass into submodule
Date: Mon, 29 Feb 2016 14:58:28 -0800
Message-ID: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 23:58:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWm3-0005OM-BS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbcB2W6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:58:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:52381 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbcB2W6i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:58:38 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 29 Feb 2016 14:58:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; 
   d="scan'208";a="661447392"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 14:58:37 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287928>

From: Jacob Keller <jacob.keller@gmail.com>

This series implements ability to pass the credential.* configuration
variables from the command line directly into the submodule. The other
patches in this series are small fixups noticed along the way.

--> Interdiff between v5 and v6 <--

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 43943eef81b4..3d37c3f1822d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -140,18 +140,18 @@ static int submodule_config_ok(const char *var)
 
 static int sanitize_submodule_config(const char *var, const char *value, void *data)
 {
-	struct strbuf quoted = STRBUF_INIT;
 	struct strbuf *out = data;
 
 	if (submodule_config_ok(var)) {
 		if (out->len)
 			strbuf_addch(out, ' ');
 
-		sq_quotef(out, "%s=%s", var, value);
+		if (value)
+			sq_quotef(out, "%s=%s", var, value);
+		else
+			sq_quote_buf(out, var);
 	}
 
-	strbuf_release(&quoted);
-
 	return 0;
 }
 
@@ -235,16 +235,17 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
-		   "[--reference <repository>] [--name <name>] [--url <url>]"
-		   "[--depth <depth>] [--path <path>]"),
+		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
+		   "--url <url> --path <path>"),
 		NULL
 	};
 
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
-	if (argc)
-		usage(*git_submodule_helper_usage);
+	if (argc || !url || !path)
+		usage_with_options(git_submodule_helper_usage,
+				   module_clone_options);
 
 	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
 	sm_gitdir = strbuf_detach(&sb, NULL);

Jacob Keller (6):
  submodule: don't pass empty string arguments to submodule--helper
    clone
  submodule: check argc count for git submodule--helper clone
  submodule: fix submodule--helper clone usage
  submodule: fix segmentation fault in submodule--helper clone
  quote: implement sq_quotef()
  git: submodule honor -c credential.* from command line

Michael J Gruber (1):
  t/lib-httpd: load mod_unixd

 builtin/submodule--helper.c  | 76 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh             | 40 ++++++++++++++---------
 quote.c                      | 13 ++++++++
 quote.h                      |  3 ++
 t/lib-httpd/apache.conf      |  3 ++
 t/t5550-http-fetch-dumb.sh   | 17 ++++++++++
 t/t7412-submodule--helper.sh | 26 +++++++++++++++
 7 files changed, 160 insertions(+), 18 deletions(-)
 create mode 100755 t/t7412-submodule--helper.sh

-- 
2.7.1.429.g45cd78e
