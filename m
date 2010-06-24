From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] Add optional parameters to the diff option "--ignore-submodules"
Date: Thu, 24 Jun 2010 19:11:43 +0200
Message-ID: <4C2391CF.5090606@web.de>
References: <4C0E7037.8080403@web.de> <4C0E7077.9090509@web.de> <oyrgMnuxMzyEmKMa6Bb_rvLb_zp8WscXW73T03xzJ5_bpheAt9Hpcw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 19:11:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORpy0-0005dq-QY
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0FXRLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 13:11:51 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:41545 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0FXRLu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 13:11:50 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9CE3916145E85;
	Thu, 24 Jun 2010 19:11:48 +0200 (CEST)
Received: from [80.128.86.138] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1ORpxs-0007fh-00; Thu, 24 Jun 2010 19:11:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <oyrgMnuxMzyEmKMa6Bb_rvLb_zp8WscXW73T03xzJ5_bpheAt9Hpcw@cipher.nrlssc.navy.mil>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX187BYapmmxQZ7PBAhU+BRjBVmlpMaVvqIPMcHSt
	z8lMBAzJWFbWqwUDMcXdQDT33uXSBAApPbp6Mrin72PXRgUTTu
	K53eXFIfx3v9O5jtgfKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149606>

Am 24.06.2010 16:23, schrieb Brandon Casey:
> On 06/08/2010 11:31 AM, Jens Lehmann wrote:
> 
> Two things...
> 
>> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
>> index 83c1914..559b41e 100755
>> --- a/t/t4027-diff-submodule.sh
>> +++ b/t/t4027-diff-submodule.sh
>> @@ -103,9 +103,17 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
>>  	git diff HEAD >actual &&
>>  	sed -e "1,/^@@/d" actual >actual.body &&
>>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>> -	test_cmp expect.body actual.body
>> +	test_cmp expect.body actual.body &&
>> +	git diff --ignore-submodules HEAD >actual2 &&
>> +	echo -n "" | test_cmp - actual2 &&
> 
> 'echo -n' is not portable (here, and below).  Please use printf
> instead.  Ditto for t4041

Thanks, I haven't been aware of that.


>> +	git diff --ignore-submodules=untracked HEAD >actual3 &&
>> +	sed -e "1,/^@@/d" actual3 >actual3.body &&
>> +	expect_from_to >expect.body $subprev $subprev-dirty &&
>> +	test_cmp expect.body actual3.body &&
>> +	git diff --ignore-submodules=dirty HEAD >actual4 &&
>> +	echo -n "" | test_cmp - actual4
>>  '
>> -
>> +test_done
>    ^^^^^^^^^
> 
> Why is this test_done here?  There are additional tests after this point,
> and an additional call to test_done.

Grmph, this is a leftover from debugging :-(
Thank you for spotting this one too!


As the patch introducing this is already in next, here is another one:

--------------------8<--------------------------
From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Thu, 24 Jun 2010 19:01:27 +0200
Subject: [PATCH] t4027 & t4041: Fix use of "echo -n" and a premature "test_done"

Replace the non portable "echo -n" with "printf" and remove a premature
"test_done".

Reported-by: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 t/t4027-diff-submodule.sh        |   12 ++++++------
 t/t4041-diff-submodule-option.sh |   14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 559b41e..3f2e591 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -105,15 +105,15 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules HEAD >actual2 &&
-	echo -n "" | test_cmp - actual2 &&
+	printf "" | test_cmp - actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
 	sed -e "1,/^@@/d" actual3 >actual3.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual3.body &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	echo -n "" | test_cmp - actual4
+	printf "" | test_cmp - actual4
 '
-test_done
+
 test_expect_success 'git diff HEAD with dirty submodule (index, refs match)' '
 	(
 		cd sub &&
@@ -139,11 +139,11 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
 	git diff --ignore-submodules=all HEAD >actual2 &&
-	echo -n "" | test_cmp - actual2 &&
+	printf "" | test_cmp - actual2 &&
 	git diff --ignore-submodules=untracked HEAD >actual3 &&
-	echo -n "" | test_cmp - actual3 &&
+	printf "" | test_cmp - actual3 &&
 	git diff --ignore-submodules=dirty HEAD >actual4 &&
-	echo -n "" | test_cmp - actual4
+	printf "" | test_cmp - actual4
 '

 test_expect_success 'git diff (empty submodule dir)' '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f44b906..7600ed1 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -207,17 +207,17 @@ EOF

 test_expect_success 'submodule contains untracked content (untracked ignored)' "
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'submodule contains untracked content (dirty ignored)' "
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'submodule contains untracked and modifed content' "
@@ -240,13 +240,13 @@ EOF
 test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'submodule contains untracked and modifed content (all ignored)' "
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'submodule contains modifed content' "
@@ -295,7 +295,7 @@ EOF

 test_expect_success 'modified submodule contains untracked content (all ignored)' "
 	git diff-index -p --ignore-submodules=all --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'modified submodule contains untracked and modifed content' "
@@ -331,7 +331,7 @@ EOF
 test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' "
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
-	echo -n '' | diff actual -
+	printf '' | diff actual -
 "

 test_expect_success 'modified submodule contains modifed content' "
-- 
1.7.1.716.g6c3d8
