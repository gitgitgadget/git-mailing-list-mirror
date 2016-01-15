From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Fri, 15 Jan 2016 15:03:17 -0800
Message-ID: <xmqqlh7qfnt6.fsf@gitster.mtv.corp.google.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
	<xmqq4mehm92b.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka0rxYK7GRSjh13XOsg887EgqYtc5B60z9qU=tAoJGERQ@mail.gmail.com>
	<xmqqwpraiw15.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaBLmwfeMocKP+tQmqNLy0BDYTU9dFtMY6rmiTqNSi_Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDOu-0005o6-UK
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbcAOXDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:03:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750729AbcAOXDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:03:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7FA863C0EE;
	Fri, 15 Jan 2016 18:03:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jhq19Vxud24RsnoBbe7eufiEHC8=; b=hLXyiG
	TaHlXE03DJtDv9bKxxUYf4OAp7TDeKNuVeFpekWPDDiMLvjWSGmNoGISQyvmX9VG
	SfiAJLRdMJR+ztTzftVurNmu4zIdkaZbdzUhtPDZ8L6jErmNoVVcer6Cx5gXppcV
	/1/vy144QBvz8HKuS49Pn4qYdq1UQUFyZUr5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x42GnIIOsz4Ea4ZT7YF3LL1SGx9TtIQE
	Oyd1VObFo6PBWA9A88YGbv9FX9PiKWIbf5a+4IPiOKqCpxqJiOIuRR8TqZ9YbD/T
	acQ1R/Y/6rnzFOy9VB4MrEuYMqNw88ChWMRMHh+KpYUVWZH/wngeG2f3z9zbUGy4
	KUzrimwMmrA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C7B33C0EC;
	Fri, 15 Jan 2016 18:03:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C36F03C0EB;
	Fri, 15 Jan 2016 18:03:18 -0500 (EST)
In-Reply-To: <CAGZ79kaBLmwfeMocKP+tQmqNLy0BDYTU9dFtMY6rmiTqNSi_Dg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 15 Jan 2016 14:58:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2ABBF3EC-BBDC-11E5-8BFE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284228>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jan 15, 2016 at 9:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> It is somewhat hard to see how this avoids stripping one (or both)
>>>> slashes just after "http:" in remoteurl="http://site/path/", leaving
>>>> just "http:/" (or "http:").
>>>
>>> it would leave just 'http:/' if url were to be ../../some/where/else,
>>> such that the constructed url below would be http://some/where/else.
>>
>> Is that a good outcome, though?  Isn't it something we would want to
>> catch as an error?
>
> I would want to add theses checks later and for now
> just port over the code from shell to C. (The same issue
> is found in the shell code and nobody seems to bother so far)

Understood and I think that is a good direction to go.  Perhaps
leave a comment in the area to document it as a known bug (or a
NEEDSWORK) to make it more obvious and to help remember it?

Thanks.
