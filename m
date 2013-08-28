From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH v2 2/3] submodule: introduce --[no-]display-comment-char
Date: Wed, 28 Aug 2013 14:47:03 +0200
Message-ID: <1377694024-24173-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
 <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: j.sixt@viscovery.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 14:48:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEfAP-0004GO-8V
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 14:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383Ab3H1MsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 08:48:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44254 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab3H1MsC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 08:48:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7SClvCx008773
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 14:47:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VEfAF-0006K9-9s; Wed, 28 Aug 2013 14:47:59 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VEfAF-0006J7-0H; Wed, 28 Aug 2013 14:47:59 +0200
X-Mailer: git-send-email 1.8.4.11.g9db5bc7.dirty
In-Reply-To: <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Aug 2013 14:47:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SClvCx008773
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1378298879.20251@lemFdnpDsY+PYKdq5U+PRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233186>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
(--for-status was undocumented, so I didn't bother documenting this either)

 git-submodule.sh | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..ac0fdad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -966,6 +966,7 @@ set_name_rev () {
 cmd_summary() {
 	summary_limit=-1
 	for_status=
+	display_comment_char=t
 	diff_cmd=diff-index
 
 	# parse $args after "submodule ... summary".
@@ -981,6 +982,12 @@ cmd_summary() {
 		--for-status)
 			for_status="$1"
 			;;
+		--display-comment-char)
+			display_comment_char=t
+			;;
+		--no-display-comment-char)
+			display_comment_char=
+			;;
 		-n|--summary-limit)
 			summary_limit="$2"
 			isnumber "$summary_limit" || usage
@@ -1151,13 +1158,18 @@ cmd_summary() {
 		echo
 	done |
 	if test -n "$for_status"; then
+		if test -n "$display_comment_char"; then
+			filter_cmd='git stripspace -c'
+		else
+			filter_cmd=cat
+		fi
 		if [ -n "$files" ]; then
-			gettextln "Submodules changed but not updated:" | git stripspace -c
+			gettextln "Submodules changed but not updated:" | $filter_cmd
 		else
-			gettextln "Submodule changes to be committed:" | git stripspace -c
+			gettextln "Submodule changes to be committed:" | $filter_cmd
 		fi
-		printf "\n" | git stripspace -c
-		git stripspace -c
+		printf "\n" | $filter_cmd
+		$filter_cmd
 	else
 		cat
 	fi
-- 
1.8.4.11.g9db5bc7.dirty
