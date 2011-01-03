From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] tests: give vcs-svn/line_buffer its own test script
Date: Sun, 2 Jan 2011 18:51:07 -0600
Message-ID: <20110103005107.GC30506@burratino>
References: <20101224080505.GA29681@burratino>
 <20110103004900.GA30506@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 03 01:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZYds-0003UD-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 01:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab1ACAvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 19:51:16 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61937 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1ACAvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 19:51:15 -0500
Received: by gxk9 with SMTP id 9so2459864gxk.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 16:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qjkHQMjFkqqG6p6P9kOBzh0brkK01BSRN7ZoGzgY/JQ=;
        b=cUpvVeh/vg2RreP6UF8pBJQ29hmJ34jqkg82wSlsQXyb1iPH2bwcvqhiFW1F0rOYGE
         1Om2HsOucInx2YpoRpnZxSTW9yqRknYIvqso7zkh+eRLr2c/g+7hBv74AD1PbzcuAvsb
         IREg9XppT+rGPdcVfuJEUnsulHuFInWeIa0gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ooNeIGh0QTzgswbWL0tQZG/WZYQ4feI1jXJHukOL7T4Nr95mbyTZdxlaetLQZ9AK8x
         o5yEVSLycPsRb/f5VmbZMJHhhUlKj1m5TNsRqwr4p/MFOi+gQfQewwi18VvdJThfm9Dr
         sp6mNiP/5rTW2Aw/9Pj8hv2cPRS+sUC3JugMY=
Received: by 10.90.20.6 with SMTP id 6mr11417409agt.200.1294015874883;
        Sun, 02 Jan 2011 16:51:14 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id e74sm11842553yhc.5.2011.01.02.16.51.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 16:51:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110103004900.GA30506@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164432>

Split the line_buffer test into small pieces and move it to its
own file as preparation for adding more tests.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0080-vcs-svn.sh     |   54 --------------------------------------
 t/t0081-line-buffer.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 54 deletions(-)
 create mode 100755 t/t0081-line-buffer.sh

diff --git a/t/t0080-vcs-svn.sh b/t/t0080-vcs-svn.sh
index 8be9700..99a314b 100755
--- a/t/t0080-vcs-svn.sh
+++ b/t/t0080-vcs-svn.sh
@@ -76,60 +76,6 @@ test_expect_success 'obj pool: high-water mark' '
 	test_cmp expected actual
 '
 
-test_expect_success 'line buffer' '
-	echo HELLO >expected1 &&
-	printf "%s\n" "" HELLO >expected2 &&
-	echo >expected3 &&
-	printf "%s\n" "" Q | q_to_nul >expected4 &&
-	printf "%s\n" foo "" >expected5 &&
-	printf "%s\n" "" foo >expected6 &&
-
-	test-line-buffer <<-\EOF >actual1 &&
-	read 5
-	HELLO
-	EOF
-
-	test-line-buffer <<-\EOF >actual2 &&
-	read 0
-
-	copy 5
-	HELLO
-	EOF
-
-	q_to_nul <<-\EOF |
-	read 1
-	Q
-	EOF
-	test-line-buffer >actual3 &&
-
-	q_to_nul <<-\EOF |
-	read 0
-
-	copy 1
-	Q
-	EOF
-	test-line-buffer >actual4 &&
-
-	test-line-buffer <<-\EOF >actual5 &&
-	read 5
-	foo
-	EOF
-
-	test-line-buffer <<-\EOF >actual6 &&
-	read 0
-
-	copy 5
-	foo
-	EOF
-
-	test_cmp expected1 actual1 &&
-	test_cmp expected2 actual2 &&
-	test_cmp expected3 actual3 &&
-	test_cmp expected4 actual4 &&
-	test_cmp expected5 actual5 &&
-	test_cmp expected6 actual6
-'
-
 test_expect_success 'string pool' '
 	echo a does not equal b >expected.differ &&
 	echo a equals a >expected.match &&
diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
new file mode 100755
index 0000000..13ac735
--- /dev/null
+++ b/t/t0081-line-buffer.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description="Test the svn importer's input handling routines.
+"
+. ./test-lib.sh
+
+test_expect_success 'read greeting' '
+	echo HELLO >expect &&
+	test-line-buffer <<-\EOF >actual &&
+	read 5
+	HELLO
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '0-length read, send along greeting' '
+	printf "%s\n" "" HELLO >expect &&
+	test-line-buffer <<-\EOF >actual &&
+	read 0
+
+	copy 5
+	HELLO
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'buffer_read_string copes with trailing null byte' '
+	echo >expect &&
+	q_to_nul <<-\EOF | test-line-buffer >actual &&
+	read 1
+	Q
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '0-length read, copy null byte' '
+	printf "%s\n" "" Q | q_to_nul >expect &&
+	q_to_nul <<-\EOF | test-line-buffer >actual &&
+	read 0
+
+	copy 1
+	Q
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'long reads are truncated' '
+	printf "%s\n" foo "" >expect &&
+	test-line-buffer <<-\EOF >actual &&
+	read 5
+	foo
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'long copies are truncated' '
+	printf "%s\n" "" foo >expect &&
+	test-line-buffer <<-\EOF >actual &&
+	read 0
+
+	copy 5
+	foo
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.4.rc0.580.g89dc.dirty
