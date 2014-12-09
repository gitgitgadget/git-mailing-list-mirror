From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Tue, 09 Dec 2014 14:41:51 -0800
Message-ID: <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 23:41:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyTTi-0003vr-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbaLIWly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 17:41:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751595AbaLIWlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 17:41:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18E7F25707;
	Tue,  9 Dec 2014 17:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=88vN+NGP1W5M4JwnX97ouDe00j0=; b=YqLJwW
	OFhvBNfZ/ezsaIr9Wv+F+1zC/1EQDFqCuHr6hrp9CzaVPNyuBZ+Vw70pqgTo5bCP
	GRuDvhKdvBlOsDEzNOKw7YdmqSRxwR1Otygou/8WqpO0MpMfS0tmyW2uvekESU3C
	H9CILstAvCOHrFqXvIJ0A6fRZxVJ9c5KD7z3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oKeApBOuyTkoCnoLwmeHH1zG1pBVSXvX
	kWqLKgEPey0AzPaYouSOXJZjNEpQlm707jHjesHfiM7lxJZpBTUq2iHu7LgsBiSy
	mHJ3q4jcSGYCVKF+AkO9kRQ2mmUozZV65cXpJRoYdL8zG9f5VEcdMVSzWv0a/ZjW
	kYhOwBMVQEY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 106ED25706;
	Tue,  9 Dec 2014 17:41:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C74E25705;
	Tue,  9 Dec 2014 17:41:52 -0500 (EST)
In-Reply-To: <20141209180916.GA26873@peff.net> (Jeff King's message of "Tue, 9
	Dec 2014 13:09:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91F0C378-7FF4-11E4-B344-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261171>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 09, 2014 at 12:49:58PM -0500, Jeff King wrote:
>
>> Another option would be to use a static strbuf. Then we're only wasting
>> heap, and even then only as much as we need (we'd still manually cap it
>> at LARGE_PACKET_MAX since that's what the protocol dictates). This would
>> also make packet_buf_write more efficient (right now it formats into a
>> static buffer, and then copies the result into a strbuf; probably not
>> measurably important, but silly nonetheless).
>
> Below is what that would look like. It's obviously a much more invasive
> change, but I think the result is nice.

Yes, indeed.  Is there any reason why we shouldn't go with this
variant, other than "it touches a bit more lines" that I am not
seeing?

> Let's switch to using a strbuf, with a hard-limit of
> LARGE_PACKET_MAX (which is specified by the protocol).  This
> matches the size of the readers, as of 74543a0 (pkt-line:
> provide a LARGE_PACKET_MAX static buffer, 2013-02-20).
> Versions of git older than that will complain about our
> large packets, but it's really no worse than the current
> behavior. Right now the sender barfs with "impossibly long
> line" trying to send the packet, and afterwards the reader
> will barf with "protocol error: bad line length %d", which
> is arguably better anyway.

Anything older than 1.8.3 is affected by this, but only when the
sending side has to send a large packet.  It is between failing
because the sender cannot send a large packet and failing because
the receiver does not expect such a large packet to come, and either
way the whole operation will fail anyway, so there is no net loss.
