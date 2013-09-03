From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] rev-parse test: use test_cmp instead of "test" builtin
Date: Tue, 3 Sep 2013 10:07:15 -0700
Message-ID: <20130903170715.GD29921@google.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGu4g-0005oH-3y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431Ab3ICRH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:07:26 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:50593 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab3ICRHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:07:25 -0400
Received: by mail-ye0-f170.google.com with SMTP id r4so777026yen.15
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f/yomMgaxJVVc+4WO4FwawUiB5iLJ/Ul+ap0xwuY87s=;
        b=gbyy3dWIAstYSaIKxKTXGGTqe6Ge4Y3ZyfDOaFUKjm9IRKHly6AzThaVcMd7m2aoDM
         +nVA4tnK/ZI0joQqStN6uTRdEmQmzX8J3br6slmOc5X5EJy8901USKDwLS0/qFJuR3aB
         Lz9jdwa6DHBdGTbzqx0vgmKqDD52mgoFekwr/6mnNE82oq0JK49A92lcGV+V+E+7jZAb
         AbthsCas2qsy5IWX3x23XMfOVZK7+nip8jsklHAkOSNQo09lXnm6Obg2Z2bADWA74aZq
         4su39vLWkX3OjN0MsR3zbLNjDxpkBTqwvZgcVbu+ER7/9ldUml077jqKzZOYZJpIoYN8
         qrIA==
X-Received: by 10.236.150.112 with SMTP id y76mr9420yhj.165.1378228045178;
        Tue, 03 Sep 2013 10:07:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id f67sm23701366yhi.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 10:07:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130903170419.GA29921@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233740>

Use test_cmp instead of passing two command substitutions to the
"test" builtin.  This way:

 - when tests fail, they can print a helpful diff if run with
   "--verbose"

 - the argument order "test_cmp expect actual" feels natural,
   unlike test <known> = <unknown> that seems a little backwards

 - the exit status from invoking git is checked, so if rev-parse
   starts segfaulting then the test will notice and fail

Use a custom function for this instead of test_cmp_rev to emphasize
that we are testing the output from "git rev-parse" with certain
arguments, not checking that the revisions are equal in abstract.

Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 416067c..8a6ff66 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -8,6 +8,12 @@ test_description='Test git rev-parse with different parent options'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
+test_cmp_rev_output () {
+	git rev-parse --verify "$1" >expect &&
+	eval "$2" >actual &&
+	test_cmp expect actual
+}
+
 date >path0
 git update-index --add path0
 save_tag tree git write-tree
@@ -22,7 +28,7 @@ test_expect_success 'start is valid' '
 '
 
 test_expect_success 'start^0' '
-	test $(cat .git/refs/tags/start) = $(git rev-parse start^0)
+	test_cmp_rev_output tags/start "git rev-parse start^0"
 '
 
 test_expect_success 'start^1 not valid' '
@@ -30,19 +36,19 @@ test_expect_success 'start^1 not valid' '
 '
 
 test_expect_success 'second^1 = second^' '
-	test $(git rev-parse second^1) = $(git rev-parse second^)
+	test_cmp_rev_output second^ "git rev-parse second^1"
 '
 
 test_expect_success 'final^1^1^1' '
-	test $(git rev-parse start) = $(git rev-parse final^1^1^1)
+	test_cmp_rev_output start "git rev-parse final^1^1^1"
 '
 
 test_expect_success 'final^1^1^1 = final^^^' '
-	test $(git rev-parse final^1^1^1) = $(git rev-parse final^^^)
+	test_cmp_rev_output final^^^ "git rev-parse final^1^1^1"
 '
 
 test_expect_success 'final^1^2' '
-	test $(git rev-parse start2) = $(git rev-parse final^1^2)
+	test_cmp_rev_output start2 "git rev-parse final^1^2"
 '
 
 test_expect_success 'final^1^2 != final^1^1' '
@@ -62,11 +68,15 @@ test_expect_success '--verify start2^0' '
 '
 
 test_expect_success 'final^1^@ = final^1^1 final^1^2' '
-	test "$(git rev-parse final^1^@)" = "$(git rev-parse final^1^1 final^1^2)"
+	git rev-parse final^1^1 final^1^2 >expect &&
+	git rev-parse final^1^@ >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'final^1^! = final^1 ^final^1^1 ^final^1^2' '
-	test "$(git rev-parse final^1^!)" = "$(git rev-parse final^1 ^final^1^1 ^final^1^2)"
+	git rev-parse final^1 ^final^1^1 ^final^1^2 >expect &&
+	git rev-parse final^1^! >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'repack for next test' '
@@ -74,13 +84,8 @@ test_expect_success 'repack for next test' '
 '
 
 test_expect_success 'short SHA-1 works' '
-	start=`git rev-parse --verify start` &&
-	echo $start &&
-	abbrv=`echo $start | sed s/.\$//` &&
-	echo $abbrv &&
-	abbrv=`git rev-parse --verify $abbrv` &&
-	echo $abbrv &&
-	test $start = $abbrv
+	start=$(git rev-parse --verify start) &&
+	test_cmp_rev_output start "git rev-parse ${start%?}"
 '
 
 test_done
-- 
1.8.4
