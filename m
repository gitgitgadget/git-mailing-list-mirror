From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 10/14] pull: add t5572 for submodule updates
Date: Sun, 15 Jun 2014 19:02:47 +0200
Message-ID: <539DD1B7.4060403@web.de>
References: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 19:02:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDpX-0004Fx-6v
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 19:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbaFORCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 13:02:51 -0400
Received: from mout.web.de ([212.227.15.4]:63508 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbaFORCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 13:02:51 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MGzXS-1X1Bta09T8-00Dp2j; Sun, 15 Jun 2014 19:02:48
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <539DD029.4030506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:rqYrn5Haz3IdotQLt918Pb26vbtDeFqeKXNlzEV2Bc1gUmj3jXn
 vyXPQN026LRY03FSe0qPpjO+M6iVLrjXyxgEPXEXMKfzzVWMQOp4tn8/BAkjU93ch9u41ia
 p6BnrsVMPAl4NevATYLmG/K5KO0useGmLZtMICdqOU7Iphl6CUUBNtPvRTiAxznpQGMjohg
 j3FT2hPxLcb7SIVLKOQSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251692>

Test that the pull command updates the work tree as expected (for
submodule changes which don't result in conflicts) when used without
arguments or with the '--ff', '--ff-only' and '--no-ff' flag each. Add
helper functions to reset the branch to be updated to to the current
HEAD so that pull is doing the transition from HEAD to the given branch.

Set KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES
and KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR to
document that pull has the same --no-ff known failures merge has.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t5572-pull-submodule.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/t5572-pull-submodule.sh

diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
new file mode 100755
index 0000000..accfa5c
--- /dev/null
+++ b/t/t5572-pull-submodule.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='pull can handle submodules'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-submodule-update.sh
+
+reset_branch_to_HEAD () {
+	git branch -D "$1" &&
+	git checkout -b "$1" HEAD &&
+	git branch --set-upstream-to="origin/$1" "$1"
+}
+
+git_pull () {
+	reset_branch_to_HEAD "$1" &&
+	git pull
+}
+
+# pulls without conflicts
+test_submodule_switch "git_pull"
+
+git_pull_ff () {
+	reset_branch_to_HEAD "$1" &&
+	git pull --ff
+}
+
+test_submodule_switch "git_pull_ff"
+
+git_pull_ff_only () {
+	reset_branch_to_HEAD "$1" &&
+	git pull --ff-only
+}
+
+test_submodule_switch "git_pull_ff_only"
+
+git_pull_noff () {
+	reset_branch_to_HEAD "$1" &&
+	git pull --no-ff
+}
+
+KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
+KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
+test_submodule_switch "git_pull_noff"
+
+test_done
-- 
2.0.0.275.gba02dd0
