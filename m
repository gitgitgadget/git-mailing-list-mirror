From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] t1300: put git invocations inside test function
Date: Wed, 12 Oct 2011 14:29:20 -0400
Message-ID: <20111012182920.GA18948@sigill.intra.peff.net>
References: <20111012182742.GA14543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:29:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3YW-0001vG-6E
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab1JLS3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:29:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58666
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377Ab1JLS3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:29:22 -0400
Received: (qmail 13691 invoked by uid 107); 12 Oct 2011 18:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 14:29:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 14:29:20 -0400
Content-Disposition: inline
In-Reply-To: <20111012182742.GA14543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183386>

This is a very old script, and did a lot of:

  echo whatever >expect
  git config foo bar
  test_expect_success 'cmp .git/config expect'

which meant that we didn't actually check that the call to
git-config succeeded. Fix this, and while we're at it,
modernize the style to use test_cmp.

Signed-off-by: Jeff King <peff@peff.net>
---
There are still a few 'cp' and 'rm' calls outside of the test functions,
but we can generally expect those to work (as we do with the 'cat'
calls).

 t/t1300-repo-config.sh |  176 +++++++++++++++++++++++++-----------------------
 1 files changed, 93 insertions(+), 83 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3e140c1..cf508af 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -7,28 +7,28 @@ test_description='Test git config in different settings'
 
 . ./test-lib.sh
 
-test -f .git/config && rm .git/config
-
-git config core.penguin "little blue"
+test_expect_success 'clear default config' '
+	rm -f .git/config
+'
 
 cat > expect << EOF
 [core]
 	penguin = little blue
 EOF
-
-test_expect_success 'initial' 'cmp .git/config expect'
-
-git config Core.Movie BadPhysics
+test_expect_success 'initial' '
+	git config core.penguin "little blue" &&
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [core]
 	penguin = little blue
 	Movie = BadPhysics
 EOF
-
-test_expect_success 'mixed case' 'cmp .git/config expect'
-
-git config Cores.WhatEver Second
+test_expect_success 'mixed case' '
+	git config Core.Movie BadPhysics &&
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [core]
@@ -37,10 +37,10 @@ cat > expect << EOF
 [Cores]
 	WhatEver = Second
 EOF
-
-test_expect_success 'similar section' 'cmp .git/config expect'
-
-git config CORE.UPPERCASE true
+test_expect_success 'similar section' '
+	git config Cores.WhatEver Second
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [core]
@@ -50,8 +50,10 @@ cat > expect << EOF
 [Cores]
 	WhatEver = Second
 EOF
-
-test_expect_success 'similar section' 'cmp .git/config expect'
+test_expect_success 'uppercase section' '
+	git config CORE.UPPERCASE true &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'replace with non-match' \
 	'git config core.penguin kingpin !blue'
@@ -69,7 +71,7 @@ cat > expect << EOF
 	WhatEver = Second
 EOF
 
-test_expect_success 'non-match result' 'cmp .git/config expect'
+test_expect_success 'non-match result' 'test_cmp expect .git/config'
 
 cat > .git/config <<\EOF
 [alpha]
@@ -88,7 +90,7 @@ bar = foo
 [beta]
 EOF
 
-test_expect_success 'unset with cont. lines is correct' 'cmp .git/config expect'
+test_expect_success 'unset with cont. lines is correct' 'test_cmp expect .git/config'
 
 cat > .git/config << EOF
 [beta] ; silly comment # another comment
@@ -116,7 +118,7 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'multiple unset is correct' 'cmp .git/config expect'
+test_expect_success 'multiple unset is correct' 'test_cmp expect .git/config'
 
 cp .git/config2 .git/config
 
@@ -140,9 +142,7 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection] noNewline = ouch
 EOF
 
-test_expect_success 'all replaced' 'cmp .git/config expect'
-
-git config beta.haha alpha
+test_expect_success 'all replaced' 'test_cmp expect .git/config'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -153,10 +153,10 @@ noIndent= sillyValue ; 'nother silly comment
 	haha = alpha
 [nextSection] noNewline = ouch
 EOF
