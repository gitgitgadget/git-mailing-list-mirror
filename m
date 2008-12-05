From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] git-am --whitespace: do not lose the command line option
Date: Thu,  4 Dec 2008 18:22:57 -0800
Message-ID: <1228443780-3386-2-git-send-email-gitster@pobox.com>
References: <1228443780-3386-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 03:24:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QMk-0002RA-0T
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbYLECXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbYLECXI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705AbYLECXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B2696846D7
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F3D7C846D6 for
 <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:04 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.60.g1d1d7
In-Reply-To: <1228443780-3386-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A63F7A08-C273-11DD-B02A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102389>

When you start "git am --whitespace=fix" and the patch application process
is interrupted by an unapplicable patch early in the series, after
fixing the offending patch, the remainder of the patch should be processed
still with --whitespace=fix when restarted with "git am --resolved" (or
dropping the offending patch with "git am --skip").

The breakage was introduced by the commit 67dad68 (add -C[NUM] to git-am,
2007-02-08); this should fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index aa60261..1bf70d4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -121,7 +121,7 @@ It does not apply to blobs recorded in its index."
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
+sign= utf8=t keep= skip= interactive= resolved= rebasing= abort= ws=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -156,7 +156,7 @@ do
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
-		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+		ws="--whitespace=$2"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
 	--)
@@ -283,7 +283,7 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-ws=`cat "$dotest/whitespace"`
+ws=$(cat "$dotest/whitespace")
 if test "$(cat "$dotest/sign")" = t
 then
 	SIGNOFF=`git var GIT_COMMITTER_IDENT | sed -e '
@@ -454,7 +454,7 @@ do
 
 	case "$resolved" in
 	'')
-		git apply $git_apply_opt --index "$dotest/patch"
+		git apply $git_apply_opt $ws --index "$dotest/patch"
 		apply_status=$?
 		;;
 	t)
-- 
1.6.1.rc1.60.g1d1d7

 
