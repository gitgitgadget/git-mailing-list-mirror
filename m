From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] add: ignore only ignored files
Date: Mon, 24 Nov 2014 11:23:49 +0100
Message-ID: <54730735.1080500@drmicha.warpmail.net>
References: <546F5CC7.8060904@drmicha.warpmail.net> <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net> <20141121180105.GB26650@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 24 11:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsqoG-0002sD-QI
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 11:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbaKXKXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 05:23:53 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59118 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227AbaKXKXw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Nov 2014 05:23:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 23220205EF
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 05:23:52 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 24 Nov 2014 05:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=isdwo9JrOmMhiuv2wS6daU
	PW+oI=; b=dWuxupOtq2hK/bLGR93eYhvoVTWvNkiEzZrJOLValWy72Ubz/Nwz+R
	agS1GIUCS1VNIqVj256fxTwvuGt/QxYAYHZ+q7E1ib/n/fZSyRBRpFo2l3xCfLiZ
	1G1C7ojzfeFO79ACzcG3N3HrHZcBLE/CjkbUmXYTiws0tZhm0/cQs=
X-Sasl-enc: hOCDLKwADBwm0Tp5pIzqvbLGbwBgLZzmkZqjUuWbUVRD 1416824631
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 614D8680116;
	Mon, 24 Nov 2014 05:23:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20141121180105.GB26650@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260120>

Jeff King schrieb am 21.11.2014 um 19:01:
> On Fri, Nov 21, 2014 at 05:08:19PM +0100, Michael J Gruber wrote:
> 
>> "git add foo bar" adds neither foo nor bar when bar is ignored, but dies
>> to let the user recheck their command invocation. This becomes less
>> helpful when "git add foo.*" is subject to shell expansion and some of
>> the expanded files are ignored.
>>
>> "git add --ignore-errors" is supposed to ignore errors when indexing
>> some files and adds the others. It does ignore errors from actual
>> indexing attempts, but does not ignore the error "file is ignored" as
>> outlined above. This is unexpected.
>>
>> Change "git add foo bar" to add foo when bar is ignored, but issue
>> a warning and return a failure code as before the change.
>>
>> That is, in the case of trying to add ignored files we now act the same
>> way (with or without "--ignore-errors") in which we act for more
>> severe indexing errors when "--ignore-errors" is specified.
> 
> Thanks, this looks pretty good to me. I agree with Junio's sense that we
> should cook it extra long to give people time to react.
> 
>> My sincere thanks go out to Jeff without whom I could not possibly
>> have come up with a patch like this :)
> 
> :) Sorry if I was being obnoxious before. Sometimes contributors need a
> gentle push to keep going, but I should know by now that you are not
> such a person.

We were just having fun with each other ;)

>> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
>> index fe274e2..f7ff1f5 100755
>> --- a/t/t3700-add.sh
>> +++ b/t/t3700-add.sh
>> @@ -91,6 +91,13 @@ test_expect_success 'error out when attempting to add ignored ones without -f' '
>>  	! (git ls-files | grep "\\.ig")
>>  '
>>  
>> +test_expect_success 'error out when attempting to add ignored ones but add others' '
>> +	touch a.if &&
>> +	test_must_fail git add a.?? &&
>> +	! (git ls-files | grep "\\.ig") &&
>> +	(git ls-files | grep a.if)
>> +'
> 
> I am somewhat allergic to pipes in our test suite, because they can mask
> errors (especially with a negated grep, because we do not know if they
> correctly produced any output at all). But I guess this is matching the
> surrounding code, and it is quite unlikely for `ls-files` to fail in any
> meaningful way here. So I think it's fine.
> 
> -Peff
> 

I do prefer test_cmp myself, also because it tells you much more in case
of a broken test - a failed boolean chain doesn't even tell you where it
broke.

In this specific case, many more tests would need to be rewriten,
though, so I preferred to keep the style of the surrounding code.

Michael
