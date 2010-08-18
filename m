From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 2/8] detached-stash: simplify stash_apply
Date: Wed, 18 Aug 2010 23:09:34 +1000
Message-ID: <1282136980-25793-3-git-send-email-jon.seymour@gmail.com>
References: <1282136980-25793-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:10:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OliPl-0001G7-Ij
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab0HRNK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:10:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40726 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab0HRNK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:10:27 -0400
Received: by pxi10 with SMTP id 10so205454pxi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dkiGpW4X8BbRFMpcCy5Se50lrKOTXO36dADWqIoqRmU=;
        b=gUX4av5Kx8Wuv3cP+eJsFNlEn4RIBcwKD9bgdoAffnAwj93jXxzsrAD7ANgN6cRFIc
         rCLqDXiqI/7OGcqUYd1t6MxhCLvotqxngpaMSMXSSWDFZ8I20Vw2PLHidO9BM4yGXkx/
         F03OmgApE95S55XdQaP8tEub0f8fqgOu8RQ3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pXqvX90hnnoZeI40jUPc85PuoPSRcxcPHx9scjlwSBfUPCENPUk4W722jG1AZYzNrW
         MqlpfjMZ/bn/pNOKL/WASrgSN30HkavhlvlQYOJ555OGIB3wGwK8QH5E6Ufy+OSiaclD
         J04i2JMSvcVlUO5u3HM1uEsS4JIgdtyttr+pI=
Received: by 10.142.132.18 with SMTP id f18mr7000818wfd.263.1282137027459;
        Wed, 18 Aug 2010 06:10:27 -0700 (PDT)
Received: from localhost.localdomain ([120.16.55.229])
        by mx.google.com with ESMTPS id w31sm303253wfd.20.2010.08.18.06.10.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:10:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g4fabf
In-Reply-To: <1282136980-25793-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153839>

The implementation of stash_apply() is simplified to take
advantage of the common parsing function parse_flags_and_rev().

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   38 +++-----------------------------------
 1 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 42b0da2..ba68f1e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -358,40 +358,8 @@ assert_stash_ref() {
 }
 
 apply_stash () {
-	applied_stash=
-	unstash_index=
 
-	while test $# != 0
-	do
-		case "$1" in
-		--index)
-			unstash_index=t
-			;;
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	if test $# = 0
-	then
-		have_stash || die 'Nothing to apply'
-		applied_stash="$ref_stash@{0}"
-	else
-		applied_stash="$*"
-	fi
-
-	# stash records the work tree, and is a merge between the
-	# base commit (first parent) and the index tree (second parent).
-	s=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
-	w_tree=$(git rev-parse --quiet --verify "$s:") &&
-	b_tree=$(git rev-parse --quiet --verify "$s^1:") &&
-	i_tree=$(git rev-parse --quiet --verify "$s^2:") ||
-		die "$*: no valid stashed state found"
+	assert_stash_like "$@"
 
 	git update-index -q --refresh &&
 	git diff-files --quiet --ignore-submodules ||
@@ -402,7 +370,7 @@ apply_stash () {
 		die 'Cannot apply a stash in the middle of a merge'
 
 	unstashed_index_tree=
-	if test -n "$unstash_index" && test "$b_tree" != "$i_tree" &&
+	if test -n "$INDEX_OPTION" && test "$b_tree" != "$i_tree" &&
 			test "$c_tree" != "$i_tree"
 	then
 		git diff-tree --binary $s^2^..$s^2 | git apply --cached
@@ -447,7 +415,7 @@ apply_stash () {
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
-		if test -n "$unstash_index"
+		if test -n "$INDEX_OPTION"
 		then
 			echo >&2 'Index was not unstashed.'
 		fi
-- 
1.7.2.1.95.g4fabf
