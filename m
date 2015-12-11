From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 06/10] strbuf: introduce strbuf_split_str_without_term()
Date: Fri, 11 Dec 2015 14:31:19 -0800
Message-ID: <xmqq8u50ehxk.fsf@gitster.mtv.corp.google.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
	<1447271075-15364-7-git-send-email-Karthik.188@gmail.com>
	<CAPig+cSxWybzunt_KWT+prZ=wXMi1wqM44jQZbp1pcz+spJW6A@mail.gmail.com>
	<CAOLa=ZQz-NE3uKtU72NUyR23QaJE4jf=UqiMptnM+hOmAE9GRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 23:31:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7WDn-0001c0-7k
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 23:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754439AbbLKWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 17:31:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752542AbbLKWbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 17:31:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8182F321B9;
	Fri, 11 Dec 2015 17:31:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ORRQ+lTCEoS1zoKzsYCLwNmJ5Iw=; b=Xb5wL9
	czGbvkn2ZmT6xh7GODQgmM/Gkp82fZKdRgQgC69J9c1d3ElASocXLEpUFOVnRT1d
	wbEZE4Brq5iVGVnuvbYAj4gYyxR3VIEBCwQ85rGAoTUsuu/pgipn8zsS879KGL2k
	6CHfJtrpcGYhhucvoKJLTWW8gXgZmzdgxgrPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XgwAluLRwqU2FeH0aPwZwdwdASFBDa1Z
	F/jNkFykC8uqoILra5clJtpc2ecBBaS4zvLNx0jq8bVx/Bz+v8sRlPOzMmsb5Z2H
	QHbvvNP8waV6QLEby27Lkt00XprV745WplbCHJvYO3UrXGUFoSELLsmAPM7hIAP8
	5NYzXGqmIJo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 79C80321B8;
	Fri, 11 Dec 2015 17:31:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F3F2C321B7;
	Fri, 11 Dec 2015 17:31:20 -0500 (EST)
In-Reply-To: <CAOLa=ZQz-NE3uKtU72NUyR23QaJE4jf=UqiMptnM+hOmAE9GRw@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 3 Dec 2015 23:42:40 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E72344AA-A056-11E5-824D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282281>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> diff --git a/ref-filter.c b/ref-filter.c
>>> @@ -892,14 +892,11 @@ static void populate_value(struct ref_array_item *ref)
>>>                          * TODO: Implement a function similar to strbuf_split_str()
>>>                          * which would omit the separator from the end of each value.
>>>                          */
>>> -                       s = to_free = strbuf_split_str(valp, ',', 0);
>>> +                       s = to_free = strbuf_split_str_without_term(valp, ',', 0);
>>>
>>>                         align->position = ALIGN_LEFT;
>>>
>>>                         while (*s) {
>>> -                               /*  Strip trailing comma */
>>> -                               if (s[1])
>>> -                                       strbuf_setlen(s[0], s[0]->len - 1);
>>
>> I'd prefer to see this ref-filter.c change split out as a separate
>> patch so as not to pollute the otherwise single-purpose change
>> introduced by this patch (i.e. capability to omit the terminator).
>>
>> Also, it might make sense to move this patch to the head of the
>> series, since it's conceptually distinct from the rest of the patches,
>> and could conceivably prove useful on its own, regardless of how the
>> rest of the series fares.
>>
>
> I guess it makes sense to split this into two separate patches. I'll do that and
> push it to the top of the series.

Sounds good.  I also notice that the "TODO: Implement a function
similar to..." we see in the precontext can now be removed, as that
is what is done in this patch?
