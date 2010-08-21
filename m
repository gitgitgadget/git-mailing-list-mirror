From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 3/9] detached-stash: simplify stash_apply
Date: Sat, 21 Aug 2010 14:08:58 +1000
Message-ID: <1282363744-4924-4-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:09:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfP0-0006is-IP
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab0HUEJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:09:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab0HUEJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:09:46 -0400
Received: by pvg2 with SMTP id 2so1476555pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rSFOqukExKGJnD+PutWY1eKbXnNryGryWt5tfoSM/Ok=;
        b=XFiHGIoLg/0FTTWl+YKHFraP0UmVlsDRQhOTO8Bj5S63FdiJfC8At3ez6OVnTM/esb
         vUIkIDoKouf3uvFCsNWyOPq/PihK0Ag6I3EWY9f2NtD2DgiX00nev6+3sZ7nqTwHsDKr
         WTIrjJMtP0JgEIFiPpWLOMMkc5aHLqXdy++oc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TerZd1YpbGYx+8uCoi4eNMYl7W4qABnZEj9HjhV9efqFw9XNrogAvHFBfxmY1yMI33
         Ff7uwRH/i5jn9qtmsG2F+0O4wA6Nn3WcS4dXl/uPvanBWtVwdSWnx65Bn+Cv/w56LZKG
         VOCIhMzl+rdQf/xMBzZBEu8qgnnUDS1yADbGQ=
Received: by 10.142.136.1 with SMTP id j1mr1740528wfd.329.1282363785688;
        Fri, 20 Aug 2010 21:09:45 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154099>

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
1.7.2.1.110.g34f32
