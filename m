From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Tue, 26 Aug 2014 13:20:53 -0700
Message-ID: <xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
	<1409066605-4851-3-git-send-email-prohaska@zib.de>
	<20140826182125.GC17546@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 22:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMNEt-0006IT-EO
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 22:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbaHZUVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 16:21:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65217 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330AbaHZUVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 16:21:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8264E331A4;
	Tue, 26 Aug 2014 16:21:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ffkI8JbhYFkPmGn7exSnoUkMZjY=; b=Ii8I67
	z8ghIvhTSJjkX92FLYn4XGS20FvR1BguWrDfZN8WHrvGJGJa6zsU6apgxvv5cN1F
	kwbpf0IYln1bM1FO9zFF/52rhVZ1HgZ5QTG/KVXRdsnyLqKTTzz3oA71IUnQ5X27
	D8GumJ8Zkjh4ci/g5GN3uD6CBW1/LrV+GWhRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kVfKiKRYlmbS/ZoXgDSkkaibzo5xDopY
	6HeiAo9k8BZOcvVKerCxi7SP1BYhkJ62TytNRwbvl5hPP+ZoFiQBmQFxnI5PIwvB
	YH6FDv1ecfwhmQ8ExqS3C1MQMaex1PfpD/nrcItRqrfq7aplsmt6jQUMn6yQPSHp
	4dV/c/GSFbE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76355331A3;
	Tue, 26 Aug 2014 16:21:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6FDEB3319A;
	Tue, 26 Aug 2014 16:20:55 -0400 (EDT)
In-Reply-To: <20140826182125.GC17546@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 14:21:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7BD0AEDE-2D5E-11E4-A442-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255940>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 26, 2014 at 05:23:21PM +0200, Steffen Prohaska wrote:
>
>> +/*
>> + * Use default if environment variable is unset or empty string.
>> + */
>> +unsigned long git_env_ulong(const char *k, unsigned long val)
>> +{
>> +	const char *v = getenv(k);
>> +	if (v && *v && !git_parse_ulong(v, &val))
>> +		die("failed to parse %s", k);
>> +	return val;
>> +}
>
> I think the "empty string" behavior here is sensible. I notice that
> git_env_bool is not so careful. I think we should probably do this
> (independent of your series):
>
> -- >8 --
> Subject: git_env_bool: treat empty string as "not set"
>
> If an environment variable we treat as a boolean is not set,
> we use some default value provided by the caller. If it is
> set but is the empty string, however, we treat it as
> "false". This can be rather confusing, as it is easy to set
> the variable to the empty string in the shell (e.g., by
> calling GIT_SMART_HTTP= instead of "unset").

I think different people have different confusion criteria.
To me, these two are very different operations:

    $ VAR=
    $ unset VAR

I think it boils down to that I see that the distance between "unset
vs set to empty" is far larger than the distance between "empty vs
false".  You probably see these two distances the other way,
i.e. "set to empty is almost like unset" and "empty is not a valid
way to say false".

Due to this difference, the new test confused me and had me read it
three times.

> +test_expect_success 'empty GIT_SMART_HTTP leaves smart http enabled' '
> +	(GIT_SMART_HTTP= &&
> +	 export GIT_SMART_HTTP &&
> +	 cd clone &&
> +	 git fetch)
> +'

The test before this one explicitly sets GIT_SMART_HTTP to "0" and
expects the fetch to fail.  It is sensible to you because "0" is a
lot more explicit "false" than an empty string to you, and you
equate an empty and unset, hence the new one should succeed.

But it looks nonsensical to me that the new one expects to succeed,
because "0" and an empty string are both valid way to say "false"
to me, and it should behave the same way as the "0" one.

I view the *v check before git_parse_ulong() being unnecessarily
defensive to avoid triggering "die()".  An empty string is obviously
not a number (somebody could argue that it is the same as zero,
though), but nevertheless the user _is_ telling us to use that value
by setting and exporting the variable.  If we cannot parse it,
barfing is what the user would appreciate.

So, I am not sure the patch in the message I am responding to, and I
am not sure about that *v check in Steffen's patch, either.
