From: imyousuf@gmail.com
Subject: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input support to git submodule recurse subcommand
Date: Mon,  5 May 2008 15:09:40 +0600
Message-ID: <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 11:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JswjI-0004wk-HN
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 11:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbYEEJKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 05:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbYEEJKk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 05:10:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64628 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbYEEJKj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 05:10:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1027289nfc.21
        for <git@vger.kernel.org>; Mon, 05 May 2008 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ryjgWzCAn2FiZ2JKqYU8XXWknOydjF9E5EM7vLxgfeo=;
        b=BbPYBZDy5xxc14aHlctgCEEtoZwCChp3EF8trx62Oa5NwsMFjlW2CFeP9C1bh85W7hgtFISrOtGcLgTX0okjnIHSyTHrcfsFTmP9Xh70uFaldxHIx+QPuOSCS6VC8Qe9tmeoMiPtt8oNr0xPn3qLeoTt5rKcFczLdT1Zpm4heK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bm2FY2gAeTAItasJ+i9h0+mky54VuOjtWXTeFQOh+oOF4Ut/h0M4rp0sZf47UdBS+GoRknSrB7WrYjJIISIIm4JplhKYx0BrTTZjQTdLH5uUEIz9qnFq79q6PXmz3VRIIMziaQ8W//sxSZmi2qOLD0nsmPvdsDZ6z1y7RAP9TZw=
Received: by 10.210.47.1 with SMTP id u1mr5365147ebu.133.1209978638775;
        Mon, 05 May 2008 02:10:38 -0700 (PDT)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id d23sm25219766nfh.11.2008.05.05.02.10.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 May 2008 02:10:37 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81259>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

There is a scenario which has been put forward several times in
discussion over the recurse subcommand and it is that commands chould have
different arguments for different modules.

For example, one module could want to checkout 'master', while another might want
to checkout 'work'. The [-a|--customized-argument] argument provides platform
just for that. Consider the following command and its followup for further info:

	git submodule recurse -a checkout

	Submodule b is not initialized and skipped
	git submodule recurse a checkout
	Please provide an argument: master
	Press y to provide another arg...
	git checkout master
	Already on branch "master"
	Submodule d is not initialized and skipped
	git submodule recurse . checkout
	Please provide an argument: master
	Press y to provide another arg...
	git checkout master
	Already on branch "master"

This command would also come in handy for diffs and other commands.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 git-submodule.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8161d51..314652d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -12,7 +12,7 @@ LONG_USAGE="$0 add [-q|--quiet] [-b|--branch branch] <repository> [<path>]
 $0 [status] [-q|--quiet] [-c|--cached] [--] [<path>...]
 $0 init|update [-q|--quiet] [--] [<path>...]
 $0 summary [--cached] [-n|--summary-limit <n>] [<commit>]
-$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] <git command> [<args> ...]"
+$0 recurse [-q|--quiet] [-e|--exit-after-error] [-d|--depth <recursion depth>] [-b|--breadth-first] [-a|--customized-argument] <git command> [<args> ...]"
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
@@ -25,6 +25,8 @@ depth=0
 current_depth=0
 depth_first=1
 on_error=
+use_custom_args=
+custom_args=
 
 #
 # print stuff on stdout unless -q was specified
@@ -585,6 +587,40 @@ cmd_status()
 	done
 }
 
+# Take arguments from user to pass as custom arguments and execute the command
+exec_with_custom_args()
+{
+	input=
+	arg_index=0
+	eval_str="set "
+	while test $# -gt 0
+	do
+		arg_index=$(($arg_index + 1))
+		var='$'"$arg_index"
+		input="$1"
+		eval_str="$eval_str $var \"$input\""
+		shift
+	done
+	while :
+	do
+		arg_index=$(($arg_index + 1))
+		printf "Please provide an argument: "
+		read input
+		var='$'"$arg_index"
+		eval_str="$eval_str $var \"$input\""
+		printf "Press y to provide another arg... "
+		read keypress
+		if test "$keypress" != "y" &&
+			test "$keypress" != "Y"
+		then
+			break
+		fi
+	done
+	eval $eval_str
+	say "$*"
+	"$@"
+}
+
 # Check whether the submodule is initialized or not
 initialize_sub_module()
 {
@@ -637,10 +673,16 @@ traverse_module()
 		# If depth-first is specified in that case submodules are
 		# are traversed before executing the command on this submodule
 		test -n "$depth_first" && traverse_submodules "$@"
-		# pwd is mentioned in order to enable the ser to distinguish
-		# between same name modules, e.g. a/lib and b/lib.
 		say "git submodule recurse $submod_path $*"
-		git "$@"
+		if test -n "$use_custom_args"
+		then
+			# Execute the commands after taking the arguments
+			# Please note that one input is for one argument
+			# only.
+			exec_with_custom_args git "$@"
+		else
+			git "$@"
+		fi
 		# if exit on error is specifed than script will exit if any
 		# command fails. As there is no transaction there will be
 		# no rollback either
@@ -689,6 +731,9 @@ cmd_recurse() {
 		-e|--exit-after-error)
 			on_error=1
 			;;
+		-a|--customized-argument)
+			use_custom_args=1
+			;;
 		-*)
 			usage
 			;;
-- 
1.5.4.2
