From: Pavel Roskin <proski@gnu.org>
Subject: stg clean removes conflicting patch
Date: Thu, 24 Jan 2008 22:55:17 -0500
Message-ID: <1201233317.2811.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 04:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIFfQ-00079r-2X
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 04:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYAYDzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 22:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYAYDzU
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 22:55:20 -0500
Received: from c60.cesmail.net ([216.154.195.49]:54779 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbYAYDzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 22:55:19 -0500
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 24 Jan 2008 22:55:18 -0500
Received: from [192.168.1.21] (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id C1CF3618FE1;
	Thu, 24 Jan 2008 22:55:17 -0500 (EST)
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71676>

Hello!

If "stg push" fails, the subsequent "stg clean" will remove the patch
that could not been applied.  I think it's wrong.  Especially when doing
"stg pull", it can happen that I want to run "stg clean" to get rid of
the patches applied upstream so I can concentrate on the conflict.
Instead, the conflicting patch is removed too.

I've made a patch for the testsuite that should pass once the bug is
fixed.  Try removing "stg clean" from the test. and it will pass.  But
"stg clean" should make no difference here.

Add test to ensure that "stg clean" preserves conflicting patches

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 t/t2500-clean.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)


diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index 3364c18..ad8f892 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -24,4 +24,21 @@ test_expect_success 'Clean empty patches' '
     [ "$(echo $(stg unapplied))" = "" ]
 '
 
+test_expect_success 'Create a conflict' '
+    stg new p1 -m p1 &&
+    echo bar > foo.txt &&
+    stg refresh &&
+    stg pop &&
+    stg new p2 -m p2
+    echo quux > foo.txt &&
+    stg refresh &&
+    ! stg push
+'
+
+test_expect_success 'Make sure conflicting patches are preserved' '
+    stg clean &&
+    [ "$(echo $(stg applied))" = "p0 p2 p1" ] &&
+    [ "$(echo $(stg unapplied))" = "" ]
+'
+
 test_done


-- 
Regards,
Pavel Roskin
