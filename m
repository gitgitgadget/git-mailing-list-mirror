From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v11 10/10] bisect: allow setting any user-specified in 'git bisect start'
Date: Mon, 29 Jun 2015 17:40:35 +0200
Message-ID: <1435592435-27914-11-git-send-email-Matthieu.Moy@imag.fr>
References: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 29 17:41:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9bB5-00033O-S0
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbbF2Pky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:40:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46693 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726AbbF2Pku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:40:50 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFeg9Y018095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:40:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFehcd031693;
	Mon, 29 Jun 2015 17:40:43 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9bAp-0008E9-Ka; Mon, 29 Jun 2015 17:40:43 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.gd2bff5d
In-Reply-To: <1435592435-27914-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 17:40:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFeg9Y018095
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436197242.57072@kWvEXfGG6SDs1ePoBR+e2A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272958>

This allows a natural user-interface when looking for any change in the
code, not just regression. For example:

git bisect start --term-old fast --term-new slow
git bisect fast
git bisect slow
...

There were several proposed user-interfaces for this feature. This patch
implements it as options to 'git bisect start' for the following reasons:

* By construction, the terms will be valid for one and only one
  bisection.

* Unlike positional arguments, using named options avoid having to
  remember an order.

* We can combine user-defined terms and passing old/new commits as
  argument to "git bisect start".

* The implementation is relatively simple.

See previous discussions:

  http://mid.gmane.org/1435337896-20709-3-git-send-email-Matthieu.Moy@imag.fr

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-bisect.txt | 37 +++++++++++++++++++--
 git-bisect.sh                | 21 +++++++++++-
 t/t6030-bisect-porcelain.sh  | 77 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 4dd6295..340f3c1 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,7 +16,8 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
+ git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
+                  [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new) [<rev>]
  git bisect (good|old) [<rev>...]
  git bisect terms [--term-good | --term-bad]
@@ -41,7 +42,7 @@ In fact, `git bisect` can be used to find the commit that changed
 *any* property of your project; e.g., the commit that fixed a bug, or
 the commit that caused a benchmark's performance to improve. To
 support this more general usage, the terms "old" and "new" can be used
-in place of "good" and "bad". See
+in place of "good" and "bad", or you can choose your own terms. See
 section "Alternate terms" below for more information.
 
 Basic bisect commands: start, bad, good
@@ -167,6 +168,31 @@ git bisect terms
 You can get just the old (respectively new) term with `git bisect term
 --term-old` or `git bisect term --term-good`.
 
+If you would like to use your own terms instead of "bad"/"good" or
+"new"/"old", you can choose any names you like (except existing bisect
+subcommands like `reset`, `start`, ...) by starting the
+bisection using
+
+------------------------------------------------
+git bisect start --term-old <term-old> --term-new <term-new>
+------------------------------------------------
+
+For example, if you are looking for a commit that introduced a
+performance regression, you might use
+
+------------------------------------------------
+git bisect start --term-old fast --term-new slow
+------------------------------------------------
+
+Or if you are looking for the commit that fixed a bug, you might use
+
+------------------------------------------------
+git bisect start --term-new fixed --term-old broken
+------------------------------------------------
+
+Then, use `git bisect <term-old>` and `git bisect <term-new>` instead
+of `git bisect good` and `git bisect bad` to mark commits.
+
 Bisect visualize
 ~~~~~~~~~~~~~~~~
 
@@ -450,6 +476,13 @@ $ git bisect start
 $ git bisect new HEAD    # current commit is marked as new
 $ git bisect old HEAD~10 # the tenth commit from now is marked as old
 ------------
++
+or:
+------------
+$ git bisect start --term-old broken --term-new fixed
+$ git bisect fixed
+$ git bisect broken HEAD~10
+------------
 
 Getting help
 ~~~~~~~~~~~~
diff --git a/git-bisect.sh b/git-bisect.sh
index da86d9e..718902b 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -3,7 +3,8 @@
 USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
 	print this long help message.
-git bisect start [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
+git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
+                 [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
 	reset bisect state and start bisection.
 git bisect (bad|new) [<rev>]
 	mark <rev> a known-bad revision/
@@ -99,6 +100,24 @@ bisect_start() {
 		--no-checkout)
 			mode=--no-checkout
 			shift ;;
+		--term-good|--term-old)
+			shift
+			must_write_terms=1
+			TERM_GOOD=$1
+			shift ;;
+		--term-good=*|--term-old=*)
+			must_write_terms=1
+			TERM_GOOD=${1#*=}
+			shift ;;
+		--term-bad|--term-new)
+			shift
+			must_write_terms=1
+			TERM_BAD=$1
+			shift ;;
+		--term-bad=*|--term-new=*)
+			must_write_terms=1
+			TERM_BAD=${1#*=}
+			shift ;;
 		--*)
 			die "$(eval_gettext "unrecognised option: '\$arg'")" ;;
 		*)
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 9393488..e74662b 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -817,4 +817,81 @@ test_expect_success 'bisect terms shows good/bad after start' '
 	test_cmp expected actual
 '
 
+test_expect_success 'bisect start with one term1 and term2' '
+	git bisect reset &&
+	git bisect start --term-old term2 --term-new term1 &&
+	git bisect term2 $HASH1 &&
+	git bisect term1 $HASH4 &&
+	git bisect term1 &&
+	git bisect term1 >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect replay with term1 and term2' '
+	git bisect replay log_to_replay.txt >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect reset
+'
+
+test_expect_success 'bisect start term1 term2' '
+	git bisect reset &&
+	git bisect start --term-new term1 --term-old term2 $HASH4 $HASH1 &&
+	git bisect term1 &&
+	git bisect term1 >bisect_result &&
+	grep "$HASH2 is the first term1 commit" bisect_result &&
+	git bisect log >log_to_replay.txt &&
+	git bisect reset
+'
+
+test_expect_success 'bisect cannot mix terms' '
+	git bisect reset &&
+	git bisect start --term-good term1 --term-bad term2 $HASH4 $HASH1 &&
+	test_must_fail git bisect a &&
+	test_must_fail git bisect b &&
+	test_must_fail git bisect bad &&
+	test_must_fail git bisect good &&
+	test_must_fail git bisect new &&
+	test_must_fail git bisect old
+'
+
+test_expect_success 'bisect terms rejects invalid terms' '
+	git bisect reset &&
+	test_must_fail git bisect start --term-good invalid..term &&
+	test_must_fail git bisect terms --term-bad invalid..term &&
+	test_must_fail git bisect terms --term-good bad &&
+	test_must_fail git bisect terms --term-good old &&
+	test_must_fail git bisect terms --term-good skip &&
+	test_must_fail git bisect terms --term-good reset &&
+	test_path_is_missing .git/BISECT_TERMS
+'
+
+test_expect_success 'bisect start --term-* does store terms' '
+	git bisect reset &&
+	git bisect start --term-bad=one --term-good=two &&
+	git bisect terms >actual &&
+	cat <<-EOF >expected &&
+	Your current terms are two for the old state
+	and one for the new state.
+	EOF
+	test_cmp expected actual &&
+	git bisect terms --term-bad >actual &&
+	echo one >expected &&
+	test_cmp expected actual &&
+	git bisect terms --term-good >actual &&
+	echo two >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'bisect start takes options and revs in any order' '
+	git bisect reset &&
+	git bisect start --term-good one $HASH4 \
+		--term-good two --term-bad bad-term \
+		$HASH1 --term-good three -- &&
+	(git bisect terms --term-bad && git bisect terms --term-good) >actual &&
+	printf "%s\n%s\n" bad-term three >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.5.0.rc0.10.gd2bff5d
