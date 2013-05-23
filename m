From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: fix handling of special characters
Date: Thu, 23 May 2013 14:27:59 -0700
Message-ID: <7vtxltcrog.fsf@alter.siamese.dyndns.org>
References: <20130523135418.GA20741@redhat.com>
	<7vk3mpeaok.fsf@alter.siamese.dyndns.org>
	<20130523211954.GD31421@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 23 23:28:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufd3P-0006QX-TN
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253Ab3EWV2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:28:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759175Ab3EWV2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:28:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4999D21074;
	Thu, 23 May 2013 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SG0EPWQIgugnM3+3uVHQzRr4ZXY=; b=gvFFsb
	1P0wthyUGrbrqW33eEIM/FIq6FNYLFtb83waokrvdK4V2D+QvxaE7IRSyADPXrEo
	UytX94Hu2ed6RHBHmFXeeRCOn1/gtQBpiMWEaeFX2/0gzuDpPJ/0AV7vK4wl8BqP
	4dhN7rm5LguPwGNg6iDT8QhDch7t5TtjLjLeo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DhUplJdctF+AJvlM80OjKVVynHI8nfvq
	krVTIuUWtPK8MFvk8Z120kSl0UlQFatK4xXt3YCciJYCFG26EcvLlYFRKUDrCgix
	ctr4vT+YJKj5fQIOnojQgtawfqH4EstoYyAX/Xh75j3eFs5AFCB++7L38A5Vx4su
	mfFP7Vs6jkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4199D21073;
	Thu, 23 May 2013 21:28:01 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93F1E21070;
	Thu, 23 May 2013 21:28:00 +0000 (UTC)
In-Reply-To: <20130523211954.GD31421@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 24 May 2013 00:19:54 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4ED9CFC-C3EF-11E2-A447-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225301>

"Michael S. Tsirkin" <mst@redhat.com> writes:

>> Is $author already sanitized at this point in the code?  I see it
>> was unwrapped with unquote_rfc2047 after it was read from the From:
>> line; will it always be the same as sanitize_address($author) would
>> return, and if not, would you rather compare between sanitized
>> versions of sender and author, no?
>
> Yes. I'll have to look at the code more closely.
> In my testing author here is "Michael S. Tsirkin" <mst@redhat.com>
> so it matches the sanitized sender.
> Of course that's because my name does not have non-ascii,
> just a dot.

So the conclusion is that the logic to see if the names are the same
needs a bit more work than what was posted, I think?

>> Also, isn't the $sender the same during the whole outer loop that
>> iterates over @files?  Do we need to apply sanitize_address() on it
>> over and over for each and every logical line in the @header?
>> 
>> This comment also applies to the other patch but they probably
>> should become a single patch anyway, I guess?
>
> OK so now you are ok with this last bit, right?

Sorry, but I am not sure what you are asking.

Do I think the assignment to $sanitized_sender can and should be
done just once, not once per file, if the code inspection tells us
that $sender is a constant inside the foreach (@files) loop?

Do I think these two are solving pretty much the same thing and is
better to be done in a single patch?  

I didn't really think them through when I responded, but now after
you made me think, I would say the answers to both of them are yes.
