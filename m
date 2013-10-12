From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/7] pull: refactor $rebase variable into $mode
Date: Sat, 12 Oct 2013 02:02:00 -0500
Message-ID: <1381561322-20059-6-git-send-email-felipe.contreras@gmail.com>
References: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtJK-0002IP-3r
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab3JLHIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:08:20 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:54613 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab3JLHIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:08:18 -0400
Received: by mail-ob0-f181.google.com with SMTP id va2so3472147obc.12
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hS79VpF4sHZisnP1HOO60C8AlPLQf/q8a6iMCHrD5do=;
        b=dtQUPJDcsrAe4Uo3Y1K7FJjHoyvJpNt6GuRK/qZ0MIdgzat9tFAx7oqc4P3zlUQK4l
         wXFnUXPl7TizGnAUpYkEtSrBPq20BaOliGHBOpbom9pf/gJcx0SIgctd3st7JHnzLRk+
         tCs8ZtlMuUd7C2wOEFYbz2iZHetBKkFETKw4iy7NBybmJ1untQSIPU5mi2ERMRm+Quml
         kdoDrdhiPgNGxsALLf/Y6odS0XLYiSzb900ycGQIbG1VjNo9W2hCSPjKH7BKtkR644KQ
         ZnPIElLFuopV6Rm6DnyJ0HoZJAQInIIZZTO7WQ8a0uz5BkfXhdOmBIp9/dSbrbW1Acd5
         1z5Q==
X-Received: by 10.60.68.135 with SMTP id w7mr18221918oet.9.1381561697528;
        Sat, 12 Oct 2013 00:08:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm101369555oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:08:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561322-20059-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235953>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-pull.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8363647..f53d193 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -48,8 +48,7 @@ if test -z "$mode"
 then
 	mode=$(git config pull.mode)
 fi
-test "$mode" = 'rebase' && rebase="true"
-if test -z "$rebase"
+if test -z "$mode"
 then
 	rebase=$(git config --bool branch.$curr_branch_short.rebase)
 	if test -z "$rebase"
@@ -58,6 +57,7 @@ then
 	fi
 	if test "$rebase" = 'true'
 	then
+		mode="rebase"
 		echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
 		echo "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
@@ -125,10 +125,10 @@ do
 		merge_args="$merge_args$xx "
 		;;
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
+		mode=rebase
 		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		rebase=false
+		mode=
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
@@ -171,7 +171,7 @@ error_on_no_merge_candidates () {
 		esac
 	done
 
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		op_type=rebase
 		op_prep=against
@@ -185,7 +185,7 @@ error_on_no_merge_candidates () {
 	remote=$(git config "branch.$curr_branch.remote")
 
 	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
+		if [ "$mode" = rebase ]; then
 			printf "There is no candidate for rebasing against "
 		else
 			printf "There are no candidates for merging "
@@ -208,7 +208,7 @@ error_on_no_merge_candidates () {
 	exit 1
 }
 
-test true = "$rebase" && {
+test "$mode" = rebase && {
 	if ! git rev-parse -q --verify HEAD >/dev/null
 	then
 		# On an unborn branch
@@ -273,7 +273,7 @@ case "$merge_head" in
 	then
 		die "$(gettext "Cannot merge multiple branches into empty head")"
 	fi
-	if test true = "$rebase"
+	if test "$mode" = rebase
 	then
 		die "$(gettext "Cannot rebase onto multiple branches")"
 	fi
@@ -294,7 +294,7 @@ then
 	exit
 fi
 
-if test true = "$rebase"
+if test "$mode" = rebase
 then
 	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
 	if test "$oldremoteref" = "$o"
@@ -304,8 +304,8 @@ then
 fi
 
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
-case "$rebase" in
-true)
+case "$mode" in
+rebase)
 	eval="git-rebase $diffstat $strategy_args $merge_args $verbosity"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
-- 
1.8.4-fc
