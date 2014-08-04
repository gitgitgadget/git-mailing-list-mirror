From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t5704: Fix the test that checks for excluded tags
Date: Mon, 04 Aug 2014 13:28:22 -0700
Message-ID: <xmqqmwbkq9sp.fsf@gitster.dls.corp.google.com>
References: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
	<xmqqzjfkqap5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:28:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOs0-0001gf-I7
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbaHDU2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:28:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57566 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbaHDU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:28:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B6F82F2D0;
	Mon,  4 Aug 2014 16:28:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ni1Fm4ajGdFgVvT5Rt5hGt4Mbkk=; b=npq5X5
	3dtgYfUmI8GQi1pU+KtMK1uL1ta4kmz2omxX5vVjjbpfwt+L44rEE1x4Q2TCe7Yd
	prqsed1/zrC4IEPG5E8ZlbCQoOtaaBOScmATRKJIxg4FUeglImyXiDqU7sRQuvIi
	YX+J02O1x051byH5PGOFtvb16/3D58/1pRzTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HBrgvuPArEPYcybaFrgDbt1UBwBWqYfk
	JJR5GDiaxBr4dXlvOQQGXLKmvf92E97vfNfxy97FPARR701oGTUh9opI6Sw7TZZx
	Tdb+VmHTszT6SkPG4TrhWsnafh45DjqkWixZNJs3edwo+vj7ut1pWJNdDoH9VgkG
	wQyvQMEBc8k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 908C52F2CE;
	Mon,  4 Aug 2014 16:28:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC7DF2F2C9;
	Mon,  4 Aug 2014 16:28:24 -0400 (EDT)
In-Reply-To: <xmqqzjfkqap5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 Aug 2014 13:08:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E29CF708-1C15-11E4-8308-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254776>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
>> index a45c316..2f063ea 100755
>> --- a/t/t5704-bundle.sh
>> +++ b/t/t5704-bundle.sh
>> @@ -6,7 +6,7 @@ test_description='some bundle related tests'
>>  test_expect_success 'setup' '
>>  	test_commit initial &&
>>  	test_tick &&
>> -	git tag -m tag tag &&
>> +	git tag -am tag tag &&
> ...
> Oh, wait.

In any case, the fix in 2/2 is real, and applying both and then
reverting the above hunk passes the test.  Also, applying both,
reverting the above hunk *and* reverting the fix to bundle.c of
course makes the rest fail.

So I would be tempted to squash these two patches into one using the
log message from the latter one, while excluding the change in the
above hunk.

Thanks.

>> @@ -14,7 +14,10 @@ test_expect_success 'setup' '
>>  	git tag -d third
>>  '
>>  
>> -test_expect_success 'tags can be excluded by rev-list options' '
>> +test_expect_failure 'annotated tags can be excluded by rev-list options' '
>> +	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
>> +	git ls-remote bundle > output &&
>> +	grep tag output &&
>>  	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
>>  	git ls-remote bundle > output &&
>>  	! grep tag output
