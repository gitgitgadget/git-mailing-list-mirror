From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1050-large: replace dd by test-genrandom
Date: Tue, 13 Jan 2015 15:40:10 -0800
Message-ID: <xmqq4mruckrp.fsf@gitster.dls.corp.google.com>
References: <54B5579B.4080607@kdbg.org> <20150113214733.GA16582@peff.net>
	<54B59D24.7030508@kdbg.org> <20150113223849.GA3144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 00:40:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBB4Q-0004dd-8P
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 00:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbbAMXkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 18:40:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052AbbAMXkN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 18:40:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 753D92E7D5;
	Tue, 13 Jan 2015 18:40:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kGepv4c7ECzfl/A3yO7ipYO4wSw=; b=QD2b1O
	9cO6rJiv2rDCFdU5eLQS/4xSgj6j4azI9X4bRpQMzouUYEb+WGYOOTHNIhPuMVwj
	4jjQwBBbfCRLTFenDDgMT9DW81mcf0OuRjLExRF+qqjavcre3/K7Ee8O2G3JPbaf
	If1odx8Oj9yh2iTUVPzdiWE57dc/+R9RsHS34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TemeXWGl9vmu7026rwb1ZcIANS3HSB1U
	c+a91HdpUTibVAp7RRW6OTGWCcSRBpD0mjMgzYnCqOn/SzRbo8TbXlwNJbBYXcTU
	+KBKaNH2kySO+bAE/ZdsFU6+LYkbTUJ1kyOEN5dhgXPNvctJyu3ikEDdpCN3fWfa
	PAEI+/emOXo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C1BD2E7D4;
	Tue, 13 Jan 2015 18:40:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B30612E7D2;
	Tue, 13 Jan 2015 18:40:11 -0500 (EST)
In-Reply-To: <20150113223849.GA3144@peff.net> (Jeff King's message of "Tue, 13
	Jan 2015 17:38:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8419AC02-9B7D-11E4-93DA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262362>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 13, 2015 at 11:33:08PM +0100, Johannes Sixt wrote:
>
>> BTW, is it the incompressibility where the time is lost or lack of
>> sparseness of the files? How does the timing change with this patch on
>> top?
>
> Oh, good call. It's the incompressibility. Which makes perfect sense.
>
> Once we copy the file into the object database, that copy is not sparse.
> But in the genrandom version, it _is_ a million times bigger. :)

Yeah, of course ;-)

> With the patch below, my timings go back to ~0.7s (actually, they seem
> slightly _better_ on average than what is in "master" now, but there is
> quite a bit of run-to-run noise, so it may not be meaningful).
>
>> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
>> index f653121..9cf4e0e 100755
>> --- a/t/t1050-large.sh
>> +++ b/t/t1050-large.sh
>> @@ -9,10 +9,10 @@ test_expect_success setup '
>>  	# clone does not allow us to pass core.bigfilethreshold to
>>  	# new repos, so set core.bigfilethreshold globally
>>  	git config --global core.bigfilethreshold 200k &&
>> -	test-genrandom seed1 2000000 >large1 &&
>> +	printf "\0%2000000s" X >large1 &&
>>  	cp large1 large2 &&
>>  	cp large1 large3 &&
>> -	test-genrandom seed2 2500000 >huge &&
>> +	printf "\0%2500000s" Y >huge &&
>>  	GIT_ALLOC_LIMIT=1500k &&
>>  	export GIT_ALLOC_LIMIT
>>  '
>
> I think with this squashed in, I have no complaints at all about your
> patch.

OK, perhaps that affects the log message, so I'd play lazy and wait
for a reroll.

Are we depending on the binary-ness of these test files by the way?
The leading NUL \0 looked a bit strange to me.
