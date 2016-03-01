From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Tue, 01 Mar 2016 11:44:24 -0800
Message-ID: <xmqqio166l0n.fsf@gitster.mtv.corp.google.com>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de>
	<d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de>
	<56D5EEE2.3080100@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:44:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaqDg-0000VZ-Sz
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 20:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbcCATo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 14:44:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752234AbcCATo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 14:44:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 35F6548B28;
	Tue,  1 Mar 2016 14:44:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e1Ok3P946M9asUf+BmRlUKfNBa0=; b=cFG0VO
	PzjCu9l+TFgnyHM61PmAAeRcEzvfm6tZS21/p9+lMzLPJAfMJkXy8fnZ5nNkWcC5
	Ke2ahqCNVKEphgpou2iKhlQ36EcQXyOCGojTIcYtBldLk1YXpI8IqZkIDmzTZfMY
	khCKOaq+9/1jQsbcJ7cfQYogyw60YGZebk4tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xRUDcNbSfzpYIkCXM/JLCDZPvd8gSqo1
	qHeFfswVDJ+3KSL5OyCz7a95POztnSrQ2+QZQxipgUbPUrOJciAxEP/cSLHZuFOw
	IV+84wTZLbLIdXNvekc0X/+xr+NIku/bWcYTiSrgc4dwmhmK8igwR1BFEx77b/Nl
	w/tLkaQhLB0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D9FD48B27;
	Tue,  1 Mar 2016 14:44:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D5CA48B26;
	Tue,  1 Mar 2016 14:44:25 -0500 (EST)
In-Reply-To: <56D5EEE2.3080100@kdbg.org> (Johannes Sixt's message of "Tue, 1
	Mar 2016 20:34:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00FAED64-DFE6-11E5-A546-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288058>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 01.03.2016 um 15:13 schrieb Johannes Schindelin:
>> The pthread_exit() function is not expected to return. Ever. On Windows,
>> we call ExitThread() whose documentation claims: "This function does not
>> return a value.":
>>
>> 	https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659
>
> This is misleading: MSDN marks all functions declared void as "does
> not return a value," for example, look at EnterCriticalSection:
>
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms682608
>
> For this reason, I actually prefer your version 1 patch without the
> explanation.

;-)

>> -static inline int pthread_exit(void *ret)
>> +static inline int NORETURN pthread_exit(void *ret)
>
> I would have written it as
>
> #ifdef __GNUC__
> __attribute__((__noreturn__))
> #endif
> static inline int pthread_exit(void *ret) ...
>
> but I can live with your version as long as it compiles.

Either way, let's make sure that the final version returns "void",
cf.

http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_exit.html

Thanks.
