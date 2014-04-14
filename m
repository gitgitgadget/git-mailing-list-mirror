From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 20/25] try_merge_strategy(): use a statically-allocated lock_file object
Date: Mon, 14 Apr 2014 15:54:50 +0200
Message-ID: <1397483695-10888-21-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhNY-0002Lx-LN
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbaDNN4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:56:22 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49839 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222AbaDNNzl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:41 -0400
X-AuditID: 1207440c-f79656d000003eba-09-534be8dd89a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FB.47.16058.DD8EB435; Mon, 14 Apr 2014 09:55:41 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09K010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:39 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHv3hXewwc8J7BZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGd8aLvHXPCRv+LXhk1sDYz/eLoY
	OTkkBEwkjn16zQhhi0lcuLeerYuRi0NI4DKjxOqXz6Gck0wSD388B6tiE9CVWNTTzARiiwio
	SUxsO8QCUsQs0M4kcWhHL1hCWCBaomXLbTCbRUBVovfuJBYQm1fAVaLt73ZmiHVyEiePTWbt
	YuTg4ASKL/yQBRIWEnCRuPtlCusERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3QN9XIz
	S/RSU0o3MUKCkWcH47d1MocYBTgYlXh4O+Z4BwuxJpYVV+YeYpTkYFIS5c24ARTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwuu6FSjHm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQWgST
	leHgUJLgNQZGnZBgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDbii4HRAZLiAdqb
	9Bxkb3FBYi5QFKL1FKOilDhvCUhCACSRUZoHNxaWYl4xigN9KcwrAbKdB5ie4LpfAQ1mAhrM
	0g42uCQRISXVwFj8y3VHXP5xiytqxdNPna/oCVrbPeHh69ZGy8zIKbtiGKVbty+OOnnO/u0f
	X5XeH8UPRc6weK82q5Jty/K6evbOvpSH0ts/3PkqPFfuxqIVsspKz4zYjacp6Hzz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246240>

Even the one lockfile object needn't be allocated each time the
function is called.  Instead, define one statically-allocated
lock_file object and reuse it for every call.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9b7e7cb..1efa7b6 100644
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
