From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 09/14] rebase: add t3426 for submodule updates
Date: Thu, 19 Jun 2014 22:12:51 +0200
Message-ID: <53A34443.3070301@web.de>
References: <539DD029.4030506@web.de> <539DD19B.6000504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxiht-0006fa-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbaFSUNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 16:13:05 -0400
Received: from mout.web.de ([212.227.15.14]:64862 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757325AbaFSUND (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 16:13:03 -0400
Received: from [192.168.178.41] ([79.193.64.138]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MMFFF-1X5AQT27jh-0081vE; Thu, 19 Jun 2014 22:12:52
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD19B.6000504@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:j2KCXvmdHKgzMQYgaYuthlPM/iyfLAWYlxXaE4vYzIM/iS1kBVA
 jj57vZifoZ5K1AjnQZ1ktkddfV/tLU5vEvm6gWcVgbb+wFtp+8IEKXTtXsFOhIk6ZmvUboD
 iVav5K8zrorYqkb9idItZK1E+Up4UZf65IOpa/q0jKkAP1CqmVHysNY8L1cPuxHOVPJb113
 4w2Pbg3yb7IbpB4bAtegw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252179>

Test that the rebase command updates the work tree as expected for
changes which don't result in conflicts. To make that work add two
helper functions that add a commit only touching files and then
revert it. This allows to rebase the target commit over these two
and to compare the result.

Set KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR to
document that "replace directory with submodule" fails for an
interactive rebase because a directory "sub1" already exists.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Changes to v1:

*) fix broken &&-chain (you have this as "SQUASH???" commit in pu)

*) use "expect" instead of "expected"


 t/t3426-rebase-submodule.sh | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 t/t3426-rebase-submodule.sh

diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
new file mode 100755
index 0000000..d5b896d
--- /dev/null
+++ b/t/t3426-rebase-submodule.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='rebase can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+git_rebase () {
+	git status -su >expect &&
+	ls -1pR * >>expect &&
+	git checkout -b ours HEAD &&
+	echo x >>file1 &&
+	git add file1 &&
+	git commit -m add_x &&
+	git revert HEAD &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expect actual &&
+	git rebase "$1"
+}
+
+test_submodule_switch "git_rebase"
+
+git_rebase_interactive () {
+	git status -su >expect &&
+	ls -1pR * >>expect &&
+	git checkout -b ours HEAD &&
+	echo x >>file1 &&
+	git add file1 &&
+	git commit -m add_x &&
+	git revert HEAD &&
+	git status -su >actual &&
+	ls -1pR * >>actual &&
+	test_cmp expect actual &&
+	set_fake_editor &&
+	echo "fake-editor.sh" >.git/info/exclude &&
+	git rebase -i "$1"
+}
+
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+# The real reason "replace directory with submodule" fails is because a
+# directory "sub1" exists, but we reuse the suppression added for merge here
+test_submodule_switch "git_rebase_interactive"
+
+test_done
-- 
2.0.0.406.gf4dce28
