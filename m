From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v6 5/7] submodule: fix segmentation fault in submodule--helper clone
Date: Mon, 29 Feb 2016 14:58:33 -0800
Message-ID: <1456786715-24256-6-git-send-email-jacob.e.keller@intel.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 23:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWm8-0005RY-M3
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcB2W6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:58:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:52385 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbcB2W6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:58:40 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,521,1449561600"; 
   d="scan'208";a="661447400"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.65])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Feb 2016 14:58:38 -0800
X-Mailer: git-send-email 2.7.1.429.g45cd78e
In-Reply-To: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287926>

From: Jacob Keller <jacob.keller@gmail.com>

The git submodule--helper clone command will fail with a segmentation
fault when given a null url or null path variable. Since these are
required for proper functioning of the submodule--helper clone
subcommand, add checks to prevent running and fail gracefully when
missing.

Update the usage string to reflect the requirement that the --url and
--path "options" are required.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
This bug was discovered when trying to test the usage string of the
previous change. I bisected and this has been in the submodule--helper
code since the first iteration of module_clone. I am not really sure how
much we care, since only internal callers will be using
submodule--helper, but I suspect that it was not intended to segfault.

I fixed the usage string to remove the [] around the url and path
options, hopefully indicating they aren't "optional". Alternatively we
could start requiring them as regular arguments if we wanted.

Note the error message resulting from --url="" or --path="" are not very
obvious but they do not result in a segfault so I didn't check for those
in this patch.

 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3c4d3ff7f4af..35ae85a7e1bc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -186,15 +186,15 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
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
+	if (argc || !url || !path)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
-- 
2.7.1.429.g45cd78e
