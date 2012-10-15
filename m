From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exclude: fix a bug in prefix comparison optimization
Date: Sun, 14 Oct 2012 21:28:48 -0700
Message-ID: <7vk3usxssf.fsf@alter.siamese.dyndns.org>
References: <1350214522-3242-1-git-send-email-pclouds@gmail.com>
 <7v8vb9yn09.fsf@alter.siamese.dyndns.org>
 <CACsJy8DEqkPob+KjFS_Y3BraS40CSP7snS3aB41hg0Ng0DuJDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 06:29:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNcId-0004jm-RU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 06:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270Ab2JOE25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 00:28:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63100 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab2JOE24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 00:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 768039C48;
	Mon, 15 Oct 2012 00:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VttV8QQ8Aunq7BXtulhuA9yaCao=; b=VY8RTg
	JQblZXqGFLjd8JcAgdjfQ/z7fTSiWg2SOA/XwxPh+Z4dbNR9y93JxU4/jOYwXeOZ
	NHmpRtIlvS/E2mIWC7fBuOedg1KjqI8ed6s0PX4EV4hOhguY20//2zwNHutkwAQz
	nVLF+9gqtZuGcqgAD9wFEyAguwcUJB0/kR/Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+Di303FJD02wudXbelN6SC7gnQge9cg
	PIuz6fNx7LiWVScrrNQj4IgS72NNuQ16yNsoxtqsP9A6hqB5uvcFfto3brVZb9jB
	F2FJI4OQ350oFu2FmzUa0mKgejsoEXKIHymoiyhIl2ax22sjWygQnrbU4lcMfNUA
	WFOSpQxFxM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 640CE9C3B;
	Mon, 15 Oct 2012 00:28:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B62219C31; Mon, 15 Oct 2012
 00:28:54 -0400 (EDT)
In-Reply-To: <CACsJy8DEqkPob+KjFS_Y3BraS40CSP7snS3aB41hg0Ng0DuJDg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 15 Oct 2012 11:09:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4464228-1680-11E2-9800-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207689>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Oct 15, 2012 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> With your "teach attr.c match the same optimization as dir.c"
>> series, you would need something like this
>>
>> diff --git i/attr.c w/attr.c
>> index 6d39406..528e935 100644
>> --- i/attr.c
>> +++ w/attr.c
>> @@ -710,7 +710,7 @@ static int path_matches(const char *pathname, int pathlen,
>>          * if the non-wildcard part is longer than the remaining
>>          * pathname, surely it cannot match.
>>          */
>> -       if (!namelen || prefix > namelen)
>> +       if (prefix > namelen)
>>                 return 0;
>>         if (baselen != 0)
>>                 baselen++;
>
> If there's still a chance to rewrite attr-match-optim-more series (I
> see it's in next now), then I could reorder the patches so that
> excluded_from_list code refactoring goes first, then rewrite "teach
> attr.c match... as dir.c" patch makes use of the new functions without
> code duplication. The end result would be the same, except that we
> won't see this bug in attr.c's history. Not much value so if it may
> take a lot of your time, don't bother.

Actually it started to become nuisance to deal with conflicts among
as/check-ignore and the attr/dir/wildmatch series, and I've been
wondering if it makes sense to eject all of these out of 'next' (as
they won't advance beyond 'next' until the next release anyway).

So please go ahead and reroll the whole thing if you think the end
result would be a history with better organization.
