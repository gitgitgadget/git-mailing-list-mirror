From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_in_full: always report errors
Date: Thu, 26 May 2011 11:35:51 -0700
Message-ID: <7vy61twbqw.fsf@alter.siamese.dyndns.org>
References: <87tych5zrh.fsf@rho.meyering.net>
 <20110526141130.GB18520@sigill.intra.peff.net>
 <87hb8h5y09.fsf@rho.meyering.net>
 <20110526163027.GC4049@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 20:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPfPl-000442-1X
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713Ab1EZSgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 14:36:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308Ab1EZSgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 14:36:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E770A4214;
	Thu, 26 May 2011 14:38:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DIlSozODCzYgzvH7DVzKLPbXlBc=; b=E8z2nD
	kdE7m4hZ4yLjnpd8tcErBHVXtrTQjsbEunHirpqveoSb1FymRbjjmAK0Omeic3ZQ
	piSdXwEv9oC1niNFuquIujwzUaYusJvx/H5oLL0vrlEuN++BT+Qy3LJfLHqRwCYC
	fx/eyQj0ovF9Ajiezu6qTwa6xDqUrNhbRszDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=okwGxvKgORGHVYbU0pxYUM3sCm0k4Hxb
	Uo48tRxCX/r6DPTCM66oV9bfxp0IjF6HJgT8YFQbXlCO3qcbYXrIQEJnK3QmHb8j
	yqYx47nEFhJZea59tf83sUqzrycCubehsDojn/Y5wFMZkvL8D7ShCoTb94YV/iHQ
	T63NVbqVj28=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6B6C4213;
	Thu, 26 May 2011 14:38:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 651DE4212; Thu, 26 May 2011
 14:38:00 -0400 (EDT)
In-Reply-To: <20110526163027.GC4049@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 May 2011 12:30:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AF0CC26-87C7-11E0-8595-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174558>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] read_in_full: always report errors
>
> The read_in_full function repeatedly calls read() to fill a
> buffer. If the first read() returns an error, we notify the
> caller by returning the error. However, if we read some data
> and then get an error on a subsequent read, we simply return
> the amount of data that we did read, and the caller is
> unaware of the error.

Is the caller unaware?  While it won't hurt the callers who do:

   if (expect != read_in_full(fd, buf, expect))
      die(...)

I think this change hurts the one that you mentioned in your analysis.

The caller in index_stream() reads what it could, writes what it read, and
comes back and makes another call to read_in_full(), at which point either
it gets an error and the whole thing would error out (i.e. no difference
from before), or if it was an transient error that interrupted the
previous read_in_full(), it can keep reading (with this patch it will not
have a chance to do so).

> This makes the tradeoff that seeing the partial data is more
> important than the fact that an error occurred. In practice,
> this is generally not the case; we care more if an error
> occurred, and should throw away any partial data.

Not really. I think we care about both, and I think that is what the
current code tries to do.
