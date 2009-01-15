From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: [PATCH/RFC v1 1/1] +5 cases (4 fail), diff whitespace tests
Date: Wed, 14 Jan 2009 16:48:24 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901141633030.9831@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 01:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGYQ-0003F4-Rd
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756465AbZAOA4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761291AbZAOA4C
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:56:02 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:37656 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657AbZAOAz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:55:59 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 19:55:59 EST
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0F0mP8o011328;
	Wed, 14 Jan 2009 16:48:25 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0F0mPxG011325;
	Wed, 14 Jan 2009 16:48:25 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105749>

  +5 cases (4 fail), diff whitespace tests
  There are 2^3 = eight possible combinations of the three flags:
  -w -b --ignore-space-at-eol
  Three of those combinations were already being tested:
  [none]
  -w
  -b
  Add tests of the other five combinations,
  four of which fail with git
  3cf3b838c7b379824c68ee87799aaaa9028b36cd
  from Tue Jan 13 23:41:32 2009 -0800.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---

All four failures involve combining whitespace ignore options.  It's likely the 
fix will involve one or both of the following two functions in xdiff/xutils.c:
xdl_hash_record_with_whitespace()
xdl_recmatch()

I played around with it and discovered I could make
"git diff -b --ignore-space-at-eol" work by changing
if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
to
else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
But I don't know if that would break something else.

                                          -- Keith

  t/t4015-diff-whitespace.sh |   27 +++++++++++++++++++++++++++
  1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index fc2307e..dbb608c 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -98,6 +98,12 @@ index d99af23..8b32fb5 100644
  EOF
  git diff -w > out
  test_expect_success 'another test, with -w' 'test_cmp expect out'
+git diff -w -b > out
+test_expect_failure 'another test, with -w -b' 'test_cmp expect out'
+git diff -w --ignore-space-at-eol > out
+test_expect_failure 'another test, with -w --ignore-space-at-eol' 'test_cmp expect out'
+git diff -w -b --ignore-space-at-eol > out
+test_expect_failure 'another test, with -w -b --ignore-space-at-eol' 'test_cmp expect out'

  tr 'Q' '\015' << EOF > expect
  diff --git a/x b/x
@@ -116,6 +122,27 @@ index d99af23..8b32fb5 100644
  EOF
  git diff -b > out
  test_expect_success 'another test, with -b' 'test_cmp expect out'
+git diff -b --ignore-space-at-eol > out
+test_expect_failure 'another test, with -b --ignore-space-at-eol' 'test_cmp expect out'
+
+tr 'Q' '\015' << EOF > expect
+diff --git a/x b/x
+index d99af23..8b32fb5 100644
+--- a/x
++++ b/x
+@@ -1,6 +1,6 @@
+-whitespace at beginning
+-whitespace change
+-whitespace in the middle
++	whitespace at beginning
++whitespace 	 change
++white space in the middle
+ whitespace at end
+ unchanged line
+ CR at endQ
+EOF
+git diff --ignore-space-at-eol > out
+test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect out'

  test_expect_success 'check mixed spaces and tabs in indent' '

-- 
1.6.1.137.gb17b6
