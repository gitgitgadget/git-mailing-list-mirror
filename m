From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH 1/2] builtin/checkout.c: don't leak memory in check_tracking_name
Date: Mon, 17 Jun 2013 18:40:49 -0700
Message-ID: <1371519650-17869-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	<johan@herland.net>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 03:41:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UokvY-00081q-CU
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 03:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab3FRBlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 21:41:40 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:15124 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab3FRBlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 21:41:39 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate03.nvidia.com
	id <B51bfbc6f0000>; Mon, 17 Jun 2013 18:48:31 -0700
Received: from hqemhub03.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2013 18:39:54 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Mon, 17 Jun 2013 18:39:54 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub03.nvidia.com
 (172.20.150.15) with Microsoft SMTP Server id 8.3.298.1; Mon, 17 Jun 2013
 18:41:23 -0700
X-Mailer: git-send-email 1.8.2.415.g63cec41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228127>

From: Brandon Casey <drafnel@gmail.com>

remote_find_tracking() populates the query struct with an allocated
string in the dst member.  So, we do not need to xstrdup() the string,
since we can transfer ownership from the query struct (which will go
out of scope at the end of this function) to our callback struct, but
we must free the string if it will not be used so we will not leak
memory.

Let's do so.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin/checkout.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f5b50e5..3be0018 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -838,13 +838,16 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 	memset(&query, 0, sizeof(struct refspec));
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
-	    get_sha1(query.dst, cb->dst_sha1))
+	    get_sha1(query.dst, cb->dst_sha1)) {
+		free(query.dst);
 		return 0;
+	}
 	if (cb->dst_ref) {
+		free(query.dst);
 		cb->unique = 0;
 		return 0;
 	}
-	cb->dst_ref = xstrdup(query.dst);
+	cb->dst_ref = query.dst;
 	return 0;
 }
 
-- 
1.8.2.415.g63cec41
