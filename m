From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] Let submodule command exit with error status if path does
	not exist
Date: Thu, 9 Aug 2012 22:03:04 +0200
Message-ID: <20120809200302.GA93203@book.hvoigt.net>
References: <1340872080.2103.92.camel@athena.dnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Milde <daniel@milde.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzYx6-0002VY-2k
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 22:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759512Ab2HIUDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 16:03:22 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:42963 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759378Ab2HIUDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 16:03:21 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SzYwp-0007Zp-Q6; Thu, 09 Aug 2012 22:03:12 +0200
Content-Disposition: inline
In-Reply-To: <1340872080.2103.92.camel@athena.dnet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203179>

Previously the exit status of git submodule was zero for various
subcommands even though the user specified an unknown path.

The reason behind that was that they all pipe the output of module_list
into the while loop which then does the action on the paths specified by
the commandline. Since piped commands are run in parallel the status
code of module_list was swallowed.

We work around this by introducing a new function module_list_valid
which is used to check the leftover commandline parameters passed to
module_list.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 git-submodule.sh           | 19 ++++++++++++++++++-
 t/t7400-submodule-basic.sh | 26 ++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index aac575e..1fd21da 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -103,13 +103,21 @@ resolve_relative_url ()
 	echo "${is_relative:+${up_path}}${remoteurl#./}"
 }
 
+module_list_ls_files() {
+	git ls-files --error-unmatch --stage -- "$@"
+}
+
+module_list_valid() {
+	module_list_ls_files "$@" >/dev/null
+}
+
 #
 # Get submodule info for registered submodules
 # $@ = path to limit submodule list
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" |
+	module_list_ls_files "$@" |
 	perl -e '
 	my %unmerged = ();
 	my ($null_sha1) = ("0" x 40);
@@ -434,6 +442,8 @@ cmd_init()
 		shift
 	done
 
+	module_list_valid "$@" || exit 1
+
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
@@ -532,6 +542,8 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
+	module_list_valid "$@" || exit 1
+
 	cloned_modules=
 	module_list "$@" | {
 	err=
@@ -929,6 +941,8 @@ cmd_status()
 		shift
 	done
 
+	module_list_valid "$@" || exit 1
+
 	module_list "$@" |
 	while read mode sha1 stage sm_path
 	do
@@ -996,6 +1010,9 @@ cmd_sync()
 			;;
 		esac
 	done
+
+	module_list_valid "$@" || exit 1
+
 	cd_to_toplevel
 	module_list "$@" |
 	while read mode sha1 stage sm_path
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c73bec9..3a40334 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -258,6 +258,27 @@ test_expect_success 'init should register submodule url in .git/config' '
 	test_cmp expect url
 '
 
+test_failure_with_unknown_submodule() {
+	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
+	grep "^error: .*no-such-submodule" output.err
+}
+
+test_expect_success 'init should fail with unknown submodule' '
+	test_failure_with_unknown_submodule init
+'
+
+test_expect_success 'update should fail with unknown submodule' '
+	test_failure_with_unknown_submodule update
+'
+
+test_expect_success 'status should fail with unknown submodule' '
+	test_failure_with_unknown_submodule status
+'
+
+test_expect_success 'sync should fail with unknown submodule' '
+	test_failure_with_unknown_submodule sync
+'
+
 test_expect_success 'update should fail when path is used by a file' '
 	echo hello >expect &&
 
@@ -418,10 +439,7 @@ test_expect_success 'moving to a commit without submodule does not leave empty d
 '
 
 test_expect_success 'submodule <invalid-path> warns' '
-
-	git submodule no-such-submodule 2> output.err &&
-	grep "^error: .*no-such-submodule" output.err
-
+	test_failure_with_unknown_submodule
 '
 
 test_expect_success 'add submodules without specifying an explicit path' '
-- 
1.7.12.rc2.10.g45a4861
