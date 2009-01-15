From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] color-words: make regex configurable via
 attributes
Date: Thu, 15 Jan 2009 02:33:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150233121.3586@pacific.mpi-cbg.de>
References: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch> <48504e8a330beca560208ce050d43bc92ac04c90.1231971446.git.trast@student.ethz.ch> <b1290f83267e64856e58477e0c19e920dd416c82.1231971446.git.trast@student.ethz.ch>
 <b404fdfe0f5af535b35d1f239a68f6a7911ede19.1231971446.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:34:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNH7p-00040B-0m
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZAOBdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 20:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZAOBdC
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:33:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:49081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751966AbZAOBdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:33:00 -0500
Received: (qmail invoked by alias); 15 Jan 2009 01:32:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 15 Jan 2009 02:32:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Eo8khfDFEs+pIN4Y/t+SRvv0D9O5pF6GU6KSE+s
	Tu2O8BIc5U7dFI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <b404fdfe0f5af535b35d1f239a68f6a7911ede19.1231971446.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105752>

Hi Thomas,

could you please squash this in?

-- snipsnap --
[PATCH to be squashed into the attributes patch] Decomplicate t4034 again

---
 t/t4034-diff-words.sh |   50 ++++++++++++++++++++++--------------------------
 1 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 631ca44..07e48d1 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -22,10 +22,8 @@ decrypt_color () {
 
 word_diff () {
 	test_must_fail git diff --no-index "$@" pre post > output &&
-	decrypt_color < output > output.decrypted
-}
-word_diff_check () {
-	test_cmp "$1" output.decrypted
+	decrypt_color < output > output.decrypted &&
+	test_cmp expect output.decrypted
 }
 
 cat > pre <<\EOF
@@ -82,12 +80,25 @@ EOF
 
 test_expect_success 'word diff with a regular expression' '
 
-	word_diff --color-words="[a-z]+" &&
-	word_diff_check expect
+	word_diff --color-words="[a-z]+"
 
 '
 
-cat > expect-by-chars <<\EOF
+test_expect_success 'set a diff driver' '
+	git config diff.testdriver.wordregex "[^[:space:]]" &&
+	cat <<EOF > .gitattributes
+pre diff=testdriver
+post diff=testdriver
+EOF
+'
+
+test_expect_success 'option overrides default' '
+
+	word_diff --color-words="[a-z]+"
+
+'
+
+cat > expect <<\EOF
 <WHITE>diff --git a/pre b/post<RESET>
 <WHITE>index 330b04f..5ed8eff 100644<RESET>
 <WHITE>--- a/pre<RESET>
@@ -102,25 +113,9 @@ a = b + c<RESET>
 <GREEN>aeff = aeff * ( aaa )<RESET>
 EOF
 
-test_expect_success 'set a diff driver' '
-	git config diff.testdriver.wordregex "[^[:space:]]" &&
-	cat <<EOF > .gitattributes
-pre diff=testdriver
-post diff=testdriver
-EOF
-'
-
 test_expect_success 'use default supplied by driver' '
 
-	word_diff --color-words &&
-	word_diff_check expect-by-chars
-
-'
-
-test_expect_success 'option overrides default' '
-
-	word_diff --color-words="[a-z]+" &&
-	word_diff_check expect
+	word_diff --color-words
 
 '
 
@@ -136,10 +131,11 @@ cat > expect <<\EOF
 aaa (aaa) <GREEN>aaa<RESET>
 EOF
 
-test_expect_success "test parsing words for newline" '
+test_expect_success 'test parsing words for newline' '
+
+	word_diff --color-words="a+"
 
-	word_diff --color-words="a+" &&
-	word_diff_check expect
+	word_diff --color-words=.
 
 '
 
-- 
1.6.1.300.gbc493
