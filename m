From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 04/35] rollback_lock_file(): exit early if lock is not active
Date: Tue, 16 Sep 2014 21:33:25 +0200
Message-ID: <1410896036-12750-5-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:41:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyd2-0003In-3U
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbaIPTlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:41:24 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50602 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754887AbaIPTlX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:41:23 -0400
X-AuditID: 12074412-f792e6d000005517-e7-541890bd0527
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D3.45.21783.DB098145; Tue, 16 Sep 2014 15:34:21 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBc8001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:19 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42IRYndR1N07QSLE4PpldouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOuDj5KnvBD9aKX9dXszYwvmTpYuTkkBAwkei4P48Z
	whaTuHBvPVsXIxeHkMBlRomdJ95BOSeYJDat/8oOUsUmoCuxqKeZCSQhItDGKLHr4mZWEIdZ
	oJtR4v2J00wgVcICARJn9/5jA7FZBFQlZi08CGbzCrhIrDo9AWqfnMSG3f8Zuxg5ODgFXCW+
	7isAMYWASg7e9ZvAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkjg
	Ce1gXH9S7hCjAAejEg+vxyPxECHWxLLiytxDjJIcTEqivP+6JUKE+JLyUyozEosz4otKc1KL
	DzFKcDArifD+8AXK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8N7s
	B2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VGfDEwOkBSPEB7P4K08xYXJOYC
	RSFaTzEac7Q0ve1l4ljX+a2fSYglLz8vVUqc1wakVACkNKM0D24RLOW8YhQH+luY9x1IFQ8w
	XcHNewW0iglo1dkeMZBVJYkIKakGRub+nia3E5PXFu1dc8n/QvL218UCa+vEcnbJ/Sx0X1xf
	X3hLp7X2w1Y7t4IWhzuZW2KVU5bb3/H4P61q24fXDw7nddZ9zvp/1Xn23Fye+4Jl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257161>

Eliminate a layer of nesting.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
---
 lockfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index a548e08..49179d8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -272,10 +272,11 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
-		if (lk->fd >= 0)
-			close(lk->fd);
-		unlink_or_warn(lk->filename);
-		lk->filename[0] = 0;
-	}
+	if (!lk->filename[0])
+		return;
+
+	if (lk->fd >= 0)
+		close(lk->fd);
+	unlink_or_warn(lk->filename);
+	lk->filename[0] = 0;
 }
-- 
2.1.0
