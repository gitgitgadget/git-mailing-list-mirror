From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH] commit.c: use the generic "sha1_pos" function for lookup
 sha1
Date: Wed, 26 Feb 2014 14:07:47 +0400
Message-ID: <530DBCF3.9060801@yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020405000504030006080905"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 11:08:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIbQ1-0002Ta-PB
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbaBZKIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:08:45 -0500
Received: from forward2h.mail.yandex.net ([84.201.187.147]:59703 "EHLO
	forward2h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaBZKIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:08:43 -0500
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
	by forward2h.mail.yandex.net (Yandex) with ESMTP id 8885C702269
	for <git@vger.kernel.org>; Wed, 26 Feb 2014 14:08:25 +0400 (MSK)
Received: from smtp2h.mail.yandex.net (localhost [127.0.0.1])
	by smtp2h.mail.yandex.net (Yandex) with ESMTP id 504EB1703CAE
	for <git@vger.kernel.org>; Wed, 26 Feb 2014 14:08:25 +0400 (MSK)
Received: from unknown (unknown [31.181.66.29])
	by smtp2h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id o8vVf0HrVn-8OMOog3b;
	Wed, 26 Feb 2014 14:08:24 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 381e04dd-c989-444b-810e-490a82d2470d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393409304;
	bh=Xq4s2D2SrIYj4JufkDlASFseNgFJwy5f7BJEqye555M=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 Content-Type;
	b=UBhUL3iOHwu4Y/uF189QVpcx2y83KQDgEl2LhWw8FkjtBJo/epWJB0SO5DJbbDYjT
	 /c3BFIRnguiKCokSPaYOYjygUfwIQXIqAsidJ76j/TgTylvs6KCUt6UnnibBAzAhiS
	 94nqTtGa2TiAqQoo7Ahg3doqhzI3PX3G0NSIyu44=
Authentication-Results: smtp2h.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242706>

This is a multi-part message in MIME format.
--------------020405000504030006080905
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit

Refactor binary search in "commit_graft_pos" function: use
generic "sha1_pos" function.

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 commit.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..8edaeb7 100644
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
+			   commit_graft_sha1_access);
 }
  int register_commit_graft(struct commit_graft *graft, int ignore_dups)
-- 
1.8.5.3


--------------020405000504030006080905
Content-Type: text/plain; charset=UTF-8;
 name="=?windows-1251?Q?=D7=E0=F1=F2=FC_=E2=EB=EE=E6=E5=ED=ED=EE=E3=EE_=F1=EE?=
 =?windows-1251?Q?=EE=E1=F9=E5=ED=E8=FF?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0*=windows-1251''%D7%E0%F1%F2%FC%20%E2%EB%EE%E6%E5%ED%ED%EE%E3%EE;
 filename*1*=%20%F1%EE%EE%E1%F9%E5%ED%E8%FF


--------------020405000504030006080905--
