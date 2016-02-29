From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv19 00/11] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 13:51:12 -0800
Message-ID: <xmqqsi0b89tb.fsf@gitster.mtv.corp.google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
	<1456444119-6934-1-git-send-email-sbeller@google.com>
	<56D4AE8A.2050403@kdbg.org>
	<xmqq1t7v9qou.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY5nxDQ_o0L_MOYFOx4FPH1apW-TuB88UypuwDaLuKGNQ@mail.gmail.com>
	<xmqqwppn8ba4.fsf@gitster.mtv.corp.google.com>
	<56D4B805.7090702@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:51:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVip-0001HL-V3
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbcB2VvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:51:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751293AbcB2VvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:51:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 232DE48DA0;
	Mon, 29 Feb 2016 16:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mgc7TiIvuESmWpx2ECre0ietBoo=; b=KyYt5G
	9ta9el8otKbn9kv3rPYHRJWNWeSy5c07483xuDwSoiRuJzXH3Gy9MJ682rfp9gz4
	kkbwXIs++s2fOgbgd29tQYHdxshGZR6zloiBpbD9wsCUxnCWsIfQ5bgICH31hrgc
	X1YD4ntxq1ehDPlaSVPBk5Wy5fMZ5cjJ8cFws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lWnW3G3I858cPpAYbaSCEFXOSKk7Kkyq
	F3PvOX8hGYfoj0Y8uQjgDbzVH0itE5PUXQYdy0CyI30bNTKdg1u6OT5AZn73YeIQ
	q9nWUeCVC5/VmW3eAaq+pZZzM8LyJxV58FHX54LTDkh47tPA3XLM6ntgGYqUDU40
	ElqWvRuAs3s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1ADAE48D9F;
	Mon, 29 Feb 2016 16:51:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A6A548D9A;
	Mon, 29 Feb 2016 16:51:13 -0500 (EST)
In-Reply-To: <56D4B805.7090702@kdbg.org> (Johannes Sixt's message of "Mon, 29
	Feb 2016 22:28:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D49A08E-DF2E-11E5-A496-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287913>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.02.2016 um 22:19 schrieb Junio C Hamano:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Maybe we want to remove the struct child_process from the
>>> function signature of the callbacks and callbacks need to rely on
>>> the data provided solely thru the pointer as passed around for
>>> callback purposes, which the user is free to use for any kind
>>> of data.
>>
>> I think that is the most sensible.
>
> I also think that is the better approach. Dumping out the argv array
> is not the best end-user experience. It is just a debugging aid, and
> for that we have (or should extend if necessary) GIT_TRACE
> infrastructure. Moreover, a command that failed should have printed
> error messages, and it is not necessary to follow it up with another
> "A child process exited with code N" message.

Exactly.  Stefan, please do not go in the route of butchering the
start_command(), finish_command(), etc. API set with the "uncleaned"
variants.

Thanks.
