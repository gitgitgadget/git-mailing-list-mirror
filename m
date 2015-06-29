From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 07/10] bisect: sanity check on terms
Date: Mon, 29 Jun 2015 17:40:32 +0200
Message-ID: <1435592435-27914-8-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bBV-0003Jj-Oa
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbbF2PlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:41:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46704 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbbF2PlB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:41:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFefcw018093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFehZ9031684;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAp-0008Du-At; Mon, 29 Jun 2015 17:40:43 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 17:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFefcw018093
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197242.48803@lMkWhbwdMx6FCJscRd290w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272963>

This is currently only a defensive check since the only terms are
bad/good and new/old, which pass it, but this is a preparation step for
accepting user-supplied terms.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-bisect.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/git-bisect.sh b/git-bisect.sh
index f32fd2d..0b3c820 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -535,9 +535,42 @@ get_terms () {
 write_terms () {
 	TERM_BAD=$1
 	TERM_GOOD=$2
+	if test "$TERM_BAD" = "$TERM_GOOD"
+	then
+		die "$(gettext "please use two different terms")"
+	fi
+	check_term_format "$TERM_BAD" bad
+	check_term_format "$TERM_GOOD" good
 	printf '%s\n%s\n' "$TERM_BAD" "$TERM_GOOD" >"$GIT_DIR/BISECT_TERMS"
 }
 
+check_term_format () {
+	term=$1
+	git check-ref-format refs/bisect/"$term" ||
+	die "$(eval_gettext "'\$term' is not a valid term")"
+	case "$term" in
+	help|start|terms|skip|next|reset|visualize|replay|log|run)
+		die "$(eval_gettext "can't use the builtin command '\$term' as a term")"
+		;;
+	bad|new)
+		if test "$2" != bad
+		then
+			# In theory, nothing prevents swapping
+			# completely good and bad, but this situation
+			# could be confusing and hasn't been tested
+			# enough. Forbid it for now.
+			die "$(eval_gettext "can't change the meaning of term '\$term'")"
+		fi
+		;;
+	good|old)
+		if test "$2" != good
+		then
+			die "$(eval_gettext "can't change the meaning of term '\$term'")"
+		fi
+		;;
+	esac
+}
+
 check_and_set_terms () {
 	cmd="$1"
 	case "$cmd" in
-- 
2.5.0.rc0.10.gd2bff5d
