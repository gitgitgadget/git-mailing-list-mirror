From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/12] prune_remote(): use delete_refs()
Date: Sat, 13 Jun 2015 16:42:09 +0200
Message-ID: <aab9d191609b34fbfee0b68883a5b14fba2421ad.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3me1-0007iJ-RU
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbFMOmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51272 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753008AbbFMOm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:26 -0400
X-AuditID: 1207440e-f79fc6d000000caf-ef-557c41526554
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9C.2D.03247.2514C755; Sat, 13 Jun 2015 10:42:26 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpU026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:25 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqBvkWBNqsPmJvEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M972TmEq2MlR8e81ewPjG7YuRk4OCQETiWNbWhkhbDGJC/fWA8W5OIQELjNKXD86CaxI
	SOAEk8Snd6ogNpuArsSinmYmEFtEQE1iYtshFpAGZoEORokLy7exgySEBawlPn/vAWtmEVCV
	mPr4DpjNKxAlcfliC9RmOYnzx38ydzFycHAKWEi8bMqE2GUu8XZFO+sERt4FjAyrGOUSc0pz
	dXMTM3OKU5N1i5MT8/JSi3SN9XIzS/RSU0o3MULCiW8HY/t6mUOMAhyMSjy8GbHVoUKsiWXF
	lbmHGCU5mJREeSP3AIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8Apq14QK8aYkVlalFuXDpKQ5
	WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeK/ZAzUKFqWmp1akZeaUIKSZODhBhnNJiRSn
	5qWkFiWWlmTEg+IivhgYGSApHqC9D0HaeYsLEnOBohCtpxgVpcR5b4EkBEASGaV5cGNhSeIV
	ozjQl8K850GqeIAJBq77FdBgJqDB7T1VIINLEhFSUg2MIiXLq/yi576O5NA3NjcKk45SVexy
	Mp7WbWAsvMq7qGPPYcMPuht3F11UKpz/bfZVM0WB9oTZbLdLmiLFSuImXni49emOFSuCWK8J
	TIw++WRlmvCr9ozkZSkOWW13KqLvK8/cMHuJ/z7bdbIzHx/XjW1h+bhuubR15fqf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271549>

This will result in errors being emitted for references that can't be
deleted, but that is a good thing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c8dc724..cc3c741 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1314,19 +1314,12 @@ static int prune_remote(const char *remote, int dry_run)
 		string_list_append(&refs_to_prune, item->util);
 	string_list_sort(&refs_to_prune);
 
-	if (!dry_run) {
-		struct strbuf err = STRBUF_INIT;
-		if (repack_without_refs(&refs_to_prune, &err))
-			result |= error("%s", err.buf);
-		strbuf_release(&err);
-	}
+	if (!dry_run)
+		result |= delete_refs(&refs_to_prune);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
 
-		if (!dry_run)
-			result |= delete_ref(refname, NULL, 0);
-
 		if (dry_run)
 			printf_ln(_(" * [would prune] %s"),
 			       abbrev_ref(refname, "refs/remotes/"));
-- 
2.1.4
