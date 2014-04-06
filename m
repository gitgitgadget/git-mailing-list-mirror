From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/25] try_merge_strategy(): use a statically-allocated lock_file object
Date: Mon,  7 Apr 2014 01:34:02 +0200
Message-ID: <1396827247-28465-21-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc5-00074B-Mf
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbaDFXgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:64154 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754654AbaDFXfV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:21 -0400
X-AuditID: 12074413-f79076d000002d17-0f-5341e4b82582
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B3.08.11543.8B4E1435; Sun,  6 Apr 2014 19:35:20 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX7011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:18 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqLvjiWOwwe5LKhZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+PEz89sBR/5K9ZeXMfawPiPp4uRk0NCwERi+57F
	jBC2mMSFe+vZuhi5OIQELjNKrDkznQnCOc4k8Xh7GytIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoEbjBLv9h1mAUkIC0RLvJ75CayIRUBVomt2A3sXIwcHr4CrxIajxhDb5CROHpsMNpMTKLxu
	8lywViEBF6Ax99gmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRES
	esI7GHedlDvEKMDBqMTDu/KQY7AQa2JZcWXuIUZJDiYlUd4Hj4FCfEn5KZUZicUZ8UWlOanF
	hxglOJiVRHgP3ADK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeN2B
	MSYkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2uoG08xYXJOYC
	RSFaTzEqSonzsoMkBEASGaV5cGNhCeUVozjQl8K8cSBVPMBkBNf9CmgwE9DghjA7kMEliQgp
	qQZGT7da9Z3nVne9eda12PnNPHfz/+X5y/t4D2X7RUbuuvqyO6OGQeWo/85qpaaj2mtrH+yZ
	7XdbwV31NJvUfeNp5oqa9vPN+z9qKm93jrdWnbC15glrlpPx5VzbQ07Lf0dPzWbf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245819>

Even the one lockfile object needn't be allocated each time the
function is called.  Instead, define one statically-allocated
lock_file object and reuse it for every call.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f714961..0cde893 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -657,16 +657,16 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head, const char *head_arg)
 {
+	static struct lock_file lock;
 	int index_fd;
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 
-	index_fd = hold_locked_index(lock, 1);
+	index_fd = hold_locked_index(&lock, 1);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
 			(write_cache(index_fd, active_cache, active_nr) ||
-			 commit_locked_index(lock)))
+			 commit_locked_index(&lock)))
 		return error(_("Unable to write index."));
-	rollback_lock_file(lock);
+	rollback_lock_file(&lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
@@ -699,14 +699,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
-		index_fd = hold_locked_index(lock, 1);
+		index_fd = hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
 				(write_cache(index_fd, active_cache, active_nr) ||
-				 commit_locked_index(lock)))
+				 commit_locked_index(&lock)))
 			die (_("unable to write %s"), get_index_file());
-		rollback_lock_file(lock);
+		rollback_lock_file(&lock);
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(strategy, xopts_nr, xopts,
-- 
1.9.1
