From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each valid atom
Date: Wed, 03 Feb 2016 17:17:40 -0800
Message-ID: <xmqqa8nhjmtn.fsf@gitster.mtv.corp.google.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
	<1454262176-6594-6-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 02:17:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR8YN-00088v-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 02:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933456AbcBDBRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 20:17:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932723AbcBDBRn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 20:17:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 98C2C42B63;
	Wed,  3 Feb 2016 20:17:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J+gX6IbhySQy70uzudeGfX5pjFc=; b=wMn+vg
	bw+9uuR2S9fkpLhaFa0SUhKunZxXH7E/Zo34T45yIk8i5E2x3D/2nJDZK3xE3DYT
	dbHG1DG1+CyR/nySnc3leqg50uPcipMU7sYCuEBoRiUYLGhIcgKELNjFEEhZtliC
	2ysMY+3dS/rq0KVxVWjTXHJbydaCNofjucDic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9cwu404cj0O0X2XSuJStXdCr8Dj26M5
	vm/l4FGyHzZR6733utKYFhff9Zra47/V0LxlIY68+b7OEiWaGgYcGu5YBJoO6R61
	Zmqc7Pk0XCDne5DUhRhuR9YuZVImuIRmbj5ut2EA92IwfVjRu9UQQk2SqUaeyisn
	cKKkTC4S5lw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FAD142B62;
	Wed,  3 Feb 2016 20:17:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0833D42B60;
	Wed,  3 Feb 2016 20:17:41 -0500 (EST)
In-Reply-To: <CAPig+cRmfNjP8PYoQFZ7YrECgt03aE1=QynG58-+cd9ORJneZw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 3 Feb 2016 17:19:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 169AABF0-CADD-11E5-8DCA-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285390>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -138,10 +140,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>                  * shouldn't be used for checking against the valid_atom
>>                  * table.
>>                  */
>> -               const char *formatp = strchr(sp, ':');
>> -               if (!formatp || ep < formatp)
>> -                       formatp = ep;
>> -               if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
>> +               arg = memchr(sp, ':', ep - sp);
>
> Why this change from strchr() to memchr()? I understand that you're
> taking advantage of the fact that you know the extent of the string
> via 'sp' and 'ep', however, was the original strchr() doing extra
> work? Even if this change is desirable, it seems somewhat unrelated to
> the overall purpose of this patch, thus might deserves its own.

I think the original strchr() is a bug.  If you are given a
substring as a range, you shouldn't be allowing strchr() to go
beyond ep to find a NUL that may or may not exist.  That is not a
performance thing, but more about the best practice to ensure
correctness.  The caller of this function may not have such a
problem, but imagine the case where the bytes beyond ep did not have
any NUL and there is an unmapped page after that.
