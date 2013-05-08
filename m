From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/11] sha1_name: reorganize get_sha1_basic()
Date: Wed, 08 May 2013 14:51:42 -0700
Message-ID: <7vsj1xcf81.fsf@alter.siamese.dyndns.org>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
	<1367963711-8722-11-git-send-email-felipe.contreras@gmail.com>
	<7vbo8lfi8y.fsf@alter.siamese.dyndns.org>
	<CAMP44s38eJP6WRQTQMDRqo-AXb7-YE1ZS-tJ7NK_QRwgHB3Obw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 23:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaCH8-0005wJ-8R
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 23:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab3EHVvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 17:51:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47830 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab3EHVvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 17:51:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D28051CC44;
	Wed,  8 May 2013 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+PoGmmXQXuP3VTAHTsaM4tNRtJ8=; b=k0zH/2
	AhyBJwXXO97oCRxD351Di0lP/tnv04Uo0jLXGzEoitOGB9oNZvo9KRs8UbMl9X1/
	tFxHfdOjvztcfjPkAxqlGr2nKl6ng6ZjCFMXCpcqdEwqFrhCb5ghY0fSyn56zA/z
	DYUItqamfobwnRmqj5wqu/Df3Qy3hJRMNr7hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LFM7wyCbjf+qwtkDPQ8MPVMNQAZlt8dP
	bXwlr8QpZBXR8UjFG9oXUUngqQifDPL13cHzZACRKzYlV5HXh5hGErvX108TtXcS
	ylNTaOhMLAwprj/xYouJRainCAMdNj85+TWMl2XZJUZ4KOkv6CTt7sFbU6QRT4ea
	AlIYV5vFq6A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9B191CC42;
	Wed,  8 May 2013 21:51:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1435C1CC3F;
	Wed,  8 May 2013 21:51:43 +0000 (UTC)
In-Reply-To: <CAMP44s38eJP6WRQTQMDRqo-AXb7-YE1ZS-tJ7NK_QRwgHB3Obw@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 8 May 2013 15:39:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7930E1C2-B829-11E2-A026-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223689>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 8, 2013 at 1:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Through the years the functionality to handle @{-N} and @{u} has moved
>>> around the code, and as a result, code that once made sense, doesn't any
>>> more.
>>>
>>> There is no need to call this function recursively with the branch of
>>> @{-N} substituted because dwim_{ref,log} already replaces it.
>>>
>>> However, there's one corner-case where @{-N} resolves to a detached
>>> HEAD, in which case we wouldn't get any ref back.
>>>
>>> So we parse the nth-prior manually, and deal with it depending on
>>> weather it's a SHA-1, or a ref.
>>> ...
>>
>> s/weather/whether/;
>>
>>> @@ -447,6 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>>>       if (len && str[len-1] == '}') {
>>>               for (at = len-4; at >= 0; at--) {
>>>                       if (str[at] == '@' && str[at+1] == '{') {
>>> +                             if (at == 0 && str[2] == '-') {
>>> +                                     nth_prior = 1;
>>> +                                     continue;
>>> +                             }
>>
>> Does this have to be inside the loop?
>
> Yes, the whole purpose is to avoid reflog_len to be set.

What I meant was the "<nothing>@{-" check, which happens only at==0.

	if (!memcmp(str, "@{-", 3) && len > 3)
		nth_prior = 1;
	else
		for (at = len - 4; at; at--) {
			... look for and break at the first "@{" ...
		}

or something.

>> Ahh, OK, the new code will now let dwim_ref/log to process @{-N}
>> again (the log message hints this but it wasn't all that clear),
>
> I thought it was clear we would let dwim_{ref,log} do the job:

Yes, the reason I did not immediately think of that is because I
knew @{-N} was expensive (need to read reflog backwards) and didn't
think anybody would redo the code to deliberately do that twice ;-)

>> Also, a few points this patch highlights in the code before the
>> change:
>>
>>  - If we were on a branch with 40-hex name at nth prior checkout,
>>    would we mistake it as being detached at the commit?
>>
>>  - If we were on a branch 'foo' at nth prior checkout, would our
>>    previous get_sha1_1() have made us mistake it as referring to a
>>    tag 'foo' with the same name if it exists?
>
> I don't know, but I suspect there's no change after this patch.

Yes, didn't I say "the code before the change" above?

These two correctness issues look more important issues to me, with
or without the restructure patch (in other words, they are
independent).
