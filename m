From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: do not insert third header
Date: Mon, 09 Jun 2014 22:38:14 -0700
Message-ID: <xmqqwqcpb9yx.fsf@gitster.dls.corp.google.com>
References: <20140607080940.GA8858@camelia.ucw.cz>
	<xmqqa99ld5sp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jun 10 07:38:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuElQ-0006YL-P7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbaFJFiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 01:38:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56492 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaFJFiX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 01:38:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F01851FF1B;
	Tue, 10 Jun 2014 01:38:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sC9QKYbyxZHltpgG2FaBdWTq8T0=; b=chFtjk
	/16fQay+yZN4WY46YMKCboIFOPUV1jlXQqRsvfQTxfQo5FC1ivAKmTAAsJpv+kHi
	b3U3GP19TRzzRQtx+ov/iXz8HRZE+4/IxAidC3pVVm3wqlyFFxrzzGvCkvW7XLYz
	U0Urgdfhynv/kilvB2TR1vHKJcGz1/SdJwkic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OrqYNiO4YVOlz3J6ud1YIwz0jmqCIsPU
	XR1ZshmJdxNaEC3SnyMNgD+AUJtp6X1BEVKjgYL1rbTQi5O/YfPLXerAo1IAk6ub
	YpwROaDSlfvb2s7uzii+k7x7cGyDse0OO89HoXcqniACcYnEbXWGPe48jKgRZnDz
	kdGHmdnRBws=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7E481FF1A;
	Tue, 10 Jun 2014 01:38:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 14F921FF14;
	Tue, 10 Jun 2014 01:38:16 -0400 (EDT)
In-Reply-To: <xmqqa99ld5sp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 Jun 2014 16:25:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6BB7D30E-F061-11E3-842A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251160>

Junio C Hamano <gitster@pobox.com> writes:

> Stepan Kasal <kasal@ucw.cz> writes:
>
>> It is sometimes desirable to insert several header lines at the top of
>> the body, e.g., if From or Date differs from the mail header.
>> (Linus even recommends to use this second header for all kernel
>> submissions.)
>>
>> send-email has a minimal support for this; make sure it is not applied
>> when there is a second header already inserted in the patch file.
>
> I have a slight suspicion that you are reading the recommendation
> wrong.  We do not recommend to record these in-body headers in the
> message of the commit object (the recommendation is to prepend
> in-body headers to the message of the commit object when sending it
> out for review---it pretty much assumes that the underlying commit
> does not have these in-body headers that are used only during the
> transit over e-mail forwarding chain).
>
> But your patch seems to assume that the input message to send-email
> already has the in-body header.  Doesn't that indicate a misuse of
> the tool, making this new "feature" smell more like a way to
> encourage such a misuse by covering up the result?
>
> I dunno.

I forgot to mention that possible enhancements. As you mentioned,
there is only a minimal support for this in send-email.  After you
committed somebody else's patch in your tree, format-patch will
produce the normal From: and Date: using the original author's
identity and timestamp, but send-email only uses the in-body header
for "From:" (but not "Date:") to propagate this information and only
when the author is different from yourself.  It is plausible that
two new options to tell send-email to optionally

 (1) propagate "Date:" in the output from format-patch as an in-body
     header; and

 (2) propagate "From:" in the output from format-patch as an in-body
     header even when you are sending out your own patch

would support the recent kernel submission convention better.
