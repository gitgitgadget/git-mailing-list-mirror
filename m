From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v2 4/5] sha1_file: remove relative entries limitation
Date: Tue, 6 Sep 2011 18:24:04 +0800
Message-ID: <1315304645-12009-5-git-send-email-Hui.Wang@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-4-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0spL-00044q-1K
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab1IFKYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:24:18 -0400
Received: from mail.windriver.com ([147.11.1.11]:61511 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab1IFKYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:24:15 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p86ANuCq005036
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Sep 2011 03:23:56 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 6 Sep 2011 03:23:56 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1315304645-12009-4-git-send-email-Hui.Wang@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180791>

From: Hui Wang <Hui.Wang@windriver.com>

link_alt_odb_entries() will be called recursively if alternates has
valid object store paths, to avoid nesting too deep, the recursive
depth is limited to 5, this limitation is reasonable and safe for
dead-loop reference situation.

There is another limitation in this function to only permit the 1st
level alternates has relative paths, the purpose of this limitation
is to avoid inaccurate result when using memcmp() directly to compare
two directory path names, e.g. "./a/b/" and "./a/c/e/../../b" should
be the same dir, but memcmp() will report they are different dirs,
this will introduce the same dir be added twice or dead-loop
reference.

Now we have new method to compare two directories and can handle both
absolute path and relative path comparison, in addition to we already
have max depth 5 limitation, we can safely remove this limitation.

Moreover removing this limitation will make below two usage workable.

usage1: base-repos has relative path in the alternates
        %>git clone --reference base-repos src dest
usage2: src2 has relative path to point src1, src1 has relative path
	to point src
        %>git clone src2 dest

Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 sha1_file.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 18f7fb3..98fdb0a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -329,15 +329,10 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
 		}
 		while (cp < ep && *cp != sep)
 			cp++;
-		if (last != cp) {
-			if (!is_absolute_path(last) && depth) {
-				error("%s: ignoring relative alternate object store %s",
-						relative_base, last);
-			} else {
-				link_alt_odb_entry(last, cp - last,
-						relative_base, depth);
-			}
-		}
+		if (last != cp)
+			link_alt_odb_entry(last, cp - last,
+					relative_base, depth);
+
 		while (cp < ep && *cp == sep)
 			cp++;
 		last = cp;
-- 
1.6.3.1
