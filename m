From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 11:57:15 -0700
Message-ID: <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
	<CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
	<20140529161628.GB3763@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rodrigo Fernandes <rtfrodrigo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 29 20:57:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq5W2-0001YQ-8C
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 20:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaE2S5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 14:57:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50171 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbaE2S5W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 14:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81E2719E5A;
	Thu, 29 May 2014 14:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZCJtIpoyX1Id3yEtE29WSmoVmoo=; b=Ec/R44
	BPAcJX1MVYSV183IQJK8NvMjW+bF0lA+wNtE0ddKbpjuu97N605u69Y+sY7QhMv5
	hKrLX3xNp7mg4KD5Hrrp8wZhacAS2g23WBy5rIMyfbXr5iMoBciALu4p7sKYPCmi
	TQhR4WzRE9w95afYFoivL1Hw5Bq32r0pm1sQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bedXgR4VoutR9G1saA2nLAPeC8D51szx
	GWMNDKGb26lbD28a+R9qaL6O6vbk3i2W3iKUQ2mgXWSVLMfS3AahopJBs6iuc6qx
	t06imLwxS/rUcxEP1QFfam6cxuS4U2Gtu4qc1zBEmH9ChbTHn1ZnuOEkWhqrgfbg
	8rjitPhKRCA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71C5619E59;
	Thu, 29 May 2014 14:57:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A01DB19E51;
	Thu, 29 May 2014 14:57:17 -0400 (EDT)
In-Reply-To: <20140529161628.GB3763@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 29 May 2014 12:16:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E2AC798-E763-11E3-AAF0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250399>

Jeff King <peff@peff.net> writes:

> ...
> to at least make --format date output consistent with the rest of git
> (and to make "%at" consistent with "%ad" and --date=raw). That still
> doesn't address Rodrigo's concern, though (we would print "0 +0000").
>
> For that, we would want on top:
>
>   1. Teach split_ident_line to return _something_ for his malformed
>      case.
>
>   2. Teach show_ident_line to treat DATE_RAW to truly output raw
>      content, even if it is malformed.
>
> I am not sure whether those are a good idea or not. The current code
> provides some level of sanitization, so that a parser of log output will
> not get malformed cruft. And DATE_RAW may mean "show me what is in the
> raw commit, even if it is broken". Or it may just mean "show me the date
> in unix timestamp format, because that is easy to parse".
>
> I'd argue that if somebody really wants the former, they should be using
> "--pretty=raw", which will show the raw commit headers, without any
> parsing or fixup at all.

I actually am not very much interested in deciding what to show for
a broken timestamp.  An empty string is just as good as any random
cruft.  I agree with you that it would be nice to have one escape
hatch to let the users see what garbage is recorded, if only for
diagnostic purposes, and DATE_RAW may be one good way to do so (but
I'd rather recommend "cat-file commit" for real diagnostics).

I would be more interested to see whatever broken tool that created
such a commit gets fixed.  Do we know where it came from?
