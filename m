From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 14/14] revert: add t3513 for submodule updates
Date: Sun, 15 Jun 2014 19:04:58 +0200
Message-ID: <539DD23A.5000504@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:05:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDrh-00065e-MX
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbaFORFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:05:06 -0400
Received: from mout.web.de ([212.227.17.12]:49216 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbaFORFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:05:04 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MWjAd-1XGFhg0fed-00XuWq; Sun, 15 Jun 2014 19:04:59
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ywU+/WUdg8/NP+Y4btbZY9yNhLkyI64w2xxzpDTUhPL4g+9TOQM
 qlXnkW01GW58Xj0cjvm2Uw5jaIdu+TXmXNC5Hof3EfGFpI9QdMAltbiHPWGmc5yctyFI/6w
 kDX2A//vz/G1AOjptVCK9mQfkdxozirSvqpRs2o/siw8vcHWHFJmFVrjPkgPQQa2wh0RZK4
 g4FzJf14ngzIf/ROAUZfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251696>

Test that the revert command updates the work tree as expected (for
submodule changes which don't result in conflicts). Add a helper function
to first revert the checked out target commit to make the last revert
produce the to-be-tested work tree.

Set the KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT and
KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR switches to
document that revert has the similar failures.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t3513-revert-submodule.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/t3513-revert-submodule.sh

diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
new file mode 100755
index 0000000..57e2d75
--- /dev/null
+++ b/t/t3513-revert-submodule.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='revert can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+# Create a revert that moves from HEAD (including any test modifications to
+# the work tree) to $1 by first checking out $1 and reverting it. Reverting
+# the revert is the transition we test for. We tar the current work tree
+# first so we can restore the work tree test setup after doing the checkout
+# and revert.  We test here that the restored work tree content is identical
+# to that at the beginning. The last revert is then tested by the framework.
+git_revert () {
+	git status -su >expected &&
+	ls -1pR * >>expected &&
+	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	git checkout "$1" &&
+	git revert HEAD &&
+	rm -rf * &&
+	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expected actual &&
+	git revert HEAD
+}
+
+KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+test_submodule_switch "git_revert"
+
+test_done
-- 
2.0.0.275.gc479268
