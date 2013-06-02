From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] unpack-trees: plug a memory leak
Date: Sun, 02 Jun 2013 15:17:19 -0700
Message-ID: <7vehckma34.fsf@alter.siamese.dyndns.org>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-4-git-send-email-felipe.contreras@gmail.com>
	<7vfvx0nw7t.fsf@alter.siamese.dyndns.org>
	<CAMP44s3aF8VsNqJA3GNLN=cw6Vp4iJEcTn5WDq2XPs-Le--szg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 00:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjGac-0003VA-BG
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 00:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab3FBWRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 18:17:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754604Ab3FBWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 18:17:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A98524CF2;
	Sun,  2 Jun 2013 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AhS0K26LUovsz6NyDKydtymREZo=; b=OuvGMj
	giGls6kg9k3X0sM/qxur4u3KnOMeNVHXoP9ZB1vPKLb1dUdtyZdaA5zEsl+WRC0a
	75BAC57NNA0Loi1S03NDQeU0LxXzlyQl0v9mnTbKcDy3SOakf7iupootURLU4A6G
	TjLFr+jR+Zka9vRpZ8u8ulUN/WA4WuZvc8aQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hnSLTnTxVBtjj7R7Rdh15l+Hcnc51r//
	NGFNia2q2QnFilwZ2eHL/yTz95iWmiEZb7IAU6BPTi1KuhYxj6ZZj3zuJwkadimE
	pEBsnynvxJ1oHJF0rqJGXbZICkHP97m4YO5TyK1p+OjFiq4LUiMyasqgfFxh22r3
	KgyFVVIOvnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5178824CF0;
	Sun,  2 Jun 2013 22:17:21 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF69324CEE;
	Sun,  2 Jun 2013 22:17:20 +0000 (UTC)
In-Reply-To: <CAMP44s3aF8VsNqJA3GNLN=cw6Vp4iJEcTn5WDq2XPs-Le--szg@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 2 Jun 2013 14:51:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31833D36-CBD2-11E2-BCCA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226186>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Jun 2, 2013 at 2:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Before overwriting the destination index, first let's discard it's
>>> contents.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  unpack-trees.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>> index ede4299..eff2944 100644
>>> --- a/unpack-trees.c
>>> +++ b/unpack-trees.c
>>> @@ -1146,8 +1146,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>
>>>       o->src_index = NULL;
>>>       ret = check_updates(o) ? (-2) : 0;
>>> -     if (o->dst_index)
>>> +     if (o->dst_index) {
>>> +             discard_index(o->dst_index);
>>>               *o->dst_index = o->result;
>>> +     }
>>
>> I seem to recall that many callers set src_index and dst_index to
>> the same istate, and expect that the original istate pointed by the
>> src_index to remain usable.  Is it safe to discard it like this at
>> this point?
>
> Who expects that?

The patch you posted expects that no such caller depends on
src_index being left alone by the call, and I was asking if that
expectantion holds, i.e. if it is safe to discard.

I think your answer can be one of "Yes, it is safe, as no current
caller does so", "I dunno, I did not check", or "No, this and that
caller need to be adjusted".
