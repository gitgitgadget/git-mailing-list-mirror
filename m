From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Mon, 03 Mar 2014 12:07:18 -0800
Message-ID: <xmqqzjl7nj0p.fsf@gitster.dls.corp.google.com>
References: <53108650.2020708@alum.mit.edu>
	<xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
	<53112794.2070007@alum.mit.edu>
	<20140301075247.GF20397@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:07:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKZ96-0001Av-1J
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 21:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbaCCUHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 15:07:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43260 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbaCCUHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 15:07:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C1FB6FD10;
	Mon,  3 Mar 2014 15:07:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4xgRWGh1RxqOBsEb6kqML29/490=; b=l6JM6h
	2zO4323+9Jk6nzCMHHVoAdkKNPLJpTaF4osU9+5YHaHIFTnpWJU8YC4nFosptJlU
	wMAmNidMn4GDb6WqSPaIibRY5uwR2u7q+YYMMUbC5A0i3ykp8SyRS2wR4yzfv+zB
	g8F9VGitoUoqA0WcOon9OFcUv+9cCt748gKuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W/JuV1zcSSVhCqxXmPVxHQ66IfHRPmhV
	AJduy+3IQm97coJYomJRAad+AZtODyTyesaRFH5c/K3XnfvFceRCdvkLxlbauhD9
	tGHF789oimSH0JQuApFw9myIA6AIlz2jplTkD1zmRZs+Ur5XJmeYlZhEPs0ZxCjN
	NI3KYEq55Dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 657286FD0F;
	Mon,  3 Mar 2014 15:07:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CB8A6FD0A;
	Mon,  3 Mar 2014 15:07:21 -0500 (EST)
In-Reply-To: <20140301075247.GF20397@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 1 Mar 2014 02:52:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DEBCE18-A30F-11E3-9AC6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243266>

Jeff King <peff@peff.net> writes:

> Most callbacks would convert to a query system in a pretty
> straightforward way, but some that have side effects might be tricky.
> Converting them all may be too large for a GSoC project, but I think you
> could do it gradually:
>
>   1. Convert the parser to read into an in-memory representation, but
>      leave git_config() as a wrapper which iterates over it.
>
>   2. Add query functions like config_string_get() above.
>
>   3. Convert callbacks to query functions one by one.
>
>   4. Eventually drop git_config().
>
> A GSoC project could take us partway through (3).

I actually discarded the "read from these config files to preparsed
structure to memory, later to be consumed by repeated calls to the
git_config() callback functions, making the only difference from the
current scheme that the preparsed structure will be reset when there
is the new 'reset to the original' definition" as obvious and
uninteresting.

This is one of these times that I find myself blessed with capable
others that can go beyond, building on top of such an idea that I
may have discarded without thinking it through, around me ;-)

Yes, the new abstraction like config_<type>_get() that can live
alongside the existing "git_config() feeds callback chain
everything" and gradually replace the latter, would be a good way
forward.  Given that we read configuration multiple times anyway for
different purposes, even without the new abstraction, the end result
might perform better if we read the files once and reused in later
calls to git_config().

Thanks.
