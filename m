From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: emulate write(2) that fails with a EPIPE
Date: Wed, 16 Dec 2015 12:36:21 -0800
Message-ID: <xmqqmvtacere.fsf@gitster.mtv.corp.google.com>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
	<CAPig+cQzCHtyVs47=ASs5V2BSV7gpVszbdTFydiRhnz3gtD2Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 21:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9IoG-0001YK-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 21:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755370AbbLPUgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 15:36:24 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855AbbLPUgX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 15:36:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1683B33B2F;
	Wed, 16 Dec 2015 15:36:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RwlD9oaa8+hOsNKOXBJDirUtCQ0=; b=meEeCH
	hoXKxav40saNYdaOttj9bPShktKZquwoNEHGv1fqYjgVz5y6Cl4eT/YuaaSpX0JI
	bBwPcf+22sxcwfIGCALd1rQpQAUVrOm7KlVfSsWwGKUDOyj+FJlWDgk8OOGx7UX4
	9ODaV84h3YTHqwpGzvclotgzUuITQ2VC+M5p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLt+GKlM+Q+UR+4uKO5MwGH2wGYlYkwX
	H5s+cnzRnXFiDgMYV/QEwR1ZjYKpe5deGYPilt8jwPDmy6zU74TSIhvFY4ivKTJu
	pTslSLaPIHs3+tQbFd0toUSfgGXAUTx+WIEtYQKe/ddErjT9dSuiwZB059eypRwp
	yfOGy4jUJ6A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E83033B2E;
	Wed, 16 Dec 2015 15:36:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F6DF33B2D;
	Wed, 16 Dec 2015 15:36:22 -0500 (EST)
In-Reply-To: <CAPig+cQzCHtyVs47=ASs5V2BSV7gpVszbdTFydiRhnz3gtD2Qw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 16 Dec 2015 14:47:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB63B56C-A434-11E5-8875-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282587>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       if (result < 0 && errno == EINVAL && buf) {
>
> Here, errno is EINVAL...
>
>> +               /* check if fd is a pipe */
>> +               HANDLE h = (HANDLE) _get_osfhandle(fd);
>> +               if (GetFileType(h) == FILE_TYPE_PIPE)
>> +                       errno = EPIPE;
>> +               else
>> +                       errno = EINVAL;
>
> Does any of the code between the outer 'if' and this point clobber
> errno, or are you merely assigning EINVAL for robustness against
> future changes?

I do think it is a good idea to reassign 'errno' here to stress on
the fact that we return EPIPE only when we positively know that we
were reading from a pipe, and otherwise we won't change the original
errno at all.

But at the same time, if other things that are called before we
figure out if we were reading from a pipe could affect errno, I
wonder if that is an indication of a bug--an error return from
system functions that the code is not responding to.  For example,
can _get_osfhandle() fail and when it does what would we see?
Perhaps NULL in h?
