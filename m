From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/22] remove_lock_file(): call rollback_lock_file()
Date: Tue,  1 Apr 2014 17:58:28 +0200
Message-ID: <1396367910-7299-21-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 17:59:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV15r-0006X1-Kc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 17:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbaDAP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 11:59:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60167 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbaDAP7H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:59:07 -0400
X-AuditID: 12074414-f79d96d000002d2b-3a-533ae24bb6b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 27.2D.11563.B42EA335; Tue,  1 Apr 2014 11:59:07 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbO027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:59:05 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqOv9yCrYYMp+XouuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ1xsvEgU8E71opvC68wNzDeZeli5OSQEDCRuHz4HyuELSZx4d56ti5GLg4hgcuMEv3P
	9rNAOMeYJPZs+cUIUsUmoCuxqKeZCcQWEVCTmNh2CGwSs0CKxKu/u8BsYQEXiafv94HVsAio
	Ssxfc5ENxOYFis9q3gu1TU5iyu8F7CA2J1D80oM9YHEhAWeJ028WM09g5F3AyLCKUS4xpzRX
	NzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIySoRHYwHjkpd4hRgINRiYf34HmrYCHWxLLi
	ytxDjJIcTEqivD/uAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8M66CZTjTUmsrEotyodJSXOw
	KInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgvfYAqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1
	LyW1KLG0JCMeFBvxxcDoAEnxAO19BNLOW1yQmAsUhWg9xagoJc7LApIQAElklObBjYWlileM
	4kBfCvO+B6niAaYZuO5XQIOZgAZzrwMbXJKIkJJqYFyz7Lzcg84wZtVZEzO/PFX5vvvo1gdb
	cw0KkoJFv94T5GP6+FVndYJld8oimzSu/X7pbXzN3n+Y/c3D7twIr1U7bKmxTl3G2e9ixV01
	zeTbdh8evtx6zFvfb0Leg//hxiv/Ju7feFoqwa9MOKLKd19x64SuvW96OybNPz2d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245598>

It does exactly what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 3974137..852d717 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -72,12 +72,8 @@ static void remove_lock_file(void)
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->staging_filename.len) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->staging_filename.buf);
-		}
+		if (lock_file_list->owner == me)
+			rollback_lock_file(lock_file_list);
 		lock_file_list = lock_file_list->next;
 	}
 }
-- 
1.9.0
