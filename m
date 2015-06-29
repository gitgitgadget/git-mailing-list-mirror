From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 09/10] bisect: add 'git bisect terms' to view the current terms
Date: Mon, 29 Jun 2015 17:40:34 +0200
Message-ID: <1435592435-27914-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bBN-0003EG-LS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbbF2PlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:41:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33119 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725AbbF2Pk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:40:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFefbX018380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFehoD031690;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAp-0008E4-Hk; Mon, 29 Jun 2015 17:40:43 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Jun 2015 17:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFefbX018380
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197244.12046@Srx3pvCzHvWU8bK+kufVjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272961>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 10 ++++++++++
 git-bisect.sh                | 39 ++++++++++++++++++++++++++++++++++++++-
 t/t6030-bisect-porcelain.sh  | 20 ++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index abaf462..4dd6295 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -19,6 +19,7 @@ on the subcommand:
  git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new) [<rev>]
  git bisect (good|old) [<rev>...]
+ git bisect terms [--term-good | --term-bad]
  git bisect skip [(<rev>|<range>)...]
  git bisect reset [<commit>]
  git bisect visualize
@@ -157,6 +158,15 @@ git bisect new [<rev>...]
 
 to indicate that it was after.
 
+To get a reminder of the currently used terms, use
+
+------------------------------------------------
+git bisect terms
+------------------------------------------------
+
+You can get just the old (respectively new) term with `git bisect term
+--term-old` or `git bisect term --term-good`.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 42e1cee..da86d9e 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
@@ -11,6 +11,8 @@ git bisect (bad|new) [<rev>]
 git bisect (good|old) [<rev>...]
 	mark <rev>... known-good revisions/
 		revisions before change in a given property.
+git bisect terms [--term-good | --term-bad]
+	show the terms used for old and new commits (default: bad, good)
 git bisect skip [(<rev>|<range>)...]
 	mark <rev>... untestable revisions.
 git bisect next
@@ -453,6 +455,8 @@ bisect_replay () {
 			eval "$cmd" ;;
 		"$TERM_GOOD"|"$TERM_BAD"|skip)
 			bisect_write "$command" "$rev" ;;
+		terms)
+			bisect_terms $rev ;;
 		*)
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
@@ -606,6 +610,37 @@ bisect_voc () {
 	esac
 }
 
+bisect_terms () {
+	get_terms
+	if ! test -s "$GIT_DIR/BISECT_TERMS"
+	then
+		die "$(gettext "no terms defined")"
+	fi
+	case "$#" in
+	0)
+		gettextln "Your current terms are $TERM_GOOD for the old state
+and $TERM_BAD for the new state."
+		;;
+	1)
+		arg=$1
+		case "$arg" in
+			--term-good|--term-old)
+				printf '%s\n' "$TERM_GOOD"
+				;;
+			--term-bad|--term-new)
+				printf '%s\n' "$TERM_BAD"
+				;;
+			*)
+				die "$(eval_gettext "invalid argument \$arg for 'git bisect terms'.
+Supported options are: --term-good|--term-old and --term-bad|--term-new.")"
+				;;
+		esac
+		;;
+	*)
+		usage ;;
+	esac
+}
+
 case "$#" in
 0)
 	usage ;;
@@ -635,6 +670,8 @@ case "$#" in
 		bisect_log ;;
 	run)
 		bisect_run "$@" ;;
+	terms)
+		bisect_terms "$@" ;;
 	*)
 		usage ;;
 	esac
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 983c503..9393488 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -797,4 +797,24 @@ test_expect_success 'bisect cannot mix old/new and good/bad' '
 	test_must_fail git bisect old $HASH1
 '
 
+test_expect_success 'bisect terms needs 0 or 1 argument' '
+	git bisect reset &&
+	test_must_fail git bisect terms only-one &&
+	test_must_fail git bisect terms 1 2 &&
+	test_must_fail git bisect terms 2>actual &&
+	echo "no terms defined" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'bisect terms shows good/bad after start' '
+	git bisect reset &&
+	git bisect start HEAD $HASH1 &&
+	git bisect terms --term-good >actual &&
+	echo good >expected &&
+	test_cmp expected actual &&
+	git bisect terms --term-bad >actual &&
+	echo bad >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.5.0.rc0.10.gd2bff5d
