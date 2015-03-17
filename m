From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/14] handle_revision_opt(): use convert_i() when handling "-<digit>"
Date: Tue, 17 Mar 2015 17:00:07 +0100
Message-ID: <1426608016-2978-6-git-send-email-mhagger@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtvA-00015M-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbbCQQAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:36 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44997 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996AbbCQQA3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:29 -0400
X-AuditID: 12074413-f79f26d0000030e7-9f-55084f9c54cb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 31.3C.12519.C9F48055; Tue, 17 Mar 2015 12:00:29 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSg023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:28 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqDvXnyPUoGEOo0XXlW4mi4beK8wW
	t1fMZ7Z4fGsCkwOLx9/3H5g85t639Lh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6M34famQtm
	c1R8OH+EtYHxAFsXIyeHhICJxIvOk6wQtpjEhXvrweJCApcZJR4/9O9i5AKyTzJJzF1yA6yI
	TUBXYlFPMxOILSKgJjGx7RALiM0skCLR+ecOO4gtLBAm0bZkFVg9i4CqxJuL8xlBbF4BZ4kL
	Vz+yQyyTkzh//CcziM0p4CLx4s9rRojFzhJrp01mm8DIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrrlebmaJXmpK6SZGSPAI72DcdVLuEKMAB6MSD29DHnuoEGtiWXFl7iFGSQ4mJVHe
	PA+OUCG+pPyUyozE4oz4otKc1OJDjBIczEoivHfcgXK8KYmVValF+TApaQ4WJXFetSXqfkIC
	6YklqdmpqQWpRTBZGQ4OJQleHT+gRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQ
	ZMQXA2MDJMUDtLcCpJ23uCAxFygK0XqKUVFKnDcIJCEAksgozYMbC0sJrxjFgb4U5lUGqeIB
	phO47ldAg5mABre0s4EMLklESEk1MCp9Dt7e9EDuFNfaGfeNQtIz3v5VLn1S35t0/qgQs+vC
	ywZ18pdenRbR2+94hjXtSdiuT9azzzzcXTz/95aJpxO8yvvESre+SaqdtG3iy9BfZ14m2CW+
	MNrYudPc+JGjrnASzwzhyZUn37immh2d/fKMduCW7kVP/ngqZmbxs7xekL7ytdtx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265633>

This tightens up the parsing a bit:

* Leading whitespace is no longer allowed
* '+' and '-' are no longer allowed

It also removes the need to check separately that max_count is
non-negative.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 25838fc..4908e66 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "numparse.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
@@ -1709,8 +1710,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
 		/* accept -<digit>, like traditional "head" */
-		if (strtol_i(arg + 1, 10, &revs->max_count) < 0 ||
-		    revs->max_count < 0)
+		if (convert_i(arg + 1, 10, &revs->max_count))
 			die("'%s': not a non-negative integer", arg + 1);
 		revs->no_walk = 0;
 	} else if (!strcmp(arg, "-n")) {
-- 
2.1.4
