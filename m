From: David Reiss <dreiss@facebook.com>
Subject: [PATCH] Prevent git blame from segfaulting on a missing author name
Date: Mon, 21 Dec 2009 20:22:43 -0800
Message-ID: <4B304993.2040600@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 07:52:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMybl-0000eE-GN
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 07:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZLVGiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 01:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZLVGiK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 01:38:10 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:58799 "EHLO
	mailout-snc1.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbZLVGiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 01:38:09 -0500
X-Greylist: delayed 8135 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Dec 2009 01:38:09 EST
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.18] (may be forged))
	by pp01.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id nBM4MYAO022885
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 21 Dec 2009 20:22:34 -0800
Received: from [192.168.1.138] (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.2.213.0; Mon, 21 Dec
 2009 20:22:44 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-12-21_14:2009-12-12,2009-12-21,2009-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0908210000 definitions=main-0912210278
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135572>

The author name should never be missing in a valid commit, but
git shouldn't segfault no matter what is in the object database.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
git blame was segfaulting on a repro produced by piping mtn git_export
from the Pidgin repository to git fast-import.  This was the most obvious
fix, but I'm not sure if it is the best solution.

Here's a script that reproduces the segfault.

#!/bin/sh
set -e
git init
echo line > afile
git add afile
TREE=`git write-tree`
cat >badcommit <<EOF
tree $TREE
author <noname> 1234567890 +0000
committer David Reiss <dreiss@facebook.com> 1234567890 +0000

some message
EOF
COMMIT=`git hash-object -t commit -w badcommit`
echo "git --no-pager blame $COMMIT -- afile"
git --no-pager blame $COMMIT -- afile


 builtin-blame.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index d4e25a5..5e19c79 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1326,7 +1326,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	timepos = tmp;
 
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (tmp > person && *tmp != ' ')
 		tmp--;
 	mailpos = tmp + 1;
 	*tmp = 0;
-- 
1.6.3.3
