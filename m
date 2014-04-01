From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/22] hold_lock_file_for_append(): release lock on errors
Date: Tue,  1 Apr 2014 17:58:14 +0200
Message-ID: <1396367910-7299-7-git-send-email-mhagger@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:00:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV173-0006Y5-EX
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbaDAQAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 12:00:23 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56969 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbaDAP6q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2014 11:58:46 -0400
X-AuditID: 1207440d-f79d86d0000043db-b4-533ae23530dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.07.17371.532EA335; Tue,  1 Apr 2014 11:58:45 -0400 (EDT)
Received: from michael.fritz.box (p57A2460D.dip0.t-ipconnect.de [87.162.70.13])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s31FwWbA027325
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 1 Apr 2014 11:58:43 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqGv6yCrY4Nh0TouuK91MFg29V5gt
	bq+Yz2zx6/ATdosfLT3MDqwef99/YPLYOesuu8ez3j2MHhcvKXt83iQXwBrFbZOUWFIWnJme
	p2+XwJ3x7GsnW0EXe8WC1s/sDYzHWLsYOTkkBEwkZmz6xQhhi0lcuLeerYuRi0NI4DKjxOL3
	O9khnGNMEv8/H2AGqWIT0JVY1NPMBGKLCKhJTGw7xAJiMwukSLz6uwvMFhbwkjj++BJYPYuA
	qkTXxJNgNq+As0Tz5ilQm+UkpvxewA5icwq4SFx6sAcsLgRUc/rNYuYJjLwLGBlWMcol5pTm
	6uYmZuYUpybrFicn5uWlFuka6eVmluilppRuYoQEFe8Oxv/rZA4xCnAwKvHwHjxvFSzEmlhW
	XJl7iFGSg0lJlPfHXaAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5ZN4FyvCmJlVWpRfkwKWkO
	FiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJ3msPgBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT
	81JSixJLSzLiQbERXwyMDpAUD9DelSDtvMUFiblAUYjWU4yKUuK8IQ+BEgIgiYzSPLixsFTx
	ilEc6Eth3k0g7TzANAPX/QpoMBPQYO51YINLEhFSUg2MFemJEdkHH5o5fGBsjr/1pGCTTlH4
	8W2djx33XKhe4bOgYfs1k0P9D/rNvd7F17T9FA/umBqXkhbYsu2Ai68y3881zaJc3rr+j1n5
	HzldmK+0o0ri/BKPeVeW2Wz/5Xg/4enuXJmUjOtMPYz/1l988UBk8RNe8cp5e16n 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245611>

If there is an error copying the old contents to the lockfile, roll
back the lockfile before exiting so that the lockfile is not held
until process cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1928e5e..e679e4c 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -212,13 +212,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 		if (errno != ENOENT) {
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
-			close(fd);
+			rollback_lock_file(lk);
 			return error("cannot open '%s' for copying", path);
 		}
 	} else if (copy_fd(orig_fd, fd)) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
-		close(fd);
+		rollback_lock_file(lk);
 		return -1;
 	}
 	return fd;
-- 
1.9.0
