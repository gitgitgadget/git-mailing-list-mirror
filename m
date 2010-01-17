From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git status: Show uncommitted submodule changes too when enabled
Date: Sun, 17 Jan 2010 20:42:31 +0100
Message-ID: <4B536827.4070202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: pkufranky@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 20:42:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWb1F-0003dQ-28
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 20:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab0AQTmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 14:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417Ab0AQTmh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 14:42:37 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34817 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab0AQTmg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 14:42:36 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 447A714524742;
	Sun, 17 Jan 2010 20:42:35 +0100 (CET)
Received: from [80.128.115.167] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWb15-000071-00; Sun, 17 Jan 2010 20:42:31 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/nm61bRmzNKzrFE5fpzP/S/tv/k0mPd0pb5vry
	bT7glNJJaVo1SivIlRu9sqIeVdSayQG5ZSXTYbw+j3QcqRPVtY
	3PdEAlOQ+aNiQgkhhURg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137315>

When the configuration variable status.submodulesummary is not 0 or
false, "git status" shows the submodule summary of the staged submodule
commits. But it did not show the summary of those commits not yet
staged in the supermodule, making it hard to see what will not be
committed.

The output of "submodule summary --for-status" has been changed from
"# Modified submodules:" to "# Submodule changes to be committed:" for
the already staged changes. "# Submodules changed but not updated:" has
been added for changes that will not be committed. This is much clearer
and consistent with the output for regular files.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


While looking for ways to teach "git status" how to show dirty
submodules i came across this functionality. I think the output of
only the staged submodule changes is not enough, submodule commits
not staged in the superproject should be shown too (At the time this
functionality was introduced the "--files" option to "git submodule
summary" was missing, so there was no way to show the unstaged
submodule changes back then).


 git-submodule.sh             |    6 +++++-
 t/t7401-submodule-summary.sh |    2 +-
 t/t7508-status.sh            |    4 ++--
 wt-status.c                  |   12 +++++++-----
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 77d2232..664f217 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -688,7 +688,11 @@ cmd_summary() {
 		echo
 	done |
 	if test -n "$for_status"; then
-		echo "# Modified submodules:"
+		if [ -n "$files" ]; then
+			echo "# Submodules changed but not updated:"
+		else
+			echo "# Submodule changes to be committed:"
+		fi
 		echo "#"
 		sed -e 's|^|# |' -e 's|^# $|#|'
 	else
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 6cc16c3..d3c039f 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -213,7 +213,7 @@ EOF
 test_expect_success '--for-status' "
     git submodule summary --for-status HEAD^ >actual &&
     test_cmp actual - <<EOF
-# Modified submodules:
+# Submodule changes to be committed:
 #
 # * sm1 $head6...0000000:
 #
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index cf67fe3..556d0fa 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -579,7 +579,7 @@ cat >expect <<EOF
 #
 #	modified:   dir1/modified
 #
-# Modified submodules:
+# Submodule changes to be committed:
 #
 # * sm 0000000...$head (1):
 #   > Add foo
@@ -672,7 +672,7 @@ cat >expect <<EOF
 #
 #	modified:   dir1/modified
 #
-# Modified submodules:
+# Submodule changes to be committed:
 #
 # * sm 0000000...$head (1):
 #   > Add foo
diff --git a/wt-status.c b/wt-status.c
index 65feb29..5807fc3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -459,7 +459,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	wt_status_print_trailer(s);
 }

-static void wt_status_print_submodule_summary(struct wt_status *s)
+static void wt_status_print_submodule_summary(struct wt_status *s, int uncommitted)
 {
 	struct child_process sm_summary;
 	char summary_limit[64];
@@ -468,11 +468,11 @@ static void wt_status_print_submodule_summary(struct wt_status *s)
 	const char *argv[] = {
 		"submodule",
 		"summary",
-		"--cached",
+		uncommitted ? "--files" : "--cached",
 		"--for-status",
 		"--summary-limit",
 		summary_limit,
-		s->amend ? "HEAD^" : "HEAD",
+		uncommitted ? NULL : (s->amend ? "HEAD^" : "HEAD"),
 		NULL
 	};

@@ -580,8 +580,10 @@ void wt_status_print(struct wt_status *s)
 	wt_status_print_updated(s);
 	wt_status_print_unmerged(s);
 	wt_status_print_changed(s);
-	if (s->submodule_summary)
-		wt_status_print_submodule_summary(s);
+	if (s->submodule_summary) {
+		wt_status_print_submodule_summary(s, 0);  /* staged */
+		wt_status_print_submodule_summary(s, 1);  /* unstaged */
+	}
 	if (s->show_untracked_files)
 		wt_status_print_untracked(s);
 	else if (s->commitable)
-- 
1.6.6.327.g4c0c1.dirty
