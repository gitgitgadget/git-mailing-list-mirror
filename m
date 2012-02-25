From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] test-parse-options: convert to OPT_BOOL()
Date: Sat, 25 Feb 2012 20:11:16 +0100
Message-ID: <4F493254.1020801@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 20:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1N7q-0002fG-Ul
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 20:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621Ab2BYTRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 14:17:42 -0500
Received: from india601.server4you.de ([85.25.151.105]:38116 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546Ab2BYTRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 14:17:41 -0500
Received: from [192.168.2.105] (p4FFD9274.dip.t-dialin.net [79.253.146.116])
	by india601.server4you.de (Postfix) with ESMTPSA id 753592F8117;
	Sat, 25 Feb 2012 20:11:23 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F49317A.3080809@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191544>

Introduce OPT_BOOL() to test-parse-options and add some tests for
these "true" boolean options. Rename OPT_BOOLEAN to OPT_COUNTUP and
OPTION_BOOLEAN to OPTION_COUNTUP as well.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t0040-parse-options.sh |   60 ++++++++++++++++++++++++++++++++++++++++++++--
 test-parse-options.c     |   12 ++++++----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a1e4616..79aefe2 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -10,7 +10,10 @@ test_description='our own option parser'
 cat > expect << EOF
 usage: test-parse-options <options>
 
-    -b, --boolean         get a boolean
+    --yes                 get a boolean
+    -D, --no-doubt        begins with 'no-'
+    -B, --no-fear         be brave
+    -b, --boolean         increment by one
     -4, --or4             bitwise-or boolean with ...0100
     --neg-or4             same as --no-or4
 
@@ -53,6 +56,59 @@ test_expect_success 'test help' '
 
 mv expect expect.err
 
+cat >expect.template <<EOF
+boolean: 0
+integer: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+file: (not set)
+EOF
+
+check() {
+	what="$1" &&
+	shift &&
+	expect="$1" &&
+	shift &&
+	sed "s/^$what .*/$what $expect/" <expect.template >expect &&
+	test-parse-options $* >output 2>output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+}
+
+check_unknown() {
+	case "$1" in
+	--*)
+		echo error: unknown option \`${1#--}\' >expect ;;
+	-*)
+		echo error: unknown switch \`${1#-}\' >expect ;;
+	esac &&
+	cat expect.err >>expect &&
+	test_must_fail test-parse-options $* >output 2>output.err &&
+	test ! -s output &&
+	test_cmp expect output.err
+}
+
+test_expect_success 'OPT_BOOL() #1' 'check boolean: 1 --yes'
+test_expect_success 'OPT_BOOL() #2' 'check boolean: 1 --no-doubt'
+test_expect_success 'OPT_BOOL() #3' 'check boolean: 1 -D'
+test_expect_success 'OPT_BOOL() #4' 'check boolean: 1 --no-fear'
+test_expect_success 'OPT_BOOL() #5' 'check boolean: 1 -B'
+
+test_expect_success 'OPT_BOOL() is idempotent #1' 'check boolean: 1 --yes --yes'
+test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
+
+test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
+test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
+
+test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown --fear'
+test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown --no-no-fear'
+
+test_expect_failure 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
+
 cat > expect << EOF
 boolean: 2
 integer: 1729
@@ -296,7 +352,7 @@ test_expect_success 'OPT_NEGBIT() works' '
 	test_cmp expect output
 '
 
-test_expect_success 'OPT_BOOLEAN() with PARSE_OPT_NODASH works' '
+test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
 	test-parse-options + + + + + + > output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
diff --git a/test-parse-options.c b/test-parse-options.c
index 36487c4..3c9510a 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -37,7 +37,11 @@ int main(int argc, const char **argv)
 		NULL
 	};
 	struct option options[] = {
-		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
+		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
+		OPT_BOOL('D', "no-doubt", &boolean, "begins with 'no-'"),
+		{ OPTION_SET_INT, 'B', "no-fear", &boolean, NULL,
+		  "be brave", PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_COUNTUP('b', "boolean", &boolean, "increment by one"),
 		OPT_BIT('4', "or4", &boolean,
 			"bitwise-or boolean with ...0100", 4),
 		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
@@ -62,11 +66,11 @@ int main(int argc, const char **argv)
 		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
 			number_callback),
-		{ OPTION_BOOLEAN, '+', NULL, &boolean, NULL, "same as -b",
+		{ OPTION_COUNTUP, '+', NULL, &boolean, NULL, "same as -b",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH },
-		{ OPTION_BOOLEAN, 0, "ambiguous", &ambiguous, NULL,
+		{ OPTION_COUNTUP, 0, "ambiguous", &ambiguous, NULL,
 		  "positive ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
-		{ OPTION_BOOLEAN, 0, "no-ambiguous", &ambiguous, NULL,
+		{ OPTION_COUNTUP, 0, "no-ambiguous", &ambiguous, NULL,
 		  "negative ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
-- 
1.7.9.2
