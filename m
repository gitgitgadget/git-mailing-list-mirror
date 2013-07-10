From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] wt-status: use "format" function attribute for status_printf
Date: Tue, 09 Jul 2013 22:52:55 -0700
Message-ID: <7vehb7t0zs.fsf@alter.siamese.dyndns.org>
References: <20130710001659.GA11643@sigill.intra.peff.net>
	<20130710002328.GC19423@sigill.intra.peff.net>
	<7vmwpvt28j.fsf@alter.siamese.dyndns.org>
	<20130710052859.GA5339@sigill.intra.peff.net>
	<7vip0jt1sy.fsf@alter.siamese.dyndns.org>
	<20130710054050.GA7206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 10 07:53:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwnKo-0000cN-2E
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 07:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab3GJFw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 01:52:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3GJFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 01:52:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B6427D2B;
	Wed, 10 Jul 2013 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RcFd00zRT4hS6C3eNCP4PdRHI10=; b=XVDMSl
	ksWT/i6l75WohlofSHIG//fBROfXvy9+l2yHvzufq1CO7oXiTYkefP3QfTeIkjKb
	9UzUuflEuBhJuGitvQPvrIw1jZmgnwYGI5ufFH6boMBSTyZxOsG81AKcl2IjPLDM
	jsxW/9DO9sfxwhlN+cGNmtuymFT+ehdE7sGYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWVv6v8NgwfDdDElgqpEyCYLr9f8tWIb
	xFNs7UxF5bXqwzZDJjp4JSi9+0AsvRnEHFE3F5cQXH7BB4qzIqul+/MvjwEvkUg7
	xrE0HCFFV9kQmy2UKnpQFzU8S1UW+Q1lhSUVGADHuOPmLYs14vjEFe1Yad8FQigW
	Rqb+5/jgMAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4931D27D29;
	Wed, 10 Jul 2013 05:52:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A36C227D27;
	Wed, 10 Jul 2013 05:52:56 +0000 (UTC)
In-Reply-To: <20130710054050.GA7206@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2013 01:40:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8345BF8-E924-11E2-A841-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230027>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 09, 2013 at 10:35:25PM -0700, Junio C Hamano wrote:
>
>> > You can "fix" it with -Wno-zero-format-length, so the hassle is not
>> > huge. 
>> 
>> Yes, or just do func(..., "%s", "") perhaps?  That also sound iffy.
>
> I imagine that is the method intended by upstream (though who
> knows...the whole warning seems kind of stupid to me; it is clear that
> printf("") is a no-op, but it is obviously not clear that arbitrary
> functions using __attribute__(format) are).
>
> The patch to do it is below, but I actually think an explicit blank-line
> function like:
>
>   status_print_empty_line(s, color);
>
> would be more obvious to a reader.

I noticed that all but one can be dealt with with

    perl -p -i -e 's/status_printf_ln\((.*), ""\);/status_printf($1, "\\n");/'

That is,

-	status_printf_ln(s, GIT_COLOR_NORMAL, "");
+	status_printf(s, GIT_COLOR_NORMAL, "\n");

which does not look _too_ bad.

There is one instance that needs this, though.

-		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
