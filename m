From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [RFC PATCH] Record a single transaction for conflicting push
	operations
Date: Thu, 17 Dec 2009 23:22:12 +0000
Message-ID: <20091217232212.4869.43002.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gustav =?utf-8?b?SMOlbGxiZXJn?= <gustav@virtutech.com>,
	Karl Wiberg <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 00:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLPfs-0008Op-8J
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 00:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484AbZLQXWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2009 18:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759197AbZLQXWS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 18:22:18 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:21383 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758100AbZLQXWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 18:22:16 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20091217232215.EEAH17277.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Thu, 17 Dec 2009 23:22:15 +0000
Received: from [127.0.1.1] (really [86.9.126.106])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20091217232215.OIQ13254.aamtaout01-winn.ispmail.ntl.com@[127.0.1.1]>;
          Thu, 17 Dec 2009 23:22:15 +0000
User-Agent: StGit/0.15-28-gdf0b9
X-Cloudmark-Analysis: v=1.1 cv=1ggfb5FlKZQUfF3vzm9UBYZ2uTfLsbs/8dSljwg5+mE= c=1 sm=0 a=FpfSDvT_KwoA:10 a=pGLkceISAAAA:8 a=5HExe6NRAAAA:8 a=hHMng47ZAAAA:8 a=V2qzGUorRXw6kvE2wJIA:9 a=CpuUN7WvwZsqgPzhN8AA:7 a=iZ_Gk-l8eQUDHdbjbBQppFCWVUcA:4 a=MSl-tDqOz04A:10 a=G3pnvarxzbsA:10 a=ePXRMeZs6ywA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135386>

StGit commands resulting in a conflicting patch pushing record two
transactions in the log (with one of them being inconsistent with HEAD
!=3D top). Undoing such operations requires two "stg undo" (possibly wi=
th
--hard) commands which is unintuitive. This patch changes such
operations to only record one log entry and "stg undo" reverts the stac=
k
to the state prior to the operation.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Gustav H=C3=A5llberg <gustav@virtutech.com>
Cc: Karl Wiberg <kha@treskal.com>
---
 stgit/lib/transaction.py |    5 +++--
 t/t3103-undo-hard.sh     |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 30a153b..fad5ab4 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -232,8 +232,9 @@ class StackTransaction(object):
             self.__stack.patchorder.hidden =3D self.__hidden
             log.log_entry(self.__stack, msg)
         old_applied =3D self.__stack.patchorder.applied
-        write(self.__msg)
-        if self.__conflicting_push !=3D None:
+        if not self.__conflicting_push:
+            write(self.__msg)
+        else:
             self.__patches =3D _TransPatchMap(self.__stack)
             self.__conflicting_push()
             write(self.__msg + ' (CONFLICT)')
diff --git a/t/t3103-undo-hard.sh b/t/t3103-undo-hard.sh
index 2d0f382..df14b1f 100755
--- a/t/t3103-undo-hard.sh
+++ b/t/t3103-undo-hard.sh
@@ -46,11 +46,11 @@ test_expect_success 'Try to undo without --hard' '
=20
 cat > expected.txt <<EOF
 EOF
-test_expect_failure 'Try to undo with --hard' '
+test_expect_success 'Try to undo with --hard' '
     stg undo --hard &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
-    test "$(echo $(stg series))" =3D "> p1 - p2 - p3" &&
+    test "$(echo $(stg series))" =3D "+ p1 + p2 > p3" &&
     test "$(stg id)" =3D "$(stg id $(stg top))"
 '
=20
