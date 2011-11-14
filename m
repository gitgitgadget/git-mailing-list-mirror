From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Copy resolve_ref() return value for longer use
Date: Sun, 13 Nov 2011 20:03:41 -0800
Message-ID: <7vfwhrl59e.fsf@alter.siamese.dyndns.org>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <1321179735-21890-1-git-send-email-pclouds@gmail.com>
 <1321179735-21890-2-git-send-email-pclouds@gmail.com>
 <7vbosfoiuy.fsf@alter.siamese.dyndns.org>
 <CACsJy8BnqoPVJiM6mbq7p3gKtLh-KGUuTshcukGokC3istTxMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 05:03:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPnlu-0006aX-VZ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 05:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab1KNEDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 23:03:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725Ab1KNEDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 23:03:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 203945B0E;
	Sun, 13 Nov 2011 23:03:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lD9taN28QAp0KxsTQBJ0VthIs60=; b=p3XshWopk+5TdfyorNF6
	sImFBKBvCjCNwERWoC6TUfC62Z5kYMw8JqzkaZO/kWvEje35fQTX7Cput/mdVI3a
	1GFFH/pkgAf2TXm/2HKFYnELu4sXtGxSv0FSckuwbgo44azp5AKvxoWiVpaCNurn
	RyEfa1rhIiLKFjcliCNIWGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=A25sux5VIh8q2QVAYbjOLHzc4Jg4+1dcGz2GmOuQ7YKKTS
	K10S2BEuloUSqLjtKVovGWVJVZaqbuFDOKMCQV+OFfNAb/YS8QKrz8BMGNAN+et7
	ublIa2Q6orX21OQYrEetmCMBj30LdOcJZFPwWhWYOvcI5nGPHO87WUEQp1yHc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1799A5B0D;
	Sun, 13 Nov 2011 23:03:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28AA85B0C; Sun, 13 Nov 2011
 23:03:43 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A481F3DE-0E75-11E1-9CB1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185363>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> Now reference_name stores the result of xstrdup(), it does not have reason
>> to be of type "const char *". It is preferable to lose the cast here, I
>> think. The same comment applies to the remainder of the patch.
>
> But resolve_ref() returns "const char *", we need to type cast at
> least once, either at resolve_ref() assignment or at free(), until we
> change resolve_ref().

In any case, I do not think it matters either way, so I queued this patch
to 'pu' unmodified.

This patch uses xstrdup() on return value of resolve_ref() only at
hand-picked places; while the choice of the places the patch decided not
to call free() looked reasonable from a quick review, both of us may be
blind and it may introduce huge leaks in a repeatedly called function.

A more extensive patch that would turn resolve_ref() to return an
allocated piece of memory share the same risk of adding new leaks at the
callsites, and this late in the cycle, neither will be in 1.7.8 anyway.

Given that if we build the more extensive patch on top of this one after
1.7.8, it will need to undo xstrdup() in this patch, add free()s that
become necessary, in addition to having to add free()s that this patch
might have potentially forgot, I have a feeling that we should just drop
this [2/2] and do a more thorough fix after 1.7.8 release is done
immediately on top of [1/2].

Thanks.
