From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/3] tag: use skip_prefix instead of magic numbers
Date: Fri, 11 Jul 2014 15:55:45 -0700
Message-ID: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 01:02:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jpR-00015I-Iw
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 01:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaGKXCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 19:02:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:12166 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaGKXCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 19:02:02 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 11 Jul 2014 16:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,646,1400050800"; 
   d="scan'208";a="560731932"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2014 15:55:51 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253345>

From: Jeff King <peff@peff.net>

Make the parsing of the --sort parameter more readable by having
skip_prefix keep our pointer up to date.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Fixed issue with patch in that we dropped the reset to STRCMP_SORT, discovered
by Junio.

 builtin/tag.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ef765563388c..9d7643f127e7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -524,18 +524,14 @@ static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 	int *sort = opt->value;
 	int flags = 0;
 
-	if (*arg == '-') {
+	if (skip_prefix(arg, "-", &arg))
 		flags |= REVERSE_SORT;
-		arg++;
-	}
-	if (starts_with(arg, "version:")) {
+
+	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
 		*sort = VERCMP_SORT;
-		arg += 8;
-	} else if (starts_with(arg, "v:")) {
-		*sort = VERCMP_SORT;
-		arg += 2;
-	} else
+	else
 		*sort = STRCMP_SORT;
+
 	if (strcmp(arg, "refname"))
 		die(_("unsupported sort specification %s"), arg);
 	*sort |= flags;
-- 
2.0.1.475.g9b8d714