-
-test_expect_success 'really mean test' 'cmp .git/config expect'
-
-git config nextsection.nonewline wow
+test_expect_success 'really mean test' '
+	git config beta.haha alpha &&
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -168,11 +168,12 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection]
 	nonewline = wow
 EOF
-
-test_expect_success 'really really mean test' 'cmp .git/config expect'
+test_expect_success 'really really mean test' '
+	git config nextsection.nonewline wow &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'get value' 'test alpha = $(git config beta.haha)'
-git config --unset beta.haha
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -183,10 +184,10 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection]
 	nonewline = wow
 EOF
-
-test_expect_success 'unset' 'cmp .git/config expect'
-
-git config nextsection.NoNewLine "wow2 for me" "for me$"
+test_expect_success 'unset' '
+	git config --unset beta.haha &&
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [beta] ; silly comment # another comment
@@ -198,8 +199,10 @@ noIndent= sillyValue ; 'nother silly comment
 	nonewline = wow
 	NoNewLine = wow2 for me
 EOF
-
-test_expect_success 'multivar' 'cmp .git/config expect'
+test_expect_success 'multivar' '
+	git config nextsection.NoNewLine "wow2 for me" "for me$" &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'non-match' \
 	'git config --get nextsection.nonewline !for'
@@ -214,8 +217,6 @@ test_expect_success 'ambiguous get' '
 test_expect_success 'get multivar' \
 	'git config --get-all nextsection.nonewline'
 
-git config nextsection.nonewline "wow3" "wow$"
-
 cat > expect << EOF
 [beta] ; silly comment # another comment
 noIndent= sillyValue ; 'nother silly comment
@@ -226,8 +227,10 @@ noIndent= sillyValue ; 'nother silly comment
 	nonewline = wow3
 	NoNewLine = wow2 for me
 EOF
-
-test_expect_success 'multivar replace' 'cmp .git/config expect'
+test_expect_success 'multivar replace' '
+	git config nextsection.nonewline "wow3" "wow$" &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'ambiguous value' '
 	test_must_fail git config nextsection.nonewline
@@ -241,8 +244,6 @@ test_expect_success 'invalid unset' '
 	test_must_fail git config --unset somesection.nonewline
 '
 
-git config --unset nextsection.nonewline "wow3$"
-
 cat > expect << EOF
 [beta] ; silly comment # another comment
 noIndent= sillyValue ; 'nother silly comment
@@ -253,7 +254,10 @@ noIndent= sillyValue ; 'nother silly comment
 	NoNewLine = wow2 for me
 EOF
 
-test_expect_success 'multivar unset' 'cmp .git/config expect'
+test_expect_success 'multivar unset' '
+	git config --unset nextsection.nonewline "wow3$" &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'invalid key' 'test_must_fail git config inval.2key blabla'
 
@@ -276,7 +280,7 @@ noIndent= sillyValue ; 'nother silly comment
 	Alpha = beta
 EOF
 
-test_expect_success 'hierarchical section value' 'cmp .git/config expect'
+test_expect_success 'hierarchical section value' 'test_cmp expect .git/config'
 
 cat > expect << EOF
 beta.noindent=sillyValue
@@ -304,15 +308,16 @@ EOF
 test_expect_success '--get-regexp' \
 	'git config --get-regexp in > output && cmp output expect'
 
-git config --add nextsection.nonewline "wow4 for you"
-
 cat > expect << EOF
 wow2 for me
 wow4 for you
 EOF
 
-test_expect_success '--add' \
-	'git config --get-all nextsection.nonewline > output && cmp output expect'
+test_expect_success '--add' '
+	git config --add nextsection.nonewline "wow4 for you" &&
+	git config --get-all nextsection.nonewline > output &&
+	test_cmp expect output
+'
 
 cat > .git/config << EOF
 [novalue]
@@ -361,8 +366,6 @@ cat > .git/config << EOF
 	c = d
 EOF
 
-git config a.x y
-
 cat > expect << EOF
 [a.b]
 	c = d
@@ -370,10 +373,10 @@ cat > expect << EOF
 	x = y
 EOF
 
-test_expect_success 'new section is partial match of another' 'cmp .git/config expect'
-
-git config b.x y
-git config a.b c
+test_expect_success 'new section is partial match of another' '
+	git config a.x y &&
+	test_cmp expect .git/config
+'
 
 cat > expect << EOF
 [a.b]
