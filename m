From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Add test to ensure that "stg clean" preserves
	conflicting patches
Date: Tue, 29 Jan 2008 04:11:12 +0100
Message-ID: <20080129031014.1095.78501.stgit@yoghurt>
References: <20080129030752.1095.27968.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgsz-0005ho-7P
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYA2DLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbYA2DLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:11:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1866 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641AbYA2DLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:11:14 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgsR-0000bo-00; Tue, 29 Jan 2008 03:11:11 +0000
In-Reply-To: <20080129030752.1095.27968.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71936>

=46rom: Pavel Roskin <proski@gnu.org>

If "stg push" fails, the subsequent "stg clean" will remove the patch
that could not be applied. I think it's wrong. Especially when doing
"stg pull", it can happen that I want to run "stg clean" to get rid of
the patches applied upstream so I can concentrate on the conflict.
Instead, the conflicting patch is removed too.

The test added by this patch should pass once the bug is fixed.

Signed-off-by: Pavel Roskin <proski@gnu.org>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I doctored the commit message a bit, and made the failing test use
test_expect_failure.

 t/t2500-clean.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)


diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index 3364c18..b38d868 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -24,4 +24,21 @@ test_expect_success 'Clean empty patches' '
     [ "$(echo $(stg unapplied))" =3D "" ]
 '
=20
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
+test_expect_failure 'Make sure conflicting patches are preserved' '
+    stg clean &&
+    [ "$(echo $(stg applied))" =3D "p0 p2 p1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
 test_done
