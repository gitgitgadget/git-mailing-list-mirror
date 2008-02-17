From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 3/4] Allow a different mergetool command to be used for 'no base' merges
Date: Sun, 17 Feb 2008 10:24:04 +0000
Message-ID: <b3bfecd3d3f3cbf5a0bbad8d65e6a7cda0e19d16.1203242325.git.charles@hashpling.org>
References: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 11:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQghT-0004qB-Iz
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbYBQKYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 05:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbYBQKYM
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:24:12 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:50252 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbYBQKYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:24:11 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JQggr-0001L0-Po
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:24:09 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HAO4Xn023398
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:24:04 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HAO4ep023397
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:24:04 GMT
Content-Disposition: inline
In-Reply-To: <b63a66ef2a97cd3e791476a74bdb7081bcd57637.1203242325.git.charles@hashpling.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: e48f9796253e385428cdd6d1701ddcc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74113>

This adds a mergetool.<tool>.cmdNoBase config variable pattern to
allow a different command syntax to be specified for custom merge
tools for add/add conflicts where there is no base.

The same effects could have been achieved before this patch by adding
some shell test syntax in the mergetool.<tool>.cmd config variable but
this allows for easier to setup and more readable configurations.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Documentation/config.txt |    6 ++++++
 git-mergetool.sh         |   10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53f790d..06a93e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -730,6 +730,12 @@ mergetool.<tool>.cmd::
 	merged; 'MERGED' contains the name of the file to which the merge
 	tool should write the results of a successful merge.
 
+mergetool.<tool>.cmdNoBase::
+	If present, the value of this variable is used instead of
+	mergetool.<tool>.cmd for conflicts where there is no common base
+	(i.e. add/add conflicts). The interpretation of this variable is
+	otherwise identical to mergetool.<tool>.cmd.
+
 mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 4681e9a..2437c37 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -273,12 +273,17 @@ merge_file () {
 	    ;;
 	*)
 	    if test -n "$merge_tool_cmd"; then
+		if base_present || test -z "$merge_tool_no_base_cmd"; then
+		    tool="$merge_tool_cmd"
+		else
+		    tool="$merge_tool_no_base_cmd"
+		fi
 		if test "$merge_tool_trust_exit_code" = "false"; then
 		    touch "$BACKUP"
-		    ( MERGED="$path" eval $merge_tool_cmd )
+		    ( MERGED="$path" eval $tool )
 		    check_unchanged
 		else
-		    ( MERGED="$path" eval $merge_tool_cmd )
+		    ( MERGED="$path" eval $tool )
 		    status=$?
 		fi
 		save_backup
@@ -408,6 +413,7 @@ else
 
     if ! test -z "$merge_tool_cmd"; then
         merge_tool_trust_exit_code="$(git config --bool mergetool.$merge_tool.trustExitCode || echo false)"
+        merge_tool_no_base_cmd="$(git config mergetool.$merge_tool.cmdNoBase)"
     fi
 fi
 
-- 
1.5.4.1.34.g94bf
