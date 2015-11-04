From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Wed, 04 Nov 2015 13:19:38 -0800
Message-ID: <xmqqziyt8nth.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<xmqq8u6da448.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbwJrQ9SrGkJsSx9oUcP98dn9wP=ZvgQLRjmPaZtOzanA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu5T8-0004ft-C8
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 22:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030907AbbKDVTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 16:19:42 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932428AbbKDVTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 16:19:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EDA526F7A;
	Wed,  4 Nov 2015 16:19:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3U3BP5SwFkyxUqczk2vTc59zWpA=; b=beJYya
	ffqAXejS/HpolDkWLthu+EiJr5k74a9x5B/mODe/uP7ZLm7pKUHxSBxQNaYAP6zd
	C0QXZw/6dPD7gQUMS2kXHmkoRo4b+ExYVuiXd3dz50rYPoFFEByM2krxKzAFKMz3
	ZhPgcBDRvbTkEKbuocantweKCxl7VHUdd5lWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUt9nRhvFZov7daTbUiEl4+ngCQdhO5/
	GinAgfN8+LCeLIHhOtq0Gdo1aPQPuc4USgNqp3zPe8I/fQ81d6JePnTqyo4e0XvU
	jJbTaoqu1CLCTYOykvv3ZaJUagPNBJFtbi3ugZmUiHn3UpacdbI/i87ySLG+aINx
	yVlRmDasCkg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 636D326F79;
	Wed,  4 Nov 2015 16:19:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D16C726F76;
	Wed,  4 Nov 2015 16:19:39 -0500 (EST)
In-Reply-To: <CAGZ79kbwJrQ9SrGkJsSx9oUcP98dn9wP=ZvgQLRjmPaZtOzanA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 4 Nov 2015 13:04:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C236AA72-8339-11E5-AEE9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280887>

Stefan Beller <sbeller@google.com> writes:

> So more like:
>
>     if (platform_capable_non_blocking_IO())
>         set_nonblocking_or_die(&pp->children[i].process.err);
>     else
>         pp->children[i].process.err = 2; /* ugly intermixed output is possible*/

When I mentioned #if..#endif, I didn't mean it as a dogmatic
"conditional compilation is wrong" sense.  It was more about "the
high-level flow of logic should not have to know too much about
platform peculiarities".  As platform_capable_non_blocking_IO()
function would be a constant function after you compile it for a
single platform, if you add 10 instances of such if/else in a patch
that adds 250 lines, unless the change is to add a set of lowest
level helpers to be called from the higher-level flow of logic so
that the callers do not have to know about the platform details,
that's just as bad as adding 10 instances of #if..#endif.

>> On the other hand, on a platform that is known to be incapable
>> (e.g. lacks SETFL or NONBLOCK), we have two options.
>>
>> 1. If we can arrange to omit the intermediary buffer processing
>>    without butchering the flow of the main logic with many
>>    #ifdef..#endif, then that would make a lot of sense to do so, and
>>    running the processes in parallel with mixed output might be OK.
>>    It may not be very nice, but should be an acceptable compromise.
>
> From what I hear this kind of output is very annoying. (One of the
> main complaints of repo users beside missing atomic fetch transactions)

When (1) "parallelism with sequential output" is the desired
outcome, (2) on some platforms we haven't found a way to achieve
both, and (3) a non-sequential output is unacceptable, then
parallelism has to give :-(.

I was getting an impression from your "not buffer" suggestion that
"sequential output" would be the one that can be sacrificed, but
that is OK.  Until we find a way to achieve both at the same time,
achieving only either one or the other is better than achieving
nothing.

>> Either way, bringing "parallelism with sequential output" to
>> platforms without nonblock IO can be left for a later day, when we
>> find either (1) a good approach that does not require nonblock IO to
>> do this, or (2) a good approach to do a nonblock IO on these
>> platforms (we know about Windows, but there may be others; I dunno).
