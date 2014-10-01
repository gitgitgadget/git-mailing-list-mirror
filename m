From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 26/38] try_merge_strategy(): use a statically-allocated lock_file object
Date: Wed,  1 Oct 2014 12:28:30 +0200
Message-ID: <1412159322-2622-27-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAE-0002kF-Tq
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbaJAK3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:36 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62633 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751644AbaJAK3e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:34 -0400
X-AuditID: 12074412-f792e6d000005517-8b-542bd78ec32b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C2.2A.21783.E87DB245; Wed,  1 Oct 2014 06:29:34 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6P026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:32 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1O27rh1icP2/gEXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3BnHf0xhK1jMX9Fx8D5zA+MRni5G
	Tg4JAROJZS8WMEHYYhIX7q1n62Lk4hASuMwo8bjrAZRznEliTc8JNpAqNgFdiUU9zWAdIgJq
	EhPbDrGAFDELLGaSmHBoE1iRsEC0xJeNl4FsDg4WAVWJFU/UQMK8Ai4SvbfXsUFsk5PYsPs/
	I4jNCRRffrmZBcQWEnCW2HHnK9MERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9HIz
	S/RSU0o3MUKCUWgH4/qTcocYBTgYlXh4FRK0Q4RYE8uKK3MPMUpyMCmJ8i66BBTiS8pPqcxI
	LM6ILyrNSS0+xCjBwawkwpt9ACjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgm
	K8PBoSTBy3ANqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFBvxxcDoAEnxAO11
	BmnnLS5IzAWKQrSeYtTlWNf5rZ9JiCUvPy9VSpw39CpQkQBIUUZpHtwKWOp5xSgO9LEwbzjI
	KB5g2oKb9ApoCRPQkuQ1YEtKEhFSUg2Mq5SKOHPabzDqSK569LzfflP67jNr7VRFrMVTtob0
	z9gctHdT0/zF7epJ14MM27c9i3IoYD3w+/68zZsW7LZnfM1gfOBksWeRmXbgx12a 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257713>

Even the one lockfile object needn't be allocated each time the
function is called.  Instead, define one statically-allocated
lock_file object and reuse it for every call.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 1ec3939..be07f27 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -656,14 +656,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
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
@@ -695,13 +695,13 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
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
