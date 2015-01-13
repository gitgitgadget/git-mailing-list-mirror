From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] stash clear: allow -v/--verbose to be passed
Date: Tue, 13 Jan 2015 23:54:37 +0600
Message-ID: <1421171677-12215-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:54:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB5g0-0000Pi-O1
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 18:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbbAMRyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 12:54:44 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46839 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbAMRyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 12:54:44 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so3881656lbd.9
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Lhb5eucEwYsc2Skrouzf6z9Jw/7fK5mes7hha+MxdBw=;
        b=j46JUs491R9Zfr7v+H0xtB0cbFflOmqReLivfThE31cuTHITrqspnQTea9AhZVj3/I
         ntqGwpd1HlmN2Fg8mLtcuQJ/LyETGBs9XfUe7XbYakD9B7WUCxWNA8UuS/A/+jhHYN5P
         cjHhuNa+81J/P5eBKu5Giq6GnHCDasfwhhizGO20mg3zOdxnRzZmPcZBrMGLV9hZVTI3
         0qIwiOtIut+iNWcLpFHowfGRbIClW3RgADAcUG4eOOzFHN6V3RoaWLbmsUKzULA/pRdJ
         aSY/mtFN5U7Qn95qncxmB8dkj7ObJEYtp5QayT68HUaGX2tMjmxkk2ZdwFETEkYbhniL
         HJjQ==
X-Received: by 10.112.42.47 with SMTP id k15mr44227758lbl.75.1421171682626;
        Tue, 13 Jan 2015 09:54:42 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.47])
        by mx.google.com with ESMTPSA id j19sm5160312lbl.23.2015.01.13.09.54.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jan 2015 09:54:41 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.239.g0ae1f56.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262343>

Added new option -v/--verbose to 'git stash clear' for verbose output.

For example:

    $ git stash clear -v
    Removed stash@{0}: WIP on stash-clear-verbose: 0ae1f56 Merge branch 'bp/diff-relative-config' into pu
    Removed stash@{1}: WIP on stash-clear-verbose: 0ae1f56 Merge branch 'bp/diff-relative-config' into pu
    Removed stash@{2}: WIP on stash-clear-verbose: 0ae1f56 Merge branch 'bp/diff-relative-config' into pu
    Removed stash@{3}: WIP on master: addfb21 Git 2.3.0-rc0

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/git-stash.txt |  4 ++--
 git-stash.sh                | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 375213f..f5b3dd8 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [<message>]]
-'git stash' clear
+'git stash' clear [-v|--verbose]
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
 
@@ -136,7 +136,7 @@ the stash is applied on top of the commit that was HEAD at the time
 `git stash` was run, it restores the originally stashed state with
 no conflicts.
 
-clear::
+clear [-v|--verbose]::
 	Remove all the stashed states. Note that those states will then
 	be subject to pruning, and may be impossible to recover (see
 	'Examples' below for a possible strategy).
diff --git a/git-stash.sh b/git-stash.sh
index 6846b18..9f16289 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -9,7 +9,7 @@ USAGE="list [<options>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
 		       [-u|--include-untracked] [-a|--all] [<message>]]
-   or: $dashless clear"
+   or: $dashless clear [-v|--verbose]"
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -46,12 +46,17 @@ untracked_files () {
 }
 
 clear_stash () {
-	if test $# != 0
-	then
-		die "$(gettext "git stash clear with parameters is unimplemented")"
-	fi
 	if current=$(git rev-parse --verify --quiet $ref_stash)
 	then
+		case "$1" in
+			-v|--verbose)
+			    shift
+			    git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash -- | sed -e 's/^/Removed /g'
+			    ;;
+			*)
+			    break
+			    ;;
+		esac
 		git update-ref -d $ref_stash $current
 	fi
 }
-- 
2.3.0.rc0.239.g0ae1f56.dirty
