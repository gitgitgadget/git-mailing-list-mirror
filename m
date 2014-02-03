From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 6/9] Teach bisect the --[no-]recurse-submodules option
Date: Mon, 03 Feb 2014 20:51:57 +0100
Message-ID: <52EFF35D.7070908@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:52:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPYp-0001ZX-OI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaBCTwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:52:00 -0500
Received: from mout.web.de ([212.227.15.3]:61665 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbaBCTv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:51:59 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LnS8Q-1VbcV12GA2-00hiNV for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:51:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52EFF25E.6080306@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:m6ui2Ce2HNMVr7FvEvxgARp4v4PwvZXg6/BVW2zPFwzPSLOVfZy
 VKtnguhB4r2Wzavnu2obS0j1E52+FXBaWWTW6aQ7xcNFETfZ52H6iuV4hwZrkwVbKFUAZb+
 1pJ4OXyHZxK4OGoN6bH0tw8SQnlr0PRKEki76Iy3pmhHhSoe3XPSv3N3yRp/qmMSrYLFaiK
 6Ab2T0UZOXwPumxgzweIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241461>

When using this option 'git bisect' will automatically update the work
tree of all initialized submodules (so they match the SHA-1 recorded in
the superproject) in each bisection step. This makes calling 'git
submodule update' eacht time obsolete, which was tedious and error prone.
If the option is given it is stored in the BISECT_RECURSE_SUBMODULES file
in the git directory so that later bisection steps can reuse it. But this
commit only adds the option without any functionality, that will be added
to unpack_trees() in subsequent commits.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-bisect.txt |  5 +++++
 git-bisect.sh                | 29 ++++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index f986c5c..c0aaba8 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -276,6 +276,11 @@ does not require a checked out tree.
 +
 If the repository is bare, `--no-checkout` is assumed.

+include::recurse-submodules-update.txt[]
++
+This option is passed to linkgit:git-checkout[1] when checking out the next
+to be tested commit and is ignored when used together with `--no-checkout`.
+
 EXAMPLES
 --------

diff --git a/git-bisect.sh b/git-bisect.sh
index 73b4c14..ba64a21 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,7 @@
 USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
-git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--no-checkout] [--[no-]recurse-submodules[=<mode>]] [<bad> [<good>...]] [--] [<pathspec>...]
 	reset bisect state and start bisection.
 git bisect bad [<rev>]
 	mark <rev> a known-bad revision.
@@ -91,6 +91,12 @@ bisect_start() {
 		--no-checkout)
 			mode=--no-checkout
 			shift ;;
+		--no-recurse-submodules)
+			recurse_submodules="$1"
+			shift ;;
+		--recurse-submodules*)
+			recurse_submodules="$1"
+			shift ;;
 		--*)
 			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 		*)
@@ -124,9 +130,13 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
+		if test -s "$GIT_DIR/BISECT_RECURSE_SUBMODULES"
+		then
+			recurse_submodules=$(cat "$GIT_DIR/BISECT_RECURSE_SUBMODULES")
+		fi
 		if test "z$mode" != "z--no-checkout"
 		then
-			git checkout "$start_head" -- ||
+			git checkout ${recurse_submodules:+"$recurse_submodules"} "$start_head" -- ||
 			die "$(eval_gettext "Checking out '\$start_head' failed. Try 'git bisect reset <validbranch>'.")"
 		fi
 	else
@@ -168,7 +178,10 @@ bisect_start() {
 		test "z$mode" != "z--no-checkout" ||
 		git update-ref --no-deref BISECT_HEAD "$start_head"
 	} &&
-	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
+	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" && {
+		test -z "$recurse_submodules" ||
+		echo "$recurse_submodules" >"$GIT_DIR/BISECT_RECURSE_SUBMODULES"
+	} &&
 	eval "$eval true" &&
 	echo "git bisect start$orig_args" >>"$GIT_DIR/BISECT_LOG" || exit
 	#
@@ -306,8 +319,13 @@ bisect_next() {
 	bisect_autostart
 	bisect_next_check good

+	if test -f "$GIT_DIR/BISECT_RECURSE_SUBMODULES"
+	then
+		recurse_submodules=$(cat "$GIT_DIR/BISECT_RECURSE_SUBMODULES")
+	fi
+
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
+	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout) ${recurse_submodules:+"$recurse_submodules"}
 	res=$?

 	# Check if we should exit because bisection is finished
@@ -374,7 +392,7 @@ bisect_reset() {
 		usage ;;
 	esac

-	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
+	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout ${recurse_submodules:+"$recurse_submodules"} "$branch" --
 	then
 		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
@@ -397,6 +415,7 @@ bisect_clean_state() {
 	# Cleanup head-name if it got left by an old version of git-bisect
 	rm -f "$GIT_DIR/head-name" &&
 	git update-ref -d --no-deref BISECT_HEAD &&
+	rm -f "$GIT_DIR/BISECT_RECURSE_SUBMODULES" &&
 	# clean up BISECT_START last
 	rm -f "$GIT_DIR/BISECT_START"
 }
-- 
1.9.rc0.28.ge3363ff
