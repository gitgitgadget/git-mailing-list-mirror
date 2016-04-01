From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Fri, 01 Apr 2016 09:12:43 -0700
Message-ID: <xmqqh9fljojo.fsf@gitster.mtv.corp.google.com>
References: <1459470946-16522-1-git-send-email-sbeller@google.com>
	<1459470946-16522-2-git-send-email-sbeller@google.com>
	<CAPig+cQ=83k-of=jP1r6bYqsYrUhiDKhR3_Bm-SfYndn+sL=Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 18:12:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1go-0001jB-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbcDAQMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 12:12:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751281AbcDAQMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:12:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BEB14E785;
	Fri,  1 Apr 2016 12:12:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IEbNFDEwMKxAz4EHtcyAd9+9lN0=; b=HWoOnm
	sUpeuwLvL4+nUQa5OuCCmibbaoOPo1tYuWCqoAsrxW1gvNMNIrEErnLOsIKKLQFW
	vdpngiFYwwIJtTefncQee3mbwKPPsvsbkG+FjdKWPawE8Wt5BgvLguM+TuFP0vPW
	e1IBxW+HZu4L6dcc9t3JkIWafJyiQMr3/+YZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tqcn9li4a+zf/EZqEuUl0qMMXUTirMz7
	qE3PhkYhZj5l4OFTJ5j7jyMzvBWaMQ3u3CvhQ91zbFk645+nr8AdZ9Miqpun9EIL
	S9OZqHk2ONP0Md3yC97bK2SMdsLBNzUkv6naxrf7ghZf4jxRkK0cJIBffK91Pfz6
	+4TrdEt5CEE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 02AAD4E783;
	Fri,  1 Apr 2016 12:12:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 729F24E781;
	Fri,  1 Apr 2016 12:12:44 -0400 (EDT)
In-Reply-To: <CAPig+cQ=83k-of=jP1r6bYqsYrUhiDKhR3_Bm-SfYndn+sL=Dg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 31 Mar 2016 20:46:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 914BF7E0-F824-11E5-8EA7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290556>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Meh. Rather than reverting the git_config_get_value(), it would have
> been just as easy and safer (less chance of a future change
> re-introducing a leak) if you had just inserted the necessary check
> here:
>
>     if (!value)
>         return  config_error_nonbool(key);

Yup, sounds much more sensible fix that is useful in the longer term
(and avoids one unnecessary strdup()).

>
> But, perhaps it's not worth the patch churn at this point...
>
>>         if (parse_notes_merge_strategy(value, strategy))
>>                 git_die_config(key, "unknown notes merge strategy %s", value);
>>
>> +       free(value);
>>         return 0;
>>  }
>>
>> --
>> 2.5.0.264.gc776916.dirty
