From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Look at both unpacked and packed objects for short name
 expansion
Date: Fri, 16 Sep 2005 01:21:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509160120470.3859@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Sep 16 01:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG32x-0004Nz-0K
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 01:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVIOXVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 19:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVIOXVU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 19:21:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51332 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751183AbVIOXVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 19:21:20 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2E4E0135323
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 01:21:19 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 0F3DA59531
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 01:21:19 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id ECDA95938D
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 01:21:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP id AEF8AE27E1
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 01:21:18 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8650>

We used to check for a unique expansion in the unpacked objects, and if
one was found, we forgot to check in the packed objects, too.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 sha1_name.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

213fff36f398fbbbee9b76a9d59339ba60f1d58c
diff --git a/sha1_name.c b/sha1_name.c
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -115,7 +115,8 @@ static int get_short_sha1(const char *na
 	if (i < 4)
 		return -1;
 	if (find_short_object_filename(i, canonical, sha1))
-		return 0;
+                /* do not allow non-unique short names */
+                return find_short_packed_object(i, res, canonical)!=0?-1:0;
 	if (find_short_packed_object(i, res, sha1))
 		return 0;
 	return -1;