@@ -385,7 +388,11 @@ cat > expect << EOF
 	x = y
 EOF
 
-test_expect_success 'new variable inserts into proper section' 'cmp .git/config expect'
+test_expect_success 'new variable inserts into proper section' '
+	git config b.x y &&
+	git config a.b c &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'alternative GIT_CONFIG (non-existing file should fail)' \
 	'test_must_fail git config --file non-existing-config -l'
@@ -399,9 +406,10 @@ cat > expect << EOF
 ein.bahn=strasse
 EOF
 
-GIT_CONFIG=other-config git config -l > output
-
-test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
+test_expect_success 'alternative GIT_CONFIG' '
+	GIT_CONFIG=other-config git config -l >output &&
+	test_cmp expect output
+'
 
 test_expect_success 'alternative GIT_CONFIG (--file)' \
 	'git config --file other-config -l > output && cmp output expect'
@@ -417,8 +425,6 @@ test_expect_success 'refer config from subdirectory' '
 
 '
 
-GIT_CONFIG=other-config git config anwohner.park ausweis
-
 cat > expect << EOF
 [ein]
 	bahn = strasse
@@ -426,7 +432,10 @@ cat > expect << EOF
 	park = ausweis
 EOF
 
-test_expect_success '--set in alternative GIT_CONFIG' 'cmp other-config expect'
+test_expect_success '--set in alternative GIT_CONFIG' '
+	GIT_CONFIG=other-config git config anwohner.park ausweis &&
+	test_cmp expect other-config
+'
 
 cat > .git/config << EOF
 # Hallo
@@ -531,7 +540,7 @@ test_expect_success 'section ending' '
 	git config gitcvs.enabled true &&
 	git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
 	git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
-	cmp .git/config expect
+	test_cmp expect .git/config
 
 '
 
@@ -750,13 +759,6 @@ test_expect_success NOT_MINGW 'get --path copes with unset $HOME' '
 	test_cmp expect result
 '
 
-rm .git/config
-
-git config quote.leading " test"
-git config quote.ending "test "
-git config quote.semicolon "test;test"
-git config quote.hash "test#test"
-
 cat > expect << EOF
 [quote]
 	leading = " test"
@@ -764,8 +766,14 @@ cat > expect << EOF
 	semicolon = "test;test"
 	hash = "test#test"
 EOF
-
-test_expect_success 'quoting' 'cmp .git/config expect'
+test_expect_success 'quoting' '
+	rm .git/config &&
+	git config quote.leading " test" &&
+	git config quote.ending "test " &&
+	git config quote.semicolon "test;test" &&
+	git config quote.hash "test#test" &&
+	test_cmp expect .git/config
+'
 
 test_expect_success 'key with newline' '
 	test_must_fail git config "key.with
@@ -790,9 +798,10 @@ section.noncont=not continued
 section.quotecont=cont;inued
 EOF
 
-git config --list > result
-
-test_expect_success 'value continued on next line' 'cmp result expect'
+test_expect_success 'value continued on next line' '
+	git config --list > result &&
+	cmp result expect
+'
 
 cat > .git/config <<\EOF
 [section "sub=section"]
@@ -813,16 +822,17 @@ barQsection.sub=section.val3
 Qsection.sub=section.val4
 Qsection.sub=section.val5Q
 EOF
+test_expect_success '--null --list' '
+	git config --null --list | nul_to_q >result &&
+	echo >>result &&
+	test_cmp expect result
+'
 
-git config --null --list | perl -pe 'y/\000/Q/' > result
-echo >>result
-
-test_expect_success '--null --list' 'cmp result expect'
-
-git config --null --get-regexp 'val[0-9]' | perl -pe 'y/\000/Q/' > result
-echo >>result
-
-test_expect_success '--null --get-regexp' 'cmp result expect'
+test_expect_success '--null --get-regexp' '
+	git config --null --get-regexp "val[0-9]" | nul_to_q >result &&
+	echo >>result &&
+	test_cmp expect result
+'
 
 test_expect_success 'inner whitespace kept verbatim' '
 	git config section.val "foo 	  bar" &&
-- 
1.7.7.rc2.21.gb9948
