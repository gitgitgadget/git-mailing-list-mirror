From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 27/39] try_merge_strategy(): use a statically-allocated lock_file object
Date: Fri, 26 Sep 2014 12:08:27 +0200
Message-ID: <1411726119-31598-28-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSTI-0004Bi-Oz
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbaIZKJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:37 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61424 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755693AbaIZKJf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:35 -0400
X-AuditID: 12074413-f79ed6d000002501-f3-54253b5e08b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 44.C9.09473.E5B35245; Fri, 26 Sep 2014 06:09:34 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMC013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:33 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1I2zVg0xuP1XzqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oz+474Fi/krDvf/YGpgPMLTxcjB
	ISFgIvH+SUoXIyeQKSZx4d56ti5GLg4hgcuMEneOfGKBcDYxSdybeJYRpIpNQFdiUU8zE4gt
	IqAmMbHtEFgRs8BiJokJhzaxgUwVFoiWaHoSAlLDIqAqsfLZOXYQm1fAVWLLsZPsENvkJDbs
	/g82kxMo3rj9GpgtJOAi0bJ+MssERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIz
	S/RSU0o3MUICUXgH466TcocYBTgYlXh4b6xTCRFiTSwrrsw9xCjJwaQkyvvFQjVEiC8pP6Uy
	I7E4I76oNCe1+BCjBAezkgjvHSOgHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoR
	TFaGg0NJgveiJVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgu4ouBkQGS4gHa
	y2UFsre4IDEXKArReopRl2Nd57d+JiGWvPy8VClx3iMgOwRAijJK8+BWwNLOK0ZxoI+FeW+A
	VPEAUxbcpFdAS5iAligdUQZZUpKIkJJqYPQ2nBDJ29bnWLGOb4Ps3wKlXk+LydLLBJ99/N/3
	IbirwXjVzwdOMi2VDVNt0gMtajlChUMb5D7EO0VOeLPg6Z4Ssz+Pd0x8vXNGbFLp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257513>

Even the one lockfile object needn't be allocated each time the
function is called.  Instead, define one statically-allocated
lock_file object and reuse it for every call.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index cb8f709..c7fa3bc 100644
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
