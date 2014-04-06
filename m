From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/25] remove_lock_file(): call rollback_lock_file()
Date: Mon,  7 Apr 2014 01:33:57 +0200
Message-ID: <1396827247-28465-16-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc2-00074B-TG
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbaDFXf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:35:58 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46560 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754648AbaDFXfL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:11 -0400
X-AuditID: 1207440c-f79656d000003eba-41-5341e4ae6483
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 23.41.16058.EA4E1435; Sun,  6 Apr 2014 19:35:10 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX2011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:09 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLvuiWOwweYNRhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PQsxlMBddYKz5tPMbcwHiUpYuRk0NCwERiz5UW
	KFtM4sK99WxdjFwcQgKXGSV2PXjCAuEcZ5JoW/8frIpNQFdiUU8zE4gtIqAmMbHtEFgRs8AN
	Rol3+w6DFQkLuEs8WfKVGcRmEVCVWPHyChuIzSvgKjHvdTMbxDo5iZPHJrOC2JxA8XWT54L1
	Cgm4AM25xzaBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJDg49nB
	+G2dzCFGAQ5GJR7eFYccg4VYE8uKK3MPMUpyMCmJ8j54DBTiS8pPqcxILM6ILyrNSS0+xCjB
	wawkwnvgBlCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PBoSTB2wcyVLAo
	NT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UHfHFwPgASfEA7Z0O0s5bXJCYCxSFaD3F
	qCglzjvzEVBCACSRUZoHNxaWUl4xigN9Kcy7DKSdB5iO4LpfAQ1mAhrcEGYHMrgkESEl1cDo
	ecSg6vulkuwjb0+IP5oxZ07XL5l6SfYnE/v/3V1W3VP1gffXTxmmO/9kA/pZeJZvmbTx1osl
	m3eujTrRxc+oZvH+6hK7xm2XjqTE/66Ik/vNnq/7gq+f8aP62VNlaocuBSwL/nfz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245814>

It does just what we need.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 0879214..f6bee35 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -69,12 +69,8 @@ static void remove_lock_file(void)
 	pid_t me = getpid();
 
 	while (lock_file_list) {
-		if (lock_file_list->owner == me &&
-		    lock_file_list->filename[0]) {
-			if (lock_file_list->fd >= 0)
-				close(lock_file_list->fd);
-			unlink_or_warn(lock_file_list->filename);
-		}
+		if (lock_file_list->owner == me)
+			rollback_lock_file(lock_file_list);
 		lock_file_list = lock_file_list->next;
 	}
 }
-- 
1.9.1
