From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2] commit.c: use the generic "sha1_pos" function for lookup
Date: Wed, 26 Feb 2014 22:49:22 +0400
Message-ID: <530E3732.3060708@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 19:56:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIjeA-0000Dp-HA
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaBZSzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:55:47 -0500
Received: from forward19.mail.yandex.net ([95.108.253.144]:43748 "EHLO
	forward19.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbaBZSzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:55:46 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2014 13:55:46 EST
Received: from smtp17.mail.yandex.net (smtp17.mail.yandex.net [95.108.252.17])
	by forward19.mail.yandex.net (Yandex) with ESMTP id 24EAE1123E10
	for <git@vger.kernel.org>; Wed, 26 Feb 2014 22:49:23 +0400 (MSK)
Received: from smtp17.mail.yandex.net (localhost [127.0.0.1])
	by smtp17.mail.yandex.net (Yandex) with ESMTP id 02EF31900230
	for <git@vger.kernel.org>; Wed, 26 Feb 2014 22:49:22 +0400 (MSK)
Received: from 212.192.143.238 (212.192.143.238 [212.192.143.238])
	by smtp17.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QUaYbxtruA-nMFaSIq0;
	Wed, 26 Feb 2014 22:49:22 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: a2cb991d-ef0e-473a-a914-debd533ec8f8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393440562;
	bh=6ZhzuOf12hnAXOJz+v4YvrhkBLx+BU3cwPTQ6gbow94=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 Content-Type:Content-Transfer-Encoding;
	b=Ckkz/6QlA377P6poM/1ZdnIo6yFqYj7pI2/+0aQ7JYBm3XjAbqkpc/f9IEimogqi9
	 9CC8tH04d/siJixTSOroUM8fyAlrzj9Z/wHzNyn7PGO7kN7byUoE7V9r3qs2wJeaxP
	 EKvZOBbbEu4qR2PIQIR+p0dISCLdgPewIpZS8ZCw=
Authentication-Results: smtp17.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242746>

Refactor binary search in "commit_graft_pos" function: use
generic "sha1_pos" function.

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 commit.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..6ceee6a 100644
--- a/commit.c
+++ b/commit.c
@@ -10,6 +10,7 @@
 #include "mergesort.h"
 #include "commit-slab.h"
 #include "prio-queue.h"
+#include "sha1-lookup.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
 
@@ -114,23 +115,16 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 static struct commit_graft **commit_graft;
 static int commit_graft_alloc, commit_graft_nr;
 
+static const unsigned char *commit_graft_sha1_access(size_t index, void *table)
+{
+	struct commit_graft **commit_graft_table = table;
+	return commit_graft_table[index]->sha1;
+}
+
 static int commit_graft_pos(const unsigned char *sha1)
 {
-	int lo, hi;
-	lo = 0;
-	hi = commit_graft_nr;
-	while (lo < hi) {
-		int mi = (lo + hi) / 2;
-		struct commit_graft *graft = commit_graft[mi];
-		int cmp = hashcmp(sha1, graft->sha1);
-		if (!cmp)
-			return mi;
-		if (cmp < 0)
-			hi = mi;
-		else
-			lo = mi + 1;
-	}
-	return -lo - 1;
+	return sha1_pos(sha1, commit_graft, commit_graft_nr,
+			commit_graft_sha1_access);
 }
 
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
-- 
1.8.3.2
