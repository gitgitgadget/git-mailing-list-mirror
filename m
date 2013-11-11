From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule update: remove unnecessary orig_flags variable
Date: Mon, 11 Nov 2013 21:55:52 +0100
Message-ID: <52814458.8090004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:56:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyWc-0004NY-PG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab3KKUzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:55:55 -0500
Received: from mout.web.de ([212.227.15.14]:65478 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab3KKUzy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:55:54 -0500
Received: from [192.168.178.41] ([91.3.132.224]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MIeUW-1ViBRg2dQm-002IZU for <git@vger.kernel.org>;
 Mon, 11 Nov 2013 21:55:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:onWEgI/6N5zjwUtnWXD9jaGep+TxHm13NDFzJkTY7hd1a6crlVS
 TuiuGktYf49VLjnzpnhMGjIwYEL6cPrmxvrluBwRsTNDObIyOzjMrKXArkFwTMLDArueCZi
 t9Zi2gN7tZ5UddW1azJGoUoy3OUMb4QnxP/bt95tgawrllVu+VzCjDjfLQzgJbkg47oJFLH
 U91+EGPAw4iuZL9UesspQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237652>

cmd_update() in the submodule script tries to preserve the options given
on the command line in the "orig_flags" variable to pass them on into the
recursion when the '--recursive' option is given. But this isn't necessary
because all the variables set by the options will be seen in the recursion
too as that is achieved by executing "eval cmd_update".

The same has already been done for cmd_status() in e15bec0ec, so let's
clean up cmd_update() likewise. Also add a test to make sure that a
submodule name given on the command line is not passed into the recursion
(which was the goal of adding the orig_flags variable in 98dbe63db).

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh            |  5 +----
 t/t7406-submodule-update.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 896f1c9..74cbc53 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -706,7 +706,6 @@ cmd_deinit()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -731,7 +730,6 @@ cmd_update()
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
-			orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
 			shift
 			;;
 		--reference=*)
@@ -765,7 +763,6 @@ cmd_update()
 			break
 			;;
 		esac
-		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
 		shift
 	done

@@ -909,7 +906,7 @@ Maybe you want to use 'update --init'?")"
 				prefix="$prefix$sm_path/"
 				clear_local_git_env
 				cd "$sm_path" &&
-				eval cmd_update "$orig_flags"
+				eval cmd_update
 			)
 			res=$?
 			if test $res -gt 0
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f0b3305..2d9db8e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -747,6 +747,17 @@ test_expect_success 'submodule update clone shallow submodule' '
 	 (cd submodule &&
 	  test 1 = $(git log --oneline | wc -l)
 	 )
+)
+'
+
+test_expect_success 'submodule update --recursive drops module name before recursing' '
+	(cd super2 &&
+	 (cd deeper/submodule/subsubmodule &&
+	  git checkout HEAD^
+	 ) &&
+	 git submodule update --recursive deeper/submodule >actual &&
+	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked out" actual
 	)
 '
+
 test_done
-- 
1.8.5.rc1.18.g384525a.dirty
