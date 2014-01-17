From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git quietly fails on https:// URL, https errors are never reported to user
Date: Fri, 17 Jan 2014 11:43:35 -0800
Message-ID: <xmqqmwiuwg0o.fsf@gitster.dls.corp.google.com>
References: <52D7D017.107@rawbw.com>
	<20140116180310.GA27180@sigill.intra.peff.net>
	<52D8FAA6.1010601@rawbw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Yuri <yuri@rawbw.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 20:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FKQ-00032Y-Sv
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 20:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbaAQTnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 14:43:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbaAQTni (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 14:43:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE50E61CC1;
	Fri, 17 Jan 2014 14:43:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H1NS0mJC8/sIMxs+MtbU7OCf92k=; b=Ys2YFV
	N787YkJKOpiJl+lL7KXZgcdR0hGjZ7ioFXGNTUaVIDa5stInuLBoNETImZpP9L8d
	nhhG3u8LtO/eVLl6xOgvG6aF8tHXJXWUPy61gPxV1mtutpzv1oayRA7Pc90FSYuJ
	2G3pmRfSf/G9grQcLH3guXaU3F5u4kF4yexns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WfktGZSO7nxdaiMFjXKAYxGZy84wBusS
	+NCnTSzAJ7kvx2WG3pz6eG1ryga6qA08SAnn3uM32mOe+5ZDw0Qw8oZ15c0tJW2i
	cVJYzPP8f3uOV2ePBDfGu8um65BtdCZRmn2HMSDTri1To2XGYrEawaueexu2cFvg
	4A2INWPEL6s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFF6961CC0;
	Fri, 17 Jan 2014 14:43:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 297E261CBD;
	Fri, 17 Jan 2014 14:43:37 -0500 (EST)
In-Reply-To: <52D8FAA6.1010601@rawbw.com> (yuri@rawbw.com's message of "Fri,
	17 Jan 2014 01:40:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A85AE698-7FAF-11E3-A958-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240616>

Yuri <yuri@rawbw.com> writes:

> I think that in a rare case of error this extra-printout wouldn't
> hurt.

If the "error is rare, extra verbiage does not hurt" were a valid
attitude, "error is rare, non-zero exit is enough" would be equally
valid ;-)

Also that statement contradicts with the rationale given by 266f1fdf
(transport-helper: be quiet on read errors from helpers,
2013-06-21), no?

    However, this makes a much more common case worse: when a helper
    does die with a useful message, we print the extra "Reading from
    'git-remote-foo failed" message. This can also end up confusing
    users, as they may not even know what remote helpers are (e.g.,
    the fact that http support comes through git-remote-https is
    purely an implementation detail that most users do not know or
    care about).
    
Your change is not an exact revert and rewords the message to read

	Failure in 'http' protocol reader.

instead of

	Reading from helper 'git-remote-http' failed.

which avoids the "helper" word and replacing it with "protocol
reader" [*1*] in an attempt to make it less likely to "end up
confusing users", but I am not sure if "protocol reader" is good
enough for those who get confused with "helper" in the first place.
They will ask their resident guru or favourite search engine about
the message and will be told that your http connection did not go
well either way, but not many people have seen this new message.

If we were to reinstate the extra final line in the error message, I
think we would be off doing a straight revert without any rewording
that introduces yet another word "protocol reader" that is not found
anywhere in our glossary.

I think I am OK with adding one more line after "Reading from
... failed" that explains a more detailed error message might be
there above that line, but I am not sure what the good phrasing
would be.


[Footnote]

*1* It may introduce a new confusion "was it 'read' that failed, or
'write'?", though ;-)
