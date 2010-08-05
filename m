From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] Add tests for the diff.ignoreSubmodules config option
Date: Fri, 06 Aug 2010 01:27:15 +0200
Message-ID: <4C5B48D3.6020402@web.de>
References: <4C4DD33F.4020104@web.de> <alpine.DEB.1.00.1008051025451.2983@bonsai2> <7vlj8ldmyj.fsf@alter.siamese.dyndns.org> <4C5B0C13.6020809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 01:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh9qP-0006Bx-9A
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 01:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760762Ab0HEX1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 19:27:18 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:51761 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759580Ab0HEX1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 19:27:17 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id 600CC15CFD20B;
	Fri,  6 Aug 2010 01:27:16 +0200 (CEST)
Received: from [80.128.118.249] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Oh9qG-0007GQ-00; Fri, 06 Aug 2010 01:27:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <4C5B0C13.6020809@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19hhCSGWveW3O9+7xUaN47p9VKN9auF4ODJ34ID
	fzR/mYOFjh1vgXqJ3dh+ReFiEowX8Pw73D4qgwvJu/8SamcRGP
	PfIAy+L5mqIEg1NZYN9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152739>

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 05.08.2010 21:08, schrieb Jens Lehmann:
> Am 05.08.2010 18:49, schrieb Junio C Hamano:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> This commit introduces a global config setting to set a default
>>> (porcelain) value for the --ignore-submodules option, keeping the
>>> default at 'none'. It can be overridden by the submodule.*.ignore
>>> setting and by the --ignore-submodules option.
>>> ...
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>
>> Nice, at least from a cursory look.  
> 
> Yup, makes sense to me too.
> 
> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

And here are some test cases for this new option.

 t/t4027-diff-submodule.sh |   10 +++++++++-
 t/t7508-status.sh         |   12 ++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 1bc6e77..d99814a 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -115,6 +115,9 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 '

 test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.git/config]' '
+	git config diff.ignoreSubmodules all &&
+	git diff HEAD >actual &&
+	! test -s actual &&
 	git config submodule.subname.ignore none &&
 	git config submodule.subname.path sub &&
 	git diff HEAD >actual &&
@@ -136,10 +139,14 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	sed -e "1,/^@@/d" actual >actual.body &&
 	expect_from_to >expect.body $subprev $subprev-dirty &&
 	test_cmp expect.body actual.body &&
-	git config --remove-section submodule.subname
+	git config --remove-section submodule.subname &&
+	git config --unset diff.ignoreSubmodules
 '

 test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
+	git config diff.ignoreSubmodules dirty &&
+	git diff HEAD >actual &&
+	! test -s actual &&
 	git config --add -f .gitmodules submodule.subname.ignore none &&
 	git config --add -f .gitmodules submodule.subname.path sub &&
 	git diff HEAD >actual &&
@@ -166,6 +173,7 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	test_cmp expect.body actual.body &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname &&
+	git config --unset diff.ignoreSubmodules &&
 	rm .gitmodules
 '

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 1aae762..9c14b85 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -849,11 +849,15 @@ test_expect_success '--ignore-submodules=untracked suppresses submodules with un
 '

 test_expect_success '.gitmodules ignore=untracked suppresses submodules with untracked content' '
+	git config diff.ignoreSubmodules dirty &&
+	git status >output &&
+	test_cmp expect output &&
 	git config --add -f .gitmodules submodule.subname.ignore untracked &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
 	test_cmp expect output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules  --remove-section submodule.subname &&
+	git config --unset diff.ignoreSubmodules
 '

 test_expect_success '.git/config ignore=untracked suppresses submodules with untracked content' '
@@ -873,11 +877,15 @@ test_expect_success '--ignore-submodules=dirty suppresses submodules with untrac
 '

 test_expect_success '.gitmodules ignore=dirty suppresses submodules with untracked content' '
+	git config diff.ignoreSubmodules dirty &&
+	git status >output &&
+	! test -s actual &&
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status > output &&
 	test_cmp expect output &&
-	git config -f .gitmodules  --remove-section submodule.subname
+	git config -f .gitmodules  --remove-section submodule.subname &&
+	git config --unset diff.ignoreSubmodules
 '

 test_expect_success '.git/config ignore=dirty suppresses submodules with untracked content' '
-- 
1.7.2.1.54.g6bed1
