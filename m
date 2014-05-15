From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 10/10] git-submodule.sh: don't use the -a or -o option with the test command
Date: Thu, 15 May 2014 07:21:50 -0700
Message-ID: <1400163710-28333-10-git-send-email-gitter.spiros@gmail.com>
References: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 16:22:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwYC-00007i-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbaEOOWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:22:09 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:47939 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbaEOOWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:22:03 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so1163750pbb.17
        for <git@vger.kernel.org>; Thu, 15 May 2014 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j+Km1lBc66nsN0GKOkNbigIUvq/HWViCFGcIedyMIB4=;
        b=gumqd1He0xrQpYnCXsHvtZsff5HzlPMLI6v3BTcdiRPimDAB9AsRu5ss4+lXuZm61d
         +5n/0qsAfKyOJIvjf8eFejbyyMDqndbDXFoPsLsaVOUamBjau0hpIMKtFPdrxv4qtgge
         ogoMIWhk7hhhbE7qQNQ/wlTvNkdK7msb5aZWCkZ3SsqBKuk0w6VxLT8y3OgkPCujmCvj
         cDWf+KCeUJ5VhEsfxn96QdLIq9J/iGDZVE675+O4rltWlVYTeAHObMciAUL6+GJw7Ukc
         SWzbmKvULY6cbgeXJFxZBoV7VMAy7+iEsryQCtg3SN0tSiqBDS8EBphyqJqI/c9vR4/0
         +HZQ==
X-Received: by 10.68.201.97 with SMTP id jz1mr12800654pbc.26.1400163723230;
        Thu, 15 May 2014 07:22:03 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id sy2sm9397666pbc.28.2014.05.15.07.22.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 May 2014 07:22:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400163710-28333-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249098>

Even though POSIX.1 lists -a/-o as options to "test", they are
marked "Obsolescent XSI". Scripts using these expressions
should be converted  as follow:

test "$1" -a "$2"

should be written as:

test "$1" && test "$2"

Likewise

test "$1" -o "$2"

should be written as:

test "$1"  test "$2"

But note that, in test, -a has higher precedence than -o while
"&&" and "||" have equal precedence in the shell.

The reason for this is that the precedence rules were never well
specified, and this made many sane-looking uses of "test -a/-o" problematic.

For example, if $x is "=", these work according to POSIX (it's not
portable, but in practice it's okay):

   $ test -z "$x"
   $ test -z "$x" && test a = b

but this doesn't

   $ test -z "$x" -a a = b
   bash: test: too many arguments

because it groups "test -n = -a" and is left with "a = b".

Similarly, if $x is "-f", these

   $ test "$x"
   $ test "$x" || test c = d

correctly adds an implicit "-n", but this fails:

   $ test "$x" -o c = d
   bash: test: too many arguments

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Inspired from this discussion http://permalink.gmane.org/gmane.comp.version-control.git/137056

 git-submodule.sh |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b55d83a..d89e1d0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -864,7 +864,7 @@ Maybe you want to use 'update --init'?")"
 		then
 			subforce=$force
 			# If we don't already have a -f flag and the submodule has never been checked out
-			if test -z "$subsha1" -a -z "$force"
+			if test -z "$subsha1" || test -z "$force"
 			then
 				subforce="-f"
 			fi
@@ -1059,13 +1059,13 @@ cmd_summary() {
 		while read mod_src mod_dst sha1_src sha1_dst status sm_path
 		do
 			# Always show modules deleted or type-changed (blob<->module)
-			test $status = D -o $status = T && echo "$sm_path" && continue
+                        ( test $status = D || test $status = T ) && echo "$sm_path" && continue
 			# Respect the ignore setting for --for-status.
 			if test -n "$for_status"
 			then
 				name=$(module_name "$sm_path")
 				ignore_config=$(get_submodule_config "$name" ignore none)
-				test $status != A -a $ignore_config = all && continue
+				test $status != A && test $ignore_config = all && continue
 			fi
 			# Also show added or modified modules which are checked out
 			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
@@ -1125,7 +1125,7 @@ cmd_summary() {
 		*)
 			errmsg=
 			total_commits=$(
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				range="$sha1_src...$sha1_dst"
 			elif test $mod_src = 160000
@@ -1162,7 +1162,7 @@ cmd_summary() {
 			# i.e. deleted or changed to blob
 			test $mod_dst = 160000 && echo "$errmsg"
 		else
-			if test $mod_src = 160000 -a $mod_dst = 160000
+			if test $mod_src = 160000 && test $mod_dst = 160000
 			then
 				limit=
 				test $summary_limit -gt 0 && limit="-$summary_limit"
@@ -1233,7 +1233,7 @@ cmd_status()
 			say "U$sha1 $displaypath"
 			continue
 		fi
-		if test -z "$url" || ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
+		if test -z "$url" || ! test -d "$sm_path"/.git || test -f "$sm_path"/.git
 		then
 			say "-$sha1 $displaypath"
 			continue;
@@ -1402,7 +1402,7 @@ then
 fi
 
 # "--cached" is accepted only by "status" and "summary"
-if test -n "$cached" && test "$command" != status -a "$command" != summary
+if test -n "$cached" && test "$command" != status && test "$command" != summary
 then
 	usage
 fi
-- 
1.7.10.4
