From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] t7002: set test prerequisite "external-grep" if 
   supported
Date: Thu, 07 Jan 2010 15:04:23 +0100
Message-ID: <4B45E9E7.1040905@viscovery.net>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>	 <1262608455-4045-1-git-send-email-pclouds@gmail.com>	 <7v4omyhc7h.fsf@alter.siamese.dyndns.org>	 <7vy6ka8rmr.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001070527ra1570a0m12182db9bb029055@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 15:04:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSsyY-0003yH-BF
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 15:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab0AGOE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 09:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270Ab0AGOE3
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 09:04:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36640 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752216Ab0AGOE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 09:04:28 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NSsyN-0005gf-TR; Thu, 07 Jan 2010 15:04:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9E8AD1660F;
	Thu,  7 Jan 2010 15:04:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <fcaeb9bf1001070527ra1570a0m12182db9bb029055@mail.gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136344>

Nguyen Thai Ngoc Duy schrieb:
> On 1/7/10, Junio C Hamano <gitster@pobox.com> wrote:
>>  So by writing the test to check the desired outcome, instead of writing it
>>  for the particular implementation of using external grep optimization, you
>>  will catch both kinds of breakages.
>>
>>  Perhaps something like this (untested, of course)?
>>
>>  test_expect_success 'strings in work tree files are not found for skip-wt paths' '
>>         no="no such string in the index" &&
>>         test_must_fail git grep -e "$no" --cached file &&
>>         git update-index --skip-worktree file &&
>>         echo "$no" >file &&
>>         test_must_fail git grep -e "$no" file &&
>>         git update-index --no-skip-worktree file &&
>>         git grep -e "$no" file
>>  '
>>
> 
> Very well reasoned. I'd say go for it!
> 
> Tested-by: me

The test is not quite complete. Not only do you want to test that the
worktree file is not looked at, but that the index version is used:


test_expect_success 'for skip-wt paths, strings are found in index, not in
worktree' '
	yes="this string is in the index" &&
	no="no such string in the index" &&
	echo "$yes" >file &&
	git update-index file &&
	echo "$no" >file &&
	git grep -e "$yes" --cached file &&
	test_must_fail git grep -e "$no" --cached file &&
	git update-index --skip-worktree file &&
	git grep -e "$yes" file &&
	test_must_fail git grep -e "$no" file &&
	git update-index --no-skip-worktree file &&
	test_must_fail git grep -e "$yes" file &&
	git grep -e "$no" file
'

Just as untested... ;)

-- Hannes
