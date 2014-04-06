From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/25] rollback_lock_file(): do not clear filename redundantly
Date: Mon,  7 Apr 2014 01:33:45 +0200
Message-ID: <1396827247-28465-4-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:35:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwbM-000602-GV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbaDFXfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64139 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754575AbaDFXes (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:34:48 -0400
X-AuditID: 12074413-f79076d000002d17-da-5341e497df60
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 00.08.11543.794E1435; Sun,  6 Apr 2014 19:34:47 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbWo011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:34:46 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqDv9iWOwwby72hZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PW3B1sBQtYKuY/e8DcwLiBuYuRk0NCwERiw//5
	jBC2mMSFe+vZuhi5OIQELjNKTFm1jgXCOc4ksaP7LRNIFZuArsSinmYwW0RATWJi2yGwImaB
	G4wS7/YdZgFJCAsEShzvXwVWxCKgKnF4ZQcbiM0r4CKx4tojJoh1chInj01mBbE5BVwl1k2e
	C9YrBFTzbt89tgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihASf
	8A7GXSflDjEKcDAq8fCuPOQYLMSaWFZcmXuIUZKDSUmU1/IeUIgvKT+lMiOxOCO+qDQntfgQ
	owQHs5II74EbQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv0cdA
	jYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg6IgvBsYHSIoHaO9FkHbe4oLEXKAo
	ROspRkUpcV52YFIQEgBJZJTmwY2FpZRXjOJAXwrzPgZp5wGmI7juV0CDmYAGN4TZgQwuSURI
	STUwzlbZtucuW8GGrkORalGMT1T33Vf9Wtq/jV/zY1Ll51yb6cWMoiuW1lzbfMDuTUuGRtaf
	XufXBZ/5FBR8V5cf01ZYUR1eLJHyXufCAvucJ/V8T+Nc0kOF9pVcWX2oVOTQ596o 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245805>

It is only necessary to clear the lock_file's filename field if it was
not already clear.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index d4bfb3f..7701267 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -277,6 +277,6 @@ void rollback_lock_file(struct lock_file *lk)
 		if (lk->fd >= 0)
 			close(lk->fd);
 		unlink_or_warn(lk->filename);
+		lk->filename[0] = 0;
 	}
-	lk->filename[0] = 0;
 }
-- 
1.9.1
