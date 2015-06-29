From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 06/10] bisect: don't mix option parsing and non-trivial code
Date: Mon, 29 Jun 2015 17:40:31 +0200
Message-ID: <1435592435-27914-7-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bB6-00033O-E2
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbbF2Pk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:40:57 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46695 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818AbbF2Pku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:40:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFefTb018091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFehUx031681;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAp-0008Dp-8N; Mon, 29 Jun 2015 17:40:43 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 17:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFefTb018091
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197242.48954@X15uEi5jFeUIH+WRSOjvJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272957>

As-is, the revisions that appear on the command-line are processed in
order. This would mix badly with code that changes the configuration
(e.g. change $TERM_GOOD and $TERM_BAD) while processing the options.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-bisect.sh | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index dcd7e59..f32fd2d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -78,6 +78,7 @@ bisect_start() {
 	bad_seen=0
 	eval=''
 	must_write_terms=0
+	revs=''
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
 		mode=--no-checkout
@@ -102,25 +103,27 @@ bisect_start() {
 				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
 				break
 			}
-
-			# The user ran "git bisect start <sha1>
-			# <sha1>", hence did not explicitly specify
-			# the terms, but we are already starting to
-			# set references named with the default terms,
-			# and won't be able to change afterwards.
-			must_write_terms=1
-
-			case $bad_seen in
-			0) state=$TERM_BAD ; bad_seen=1 ;;
-			*) state=$TERM_GOOD ;;
-			esac
-			eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+			revs="$revs $rev"
 			shift
 			;;
 		esac
 	done
 
+	for rev in $revs
+	do
+		# The user ran "git bisect start <sha1>
+		# <sha1>", hence did not explicitly specify
+		# the terms, but we are already starting to
+		# set references named with the default terms,
+		# and won't be able to change afterwards.
+		must_write_terms=1
+
+		case $bad_seen in
+		0) state=$TERM_BAD ; bad_seen=1 ;;
+		*) state=$TERM_GOOD ;;
+		esac
+		eval="$eval bisect_write '$state' '$rev' 'nolog' &&"
+	done
 	#
 	# Verify HEAD.
 	#
-- 
2.5.0.rc0.10.gd2bff5d
