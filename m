From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] test: use numstat instead of diffstat in binary-diff test
Date: Tue, 13 Mar 2012 00:02:19 -0500
Message-ID: <20120313050219.GF12550@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 06:02:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Jsb-0004Yx-MN
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 06:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028Ab2CMFCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 01:02:33 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46371 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185Ab2CMFCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 01:02:33 -0400
Received: by yenl12 with SMTP id l12so146696yen.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0p5EdZ3y0pk/J6VndIr6onHBUPiP08EYXtvixkQN+18=;
        b=goFSRHGq3J6mboevLqrxam5Mo9TzaMvuqFZrnApIQqSkFvPC9XLbpgMzvKJ7B8b1z2
         SOPjYPxc1qRwS4qlwWI/QzUpErooWVKrlmden+ejjLa0834aDIxpZBxTv8qkmXRi5dXr
         PbBUtjSW6WhNZ81au1jInVoaW35lrWOpyz59WjuuvhouBapJ4VaL/0LWBX/mMrCUU9SA
         jsvqmvTFvggarHPE1XK8hlY6fmJzk5iEYF1o3mMQ/IhZfJ9IpB1rBD2bOLLFWL0hPUAw
         xljaLenc1Pe8euePylZc5IOBHrzocsMTI0cb5NqKy951mIFvykB+LqA9DMKtdyQ+WxRE
         SgSQ==
Received: by 10.60.13.36 with SMTP id e4mr10059140oec.22.1331614952455;
        Mon, 12 Mar 2012 22:02:32 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q9sm24317299obz.14.2012.03.12.22.02.31
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 22:02:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192977>

git's --stat output is intended for humans and since v1.7.9.2~13
(2012-02-01) varies by locale.  The tests in this script using "apply
--stat" are meant to check two things:

 - how binary file changes are accounted for and printed in
   git's diffstat format

 - that "git apply" can parse the various forms of binary diff

Split these two kinds of check into separate tests, and use --numstat
instead of --stat in the latter.  This way, we lose less test coverage
when git is being run without writing its output in the C locale (for
example because GETTEXT_POISON is enabled) and there are fewer tests
to change if the --stat output needs to be tweaked again.

While at it, use commands separated by && that read and write to
temporary files in place of pipelines so segfaults and other failures
in the upstream of the processing pipeline don't get hidden.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4012-diff-binary.sh |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 008cf10a..ed24ddd8 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -8,6 +8,13 @@ test_description='Binary diff and apply
 
 . ./test-lib.sh
 
+cat >expect.binary-numstat <<\EOF
+1	1	a
+-	-	b
+1	1	c
+-	-	d
+EOF
+
 test_expect_success 'prepare repository' \
 	'echo AIT >a && echo BIT >b && echo CIT >c && echo DIT >d &&
 	 git update-index --add a b c d &&
@@ -23,13 +30,23 @@ cat > expected <<\EOF
  d |  Bin
  4 files changed, 2 insertions(+), 2 deletions(-)
 EOF
-test_expect_success 'diff without --binary' \
-	'git diff | git apply --stat --summary >current &&
-	 test_i18ncmp expected current'
+test_expect_success '"apply --stat" output for binary file change' '
+	git diff >diff &&
+	git apply --stat --summary <diff >current &&
+	test_i18ncmp expected current
+'
 
-test_expect_success 'diff with --binary' \
-	'git diff --binary | git apply --stat --summary >current &&
-	 test_i18ncmp expected current'
+test_expect_success 'apply --numstat notices binary file change' '
+	git diff >diff &&
+	git apply --numstat <diff >current &&
+	test_cmp expect.binary-numstat current
+'
+
+test_expect_success 'apply --numstat understands diff --binary format' '
+	git diff --binary >diff &&
+	git apply --numstat <diff >current &&
+	test_cmp expect.binary-numstat current
+'
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
-- 
1.7.9.2
