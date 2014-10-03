From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo = bar"
Date: Fri, 03 Oct 2014 15:17:18 -0700
Message-ID: <xmqqsij4kdch.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003202743.GH16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:17:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaBAY-0005hO-9u
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 00:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbaJCWRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 18:17:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60459 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756131AbaJCWRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 18:17:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5D743F711;
	Fri,  3 Oct 2014 18:17:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3qK5238Dx8NmRVyCRljRyYu8sVU=; b=p9LjTP
	RoY8BhARTzmlyowFGXvSLDu4Kf/nFVTMJUw2tk7vdj237WUlWcIFB9mV7fohFPI3
	3cKnUzbC1UmLFa/4s4CP+nsIcYVQbLgooyDc09iAAxFt0U7OtKCkPq7xvdVaIY5K
	+/+BT1lcZU6whXeGQPAabTm0uSXdoG/KRQlCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GDec0OF/YO0yXXDGko/ghLw11l1jDLr2
	cWAZto7WbLMIxtsADXjqq+uXUQOaxO0xIgyiiVPFYXXOrPoAz8hAmeY67+zYlAVu
	4YuItajkCQYXIji5hj6I1Exdn8r1zfwbbgO3rwRQiOR+XHrLmOoy+q8LyNViMMje
	DOtIRRrEtI0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC4503F710;
	Fri,  3 Oct 2014 18:17:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C9073F70F;
	Fri,  3 Oct 2014 18:17:19 -0400 (EDT)
In-Reply-To: <20141003202743.GH16293@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 16:27:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A3603F4-4B4B-11E4-A039-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257874>

Jeff King <peff@peff.net> writes:

> For small outputs, we sometimes use:
>
>   test "$(some_cmd)" = "something we expect"
>
> instead of a full test_cmp. The downside of this is that
> when it fails, there is no output at all from the script.
> Let's introduce a small helper to make tests easier to
> debug.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is in the same boat as the last commit; we can drop it without
> hurting the rest of the series.
>
> Is test_eq too cutesy or obfuscated? 

Not really.  As long as its two strings are not tooooo long, the
output may still be readable.

> I have often wanted it when
> debugging other tests, too. Our usual technique is to do:
>
>   echo whatever >expect &&
>   do_something >actual &&
>   test_cmp expect actual
>
> That's a bit verbose. We could hide it behind something like test_eq,
> too, but it introduces several extra new processes.

What do you mean by "extra new processes"?  Whether open coded in a
verbose way, or wrapped inside a helper, e.g.

	test_eql () {
		echo "$1" >expect &&
                shift &&
                "$@" >actual &&
                test_cmp expect actual
	}
        ...
	test_eql whatever do_something

the number of processes would be the same, no?

Or do you mean test_cmp is an extra process compared with

	test_eq whatever "$(do_something)"

Hopefully, do_something does something more than what takes test_cmp
to run, so I wouldn't be worried too much about it.
