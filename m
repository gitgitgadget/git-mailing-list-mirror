From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] git-apply: fix rubbish handling in --check case
Date: Wed, 23 Nov 2011 18:26:03 +0200
Message-ID: <1322065563-3651-2-git-send-email-dedekind1@gmail.com>
References: <1322065563-3651-1-git-send-email-dedekind1@gmail.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 17:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTFdX-0004E4-9H
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 17:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab1KWQZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 11:25:22 -0500
Received: from mga14.intel.com ([143.182.124.37]:47267 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab1KWQZU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 11:25:20 -0500
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga102.ch.intel.com with ESMTP; 23 Nov 2011 08:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.69,559,1315206000"; 
   d="scan'208";a="40547026"
Received: from sauron.fi.intel.com ([10.237.72.160])
  by AZSMGA002.ch.intel.com with ESMTP; 23 Nov 2011 08:25:18 -0800
X-Mailer: git-send-email 1.7.6.4
In-Reply-To: <1322065563-3651-1-git-send-email-dedekind1@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185853>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

This patch fixes the following inconsistency:

Let's take my bash binary.

$ ls -l /bin/bash
-rwxr-xr-x. 1 root root 924200 Jun 22 16:49 /bin/bash
$ file /bin/bash
/bin/bash: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, stripped

Let's try to apply it

$ git apply /bin/bash
error: No changes
$ echo $?
1

Good, rejected and error code is returned. Let's try with --check:

$ git apply --check /bin/bash
$ echo $?
0

Not exactly what I expected :-) The same happnes if you use an empty file.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---

Note, I did not extensively test it!

 Makefile        |    2 +-
 builtin/apply.c |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84a8a0b..2d6862a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3596,9 +3596,6 @@ static int write_out_results(struct patch *list, int skipped_patch)
 	int errs = 0;
 	struct patch *l;
 
-	if (!list && !skipped_patch)
-		return error("No changes");
-
 	for (phase = 0; phase < 2; phase++) {
 		l = list;
 		while (l) {
@@ -3741,6 +3738,11 @@ static int apply_patch(int fd, const char *filename, int options)
 	    !apply_with_reject)
 		exit(1);
 
+	if (!list && !skipped_patch) {
+		error("No changes");
+		exit(1);
+	}
+
 	if (apply && write_out_results(list, skipped_patch))
 		exit(1);
 
-- 
1.7.6.4
