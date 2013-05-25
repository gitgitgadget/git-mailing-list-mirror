From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/25] add_rev_cmdline(): make a copy of the name argument
Date: Sat, 25 May 2013 11:08:02 +0200
Message-ID: <1369472904-12875-4-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAV5-00066M-RE
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab3EYJJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:06 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:59664 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752512Ab3EYJI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:08:57 -0400
X-AuditID: 12074413-b7f226d000000902-7f-51a07fa8da02
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 84.35.02306.8AF70A15; Sat, 25 May 2013 05:08:56 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gud000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:08:55 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUixO6iqLuifkGgQfcEa4uuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZzyaaVnwnb3i1Zbz7A2MK9m6GDk5JARMJH5evMMKYYtJXLi3HijO
	xSEkcJlRovvWF0YI5wKTxOYry5hBqtgEdCUW9TQzgdgiAo4SJx5cZwUpYhboZZR4+Og7WEJY
	wFei49JRoFEcHCwCqhInN9iAhHkFXCQW/D7CCLFNQeLyrDXMICWcAq4Sb09wgoSFgEqefzrH
	OoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkCAT3sG466TcIUYB
	DkYlHl6B8vmBQqyJZcWVuYcYJTmYlER5+WsXBArxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4WVI
	AcrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4PeqAGgWLUtNTK9Iy
	c0oQ0kwcnCCCC2QDD9CGQJBC3uKCxNzizHSIolOMilLivBNBEgIgiYzSPLgBsHTwilEc6B9h
	3gUgVTzAVALX/QpoMBPQ4Ju580EGlyQipKQaGPPcUifHcG9K+ejy72DuSVeD6dt0ZzJ41vBG
	1nbpXqnsfGfzbZ3n/0XKHxbwmEs1flnn/Hde59bEM81aZ68trPUp5977LSz24aHbhSF3m1Vn
	PX2uljfpCeO5uOPcO488l7/SpRv0omx9pug3jzLpjV4a8WpCNauVuydkTPEpMTaK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225511>

Instead of assuming that the memory pointed to by the name argument
will live forever, make a local copy of it before storing it in the
ref_cmdline_info.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 revision.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index a67b615..25e424c 100644
--- a/revision.c
+++ b/revision.c
@@ -898,6 +898,10 @@ static int limit_list(struct rev_info *revs)
 	return 0;
 }
 
+/*
+ * Add an entry to refs->cmdline with the specified information.
+ * *name is copied.
+ */
 static void add_rev_cmdline(struct rev_info *revs,
 			    struct object *item,
 			    const char *name,
@@ -909,7 +913,7 @@ static void add_rev_cmdline(struct rev_info *revs,
 
 	ALLOC_GROW(info->rev, nr + 1, info->alloc);
 	info->rev[nr].item = item;
-	info->rev[nr].name = name;
+	info->rev[nr].name = xstrdup(name);
 	info->rev[nr].whence = whence;
 	info->rev[nr].flags = flags;
 	info->nr++;
-- 
1.8.2.3
