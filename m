From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: [PATCH/RFC v1 1/1] bug fix, diff whitespace ignore options
Date: Sun, 18 Jan 2009 18:01:47 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901181754190.9333@kiwi.cs.ucla.edu>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de>  <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>  <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de> 
 <8c5c35580901181331v5e54f82fxc6a042962ff1cd06@mail.gmail.com>  <alpine.DEB.1.00.0901182244310.3586@pacific.mpi-cbg.de> <8c5c35580901181446n3c36a345m5d8e78764a85c123@mail.gmail.com> <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 03:03:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjU1-0005Fq-4z
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878AbZASCBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 21:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756797AbZASCBy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:01:54 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:38289 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756743AbZASCBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:01:53 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0J21lHK011768;
	Sun, 18 Jan 2009 18:01:47 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0J21lj0011763;
	Sun, 18 Jan 2009 18:01:47 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0901190218470.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106300>

  Fixed bug in diff whitespace ignore options.
  It is now OK to specify more than one whitespace ignore option
  on the command line. In unit test 4015, expect success rather
  than failure for 4 cases.
  Note: I do not fully understand why this fix works, but it passes
  all 68 t4???-* diff test scripts.

The semantics of the three whitespace ignore flags
{ -w, -b, --ignore-space-at-eol }
obey a relation of transitive implication, i.e. the stronger
options imply the weaker options:
-w                    implies the other two
-b                    implies --ignore-space-at-eol
--ignore-space-at-eol implies only itself

Therefore it is never necessary to specify more than one of these
on the command line.  Yet we imagine scenarios where software
wrappers (e.g. GUIs, etc) generate command lines that switch on
more than one of these flags simultaneously.  It is unreasonable
to prohibit specifying more than one, since a new user might not
immediately discern the implication relation.  Now we call such
a command line valid and legal.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
  t/t4015-diff-whitespace.sh |    8 ++++----
  xdiff/xutils.c             |   22 ++++++++++++----------
  2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index dbb608c..6d13da3 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -99,11 +99,11 @@ EOF
  git diff -w > out
  test_expect_success 'another test, with -w' 'test_cmp expect out'
  git diff -w -b > out
-test_expect_failure 'another test, with -w -b' 'test_cmp expect out'
+test_expect_success 'another test, with -w -b' 'test_cmp expect out'
  git diff -w --ignore-space-at-eol > out
-test_expect_failure 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
+test_expect_success 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
  git diff -w -b --ignore-space-at-eol > out
-test_expect_failure 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'
+test_expect_success 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'

  tr 'Q' '\015' << EOF > expect
  diff --git a/x b/x
@@ -123,7 +123,7 @@ EOF
  git diff -b > out
  test_expect_success 'another test, with -b' 'test_cmp expect out'
  git diff -b --ignore-space-at-eol > out
-test_expect_failure 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'
+test_expect_success 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'

  tr 'Q' '\015' << EOF > expect
  diff --git a/x b/x
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index d7974d1..b9bda86 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -245,17 +245,19 @@ static unsigned long xdl_hash_record_with_whitespace(char const **data,
  			while (ptr + 1 < top && isspace(ptr[1])
  					&& ptr[1] != '\n')
  				ptr++;
-			if (flags & XDF_IGNORE_WHITESPACE_CHANGE
-					&& ptr[1] != '\n') {
-				ha += (ha << 5);
-				ha ^= (unsigned long) ' ';
-			}
-			if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
-					&& ptr[1] != '\n') {
-				while (ptr2 != ptr + 1) {
+			if( ! (          flags & XDF_IGNORE_WHITESPACE       )){
+				if(      flags & XDF_IGNORE_WHITESPACE_CHANGE
+						&& ptr[1] != '\n') {
  					ha += (ha << 5);
-					ha ^= (unsigned long) *ptr2;
-					ptr2++;
+					ha ^= (unsigned long) ' ';
+				}
+				else if( flags & XDF_IGNORE_WHITESPACE_AT_EOL
+						&& ptr[1] != '\n') {
+					while (ptr2 != ptr + 1) {
+						ha += (ha << 5);
+						ha ^= (unsigned long) *ptr2;
+						ptr2++;
+					}
  				}
  			}
  			continue;
-- 
1.6.1.203.ga83c8.dirty
