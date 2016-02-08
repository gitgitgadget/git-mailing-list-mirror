From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 20/25] upload-pack: support define shallow boundary by excluding revisions
Date: Mon, 08 Feb 2016 13:34:31 -0800
Message-ID: <xmqqa8na7uoo.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-21-git-send-email-pclouds@gmail.com>
	<CAPig+cQ2thjGWxar3BSJBU_O1WBsD0FHjv8i_sSMQKh+wO7bjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:34:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aStSF-0001D8-D3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbcBHVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 16:34:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756452AbcBHVee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 16:34:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABC63413B0;
	Mon,  8 Feb 2016 16:34:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8yloSTLmZWr4lHOrio7GX0WWP3E=; b=JumZNd
	xICRWZPR5h1kv+zptXTdC9xpsxZwXRPFjhkMQoecDZI48oCPr/X+Jyz44166+2JS
	O7vwDht2VdId9sjWHex9aTKCcpRgi3qRAFCNNDbT8UomjI1Qmd0DHm8uEuCf8ZpB
	oJ0fr3UK0hv7QgWmeKncPc3rR5eIaC/BFN+VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PD7V/uZywYcbiAg10NerWgBbT3JXvPx+
	X2ydOYimZS9yh/YkmtcfR96WvSM4wCifaPhKry08fPZIGvD4PH+kL1fZVPiiMxg3
	2aHP1Cf9Wq2mTkt31VS3et4Zt9BmAt8c6q5u9NL4LXzenBgZmz1TEsx4AMSc1P0J
	DxatwZIwkTs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A39CF413AE;
	Mon,  8 Feb 2016 16:34:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A733413AD;
	Mon,  8 Feb 2016 16:34:33 -0500 (EST)
In-Reply-To: <CAPig+cQ2thjGWxar3BSJBU_O1WBsD0FHjv8i_sSMQKh+wO7bjQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 5 Feb 2016 00:03:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE493962-CEAB-11E5-9001-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285811>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> @@ -746,6 +757,13 @@ static void receive_needs(void)
>>                         struct object *o = want_obj.objects[i].item;
>>                         argv_array_push(&av, oid_to_hex(&o->oid));
>>                 }
>> +               if (deepen_not.nr) {
>> +                       argv_array_push(&av, "--not");
>> +                       for (i = 0; i < deepen_not.nr; i++) {
>> +                               struct string_list_item *s = deepen_not.items + i;
>> +                               argv_array_push(&av, s->string);
>> +                       }
>
> The documentation for rev-list --not says it "Reverses the meaning ...
> up to the next --not", so would it make sense to add a final:
>
>     argv_array_push(&av, "--not");
>
> here to future-proof against some change pushing more arguments onto
> 'av' following this code?

Yup.

We enumerate the objects that are reachable are by traversing from
"want", but "--max-age" and "--not these refs" are optionally used
to truncate the enumeration, and usually we write "options" before
"parameters", so from that point of view, if this new code comes
before adding want_obj.objects[] (i.e. positive endpoints), that
would even be more readable.  And it would force this new code to
have a trailing "--not" ;-)

>> +               }
>>                 deepen_by_rev_list(av.argc, av.argv, &shallows);
>>                 argv_array_clear(&av);
>>         }
