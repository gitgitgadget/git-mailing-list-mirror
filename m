From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH] sha1_file: Remove relative entries limitation
Date: Wed, 31 Aug 2011 14:41:36 +0800
Message-ID: <1314772896-22631-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 08:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyeUo-0006At-3I
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 08:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab1HaGlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 02:41:53 -0400
Received: from mail.windriver.com ([147.11.1.11]:50157 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab1HaGlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 02:41:53 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7V6fPGA007409
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 30 Aug 2011 23:41:25 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 30 Aug 2011 23:41:25 -0700
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180458>

link_alt_odb_entries() will be called recursively if alternates has
valid object store paths, and to avoid nesting too deep, the
recursive depth is limited to 5, this limitation is reasonable and
safe for dead-loop reference situation.

There is another limitation in this function to only permit the 1st
level alternates has relative paths, but there is no foreseeable
greater risk using relative paths in 2nd/3rd... level alternates than
using absolute paths, in addition to we already have max depth 5
limitation, we can safely remove this limitation.

Moreover removing this limitation will make below two usage workable.

usage1: base-repos has relative path in the alternates
        %>git clone --reference base-repos src dest
usage2: src2 has relative path to point src1, src1 has relative path
    	to point src
        %>git clone src2 dest

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 sha1_file.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f7c3408..4130ca0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -332,15 +332,10 @@ static void link_alt_odb_entries(const char *alt, const char *ep, int sep,
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
1.7.6
