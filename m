From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] git-am: propagate -C<n>, -p<n> options as well
Date: Thu,  4 Dec 2008 18:22:58 -0800
Message-ID: <1228443780-3386-3-git-send-email-gitster@pobox.com>
References: <1228443780-3386-1-git-send-email-gitster@pobox.com>
 <1228443780-3386-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 03:24:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QN2-0002VO-91
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791AbYLECXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbYLECXQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636AbYLECXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1218C18219
	for <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 65A5B18207 for
 <git@vger.kernel.org>; Thu,  4 Dec 2008 21:23:12 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.60.g1d1d7
In-Reply-To: <1228443780-3386-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: AB384B0C-C273-11DD-BE27-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102391>

These options are meant to deal with patches that do not apply cleanly
due to the differences between the version the patch was based on and
the version "git am" is working on.

Because a series of patches applied in the same "git am" run tends to
come from the same source, it is more useful to propagate these options
after the application stops.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1bf70d4..ed54e71 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -121,7 +121,7 @@ It does not apply to blobs recorded in its index."
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort= ws=
+sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -156,7 +156,7 @@ do
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
-		ws="--whitespace=$2"; shift ;;
+		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
 	--)
@@ -247,10 +247,10 @@ else
 		exit 1
 	}
 
-	# -s, -u, -k and --whitespace flags are kept for the
-	# resuming session after a patch failure.
+	# -s, -u, -k, --whitespace, -C and -p flags are kept
+	# for the resuming session after a patch failure.
 	# -3 and -i can and must be given when resuming.
-	echo " $ws" >"$dotest/whitespace"
+	echo " $git_apply_opt" >"$dotest/apply_opt_extra"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
@@ -283,7 +283,7 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-ws=$(cat "$dotest/whitespace")
+git_apply_opt=$(cat "$dotest/apply_opt_extra")
 if test "$(cat "$dotest/sign")" = t
 then
 	SIGNOFF=`git var GIT_COMMITTER_IDENT | sed -e '
@@ -454,7 +454,7 @@ do
 
 	case "$resolved" in
 	'')
-		git apply $git_apply_opt $ws --index "$dotest/patch"
+		git apply $git_apply_opt --index "$dotest/patch"
 		apply_status=$?
 		;;
 	t)
-- 
1.6.1.rc1.60.g1d1d7
