From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] bundle: don't leak an fd in case of early return
Date: Wed, 30 Mar 2016 10:19:09 -0700
Message-ID: <xmqqio03ubn6.fsf@gitster.mtv.corp.google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-6-git-send-email-sbeller@google.com>
	<20160330011743.GD2237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:19:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJm3-0007JH-WC
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbcC3RTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:19:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753575AbcC3RTM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:19:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EEB84FE4E;
	Wed, 30 Mar 2016 13:19:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4tFxrHd8SbOjnckNX0ZrKzUKYRs=; b=Ygq9T8
	8a6k7aGVuzxjcXMMP9PQ3Tbbw0WihY7oklZdRWn1G28rDPlkEo9A4U+b0KNPA7EU
	0VQJWcd3NkcdjK0/98cxivUmyNLmhOUi19Zm4uRlws4hozHPuRgXA13i1Bzfnen+
	u+5SGRtqpi/DtIq00Tr5SvlLVFtgg7ZaWtl8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kSEgx4dvsvH4hwfjjticZ9cZ5e0tnb1G
	IGLuKpBNxtnqYNeeBam2WFIMuOqACuO74HDBaUozaIDK2i9nb6FODnyxjBcnZcPC
	EKs7mNLiRjBL9FFWNSwvF53cRzvmZAOksDA5XFJu7tpXf6Yd4ejAkfor8PSzO2a3
	+ToI1Bqa4Xo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55AED4FE4D;
	Wed, 30 Mar 2016 13:19:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD94F4FE4B;
	Wed, 30 Mar 2016 13:19:10 -0400 (EDT)
In-Reply-To: <20160330011743.GD2237@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Mar 2016 21:17:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 847E8FBC-F69B-11E5-A025-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290322>

Jeff King <peff@peff.net> writes:

>> +	if (compute_and_write_prerequisites(bundle_fd, &revs, argc, argv)) {
>> +		if (!bundle_to_stdout)
>> +			close(bundle_fd);
>>  		return -1;
>> +	}
>
> Makes sense. Should we also be rolling back the lock file? It happens
> automatically at program exit, of course, but we are in library code
> here that should not rely on that.

Yeah, I agree.  I suspect that the original wasn't even meant to be
used in a "library-ish" fashion, but as long as we are adding this
close(), we should also be doing the rollback.

Thanks.
