From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 14/14] revert: add t3513 for submodule updates
Date: Thu, 19 Jun 2014 22:12:56 +0200
Message-ID: <53A34448.4070002@web.de>
References: <539DD029.4030506@web.de> <539DD23A.5000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxiiN-0007NQ-S2
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbaFSUNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:13:10 -0400
Received: from mout.web.de ([212.227.17.11]:59158 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757325AbaFSUNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:13:09 -0400
Received: from [192.168.178.41] ([79.193.64.138]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lvk9E-1Wf9893NiG-017YDN; Thu, 19 Jun 2014 22:12:57
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD23A.5000504@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:UscEJVdHSNkWYS+0OTZ32EfrbIrcdQAvJ7kb/1yZc0C4FT2nb3o
 OL/2S8DBO123zPrdnewP8GFAq5bji0vx7QEzO0meL9JjEFOZG3ZwxBlpxmuNPMRVHqNguBe
 C5JijY4aHZ6s+Z1eU8N75aHW2U4CL+vlmjbw7iqOV4632I0BCVpZgoq49Irrp2VX1Q4sKt2
 wQ0L+2NO8117n/ZLAC8xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252180>

Test that the revert command updates the work tree as expected (for
submodule changes which don't result in conflicts). Add a helper function
to first revert the checked out target commit to make the last revert
produce the to-be-tested work tree.

Set the KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT and
KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR switches to
document that revert has the similar failures.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes to v1:

*) use "expect" instead of "expected"


 t/t3513-revert-submodule.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/t3513-revert-submodule.sh

diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
new file mode 100755
index 0000000..a1c4e02
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
+	git status -su >expect &&
+	ls -1pR * >>expect &&
+	tar czf "$TRASH_DIRECTORY/tmp.tgz" * &&
+	git checkout "$1" &&
+	git revert HEAD &&
+	rm -rf * &&
+	tar xzf "$TRASH_DIRECTORY/tmp.tgz" &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expect actual &&
+	git revert HEAD
+}
+
+KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+test_submodule_switch "git_revert"
+
+test_done
-- 
2.0.0.406.gf4dce28
