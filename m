From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 16:34:07 -0700
Message-ID: <xmqq383jvndc.fsf@gitster.dls.corp.google.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
	<20150428061741.GL24580@peff.net>
	<CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
	<20150428201918.GA10902@peff.net> <20150428203400.GN5467@google.com>
	<20150428203645.GA11473@peff.net> <20150428204213.GO5467@google.com>
	<20150428204853.GA12153@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	erik =?utf-8?Q?elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 29 01:34:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnF16-0007X0-EV
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 01:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031120AbbD1XeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 19:34:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030957AbbD1XeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 19:34:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30A184D6BE;
	Tue, 28 Apr 2015 19:34:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xf2peBNhNSQKYtLgXZde9dVTeeo=; b=dhvdLm
	E6aMOvdHSMkqcvdVxwa/CNZBm7sHJuaZ+eqq5RCbAaLTx5Udoi3SbBO/rWjFjbRy
	ueu6dhJ5E/7eUSgxk0+Hcok0lx1AJPiBfaEj4ylok2X9tjMUlzeaK+3KuSk/giSp
	RFiPlXTk6m+IaW0LngNtvBF/s9jzXbMG10XaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NNzuCxHqynRnlhpwxbpseb6o1RmRxLCu
	lu7X6TExj11/0LGztyrvtahNCGdV08Jnpi2mg1m/uencPT2O9GZbq1WaRqu5M+j9
	UEexpGlMBKeoj35N4tAzvVCdOXF7CX+4UrEbBd0Ulgx0c5HPM/wohXRPtGHmFJK0
	9M3HuzhmIEI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A9364D6BD;
	Tue, 28 Apr 2015 19:34:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AE834D6BB;
	Tue, 28 Apr 2015 19:34:08 -0400 (EDT)
In-Reply-To: <20150428204853.GA12153@peff.net> (Jeff King's message of "Tue,
	28 Apr 2015 16:48:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 110D0E82-EDFF-11E4-A12D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267950>

Jeff King <peff@peff.net> writes:

> Yes, I agree converting the integer back into a string later does not
> always carry all of the data. OTOH, the caller can often supply the
> context (i.e., this is basically how "errno" works). This gets back to
> the idea we discussed a while ago of having a "struct error" that can
> carry the code and the parameters (or if you like, the code and a
> finished error message). It just feels in some ways like that ends up
> with the worst of both worlds (a lot of boilerplate for integer codes,
> _and_ the allocation and cleanup issues associated with a string error
> message).
>
> I dunno. I'd be interested to see a rough draft of an idea applied to a
> specific callsite.

For this specific callsite, I think the error code alone is the
right way forward. It conveys all information necessary out of the
callee back to the caller, so that the caller, when it decides to do
so later, can turn error code to human readable form.

For some callsites, there may be cases where carrying a centrally
produced string may be a handy way to grab detailed error message
out of a deep call chain, but even in such a case, it is likely that
we would need a separate error code, and a funtion that returns a
pointer as its primary return value would need "two" extra out
parameters, one for message and one for code.
