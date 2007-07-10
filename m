From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] t7004: Add tests for the git tag -n option.
Date: Wed, 11 Jul 2007 01:11:53 +0200
Message-ID: <46941239.4060101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 01:12:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8OsO-0005oA-UT
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 01:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205AbXGJXL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 19:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903AbXGJXL6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 19:11:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:19087 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbXGJXL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 19:11:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1442769ugf
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:11:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Sj9LJYrglRlQ39QgjgP8iCerqTOT87Fcvn4ybIljI4ABs6VTWSI+j8wA3MRyRnKVhWwtLeSmqhrJwoxCMqFTpFtR3QxOZNCAthwgEOqjX1YfTB4lqNiz97Zum6zBRvtiNRcDm0MPnzOGTyZmf5NaPtWCgq+7X3XClYWG363kScM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Zz7fdtS4SZ4CaIDsI/zUNEE3hKFJrAgCYCZufAQvPilYX3G+0mh6YPwxbax9/M0Dyov5i4mEdBmQI4wWJIDXLOMThtPHdDaCDyL1EAiWY134ElQIBY885wb7kjNl/IUZxSwsBMZPmhTt4aXNEBhmNI6OfVPaGAZx+qcNwrDfL8M=
Received: by 10.66.232.10 with SMTP id e10mr6244195ugh.1184109115375;
        Tue, 10 Jul 2007 16:11:55 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 24sm4507155ugf.2007.07.10.16.11.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jul 2007 16:11:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52118>

These tests check the syntax for the git tag -n option
and its output when one, none or many lines of the
message are requested.

Also this commit adds a missing && in the test
that checks the sorted output of git tag -l.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 t/t7004-tag.sh |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 201 insertions(+), 1 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b785080..17de2a9 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -164,7 +164,7 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag a1 &&
 	git tag v1.0 &&
 	git tag t210 &&
-	git tag -l > actual
+	git tag -l > actual &&
 	git diff expect actual
 '

@@ -437,6 +437,106 @@ test_expect_success \
 	git diff expect actual
 '

+# listing messages for annotated non-signed tags:
+
+test_expect_success \
+	'listing the one-line message of a non-signed tag should succeed' '
+	git-tag -m "A msg" tag-one-line &&
+
+	echo "tag-one-line" >expect &&
+	git-tag -l | grep "^tag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l | grep "^tag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l tag-one-line >actual &&
+	git diff expect actual &&
+
+	echo "tag-one-line    A msg" >expect &&
+	git-tag -n xxx -l | grep "^tag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n "" -l | grep "^tag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l | grep "^tag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n -l | grep "^tag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l tag-one-line >actual &&
+	git diff expect actual &&
+	git-tag -n 2 -l tag-one-line >actual &&
+	git diff expect actual &&
+	git-tag -n 999 -l tag-one-line >actual &&
+	git diff expect actual
+'
+
+test_expect_success \
+	'listing the zero-lines message of a non-signed tag should succeed' '
+	git-tag -m "" tag-zero-lines &&
+
+	echo "tag-zero-lines" >expect &&
+	git-tag -l | grep "^tag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l | grep "^tag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l tag-zero-lines >actual &&
+	git diff expect actual &&
+
+	echo "tag-zero-lines  " >expect &&
+	git-tag -n 1 -l | grep "^tag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n -l | grep "^tag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l tag-zero-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 2 -l tag-zero-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 999 -l tag-zero-lines >actual &&
+	git diff expect actual
+'
+
+echo 'tag line one' >annotagmsg
+echo 'tag line two' >>annotagmsg
+echo 'tag line three' >>annotagmsg
+test_expect_success \
+	'listing many message lines of a non-signed tag should succeed' '
+	git-tag -F annotagmsg tag-lines &&
+
+	echo "tag-lines" >expect &&
+	git-tag -l | grep "^tag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l | grep "^tag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l tag-lines >actual &&
+	git diff expect actual &&
+
+	echo "tag-lines       tag line one" >expect &&
+	git-tag -n 1 -l | grep "^tag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n -l | grep "^tag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l tag-lines >actual &&
+	git diff expect actual &&
+
+	echo "    tag line two" >>expect &&
+	git-tag -n 2 -l | grep "^ *tag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 2 -l tag-lines >actual &&
+	git diff expect actual &&
+
+	echo "    tag line three" >>expect &&
+	git-tag -n 3 -l | grep "^ *tag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 3 -l tag-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 4 -l | grep "^ *tag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 4 -l tag-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 99 -l | grep "^ *tag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 99 -l tag-lines >actual &&
+	git diff expect actual
+'
+
 # trying to verify annotated non-signed tags:

 test_expect_success \
