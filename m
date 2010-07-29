From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFH] Spurious failures of t0025.[34]
Date: Thu, 29 Jul 2010 23:40:01 +0200
Message-ID: <201007292340.01836.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 29 23:40:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeaqD-0006ir-BT
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 23:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab0G2Vk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 17:40:28 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:43102 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665Ab0G2VkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 17:40:25 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 29 Jul
 2010 23:40:23 +0200
Received: from thomas.site (84.74.100.241) by CAS12.d.ethz.ch (172.31.38.212)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 29 Jul 2010 23:40:02
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152201>

Hi *

I have another hard-to-explain test failure under --valgrind.  I hope
it's not yet another bug buried deep in valgrind itself...

Doing the following on current next (v1.7.2.1-230-g75e8ac1) stops
after a number of iterations, usually within 5 minutes:

  while GIT_SKIP_TESTS="t0025.[5-9] t0025.??" \
      ./t0025-crlf-auto.sh --valgrind --root=/dev/shm --tee -i
  do
    :
  done

I can reproduce this both on the machine I use for valgrinding, and my
work laptop, and they're quite different:

  openSuSE 11.3, 2.6.34, gcc 4.5.0, glibc 2.11.2
  RHEL 5.4, 2.6.18, gcc 4.1.2, glibc 2.5

I ordinarily run a bleeding edge valgrind on both (calls itself
3.6.0SVN) because of the env handling bug from last month, but I also
tried with valgrind 3.5.0 on the RHEL box, same problem.

It seems random whether it stops at test 3 or 4, but #4 seems more
frequent.  These tests read

  test_expect_success 'crlf=true causes a CRLF file to be normalized' '

          # Backwards compatibility check
          rm -f .gitattributes tmp one two three &&
          echo "two crlf" > .gitattributes &&
          git read-tree --reset -u HEAD &&

          # Note, "normalized" means that git will normalize it if added
          has_cr two &&
          twodiff=`git diff two` &&
          test -n "$twodiff"
  '

  test_expect_success 'text=true causes a CRLF file to be normalized' '

          rm -f .gitattributes tmp one two three &&
          echo "two text" > .gitattributes &&
          git read-tree --reset -u HEAD &&

          # Note, "normalized" means that git will normalize it if added
          has_cr two &&
          twodiff=`git diff two` &&
          test -n "$twodiff"
  '

I tried patching them in this way:

---- 8< ----
diff --git i/t/t0025-crlf-auto.sh w/t/t0025-crlf-auto.sh
index f5f67a6..d7424c9 100755
--- i/t/t0025-crlf-auto.sh
+++ w/t/t0025-crlf-auto.sh
@@ -48,8 +48,7 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
-	twodiff=`git diff two` &&
-	test -n "$twodiff"
+	test_must_fail git diff --exit-code two
 '
 
 test_expect_success 'text=true causes a CRLF file to be normalized' '
@@ -60,8 +59,7 @@ test_expect_success 'text=true causes a CRLF file to be normalized' '
 
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
-	twodiff=`git diff two` &&
-	test -n "$twodiff"
+	test_must_fail git diff --exit-code two
 '
 
 test_expect_success 'eol=crlf gives a normalized file CRLFs with autocrlf=false' '
---- >8 ----

Unless I'm too tired, these should be equivalent.  I gained no extra
information by doing so; it just stops at a random iteration with an
empty diff.  Maybe it shifts the weight slightly towards #3 failing,
but that could just as well be the placebo effect, I have not done any
statistics.  It looks like

  expecting success: 

          rm -f .gitattributes tmp one two three &&
          echo "two text" > .gitattributes &&
          git read-tree --reset -u HEAD &&

          # Note, "normalized" means that git will normalize it if added
          has_cr two &&
          xxd two &&
          test_must_fail git diff --exit-code two

  0000000: 490d 0a61 6d0d 0a76 6572 790d 0a76 6572  I..am..very..ver
  0000010: 790d 0a66 696e 650d 0a74 6861 6e6b 0d0a  y..fine..thank..
  0000020: 796f 750d 0a                             you..
  not ok - 4 text=true causes a CRLF file to be normalized
  #
  #
  #               rm -f .gitattributes tmp one two three &&
  #               echo "two text" > .gitattributes &&
  #               git read-tree --reset -u HEAD &&
  #
  #               # Note, "normalized" means that git will normalize it if added
  #               has_cr two &&
  #               xxd two &&
  #               test_must_fail git diff --exit-code two
  #

I.e., nothing out of the ordinary except that the diff is empty.

So... does anyone have any ideas what to test next?  Or what might
cause this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
