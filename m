From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Tue, 12 Apr 2016 09:58:20 -0700
Message-ID: <xmqqvb3mrcgj.fsf@gitster.mtv.corp.google.com>
References: <570965B9.9040207@jupiterrise.com>
	<20160409210429.GB18989@sigill.intra.peff.net>
	<57098259.1060608@jupiterrise.com>
	<20160409223738.GA1738@sigill.intra.peff.net>
	<xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
	<20160411173224.GE4011@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:58:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq1e0-0005mH-8K
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933296AbcDLQ6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:58:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932463AbcDLQ6X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:58:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4A7DC55284;
	Tue, 12 Apr 2016 12:58:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i0Q5a5HNy+1eFfr7ogjcZ21cX8o=; b=batzem
	T2Kncl2Q7QyZo1+2rv6kEiynVzmiDRYMBfCh/pQJ8ooWUQ+J8PDAmXPKhPhxNlRF
	XsaJ9fm4B+NJNxfNYqrVmDUQdMpLqqBnxWHRxYLKoWM0iis9uNzgDoAEHXl6pqJt
	RaVZ2k0b3xofQnmL9vJkbis017zJoyyFog6wU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BosRlEBqvYhP2ZRpBeyHA/MgbcQOfoON
	TEgGVo/BYREb1F50nzI6gOa1v3YHXTG90xWs1bJ4ynU1cKs+cascefcIku0Jwwi6
	wcQ2vq27x89e4UmBXbqAaEcDXV0grT0/tm2pVSwSMZdTK2SXtKfAT4addGCcedmb
	WUAF475Yb3w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4232455283;
	Tue, 12 Apr 2016 12:58:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A09E05527D;
	Tue, 12 Apr 2016 12:58:21 -0400 (EDT)
In-Reply-To: <20160411173224.GE4011@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 11 Apr 2016 13:32:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C354FB0C-00CF-11E6-8B0F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291280>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 09, 2016 at 05:37:43PM -0700, Junio C Hamano wrote:
>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index b79f442..d96d0e4 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -555,10 +555,9 @@ test_expect_success 'rebase a detached HEAD' '
>>  test_expect_success 'rebase a commit violating pre-commit' '
>>  
>>  	mkdir -p .git/hooks &&
>> -	PRE_COMMIT=.git/hooks/pre-commit &&
>> -	echo "#!/bin/sh" > $PRE_COMMIT &&
>> -	echo "test -z \"\$(git diff --cached --check)\"" >> $PRE_COMMIT &&
>> -	chmod a+x $PRE_COMMIT &&
>> +	write_script .git/hooks/pre-commit <<-\EOF &&
>> +	test -z "$(git diff --cached --check)"
>> +	EOF
>
> Looks good and is the minimal change. I kind of wonder if the example
> would be more clear, though, as just:
>
>   write_script .git/hooks/pre-commit <<-\EOF &&
>   exit 1
>   EOF
>   echo whatever >file1 &&
>   ...
>
> I don't think we ever actually need the pre-commit check to pass, as we
> simply override it with --no-verify. But I dunno. Maybe people find it
> easier to read with a pseudo-realistic example (it took me a minute to
> realize the trailing whitespace in the content was important).

I was mostly worried about closing the door for future enhancement
where there are multiple commits to be replayed, some of which fail
and others pass the test.  Unconditional "exit 1" would have to be
reverted when it happens.

> It could also stand to clean up its hook with test_when_finished. The
> next test resorts to "rm -rf" on the hooks directory at the beginning.
> Yuck.

Yeah, that may be an accident waiting to happen.
