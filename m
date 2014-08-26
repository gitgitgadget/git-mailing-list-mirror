From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] convert: Stream from fd to required clean filter instead of mmap
Date: Tue, 26 Aug 2014 12:32:17 -0700
Message-ID: <xmqqmwarhwse.fsf@gitster.dls.corp.google.com>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
	<1408896466-23149-5-git-send-email-prohaska@zib.de>
	<20140825124323.GB17288@peff.net>
	<E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de>
	<xmqq4mx0mn7i.fsf@gitster.dls.corp.google.com>
	<20140826180018.GB17546@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMMTo-0001Dh-FL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 21:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbaHZTc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 15:32:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52652 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbaHZTc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 15:32:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 771B73257B;
	Tue, 26 Aug 2014 15:32:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VI5zLlQvLobOw/0HNsvu685wgf0=; b=cyBmAz
	3Di11BPzOwu1/k+RjqrC0g/giq/Faaa+KLIBwcLBYI8h8fnXf2qM8GIlN7EernB8
	GfuuJ6TAYWbmPwmOynil4o0EGOyTw8tHycU0i9rMv96N3yKzoDisjI+HZTwQl58i
	F43vXQrcZUeDd+Rscvri3J9P+qBL6uvIPOhxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwB3VS2uJG3VxBDjWh2LzUizqJ+/FR/P
	/CVtVInCldkkGMFfe5jTY5jRc6g0X56KxE9P1wGlkz94oYet/foPdiZNsNP/ZpCS
	i9bQiRL7zb27YRvcpskD9F6GQkMTvCB09fzbhNdA4HQfSUqWsCgB66oZXB14ejNi
	FwcO80QAj0g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68BFE3257A;
	Tue, 26 Aug 2014 15:32:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A5B8D32577;
	Tue, 26 Aug 2014 15:32:19 -0400 (EDT)
In-Reply-To: <20140826180018.GB17546@peff.net> (Jeff King's message of "Tue,
	26 Aug 2014 14:00:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1D52AFC-2D57-11E4-BC83-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255936>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 25, 2014 at 11:35:45AM -0700, Junio C Hamano wrote:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>> 
>> >> Couldn't we do that with an lseek (or even an mmap with offset 0)? That
>> >> obviously would not work for non-file inputs, but I think we address
>> >> that already in index_fd: we push non-seekable things off to index_pipe,
>> >> where we spool them to memory.
>> >
>> > It could be handled that way, but we would be back to the original problem
>> > that 32-bit git fails for large files.
>> 
>> Correct, and you are making an incremental improvement so that such
>> a large blob can be handled _when_ the filters can successfully
>> munge it back and forth.  If we fail due to out of memory when the
>> filters cannot, that would be the same as without your improvement,
>> so you are still making progress.
>
> I do not think my proposal makes anything worse than Steffen's patch.

I think we are saying the same thing, but perhaps I didn't phrase it
well.

> I think the main argument against going further is just that it is not
> worth the complexity. Tell people doing reduction filters they need to
> use "required", and that accomplishes the same thing.
>
>> >> So it seems like the ideal strategy would be:
>> >> 
>> >>  1. If it's seekable, try streaming. If not, fall back to lseek/mmap.
>> >> 
>> >>  2. If it's not seekable and the filter is required, try streaming. We
>> >>     die anyway if we fail.
>> 
>> Puzzled...  Is it assumed that any content the filters tell us to
>> use the contents from the db as-is by exiting with non-zero status
>> will always be large not to fit in-core?  For small contents, isn't
>> this "ideal" strategy a regression?
>
> I am not sure what you mean by regression here. We will try to stream
> more often, but I do not see that as a bad thing.

I thought the proposed flow I was commenting on was

    - try streaming and die if the filter fails

For an optional filter working on contents that would fit in core,
we currently do

    - slurp in memory, filter it, use the original if the filter fails

If we switched to 2., then... ahh, ok, I misread "is required" part.
The "regression" does not apply to that case at all.
