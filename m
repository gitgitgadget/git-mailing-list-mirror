From: imyousuf@gmail.com
Subject: [PATCH 3/5] Add Custom argument input support to git submodule recurse subcommand
Date: Sat,  3 May 2008 19:53:31 +0600
Message-ID: <1209822813-12237-3-git-send-email-imyousuf@gmail.com>
References: <1209822813-12237-1-git-send-email-imyousuf@gmail.com>
 <1209822813-12237-2-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 15:55:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsICv-0005Uk-Qc
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbYECNyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbYECNyO
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:54:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbYECNyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:54:13 -0400
Received: by ug-out-1314.google.com with SMTP id h3so301813ugf.16
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WjwDKRoSqoCzsxc4JY5c26keVtPMDkHM9dBj4btxEm0=;
        b=iwS1Y5OwdeNPACNrmJ3Oirffg6yQH7/dPLt2DOsrit8j28wRdjHIrZdx+jtf5LcMIZK7Ji8iapez+k/ulwhRGM1iGjoud226AeWD74tqStaK2uMA0ToXDouxZd6i/E4+VbOoSnGoGzgHL5uoB75VNVwANNuH5cje8PQEuh/5FTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rIVA4b+ttdi0GqWrVaTVk0YoklsMqXs4CKdq1u5QIp2ZopvBSHwS0y5j7sEgesyzj+gfdpb/Kfa6TWcdr4N5sIBSjPaSCHvsdO3h7WgKoVkbUvvLBJXq4Ti6kdBtWF4BvFCvLfiOGrNvWBNko1cxsn1vqd4ot8EDNErCtmC+V8Q=
Received: by 10.66.217.20 with SMTP id p20mr1516088ugg.51.1209822852373;
        Sat, 03 May 2008 06:54:12 -0700 (PDT)
Received: from localhost ( [122.248.32.83])
        by mx.google.com with ESMTPS id 31sm2483653ugg.47.2008.05.03.06.54.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 03 May 2008 06:54:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1209822813-12237-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81081>

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
index e0ea21f..59e58e5 100755
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
@@ -638,10 +674,16 @@ traverse_module()
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
@@ -690,6 +732,9 @@ cmd_recurse() {
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
