From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-config and large integers
Date: Tue, 20 Aug 2013 16:06:19 -0700
Message-ID: <xmqqli3wufmc.fsf@gitster.dls.corp.google.com>
References: <20130820223953.GA3429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 01:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBv0P-0001gr-Em
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 01:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab3HTXGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 19:06:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab3HTXGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 19:06:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 428393ADDE;
	Tue, 20 Aug 2013 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iRLS7AJmXVGUuBwRSLe6qJKO4+Q=; b=pMTrAF
	+/WQXVwO1FT1jutcy2RUD4gKKSI2G65d9hYbayMmRoBP/1RZdZxbz7JpkBDE6QLQ
	ooUHLZzree+iPDSi8DWMgT2xzB/PjdLXi6U7ZCU9HyLrNvZxI0RESFGn538dU89D
	Qm86Di7B7GerkbawHMH4kyKPj169FU0J9yRMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9aaJAgVOPEl2/1j6QooY0in2/ZsWGcv
	+7V60qEAtdNL7CVkjs0mawhshf2cN1/bcYB/T/NzmquyV0fv24c+DtKJFF4FERLR
	ImBj9QN2+GRBJMQnNbqsx4G8/NsgDIDYmP7ebue9e/4QH7yPV+Fc4YE2XbfCcrT7
	fGQT/fcAS1w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B403ADDD;
	Tue, 20 Aug 2013 23:06:24 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 991F83ADDC;
	Tue, 20 Aug 2013 23:06:22 +0000 (UTC)
In-Reply-To: <20130820223953.GA3429@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 Aug 2013 18:39:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 21BABE84-09ED-11E3-B9D4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232667>

Jeff King <peff@peff.net> writes:

> I was playing with a hook for file size limits that wanted to store the
> limit in git-config. It turns out we don't do a very good job of big
> integers:
>
>   $ git config foo.size 2g
>   $ git config --int foo.size
>   -2147483648
>
> Oops. After this series, we properly notice the error:
>
>   $ git config --int foo.size
>   fatal: bad config value for 'foo.size' in .git/config
>
> and even better, provide a way to access large values:
>
>   $ git config --ulong foo.size
>   2147483648

I may be missing something, but why do we even need a new option for
the command that is known to always produce textual output?

As you said "Oops", the first example that shows a string of digits
prefixed by a minus sign for input "2g" is buggy, and I think it is
perfectly reasonable to fix it to show a stringified representation
of 2*1024*1024*1024 when asked for "--int".

What am I missing???
