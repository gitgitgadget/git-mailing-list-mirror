From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Mon, 25 Aug 2014 11:26:39 -0700
Message-ID: <xmqq8umcmnmo.fsf@gitster.dls.corp.google.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
	<20140825133550.GE17288@peff.net>
	<CAP8UFD2FAfg5GenJXOkOsjU9vmCO3R3Difp6-mrP_cp4zXQENg@mail.gmail.com>
	<20140825150028.GA28176@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:26:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLyyk-0004Uq-L2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbaHYS0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:26:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59171 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbaHYS0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:26:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1214A35241;
	Mon, 25 Aug 2014 14:26:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S8JP2ipMKACwhxt5REY1dY1I+yA=; b=ULfss6
	d+K978VqG86eaGfCHgnhihiGHOnMg3O36qiLZp0ZrbAHVOvCVDkz97a62sv+K72X
	S1Io8CjifyUc3zLvGUkNo6ca4X4ny7h4XE2oDpssfOz9R/4Y+FW8KUE7cmgrXsrT
	fjPvs2dECWEZQCgOPpCwKFGNWV7AL29z8dLxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GwSrZrlFRmXD9AKUBKSvYcdwTftH7x3S
	biMmq8UUxmD0MkPtmX7ofZigZtomC1sbR0ACbDk63h/oqx1LtBr8aj30rTnXcK2K
	y0izdiDWiBZlJENb8Cta9HhUQGhSLNsArHK/JdMaSJ7DY46B3/07LSgNTFzWtx+/
	GODMhKvHVY4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0399435240;
	Mon, 25 Aug 2014 14:26:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D53DF35239;
	Mon, 25 Aug 2014 14:26:40 -0400 (EDT)
In-Reply-To: <20140825150028.GA28176@peff.net> (Jeff King's message of "Mon,
	25 Aug 2014 11:00:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BBF9A3A-2C85-11E4-BC28-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255848>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 25, 2014 at 04:06:52PM +0200, Christian Couder wrote:
>
>> > This allocation should be name_len + 1 for the NUL-terminator, no?
>> 
>> I wondered about that too, but as struct name_decoration is defined like this:
>> 
>> struct name_decoration {
>>         struct name_decoration *next;
>>         int type;
>>         char name[1];
>> };
>> 
>> the .name field of this struct already has one char, so the allocation
>> above should be ok.
>
> Yeah, you're right. I would argue it should just be FLEX_ARRAY for
> consistency with other spots, though (in which case add_name_decoration
> needs to be updated with a +1).
>
> Running "git grep '^	char [^ ]*\[[01]]' -- '*.[ch]'" shows that this
> is one of only two spots that don't use FLEX_ARRAY (and the other has a
> comment explaining why not).

Good digging, and I agree that it should use the FLEX_ARRAY for
consistency.
