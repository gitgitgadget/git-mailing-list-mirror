From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 08 Jun 2016 11:32:03 -0700
Message-ID: <xmqqr3c7lefw.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-5-samuel.groot@grenoble-inp.org>
	<xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Samuel GROOT <samuel.groot@grenoble-inp.org>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAiKa-0003Re-5e
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423538AbcFHScK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:32:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423307AbcFHScH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:32:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4F7E20A7B;
	Wed,  8 Jun 2016 14:32:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HbM4fLZQY0qfIkjmeIxDjMlv/g4=; b=v8f0Qx
	kPv+cuGLODXnnrQn5UMHDwDvKxt5oLn6ZQauW+R3leYI1Srcrbfb1rDSFJuWXGLQ
	XcSqpHwB8wg+m3DNKnCoLXhRbEcMg8rw3f9SoSZzcDGJ/vg6T+8B/23ZZgcic1XU
	TuA6ZJkjGYYizmR567JLKBxN3ZTw+/Tld2I80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnCJ3gYTqdYc3MQV9AMYCXQycen28/eh
	F5TWHxyAbOP+xm2pUDQE0tHOt/4bqgywrjhRUHsWhxOkxhcxbmAkMeiDxsRSGDlH
	fpdkPgdAqR4i+ZWCnLMB4cwXKA1ECOQjT/+hwrVTYXMJu7uHxNUW0Qjfikwd4e3k
	xf4TrS2S8Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C2C520A7A;
	Wed,  8 Jun 2016 14:32:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C86520A73;
	Wed,  8 Jun 2016 14:32:05 -0400 (EDT)
In-Reply-To: <CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 8 Jun 2016 14:12:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CC1C628-2DA7-11E6-A0DC-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296830>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>> +     # Separate body from header
>>> +     $mail{"body"} = [(<$fh>)];
>>> +
>>> +     return \%mail;
>>
>> The name of the local thing is not observable from the caller, but
>> because this is "parse-email-header" and returns "header fields"
>> without reading the "mail", perhaps call it %header instead?
>
> If there is (for some reason) a mail header named 'body', then this
> assignment of the body portion of the message will overwrite it.
> Perhaps this function should instead return multiple values: the
> header hash, and the message body.

Ah, I missed that it is attempting to return the body, too.

Because the function takes an open filehandle, I think it is better
to leave it to the callers.  A caller that is only interested in
headers can just close $fh after this helper returns without reading
body that it is not interested in, and a caller that wants to read
the body can do the slurping itself.