@@ -651,6 +751,106 @@ test_expect_success \
 	git-tag -v commentnonlfile-signed-tag
 '

+# listing messages for signed tags:
+
+test_expect_success \
+	'listing the one-line message of a signed tag should succeed' '
+	git-tag -s -m "A message line signed" stag-one-line &&
+
+	echo "stag-one-line" >expect &&
+	git-tag -l | grep "^stag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l | grep "^stag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l stag-one-line >actual &&
+	git diff expect actual &&
+
+	echo "stag-one-line   A message line signed" >expect &&
+	git-tag -n xxx -l | grep "^stag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n "" -l | grep "^stag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l | grep "^stag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n -l | grep "^stag-one-line" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l stag-one-line >actual &&
+	git diff expect actual &&
+	git-tag -n 2 -l stag-one-line >actual &&
+	git diff expect actual &&
+	git-tag -n 999 -l stag-one-line >actual &&
+	git diff expect actual
+'
+
+test_expect_success \
+	'listing the zero-lines message of a signed tag should succeed' '
+	git-tag -s -m "" stag-zero-lines &&
+
+	echo "stag-zero-lines" >expect &&
+	git-tag -l | grep "^stag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l | grep "^stag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l stag-zero-lines >actual &&
+	git diff expect actual &&
+
+	echo "stag-zero-lines " >expect &&
+	git-tag -n 1 -l | grep "^stag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n -l | grep "^stag-zero-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l stag-zero-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 2 -l stag-zero-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 999 -l stag-zero-lines >actual &&
+	git diff expect actual
+'
+
+echo 'stag line one' >sigtagmsg
+echo 'stag line two' >>sigtagmsg
+echo 'stag line three' >>sigtagmsg
+test_expect_success \
+	'listing many message lines of a signed tag should succeed' '
+	git-tag -s -F sigtagmsg stag-lines &&
+
+	echo "stag-lines" >expect &&
+	git-tag -l | grep "^stag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l | grep "^stag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 0 -l stag-lines >actual &&
+	git diff expect actual &&
+
+	echo "stag-lines      stag line one" >expect &&
+	git-tag -n 1 -l | grep "^stag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n -l | grep "^stag-lines" >actual &&
+	git diff expect actual &&
+	git-tag -n 1 -l stag-lines >actual &&
+	git diff expect actual &&
+
+	echo "    stag line two" >>expect &&
+	git-tag -n 2 -l | grep "^ *stag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 2 -l stag-lines >actual &&
+	git diff expect actual &&
+
+	echo "    stag line three" >>expect &&
+	git-tag -n 3 -l | grep "^ *stag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 3 -l stag-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 4 -l | grep "^ *stag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 4 -l stag-lines >actual &&
+	git diff expect actual &&
+	git-tag -n 99 -l | grep "^ *stag.line" >actual &&
+	git diff expect actual &&
+	git-tag -n 99 -l stag-lines >actual &&
+	git diff expect actual
+'
+
 # tags pointing to objects different from commits:

 tree=$(git rev-parse HEAD^{tree})
-- 
1.5.0
