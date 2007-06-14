From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] guilt-status(1): Remove bashisms.
Date: Thu, 14 Jun 2007 14:51:01 +0200
Message-ID: <11818254624139-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonU-0003Jt-06
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXFNMvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:15 -0400
Received: from pan.madism.org ([88.191.52.104]:60900 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbXFNMvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:05 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id E5676DA69;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 854CA929BA; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50192>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt-status |   58 ++++++++++++++++++++++++++++------------------------------
 1 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/guilt-status b/guilt-status
index 934ea53..bc2f33e 100755
--- a/guilt-status
+++ b/guilt-status
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[-a|-A] [-c|-C] [-d|-D] [-m|-M] [-r|-R] [-t|-T] [-u|-U] [-x|-X] [-n]"
-. guilt
+. `dirname $0`/guilt
 
 untracked=""
 DIFF_FILTER=""
@@ -53,7 +53,7 @@ fi
 
 git-rev-parse --verify HEAD >/dev/null 2>&1 || IS_INITIAL=t
 
-function print_status
+print_status()
 {
 	if [ -z "$no_prefix" ] ; then
 		Apfx="A "
@@ -81,34 +81,32 @@ function print_status
 	done
 }
 
-cd "$TOP_DIR"
-
 (
-# untracked; FIXME: there's got to be a better way
-if [ ! -z "$untracked" ]; then
-	if [ -f "$GIT_DIR/info/exclude" ]; then
-		git-ls-files -z --others \
-		--exclude-from="$GIT_DIR/info/exclude" \
-		--exclude-per-directory=.gitignore
-	else
-		git-ls-files -z --others --exclude-per-directory=.gitignore
-	fi | xargs -0 -L 1 echo | while read n; do
-		[ -z "$n" ] && continue
-		echo "$n" | sed -e "s/^/?\t/"
-	done
-fi
+	cd "$TOP_DIR"
+	# untracked; FIXME: there's got to be a better way
+	if [ ! -z "$untracked" ]; then
+		if [ -f "$GIT_DIR/info/exclude" ]; then
+			git-ls-files -z --others \
+			--exclude-from="$GIT_DIR/info/exclude" \
+			--exclude-per-directory=.gitignore
+		else
+			git-ls-files -z --others --exclude-per-directory=.gitignore
+		fi | xargs -0 -L 1 echo | while read n; do
+			[ -z "$n" ] && continue
+			echo "$n" | sed -e "s/^/?\t/"
+		done
+	fi
 
-# added
-if [ -z "$IS_INITIAL" ]; then
-	# non-initial commit
-	git-diff-index -M --name-status --diff-filter=$DIFF_FILTER HEAD
-else
-	# initial commit
-	git-ls-files | sed -e "s/^/A\t/"
-fi | sed -e '
-	s/\\/\\\\/g
-	s/ /\\ /g
-'
+	# added
+	if [ -z "$IS_INITIAL" ]; then
+		# non-initial commit
+		git-diff-index -M --name-status --diff-filter=$DIFF_FILTER HEAD
+	else
+		# initial commit
+		git-ls-files | sed -e "s/^/A\t/"
+	fi | sed -e '
+		s/\\/\\\\/g
+		s/ /\\ /g
+	'
 ) | print_status
 
-cd - 2>&1 >/dev/null
-- 
1.5.2.1
