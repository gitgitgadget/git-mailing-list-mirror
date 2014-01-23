From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] repack: accept larger window-memory and max-pack-size
Date: Thu, 23 Jan 2014 10:37:01 -0800
Message-ID: <xmqqd2jiv92q.fsf@gitster.dls.corp.google.com>
References: <1390420685-18449-1-git-send-email-gitster@pobox.com>
	<1390420685-18449-3-git-send-email-gitster@pobox.com>
	<20140123010642.GB17254@sigill.intra.peff.net>
	<20140123012656.GC17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@googlemail.com>,
	Siddharth Agarwal <sid0@fb.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 19:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6P9f-0004ob-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 19:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbaAWShQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 13:37:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbaAWShK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 13:37:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 554BA65C44;
	Thu, 23 Jan 2014 13:37:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C/mNlT9h4xN6K2tEW6wnCsutWjY=; b=IVWQ/o
	Rf/4NUBVp/+IPnyIW9jyDWYc50KmaqssoCZaIAgMqBsV1qtIDW4lNmzVJISgDLKT
	9O58KFfCuXdRFvN+Ctat/K3hnGFUiA+KFplr9HZDR4Hy9Ja6NqlAVcYhmer9BkQb
	Gzp3FVEj2pnELKn+BYexLtwbPmiMgGa/wWVV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vE9QVyrbujmznWOcNiFlOQtw6Ny41Mg+
	2C4l58SKTib+OKuoARYBEfeW7wVRf+SEUyQQ2ZiXvs830l5Eq2DTCf64x/7mxQwb
	shYoL1AgJIMmxRLcu8kOH33FL2B0Jq6wVQ3Dr2T/eats1JSWLEWA0WRi+WIcfnkT
	sZaZq6EaKxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C30C65C43;
	Thu, 23 Jan 2014 13:37:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC3C765C3E;
	Thu, 23 Jan 2014 13:37:05 -0500 (EST)
In-Reply-To: <20140123012656.GC17254@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 22 Jan 2014 20:26:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5BDAD56E-845D-11E3-B830-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240927>

Jeff King <peff@peff.net> writes:

> On Wed, Jan 22, 2014 at 08:06:42PM -0500, Jeff King wrote:
>
>> But I think there is a subtle problem. Here (and elsewhere) we use the
>> parsed value of "0" as a sentinel. I think that is OK for
>> --max-pack-size, where "0" is not a reasonable value. But git-repack(1)
>> says:
>> 
>>   --window-memory=0 makes memory usage unlimited, which is the default.
>> 
>> What does:
>> 
>>   git config pack.windowMemory 256m
>>   git repack --window-memory=0
>> 
>> do? It should override the config, but I think it does not with your
>> patch (nor with the current code). Using a string would fix that (though
>> you could also fix it by using a different sentinel, like ULONG_MAX).
>
> Here is a series that does that (and fixes the other issue I found). It
> would probably be nice to test these things, but checking that they
> actually had an impact is tricky (how do you know that --window-memory
> did the right thing?).
>
>   [1/3]: repack: fix typo in max-pack-size option
>   [2/3]: repack: make parsed string options const-correct
>   [3/3]: repack: propagate pack-objects options as strings
>
> -Peff

Sounds sensible; will chuck the hum-ulong series and replace with
these patches.

Thanks.
