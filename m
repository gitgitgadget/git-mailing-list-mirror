From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 26/32] try_merge_strategy(): use a statically-allocated lock_file object
Date: Sat,  6 Sep 2014 09:50:40 +0200
Message-ID: <1409989846-22401-27-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnY-0000OH-MW
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbaIFHwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:37 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42594 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbaIFHwf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:35 -0400
X-AuditID: 12074413-f79ed6d000002501-07-540abd430441
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.53.09473.34DBA045; Sat,  6 Sep 2014 03:52:35 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHP006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:33 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixO6iqOu8lyvE4NNHfouuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujAdTpjEVLOav2LftP1MD4xGeLkZODgkBE4kTO9rYIWwxiQv31rN1
	MXJxCAlcZpSYePYoI4RzjEni65VTLCBVbAK6Eot6mplAEiICbYwSuy5uZgVJMAukSHQ872YE
	sYUFoiVuNp0Bi7MIqEq8n3GPCcTmFXCVmPB4OhPEOjmJDbv/g9VzAsWnN3WC2UICLhLtJ/uZ
	JjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokREmrCOxh3nZQ7xCjA
	wajEw1vgwBUixJpYVlyZe4hRkoNJSZQ3bzlQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvx2Sg
	HG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgrd5D1CjYFFqempFWmZO
	CUKaiYMTZDiXlEhxal5KalFiaUlGPCg64ouB8QGS4gHa2wjSzltckJgLFIVoPcWoy7Gu81s/
	kxBLXn5eqpQ4LxNIkQBIUUZpHtwKWGJ5xSgO9LEw70SQKh5gUoKb9ApoCRPQEvN0TpAlJYkI
	KakGxslnvR+Ht/pfvT39qwpb5665V18beD76sSqsznnRt77otTOPzLmxRfzEhEa71DkLZR2P
	HkhLOpU7/Xu5cOy1O29eJ6RNdNJKcL+49d+U46d3tqpe9Jq4t5D1asju3dxtFo4a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256556>

Even the one lockfile object needn't be allocated each time the
function is called.  Instead, define one statically-allocated
lock_file object and reuse it for every call.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0f5c185..d2415fe 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -657,14 +657,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head, const char *head_arg)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	static struct lock_file lock;
 
-	hold_locked_index(lock, 1);
+	hold_locked_index(&lock, 1);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
-	rollback_lock_file(lock);
+	rollback_lock_file(&lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
@@ -696,13 +696,13 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
-		hold_locked_index(lock, 1);
+		hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
-		    write_locked_index(&the_index, lock, COMMIT_LOCK))
+		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
-		rollback_lock_file(lock);
+		rollback_lock_file(&lock);
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(strategy, xopts_nr, xopts,
-- 
2.1.0
