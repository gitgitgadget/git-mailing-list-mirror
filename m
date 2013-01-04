From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Fri, 04 Jan 2013 14:20:52 -0800
Message-ID: <7vsj6gsi7v.fsf@alter.siamese.dyndns.org>
References: <20130104124756.GA402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bart Trojanowski <bart@jukie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 23:21:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrFdb-0003RW-CO
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 23:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab3ADWU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 17:20:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357Ab3ADWUz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 17:20:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AAFCB0A6;
	Fri,  4 Jan 2013 17:20:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5i6WfTxavR6x0RsWZ8CbzqZNn1o=; b=IynO49
	hjMKMctJbwqSp81rlNb+fXs8H0YzpNvKd6UGf7nZiRlC3x2r4pDjBEYaNTbCXD49
	t07YOMAVLfS112U4WXCYGio6GlMcyvEeo2QQqnAM75EV2JeyZ879PnaH6IPdMeNm
	jbB2o0xFdOvBIqvhcW7TWZruL7E2BEJ1Wl6LA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=putJqRjSZHAOROcE5eajclS9DIt2oVQx
	lg9XpjSakLP2l9NPmukKK2sVvHCSQL1nrLwsat1sOOPegStpdyWF7lh1VJdoNzX7
	adQmcL8snzmpk+B8GntN2KqmGemHqFYtLuGzvTlrv64hakWKJ7x+p9dPttZpelbD
	/BEPUW2o2Eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C462B0A5;
	Fri,  4 Jan 2013 17:20:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B740B0A1; Fri,  4 Jan 2013
 17:20:53 -0500 (EST)
In-Reply-To: <20130104124756.GA402@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 4 Jan 2013 07:47:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01068FEE-56BD-11E2-9CAB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212650>

Jeff King <peff@peff.net> writes:

> I have two reservations with this patch:
>
>   1. We are ignoring SIGPIPE all the time. For an alias that is calling
>      "log", that is fine. But if pack-objects dies on the server side,
>      seeing that it died from SIGPIPE is useful data, and we are
>      squelching that. Maybe callers of run-command should have to pass
>      an "ignore SIGPIPE" flag?

What should this do:

    GIT_PAGER='head -n 1' git -p -c alias.o='!cat longfile' o

Should it behave just like

    cat longfile | head -n 1

or should it behave differently?

I am having a feeling that whatever external command given as the
value of alias.$cmd should choose what error status it wants to be
reported.

>   2. The die_errno in handle_alias is definitely wrong. Even if we want
>      to print a message for signal death, showing errno is bogus unless
>      the return value was -1. But is it the right thing to just pass the
>      negative value straight to exit()? It works, but it is depending on
>      the fact that (unsigned char)(ret & 0xff) behaves in a certain way
>      (i.e., that we are on a twos-complement platform, and -13 becomes
>      141).

Isn't that what POSIX.1 guarantees us, though?

    The value of status may be 0, EXIT_SUCCESS, EXIT_FAILURE, or any
    other value, though only the least significant 8 bits (that is,
    status & 0377) shall be available to a waiting parent process.
