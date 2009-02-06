From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (warning) Tonight's 'pu' may fail its tests
Date: Fri, 06 Feb 2009 03:32:11 -0800
Message-ID: <7v3aer7qdg.fsf@gitster.siamese.dyndns.org>
References: <7v7i437rqk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marius Storm-Olsen" <mstormo_git@storm-olsen.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 12:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOxu-0002XW-3M
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbZBFLcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZBFLcT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:32:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58590 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbZBFLcS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:32:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C75B497AB1;
	Fri,  6 Feb 2009 06:32:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7061597AB0; Fri,
  6 Feb 2009 06:32:13 -0500 (EST)
In-Reply-To: <7v7i437rqk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 06 Feb 2009 03:02:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEA4903C-F441-11DD-A779-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108689>

Junio C Hamano <gitster@pobox.com> writes:

> The frustrating thing is that
>
>     GIT_SKIP_TESTS='t[0-35-9]??? t4[01]??' \
>     GIT_TEST_OPTS='-i -v' \
>     make -j4 test
>
> fails very reliably with the above log, but:
>
>  (1) running the same "../../git-shortlog" in  "t/trash directory.t4203-mailmap/"
>      immediately after the test failed does emit the expected result;
>
>  (2) going down to t/ and manually running t4203-mailmap.sh alone succeeds;
>
>  (3) running the tests serially (i.e. without -j4) allows the test to succeed.

The test is broken and here is a fix I'll be squashing into the series.

The mystery was simply that it failed when the test was run in the
background (i.e. !isatty(0)) because it used "git shortlog" without saying
that it wants a shortlog from HEAD down to root explicitly.

 t/t4203-mailmap.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git i/t/t4203-mailmap.sh w/t/t4203-mailmap.sh
index c7a1238..094d905 100755
--- i/t/t4203-mailmap.sh
+++ w/t/t4203-mailmap.sh
@@ -24,7 +24,7 @@ nick1 (1):
 EOF
 
 test_expect_success 'No mailmap' '
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -39,7 +39,7 @@ EOF
 
 test_expect_success 'default .mailmap' '
 	echo "Repo Guy <author@example.com>" > .mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'log.mailmap set' '
 	mkdir internal_mailmap &&
 	echo "Internal Guy <bugs@company.xx>" > internal_mailmap/.mailmap &&
 	git config log.mailmap internal_mailmap/.mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -72,7 +72,7 @@ EOF
 test_expect_success 'log.mailmap override' '
 	echo "External Guy <author@example.com>" >> internal_mailmap/.mailmap &&
 	git config log.mailmap internal_mailmap/.mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -88,7 +88,7 @@ EOF
 test_expect_success 'log.mailmap file non-existant' '
 	rm internal_mailmap/.mailmap &&
 	rmdir internal_mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -102,7 +102,7 @@ nick1 (1):
 EOF
 test_expect_success 'No mailmap files, but configured' '
 	rm .mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
 
@@ -162,7 +162,7 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
 	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
 
-	git shortlog -e >actual &&
+	git shortlog -e HEAD >actual &&
 	test_cmp expect actual
 
 '
