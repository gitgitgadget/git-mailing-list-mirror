From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] Test and fix normalize_path_copy()
Date: Sun, 08 Feb 2009 15:46:00 +0100
Message-ID: <498EF028.3040702@lsrfire.ath.cx>
References: <498CAF73.6050409@lsrfire.ath.cx> <1234019311-6449-1-git-send-email-j6t@kdbg.org> <1234019311-6449-2-git-send-email-j6t@kdbg.org> <1234019311-6449-3-git-send-email-j6t@kdbg.org> <1234019311-6449-4-git-send-email-j6t@kdbg.org> <1234019311-6449-5-git-send-email-j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 08 15:55:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWB3h-0003Dy-QO
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 15:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZBHOqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 09:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbZBHOqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 09:46:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:52014 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZBHOqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 09:46:08 -0500
Received: from [10.0.1.101] (p57B7D56F.dip.t-dialin.net [87.183.213.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 77E7B2F8026;
	Sun,  8 Feb 2009 15:46:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1234019311-6449-5-git-send-email-j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108984>

Johannes Sixt schrieb:
> Moreover, the test case descriptions of t0060 now include the test data and
> expected outcome.

The test still fails in a lot of cases for me, because "/" is translated to
the installation path of msys.  E.g. with the patch at the end, which shows
the results in addition to input and expected output, I get several cases
like this (the first test call checks the return code):

* FAIL 2: normalize absolute: '/' => '/'
	test 0 = 0 && test 'C:/Program Files (x86)/msysgit/msysgit' = '/'

* FAIL 32: longest ancestor: '/foo' '/' => '0'
	test 0 = 0 && test '38' = '0'

I'm not sure what to do about it.  Should test-path-utils translate it back
into "root is / is root"?  Should the test script look up "/" at the top
and just append this value to all paths?  Unpretty.


And then there's this:

* FAIL 7: normalize absolute: '/./..' => '++failed++'
	test 0 = 0 && test 'C:/Program Files (x86)/msysgit/msysgit' = '++failed++'
*   ok 8: normalize absolute: '/../.' => '++failed++'

A printf() added to the top of normalize_path_copy() tells me that you can
add as many "/.." as you want after a path starting with "/.", it will
always translate into the install directory of msys regardless.


Anyway, here's the patch mentioned above:

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4ed1f0b..d5a38a6 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -8,13 +8,17 @@ test_description='Test various path utilities'
 . ./test-lib.sh
 
 norm_abs() {
-	test_expect_success "normalize absolute: $1 => $2" \
-	"test \"\$(test-path-utils normalize_path_copy '$1')\" = '$2'"
+	result=$(test-path-utils normalize_path_copy "$1")
+	rc=$?
+	test_expect_success "normalize absolute: '$1' => '$2'" \
+	"test $rc = 0 && test '$result' = '$2'"
 }
 
 ancestor() {
-	test_expect_success "longest ancestor: $1 $2 => $3" \
-	"test \"\$(test-path-utils longest_ancestor_length '$1' '$2')\" = '$3'"
+	result=$(test-path-utils longest_ancestor_length "$1" "$2")
+	rc=$?
+	test_expect_success "longest ancestor: '$1' '$2' => '$3'" \
+	"test $rc = 0 && test '$result' = '$3'"
 }
 
 norm_abs "" ""
