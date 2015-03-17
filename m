From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/14] write_subdirectory(): use convert_ui() for parsing mode
Date: Tue, 17 Mar 2015 17:00:05 +0100
Message-ID: <1426608016-2978-4-git-send-email-mhagger@alum.mit.edu>
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
	id 1YXtv9-00015M-3C
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbbCQQAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:30 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58119 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115AbbCQQA2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:28 -0400
X-AuditID: 1207440c-f79376d00000680a-da-55084f9a7cfa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 70.2F.26634.A9F48055; Tue, 17 Mar 2015 12:00:26 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSe023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:26 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqDvLnyPU4NhXS4uuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZPbvesxTM
	4ahYdeMCawPjC7YuRk4OCQETiZam24wQtpjEhXvrgeJcHEIClxkl7jXvYoJwTjJJ9E6eClbF
	JqArsainmQnEFhFQk5jYdogFxGYWSJHo/HOHHcQWFvCT+DbjDFg9i4CqxPXJF5lBbF4BZ4mD
	L/ZAbZOTOH/8J1icU8BF4sWf12BxIaCatdMms01g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkx
	Ly+1SNdQLzezRC81pXQTIyR8eHYwflsnc4hRgINRiYf3RgF7qBBrYllxZe4hRkkOJiVR3jwP
	jlAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrx33IFyvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJ
	JanZqakFqUUwWRkODiUJ3uV+QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoNiI
	LwZGB0iKB2hvBUg7b3FBYi5QFKL1FKOilDjvfJCEAEgiozQPbiwsKbxiFAf6UphXGaSKB5hQ
	4LpfAQ1mAhrc0s4GMrgkESEl1cDoe1spWPzze42GQ/Ylip2zOKuTJCMrRLUC3iy+b7DfTK15
	VVmHVk2Hl+qivriZxq2hO1iP7Lhzb9mCD/7yD86+FNup/Njs2IpfxolnrZpzE8qNNaWlsrl2
	n5ibey9BLuufwZq5e6w3bOF4we9dX999K37ynYz1e663Pf3jdHeFWGuXnOAdm4dK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265637>

Use convert_ui() instead of strtoul_ui() when parsing tree entries'
modes. This tightens up the parsing a bit:

* Leading whitespace is no longer allowed
* '+' and '-' are no longer allowed

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 contrib/convert-objects/convert-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/convert-objects/convert-objects.c b/contrib/convert-objects/convert-objects.c
index f3b57bf..4f484a4 100644
--- a/contrib/convert-objects/convert-objects.c
+++ b/contrib/convert-objects/convert-objects.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "numparse.h"
 #include "blob.h"
 #include "commit.h"
 #include "tree.h"
@@ -88,7 +89,7 @@ static int write_subdirectory(void *buffer, unsigned long size, const char *base
 		unsigned int mode;
 		char *slash, *origpath;
 
-		if (!path || strtoul_ui(buffer, 8, &mode))
+		if (!path || convert_ui(buffer, 8, &mode))
 			die("bad tree conversion");
 		mode = convert_mode(mode);
 		path++;
-- 
2.1.4
