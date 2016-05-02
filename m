From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL handling code
Date: Mon, 02 May 2016 16:14:57 -0700
Message-ID: <xmqq37q0qcge.fsf@gitster.mtv.corp.google.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462082573-17992-3-git-send-email-mh@glandium.org>
	<5726DE16.3030402@web.de> <20160502083133.GA20929@glandium.org>
	<57273A0B.5050409@web.de>
	<xmqqfuu0qfo4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 01:15:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axN3d-00044O-OL
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbcEBXPM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 19:15:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52106 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755254AbcEBXPL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 19:15:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 03D3A178C6;
	Mon,  2 May 2016 19:15:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aM3ho0i4CE0m
	uaHVdyo/7xwqK9k=; b=xNsOR/VcqZ8+sK6tt3kM/09Q/Z2Mw+kRNLgX3m/YB80i
	wwMGb3YZ6eAAghUHRgmDyT9lkihVfdFSHFdUAJRcD4J+0l1x0E1QnsXaS0eS/rZq
	AeK01L/nm7k4khTg4YVVZYMPcLQU+VlQ5N3yGky1cRqBiVITPFmkUBuzn5se22I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aq2c9y
	mZFY7NEOEB5XmvNa8elkgXlQiPk2AdvNu9+mNVzRxI8H8uT7Zjk9dLU1sN71gg5y
	doVBtrELeiYqkTycZvvUYfvblPNHFPw/IjnlIBV+XxhaGXKnyxc4jWesUOimHSKu
	0FEbqRtmq7p6yDheL7yHN9bsQct+xMt6B+XlI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EF2DF178C0;
	Mon,  2 May 2016 19:14:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65344178BA;
	Mon,  2 May 2016 19:14:59 -0400 (EDT)
In-Reply-To: <xmqqfuu0qfo4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 02 May 2016 15:05:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0E78880-10BB-11E6-AB1A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293301>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> git://host:[port]/path/to/repo
>> Knowing that, the "@" will be feed into the name resolver,
>> and that's OK.
>
> Is it OK?  It is plausible that our client side may even want to
> accept git://user:pass@host:port/local/part, and as an anonymous
> service, allow it to go to git://host:port/local/part without
> sending user:pass part over the wire.  Or with the same knowledge
> that git:// is an anonymous service, it is also a plausible policy
> to error such a request out.  To implement either needs a robust
> parsing of the URL, doesn't it?

To put it differently, there is a vast difference between

 (1) knowing that xx@git.kernel.org is asking to access
     git.kernel.org as user 'xx' and failing because of a policy
     that says "we do not send auth material over the wire when we
     know we are doing anonymous access"; and

 (2) not caring the distinction between xx@git.kernel.org and
     git.kernel.org, and implicitly relying on the DNS to forbid '@'
     in the hostname and to return a look-up failure when the whole
     string of the former is taken as a hostname in order to fail
     that request.

If we want to fail the request, we should be in control of the
policy to fail.  Even in an unlikely (and impossible) world where
suddenly resolver starts allowing "xx@git.kernel.org" as a host, we
do not want to be making a connection to a bogus host that is not
what the end user requested, i.e. git.kernel.org.

Otherwise we cannot change the policy to allow it in the future if
it turns out to be necessary.
