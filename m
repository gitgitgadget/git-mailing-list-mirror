From: Junio C Hamano <gitster@pobox.com>
Subject: Re: test &&-chain lint
Date: Thu, 19 Mar 2015 23:51:26 -0700
Message-ID: <xmqqd244go0h.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
	<CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
	<20150320013217.GA15302@peff.net>
	<CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
	<20150320020851.GC15302@peff.net> <20150320022532.GA5502@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:51:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYqmM-0006dm-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 07:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbbCTGva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 02:51:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751150AbbCTGv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 02:51:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6330B3BB33;
	Fri, 20 Mar 2015 02:51:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rr6DBLlg2+gJmXpZB8HX+nqoleY=; b=srFPhO
	5vZR7bzDM1POF2xUw5R7H9SHYPJ6PKBNrcph84mnknq3znm2hO59gD2xjPSL4904
	R0r+0F2JOxT7ivMNHWUxGeto72CUwwf8wdo3cqAeYDtno5edOvOB/6lG5I9Z4da3
	jiT8bNLkvMKx/RrTCEnsV6+P+AD7+OPKw8Zeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KcJMQcQKog+Pq3Y7TPZMaL+CuJKbpG6C
	axtQsXtPIinp3oXNn3dKFo+fBKI/upL0jMT6PMIiXteH3TEuFfvamW84RI5PPToY
	GLuOs4W0bb88IWci93yrUL3SFZzcWAlqFsaKXr7trdcbZDBBACBoSHdrf/XOZg+Y
	EeqL2WF0lGI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C7663BB32;
	Fri, 20 Mar 2015 02:51:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFF503BB31;
	Fri, 20 Mar 2015 02:51:27 -0400 (EDT)
In-Reply-To: <20150320022532.GA5502@peff.net> (Jeff King's message of "Thu, 19
	Mar 2015 22:25:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 884A53C0-CECD-11E4-8618-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265864>

Jeff King <peff@peff.net> writes:

> [+cc Jonathan, whose patch I apparently subconsciously copied]
>
> On Thu, Mar 19, 2015 at 10:08:51PM -0400, Jeff King wrote:
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index c096778..02a03d5 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -524,6 +524,21 @@ test_eval_ () {
>>  test_run_ () {
>>  	test_cleanup=:
>>  	expecting_failure=$2
>> +
>> +	if test -n "$GIT_TEST_CHAIN_LINT"; then
>> +		# 117 is unlikely to match the exit code of
>> +		# another part of the chain
>> +		test_eval_ "(exit 117) && $1"
>> +		if test "$?" != 117; then
>> +			# all bets are off for continuing with other tests;
>> +			# we expected none of the rest of the test commands to
>> +			# run, but at least some did. Who knows what weird
>> +			# state we're in? Just bail, and the user can diagnose
>> +			# by running in --verbose mode
>> +			error "bug in the test script: broken &&-chain"
>> +		fi
>> +	fi
>> +
>>  	setup_malloc_check
>>  	test_eval_ "$1"
>>  	eval_ret=$?
>> 
>> This turns up an appalling number of failures, but AFAICT they are all
>> "real" in the sense that the &&-chains are broken. In some cases these
>> are real, but in others the tests are of an older style where they did
>> not expect some early commands to fail (and we would catch their bogus
>> output if they did). E.g., in the patch below, I think the first one is
>> a real potential bug, and the other two are mostly noise. I do not mind
>> setting a rule and fixing all of them, though.
>> 
>> I seem to recall people looked at doing this sort of lint a while ago,
>> but we never ended up committing anything. I wonder if it was because of
>> all of these "false positives".
>
> This turns out to be rather annoying to grep for in the list archives,
> but I found at least one discussion:
>
>   http://article.gmane.org/gmane.comp.version-control.git/235913
>
> I don't know why we didn't follow it up then. Perhaps because the patch
> there (which is rather similar to what I have above) was not
> conditional, so whole chunks of the test suite needed fixing. There are
> enough problems that we would probably want to do this conditionally,
> fix them over time, and then finally flip the feature on by default.

Hmmm, they do look similar and unfamiliar ;-)  It happened while I
was offline, it seems.

Thanks for working on this---I think test-chain-lint should become
one of the pre-acceptance test on my end when it gets applied.
