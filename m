From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] stash: ensure --no-keep-index and --patch can be used in any order
Date: Thu,  7 Apr 2011 12:04:20 -0500
Message-ID: <1302195860-31053-2-git-send-email-dpmcgee@gmail.com>
References: <1302195860-31053-1-git-send-email-dpmcgee@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>, Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 19:04:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7sdG-0006lE-Kc
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab1DGREb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 13:04:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53849 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756179Ab1DGREa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 13:04:30 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so923353gwa.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=kKTDFvjXji5oYzgpAbxVZhNOgdn4/m7HlBkhee30Ug0=;
        b=MD2rudZX7ns+aFsYre7hUcIPe5RBilKGGb331KuoUziYn6KIigATH023k7HF8WeKag
         rrH4Fi6yIACrQNH6yrtz1NGXWDdFqHYc165Srnyfcdb649igHIGq9EXyMCLBnwF6ZlO7
         dvolbfESU7jhbOCAW167+9Hd2kANxgyxtE0BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GaV2+X4WluWV0yVbEp/mV6z7YatKqySp9TsNNKYpI3Tt2kdjC7KzU7RCEnnXTXybF2
         979n6sVFAuUWwSa4bfzBQf5MCmoZB4YcEJDSWrqPqXVMkxce4/ccs4EvF/m7GfhAUkdt
         1SjQT1bXu5aDYOnOMWkzO1bfmR3+PLTBHatss=
Received: by 10.150.149.34 with SMTP id w34mr1073694ybd.309.1302195870573;
        Thu, 07 Apr 2011 10:04:30 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id w1sm987220ybl.9.2011.04.07.10.04.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 10:04:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1302195860-31053-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171068>

Don't assume one comes after the other on the command line. Use a
three-state variable to track and check its value accordingly.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-stash.sh           |    9 +++++----
 t/t3904-stash-patch.sh |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index a305fb1..fd66884 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -136,11 +136,12 @@ save_stash () {
 			keep_index=t
 			;;
 		--no-keep-index)
-			keep_index=
+			keep_index=n
 			;;
 		-p|--patch)
 			patch_mode=t
-			keep_index=t
+			# only default to keep if we don't already have an override
+			test -z "$keep_index" && keep_index=t
 			;;
 		-q|--quiet)
 			GIT_QUIET=t
@@ -185,7 +186,7 @@ save_stash () {
 	then
 		git reset --hard ${GIT_QUIET:+-q}
 
-		if test -n "$keep_index" && test -n $i_tree
+		if test "$keep_index" = "t" && test -n $i_tree
 		then
 			git read-tree --reset -u $i_tree
 		fi
@@ -193,7 +194,7 @@ save_stash () {
 		git apply -R < "$TMP-patch" ||
 		die "Cannot remove worktree changes"
 
-		if test -z "$keep_index"
+		if test "$keep_index" != "t"
 		then
 			git reset
 		fi
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 4d58789..781fd71 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -48,7 +48,7 @@ test_expect_success PERL 'git stash -p --no-keep-index' '
 	verify_state bar dummy bar_index
 '
 
-test_expect_failure PERL 'git stash --no-keep-index -p' '
+test_expect_success PERL 'git stash --no-keep-index -p' '
 	set_state dir/foo work index &&
 	set_state bar bar_work bar_index &&
 	(echo n; echo y) | git stash save --no-keep-index -p &&
-- 
1.7.4.4
