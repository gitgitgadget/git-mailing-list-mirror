From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] commit -m: commit staged submodules regardless of ignore
 config
Date: Sat, 05 Apr 2014 18:59:36 +0200
Message-ID: <53403678.3060708@web.de>
References: <53403617.7050506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ronald Weiss <weiss.ronald@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 18:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWTwV-0003Sx-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 18:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbaDEQ7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 12:59:40 -0400
Received: from mout.web.de ([212.227.15.14]:52152 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaDEQ7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 12:59:39 -0400
Received: from [192.168.178.41] ([84.132.155.8]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MNtLj-1Wdtel3XqN-007X5Y; Sat, 05 Apr 2014 18:59:36
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53403617.7050506@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:RAxzQJ9BofRdSEpd4uRldtiH56mAStpr/ZMLPfiZ1yCBcsbUP7n
 VbRDt7PAIOe7PoPgG/nGw/TPtjQ5Fgs/AlXB7poPl+urh15dCJYj3dn7VzioEigW3D8/NCK
 pmlXN+M8/FSIHK+7Ggeu5uCxSJoXTdU+MWEetxkH/kNmJRYwRJ/QG82akYo4qwwZbLsTUt6
 bDb/lyFkpdIG4JSytcrlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245783>

The previous commit fixed the problem that the staged but that ignored
submodules did not show up in the status output of the commit command and
weren't committed afterwards either. But when commit doesn't generate the
status output (e.g. when used in a script with '-m') the ignored submodule
will still not be committed. This is because in that case a different code
path is taken which calls index_differs_from() instead of calling the
wt_status functions.

Fix that by calling index_differs_from() from builtin/commit.c with a
diff_options argument value that tells it not ignore any submodule changes
unless the '--ignore-submodules' option is used. Even though this option
isn't yet implemented for cmd_commit() but only for cmd_status() this
prepares cmd_commit() to correctly handle the '--ignore-submodules' option
later. As status and commit share the same ignore_submodule_arg variable
this makes the code more robust against accidental breakage and documents
how to correctly call index_differs_from().

Change the expected result of the test documenting this problem from
failure to success.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/commit.c  | 18 ++++++++++++++++--
 t/t7508-status.sh |  2 +-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..a456a60 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -833,8 +833,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,

 		if (get_sha1(parent, sha1))
 			commitable = !!active_nr;
-		else
-			commitable = index_differs_from(parent, 0);
+		else {
+			/*
+			 * Unless the user did explicitly request a submodule
+			 * ignore mode by passing a command line option we do
+			 * not ignore any changed submodule SHA-1s when
+			 * comparing index and parent, no matter what is
+			 * configured. Otherwise we won't commit any
+			 * submodules which were manually staged, which would
+			 * be really confusing.
+			 */
+			int diff_flags = DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+			if (ignore_submodule_arg &&
+			    !strcmp(ignore_submodule_arg, "all"))
+				diff_flags |= DIFF_OPT_IGNORE_SUBMODULES;
+			commitable = index_differs_from(parent, diff_flags);
+		}
 	}
 	strbuf_release(&committer_ident);

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e6483fc..d480069 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1523,7 +1523,7 @@ EOF
 	test_i18ngrep "^M. sm" output
 '

-test_expect_failure 'git commit -m will commit a staged but ignored submodule' '
+test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
 	 test_i18ngrep ! "^M. sm" output &&
-- 
1.9.1.476.g510abc7
