From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 18/35] commit_lock_file(): if close fails, roll back
Date: Tue, 16 Sep 2014 21:33:39 +0200
Message-ID: <1410896036-12750-19-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWY-0000L7-Va
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbaIPTeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:44 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43316 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755051AbaIPTen (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:43 -0400
X-AuditID: 1207440e-f79da6d0000002fc-f4-541890d3b6ba
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9A.49.00764.3D098145; Tue, 16 Sep 2014 15:34:43 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcM001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:41 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1L08QSLE4NcNdouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOuHhoD1tBB3vFtZb57A2Ml1i7GDk5JARMJD6sX8wM
	YYtJXLi3nq2LkYtDSOAyo8SFrmtgCSGBE0wSOxokQGw2AV2JRT3NTCBFIgJtjBK7Lm5mBXGY
	BboZJd6fOM0EUiUs4C6x9dludhCbRUBVYlPTQjYQm1fAVWLd9G1Qq+UkNuz+z9jFyMHBCRT/
	uq8AxBQScJE4eNdvAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSmlmxgh
	Yce3g7F9vcwhRgEORiUeXo9H4iFCrIllxZW5hxglOZiURHn/dUuECPEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLh/eELlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfDO
	6wdqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFRnwxMDZAUjxAezeDtPMWFyTm
	AkUhWk8xGnO0NL3tZeJY1/mtn0mIJS8/L1VKnNcGpFQApDSjNA9uESzhvGIUB/pbmHcLSBUP
	MFnBzXsFtIoJaNXZHjGQVSWJCCmpBsbtE9plLrha3VRX3JC5eoKJiezzluqlW2dKLlX69Wjx
	K/fA9ZntzvZqHIEBv15tuHcnrK2wyfj3nH8684vWMV8N5Xor0xTS5jl7i+fU+Td8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257151>

If closing an open lockfile fails, then we cannot be sure of the
contents of the lockfile, so there is nothing sensible to do but
delete it.  This change also leaves the lock_file object in a defined
state in this error path (namely, unlocked).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 6436111..becb3da 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -315,8 +315,12 @@ int commit_lock_file(struct lock_file *lk)
 	if (!lk->filename[0])
 		die("BUG: attempt to commit unlocked object");
 
-	if (lk->fd >= 0 && close_lock_file(lk))
+	if (lk->fd >= 0 && close_lock_file(lk)) {
+		int save_errno = errno;
+		rollback_lock_file(lk);
+		errno = save_errno;
 		return -1;
+	}
 
 	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-- 
2.1.0
