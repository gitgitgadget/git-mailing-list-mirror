From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] convert: Stream from fd to required clean filter instead of mmap
Date: Mon, 25 Aug 2014 11:35:45 -0700
Message-ID: <xmqq4mx0mn7i.fsf@gitster.dls.corp.google.com>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
	<1408896466-23149-5-git-send-email-prohaska@zib.de>
	<20140825124323.GB17288@peff.net>
	<E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:36:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLz7c-0007z5-A6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbaHYSf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:35:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53463 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbaHYSf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:35:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 651AA354A0;
	Mon, 25 Aug 2014 14:35:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ibrcWoPhpD7dhepTq6vipSoBBgg=; b=OrWqzb
	Jp6k4tBWzAnthDQoN5ntUWSic11VZPO35VAmQW4U9afgdfIib6oLsA6jqc/TwBse
	YOtsJaCLUE+gudEqyxDj0aXw5lU3eWNUrcwKLXyIRnvHzU+QoxJrbXsXdqGcpQbw
	JU+ZjcpZ0OuQ5+7NjZLVBID25NmH8xTkQPKRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ay7/bC/ii0RE6tfbJM3DcvzRzQ/7rhAc
	wK1W5m+llYxGCgRNS0H78LE7DV09NfaCa8pjnjT5b1Ybris8Rf6yp2ENAIyvITcA
	eHoJ9OY/OGfzxfhfONEf0zG66Kom42kWhGdTAgLk0wnpLQ7mDsGZKXuzTlvIYYNz
	qdX0+FoON4c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A7FE3549F;
	Mon, 25 Aug 2014 14:35:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 970C635497;
	Mon, 25 Aug 2014 14:35:48 -0400 (EDT)
In-Reply-To: <E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de> (Steffen Prohaska's
	message of "Mon, 25 Aug 2014 18:55:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2324B42-2C86-11E4-9D1B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255849>

Steffen Prohaska <prohaska@zib.de> writes:

>> Couldn't we do that with an lseek (or even an mmap with offset 0)? That
>> obviously would not work for non-file inputs, but I think we address
>> that already in index_fd: we push non-seekable things off to index_pipe,
>> where we spool them to memory.
>
> It could be handled that way, but we would be back to the original problem
> that 32-bit git fails for large files.

Correct, and you are making an incremental improvement so that such
a large blob can be handled _when_ the filters can successfully
munge it back and forth.  If we fail due to out of memory when the
filters cannot, that would be the same as without your improvement,
so you are still making progress.

> To implement something like the ideal strategy below, the entire convert 
> machinery for crlf and ident would have to be converted to a streaming
> approach.

Yes, that has always been the longer term vision since the day the
streaming infrastructure was introduced.

>> So it seems like the ideal strategy would be:
>> 
>>  1. If it's seekable, try streaming. If not, fall back to lseek/mmap.
>> 
>>  2. If it's not seekable and the filter is required, try streaming. We
>>     die anyway if we fail.

Puzzled...  Is it assumed that any content the filters tell us to
use the contents from the db as-is by exiting with non-zero status
will always be large not to fit in-core?  For small contents, isn't
this "ideal" strategy a regression?

>>  3. If it's not seekable and the filter is not required, decide based
>>     on file size:
>> 
>>       a. If it's small, spool to memory and proceed as we do now.
>> 
>>       b. If it's big, spool to a seekable tempfile.
