From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/4] difftool: Allow specifying unconfigured commands with --extcmd
Date: Sat,  9 Jan 2010 20:02:42 -0800
Message-ID: <1263096163-15743-3-git-send-email-davvid@gmail.com>
References: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 10 05:03:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTp1c-0002Bl-Gt
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 05:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab0AJEDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 23:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536Ab0AJEDI
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 23:03:08 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:44885 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab0AJEDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 23:03:06 -0500
Received: by mail-yw0-f176.google.com with SMTP id 6so20613351ywh.4
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 20:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kADbB98+Z7GYkr3ZDo8CbDo7U69hNV7BOJhw9x0RMEg=;
        b=U6nouoJhCLAne4NT8pdPH/v8Xn3Kmj3OnMRqOr7wmD/fbkD0as/ZdFeHvoLdHNae0m
         2CxKAKAzGQgB3sFbKpJ/ABnn0Sx9Q490FS0uMO0V9ArcVwGK33gnZ2hvrJTl5+d8vajC
         wy8uJ/62mKobhJumU49A5wwsCbqcgNjxyY8XE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Ot+cVc+VL16ezGFHs90iR6qjuRkNarDovHf7wzX65m7cmetZQ3xCNBELfhE8+NLHXF
         2TtTB/whzDFbJljlMpqxaxH3M5IktovABY3z4/Ybn5xgLL77kC834LMM0W5OmmRWTAIm
         /e9l+eC6EucUXovZ102GP5WspNFUFuHDDO8dQ=
Received: by 10.101.181.32 with SMTP id i32mr5249614anp.7.1263096185853;
        Sat, 09 Jan 2010 20:03:05 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm9925783yxf.41.2010.01.09.20.03.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 20:03:01 -0800 (PST)
X-Mailer: git-send-email 1.6.6.4.g20a38b.dirty
In-Reply-To: <1263096163-15743-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136553>

git-difftool requires difftool.<tool>.cmd configuration even when
tools use the standard "$diffcmd $from $to" form.  This teaches
git-difftool to run these tools in lieu of configuration by
allowing the command to be specified on the command line.

Reference: http://article.gmane.org/gmane.comp.version-control.git/133377
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/git-difftool.txt |    5 +++++
 git-difftool--helper.sh        |   30 +++++++++++++++++++++++-------
 git-difftool.perl              |    4 ++++
 t/t7800-difftool.sh            |   19 ++++++++++++++++++-
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index a5bce62..f67d2db 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -58,6 +58,11 @@ is set to the name of the temporary file containing the contents
 of the diff post-image.  `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$LOCAL`.
 
+--extcmd=<command>::
+	Specify a custom command for viewing diffs.
+	'git-difftool' ignores the configured defaults and runs
+	`$command $LOCAL $REMOTE` when this option is specified.
+
 -g::
 --gui::
 	When 'git-difftool' is invoked with the `-g` or `--gui` option
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 3621f28..d806eae 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -19,6 +19,11 @@ should_prompt () {
 	fi
 }
 
+# Indicates that --extcmd=... was specified
+use_ext_cmd () {
+	test -n "$GIT_DIFFTOOL_EXTCMD"
+}
+
 launch_merge_tool () {
 	# Merged is the filename as it appears in the work tree
 	# Local is the contents of a/filename
@@ -33,18 +38,29 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt; then
 		printf "\nViewing: '$MERGED'\n"
-		printf "Hit return to launch '%s': " "$merge_tool"
+		if use_ext_cmd; then
+			printf "Hit return to launch '%s': " \
+				"$GIT_DIFFTOOL_EXTCMD"
+		else
+			printf "Hit return to launch '%s': " "$merge_tool"
+		fi
 		read ans
 	fi
 
-	run_merge_tool "$merge_tool"
+	if use_ext_cmd; then
+		$GIT_DIFFTOOL_EXTCMD "$LOCAL" "$REMOTE"
+	else
+		run_merge_tool "$merge_tool"
+	fi
+
 }
 
-# GIT_DIFF_TOOL indicates that --tool=... was specified
-if test -n "$GIT_DIFF_TOOL"; then
-	merge_tool="$GIT_DIFF_TOOL"
-else
-	merge_tool="$(get_merge_tool)" || exit
+if ! use_ext_cmd; then
+	if test -n "$GIT_DIFF_TOOL"; then
+		merge_tool="$GIT_DIFF_TOOL"
+	else
+		merge_tool="$(get_merge_tool)" || exit
+	fi
 fi
 
 # Launch the merge tool on each path provided by 'git diff'
diff --git a/git-difftool.perl b/git-difftool.perl
index 8c836e4..f8ff245 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -62,6 +62,10 @@ sub generate_command
 			$skip_next = 1;
 			next;
 		}
+		if ($arg =~ /^--extcmd=/) {
+			$ENV{GIT_DIFFTOOL_EXTCMD} = substr($arg, 9);
+			next;
+		}
 		if ($arg =~ /^--tool=/) {
 			$ENV{GIT_DIFF_TOOL} = substr($arg, 7);
 			next;
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index eca51a8..8ee186a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -214,7 +214,24 @@ test_expect_success 'difftool.<tool>.path' '
 	diff=$(git difftool --tool=tkdiff --no-prompt branch) &&
 	git config --unset difftool.tkdiff.path &&
 	lines=$(echo "$diff" | grep file | wc -l) &&
-	test "$lines" -eq 1
+	test "$lines" -eq 1 &&
+
+	restore_test_defaults
+'
+
+test_expect_success 'difftool --extcmd=...' '
+	diff=$(git difftool --no-prompt --extcmd=cat branch) &&
+
+	lines=$(echo "$diff" | wc -l) &&
+	test "$lines" -eq 2 &&
+
+	lines=$(echo "$diff" | grep master | wc -l) &&
+	test "$lines" -eq 1 &&
+
+	lines=$(echo "$diff" | grep branch | wc -l) &&
+	test "$lines" -eq 1 &&
+
+	restore_test_defaults
 '
 
 test_done
-- 
1.6.6.4.g20a38b.dirty
