From: Max Kirillov <max@max630.net>
Subject: [PATCH] strtoul_ui: actually report error in case of negative input
Date: Mon, 14 Sep 2015 01:00:36 +0300
Message-ID: <1442181636-27821-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 00:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbFRZ-0002GC-0u
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 00:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbbIMWHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 18:07:53 -0400
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net ([68.178.252.111]:47583
	"EHLO p3plsmtpa11-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755219AbbIMWHx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2015 18:07:53 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2015 18:07:53 EDT
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa11-10.prod.phx3.secureserver.net with 
	id Gm0e1r00H5B68XE01m0jyy; Sun, 13 Sep 2015 15:00:45 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277795>

If s == "-1" and CPU is i386, then none of the checks is triggered, including
the last "(unsigned int) ul != ul", because ul == 2**32 - 1, which fits into
"unsigned int".

Fix it by changing the last check to trigger earlier, as soon as it
becomes bigger than INT_MAX.

Signed-off-by: Max Kirillov <max@max630.net>
---
This caused failure of "%(contents:lines=-1)` should fail" case from
t6302-for-each-ref-filter.sh for me in pu. Don't know why nobody has noticed
it. It did not trigger errno, instead wrapping the value. I have libc6 2.13
(debian wheezy)

Still can be fooled with carefully chosen negative input. For i386 it's
between INT_MIN and something like -UINT_MIN

Adding people from the commit which uses the function.
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f649e81..1c0229b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -815,7 +815,7 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
 
 	errno = 0;
 	ul = strtoul(s, &p, base);
-	if (errno || *p || p == s || (unsigned int) ul != ul)
+	if (errno || *p || p == s || ul > (unsigned long) INT_MAX)
 		return -1;
 	*result = ul;
 	return 0;
-- 
2.3.4.2801.g3d0809b
