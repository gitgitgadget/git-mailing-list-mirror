From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 2/2] git-commit: Add --no-status option
Date: Thu, 6 Sep 2007 03:49:53 +0400
Message-ID: <20070905234953.GB643@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4dQ-0002lK-5X
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851AbXIEXt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757836AbXIEXt6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:49:58 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:47121 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757786AbXIEXt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:49:56 -0400
X-Greylist: delayed 1694 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2007 19:49:56 EDT
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 1223B23900A4;
	Thu,  6 Sep 2007 03:49:55 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id C0CB7170DE; Thu,  6 Sep 2007 03:49:53 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57775>

By default, git-commit runs git-runstatus to print changes between
the index and the working tree.  This operation is very costly and
is not always necessary.  New option allows user to commit without
running git-runstatus when appropriate.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 Documentation/git-commit.txt |    7 ++++++-
 git-commit.sh                |   11 ++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e54fb12..177e7cd 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-commit' [-a | --interactive] [-s] [-v] [-u]
 	   [(-c | -C) <commit> | -F <file> | -m <msg> | --amend]
-	   [--no-verify] [-e] [--author <author>]
+	   [--no-status] [--no-verify] [-e] [--author <author>]
 	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
@@ -85,6 +85,11 @@ OPTIONS
 -s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
+--no-status::
+	Do not examine paths in the working tree that has changes
+	unrecorded to the index file, and changes between the
+	index file and the current commit.
+
 --no-verify::
 	This option bypasses the pre-commit hook.
 	See also link:hooks.html[hooks].
diff --git a/git-commit.sh b/git-commit.sh
index 800f96c..75126f1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--template <file>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-status] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--template <file>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -54,6 +54,7 @@ run_status () {
 	else
 		color=--nocolor
 	fi
+	test t = "$status" || return 0
 	git runstatus ${color} \
 		${verbose:+--verbose} \
 		${amend:+--amend} \
@@ -81,6 +82,7 @@ edit_flag=
 no_edit=
 log_given=
 log_message=
+status=t
 verify=t
 quiet=
 verbose=
@@ -184,6 +186,13 @@ $1"
 		no_edit=t
 		shift
 		;;
+	--no-s|--no-st|--no-sta|--no-stat|--no-statu|\
+	--no-status)
+		test "$status_only" = t &&
+			die "Option $1 does not make sense with ${0##*/}."
+		status=
+		shift
+		;;
 	-n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|\
 	--no-verify)
 		verify=
-- 
ldv
