From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t3404: be resilient against running with the -x flag
Date: Tue, 10 May 2016 14:13:26 -0700
Message-ID: <xmqqpostmxah.fsf@gitster.mtv.corp.google.com>
References: <cover.1462888768.git.johannes.schindelin@gmx.de>
	<alpine.DEB.2.20.1605101607180.4092@virtualbox>
	<xmqqshxpofqh.fsf@gitster.mtv.corp.google.com>
	<20160510205800.GC19958@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 23:13:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EyE-00086Y-En
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbcEJVNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 17:13:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751227AbcEJVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 17:13:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 993071A0E6;
	Tue, 10 May 2016 17:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/MOL2JfND61gLitY8bvAfl5Ylc8=; b=EXiOhP
	3nQgnE7PE8dLpFYKpJokrBi3PiiT8OQJ2zavQSDBIpg9adcUKCEGpywRVwBNTn4l
	aCd84GFiKv2UlnUu97VSBdcnR3Ex1ooMyrVAzniwCsDQf2jXVm1PoDjnfMyL58G7
	DczExPRgSHAj4IM/7+cdCPKjjeU6Jk/MYTaQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qGWIEUudOw+ebTw99pa1skZ+2AoP/DSR
	6mJfw++4Lkzg0rtyF4AKVNmLcSoA/+bAlTR2ABdPhUpcv1PdgIc3D3aAoDeIKSaf
	Y/PrCNieB03UTi/aEhvPH8KTnJRj7IEukkxqkIzeqSw9Gh9ctDOFvXLXSC6BCZwL
	umt2dtYP3mw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 91A461A0E4;
	Tue, 10 May 2016 17:13:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B9321A0E3;
	Tue, 10 May 2016 17:13:27 -0400 (EDT)
In-Reply-To: <20160510205800.GC19958@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 May 2016 16:58:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A36FB08-16F4-11E6-814E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294195>

Jeff King <peff@peff.net> writes:

> On Tue, May 10, 2016 at 12:49:42PM -0700, Junio C Hamano wrote:
>
>> I wonder if we can fix "-x" instead so that we do not have to
>> butcher tests like this patch does.  It was quite clear what it
>> expected to see before this patch, and it is sad that the workaround
>> makes less readable (and relies on the real output we are looking
>> for never begins with '+').
>
> I don't think there is a scalable, portable way to do so. "-x" output is
> going to stderr, and is inherited by any functions or subshells. So
> either we have to ask "-x" output to go somewhere else, or we have to
> turn it off inside the functions and subshells. The latter requires
> tweaking each site, which isn't scalable. And there is no way to do the
> former in a portable way (AFAIK).

Yeah, that was the conclusion I was coming to; the same "unscalable"
argument applies to the patch under discussion, too.

> That being said, bash supports BASH_XTRACEFD, so maybe something like
> this:
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 286c5f3..482ec11 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -321,6 +321,7 @@ then
>  else
>  	exec 4>/dev/null 3>/dev/null
>  fi
> +BASH_XTRACEFD=4
>  
>  test_failure=0
>  test_count=0
>
> would help Dscho's case (and people on other shells aren't helped, but
> they are not hurt either).

Yeah, something like that I would greatly appreciate.
