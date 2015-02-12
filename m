From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Thu, 12 Feb 2015 15:08:35 -0800
Message-ID: <xmqqd25epw24.fsf@gitster.dls.corp.google.com>
References: <20141203050217.GJ6527@google.com>
	<20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141204030133.GA16345@google.com>
	<xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
	<20141204234147.GF16345@google.com> <20141204234432.GA29953@peff.net>
	<CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
	<20141205000128.GA30048@peff.net>
	<xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
	<20141207100755.GB22230@peff.net>
	<xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:08:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM2sE-0001cd-67
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbbBLXIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 18:08:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823AbbBLXIh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:08:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF0C338001;
	Thu, 12 Feb 2015 18:08:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c9uuROt0z8Zg2E4qnWWcyz72ukg=; b=HmgMtu
	1Z0XaouCEBzMJ1d22oPTQR2yO/CWaxI6nr0NY1dmBKWBR5CcqkZJxzAmyY+fuKLz
	j3ZkjunQCmKsdC3KwBqDFGSyW7BvuKdPr6MvPXGv28fFeAj+fVDBma/rgRVm6c3K
	pa1sjIxfo+SLluZCvQ7/bHsHYz01QKz/v0x1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qr3iPc+G12KdmxoToBKPSCSIVIqI4fK1
	r34IA7uqtg9ngNRxQuQPhuyPiQMuhZoicccU0MDCGLrmty+18GQviUaoE3+SNuNV
	fQFddGoY2GX25lHp0tKe/iNwojpkBmwSY8VtCiz4DXb8LzHcSctn9BeHtImA52za
	iBNNmfQM74Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6BF438000;
	Thu, 12 Feb 2015 18:08:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 514B337FFF;
	Thu, 12 Feb 2015 18:08:36 -0500 (EST)
In-Reply-To: <xmqqk320mzo7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Dec 2014 10:43:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12BEDA68-B30C-11E4-978E-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263784>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Dec 05, 2014 at 10:00:05AM -0800, Junio C Hamano wrote:
>>
>>> I am more worried about variable length part pushing the information
>>> that is given later out to the right, e.g. "error: missing file '%s'
>>> prevents us from doing X".  Chomping to [1024] is not a good
>>> strategy for that kind of message; abbreviating %s to /path/name/...
>>> (again, with literally "...") would be.

I have this one in my pile of Undecided topics:

    * jn/doc-api-errors (2014-12-04) 1 commit
     - doc: document error handling functions and conventions

     For discussion.
     What's the status of this one????

I think we all agree that the early part of the new documentation
text is good, but the last section that proposes to store more
detailed errors in caller supplied strbuf in textual form was
controversial (and I have not convinced myself it is a good idea
yet).

I could chuck the last section and then start merging the remainder
to 'next' to salvage the "obviously good bits".  Or do people want
to hash its last section a bit more?
