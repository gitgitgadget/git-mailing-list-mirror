From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v2] t3900: do not reference numbered arguments from the test
 script
Date: Thu, 11 Aug 2011 09:05:48 +0200
Message-ID: <4E437F4C.4020305@viscovery.net>
References: <20110321105628.GC16334@sigill.intra.peff.net> <cover.1300872923.git.git@drmicha.warpmail.net> <20110324082108.GA30196@elie> <20110808011341.GA19551@elie.gateway.2wire.net> <20110808011709.GC19551@elie.gateway.2wire.net> <4E40F3EA.8020406@viscovery.net> <20110809153638.GA15687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamE=?= =?UTF-8?B?cm1hc29u?= 
	<avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 11 09:06:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrPL9-0002zS-6E
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 09:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab1HKHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 03:05:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6074 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab1HKHF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 03:05:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QrPKv-0000dX-DK; Thu, 11 Aug 2011 09:05:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 241711660F;
	Thu, 11 Aug 2011 09:05:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20110809153638.GA15687@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179087>

From: Johannes Sixt <j6t@kdbg.org>

The call to test_expect_success is nested inside a function, whose
arguments the test code wants to access. But it is not specified that any
unexpanded $1, $2, $3, etc in the test code will access the surrounding
function's arguments. Rather, they will access the arguments of the
function that happens to eval the test code.

In this case, the reference is intended to supply '-m message' to a call of
'git commit --squash'. Remove it because -m is optional and the test case
does not check for it. There are tests in t7500 that check combinations of
--squash and -m.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 8/9/2011 17:36, schrieb Jeff King:
> Hmm. Isn't t3900 already broken, even without this patch? It does
> something like this:
> 
>   foo() {
>     test_expect_success 'bar' 'echo $3'
>   }

Yes, it's broken and this patch just removes the reference.

 t/t3900-i18n-commit.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index c06a5ee..1f62c15 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -147,7 +147,7 @@ test_commit_autosquash_flags () {
 		git commit -a -m "intermediate commit" &&
 		test_tick &&
 		echo $H $flag >>F &&
-		git commit -a --$flag HEAD~1 $3 &&
+		git commit -a --$flag HEAD~1 &&
 		E=$(git cat-file commit '$H-$flag' |
 			sed -ne "s/^encoding //p") &&
 		test "z$E" = "z$H" &&
@@ -160,6 +160,6 @@ test_commit_autosquash_flags () {
 
 test_commit_autosquash_flags eucJP fixup
 
-test_commit_autosquash_flags ISO-2022-JP squash '-m "squash message"'
+test_commit_autosquash_flags ISO-2022-JP squash
 
 test_done
-- 
1.7.6.1618.gc932c
