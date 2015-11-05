From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output just once
Date: Wed, 04 Nov 2015 23:32:21 -0800
Message-ID: <xmqq4mh09a0q.fsf@gitster.mtv.corp.google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<563A6C3D.2050805@kdbg.org>
	<xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
	<20151104225618.GA18805@sigill.intra.peff.net>
	<xmqqvb9h8ale.fsf@gitster.mtv.corp.google.com>
	<20151105065111.GA4725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 08:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuF2I-0000t2-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 08:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032477AbbKEHcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 02:32:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031994AbbKEHcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 02:32:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F7E61FA26;
	Thu,  5 Nov 2015 02:32:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yAUbNNob8EsKb2SgJIQ8SpqeZ0I=; b=he+dnS
	YNWNsJ7z4Uiq5XZ/ZPAmSwVMZvRA2vZH9NLud1zu6chGI6ejV3rzY4JzWjO/kVcg
	shMprTMywjk1B8PNwqyq48fF7bR/7jE/3Vap2Wl+kHtDH9MSPE6rPm4yEyAoUhlj
	imD9gTKcjHnCiK2ku24eM4qb+D30DPbWb5U+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gUHHbQPLFt6leQQga8R7tevq39lFYul0
	3/7hGvhyeCn2o9lKFTzGMqNlJdJp3hCvP1v5/9uuMkgjvyj4IDprDceVp5y5yWud
	LMiTk+Y+9sZD62l8NlAcT3+jf1prP+9Eju0d7fve27hYGKof47ty5DXRMV9pr50U
	CsUZFngoI/U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 150541FA24;
	Thu,  5 Nov 2015 02:32:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 48D871FA23;
	Thu,  5 Nov 2015 02:32:22 -0500 (EST)
In-Reply-To: <20151105065111.GA4725@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Nov 2015 01:51:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A555F7E-838F-11E5-A805-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280914>

Jeff King <peff@peff.net> writes:

> POSIX implies it is the case in the definition of read[2] in two ways:
>
>   1. The O_NONBLOCK behavior for pipes is mentioned only when dealing
>      with empty pipes.
>
>   2. Later, it says:
>
>        The value returned may be less than nbyte if the number of bytes
>        left in the file is less than nbyte, if the read() request was
>        interrupted by a signal, or if the file is a pipe or FIFO or
>        special file and has fewer than nbyte bytes immediately available
>        for reading.
>
>      That is not explicit, but the "immediately" there seems to imply
>      it.

We were reading the same book, but I was more worried about that
"may" there; it merely tells the caller of read(2) not to be alarmed
when the call returned without filling the entire buffer, without
mandating the implementation of read(2) never to block.

Having said that,...

>> So perhaps the original reasoning of doing nonblock was faulty, you
>> are saying?
>
> Exactly. And therefore a convenient way to deal with the portability
> issue is to get rid of it. :)

... I do like the simplification you alluded to in the other
message.  Not having to worry about the nonblock (at least until it
is found problematic in the real world) is a very good first step,
especially because the approach allows us to collectively make
progress by letting all of us in various platforms build and
experiment with "something that works".
