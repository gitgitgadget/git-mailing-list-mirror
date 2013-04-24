From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 4/7] t7008: demonstrate behavior of grep with textconv
Date: Wed, 24 Apr 2013 12:09:38 +0200
Message-ID: <5177AF62.30104@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net> <5137a5a48ae6c70ad716d985a22d53ec311ee05a.1366718624.git.git@drmicha.warpmail.net> <7v1ua1l1ki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 12:09:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUwdy-0007rO-2w
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 12:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167Ab3DXKJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 06:09:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38020 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752487Ab3DXKJb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 06:09:31 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D5A8521375;
	Wed, 24 Apr 2013 06:09:30 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 24 Apr 2013 06:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=BsL6Qe6yjggoT8N2cN6pI3
	/dWyk=; b=j7seVVBCEufzqVLVgE44coePMheyGMhOlvrhKQDy9LaTxXsBHxTZ8W
	VW4ykyMsR8nsPJpQs9bJDIGlPovjsHAyO2JBtKTk/Pnwsis05tVuI39ZDA+lXj3U
	ZiErczInabE27bVESI9aTzm/iLhiKmYQMtwFfmveY233oQu+lM1CY=
X-Sasl-enc: eUZefvzMgAALTA42/dzLHfs0QrdKd+x2b4jsR8se9h8q 1366798170
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F253AC80005;
	Wed, 24 Apr 2013 06:09:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7v1ua1l1ki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222246>

Junio C Hamano venit, vidit, dixit 23.04.2013 17:16:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, "git grep" does not honor any textconv filters. Demonstrate
>> this in the tests.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  t/t7008-grep-binary.sh | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
>> index 26f8319..126fe4c 100755
>> --- a/t/t7008-grep-binary.sh
>> +++ b/t/t7008-grep-binary.sh
>> @@ -145,4 +145,27 @@ test_expect_success 'grep respects not-binary diff attribute' '
>>  	test_cmp expect actual
>>  '
>>  
>> +cat >nul_to_q_textconv <<'EOF'
>> +#!/bin/sh
>> +"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
>> +EOF
>> +chmod +x nul_to_q_textconv
>> +
>> +test_expect_success 'setup textconv filters' '
>> +	echo a diff=foo >.gitattributes &&
>> +	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
>> +'
>> +
>> +test_expect_failure 'grep does not honor textconv' '
>> +	echo "a:binaryQfile" >expect &&
>> +	git grep Qfile >actual &&
> 
> This should pass --textconv to "git grep".

But "git grep" does not know that option yet, so the test would fail for
the wrong reason.

The point ist that I expect "git grep" to apply textconv filters by
default, which it does not. (I know I might be the only one with this
expectation.)

Or do we want to document the absence of that option?

>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_failure 'grep blob does not honor textconv' '
>> +	echo "HEAD:a:binaryQfile" >expect &&
>> +	git grep Qfile HEAD:a >actual &&
> 
> Likewise.
> 
>> +	test_cmp expect actual
>> +'
>> +
>>  test_done
