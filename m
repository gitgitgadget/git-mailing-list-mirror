From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] error: save and restore errno
Date: Wed, 19 Nov 2014 10:14:17 -0800
Message-ID: <xmqqvbmbrrba.fsf@gitster.dls.corp.google.com>
References: <20141119013532.GA861@peff.net> <20141119013710.GA2135@peff.net>
	<20141119014344.GP6527@google.com> <20141119014722.GB2337@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:14:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xr9lr-0002q7-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986AbaKSSOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:14:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754452AbaKSSOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:14:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB6E61D2CD;
	Wed, 19 Nov 2014 13:14:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q8Jf5kBIAV9kYMceHAa4IJYQ//8=; b=vJDMby
	HoYc1LkH6DFBA2ZVBQrtMs8LrHHZWbLfDKHYuI+q7VpebCpYOqTJbYkVmmsp9djZ
	gTtSpYm7HgnfXcd5nehLF2yfqHVGVTOBeLELUasFyxplA9Mk2//TlHXpFF0gwTbX
	oVka7RrfVybIM23qxdMXv0H7Yr8Qjr++fujCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aH4kEgC4q5jVC9PPnS519H61QoxMrecN
	hgjARit8r3s4Hup8ZwKTuoC0MflwigHr/XJxFMgk+g+ZU4mV7uq7PkJKYtCUAYCx
	/9110vt69FeychpP1sZCzX9DlGBuIXMhddYHMRj54hqCXuwkLPYLl5XlCjRiKbI7
	0YFfgiNryzo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B286D1D2CC;
	Wed, 19 Nov 2014 13:14:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43E421D2CB;
	Wed, 19 Nov 2014 13:14:19 -0500 (EST)
In-Reply-To: <20141119014722.GB2337@peff.net> (Jeff King's message of "Tue, 18
	Nov 2014 20:47:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E13573E4-7017-11E4-95E0-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 18, 2014 at 05:43:44PM -0800, Jonathan Nieder wrote:
>
>> Jeff King wrote:
>> 
>> > It's common to use error() to return from a function, like:
>> >
>> > 	if (open(...) < 0)
>> > 		return error("open failed");
>> >
>> > Unfortunately this may clobber the errno from the open()
>> > call. So we often end up with code like this:
>> >
>> >         if (open(...) < 0) {
>> > 		int saved_errno = errno;
>> > 		error("open failed");
>> > 		errno = saved_errno;
>> > 		return -1;
>> > 	}
>> >
>> > which is less nice.
>> 
>> What the above doesn't explain is why the caller cares about errno.
>> Are they going to print another message with strerror(errno)?  Or are
>> they going to consider some errors non-errors (like ENOENT when trying
>> to unlink a file), in which case why is printing a message to stderr
>> okay?
>
> I guess the unsaid bit is:
>
>   Unfortunately this may clobber the errno from the open() call. Even
>   though error() sees the correct errno, the caller to which we are
>   returning may see a bogus errno value.
>
> -Peff

I am not sure if that answers the question asked.

If you have

	int frotz(...) {
		int fd = open(...);
        	if (fd < 0)
                	return error("open failed (%s)", strerror(errno));
		return fd;
	}

and the caller calls it and cares about the errno from this open,
what does the caller do?  Jonathan's worried about a codepath that
may be familiar to us as we recently saw a patch similar to it:

	int fd = frotz(...);
        if (fd < 0) {
        	if (errno == ENOENT || errno == EISDIR)
                	; /* not quite an error */
		else
			exit(1);
	}

If ENOENT/EISDIR is expected and a non-error, it is not useful for
frotz() to give an error message on its own.

I think a more appropriate answer to Jonathan's question is why is
the callee (i.e. frotz()) calling error() in the first place if an
unconditional error message is an issue.
