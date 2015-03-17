From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Retry if fdopen() fails due to ENOMEM
Date: Tue, 17 Mar 2015 15:32:18 -0700
Message-ID: <xmqqlhivmf0t.fsf@gitster.dls.corp.google.com>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
	<54F9365E.2000705@web.de> <54FED916.6020607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:32:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY02E-0006Cm-EB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 23:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbbCQWcW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2015 18:32:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750958AbbCQWcV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 18:32:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 703E43F01A;
	Tue, 17 Mar 2015 18:32:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=y/gMcqdf4Gh9
	ZU4LoHbY2yAkvQU=; b=m9sfqFc/m+qQLwj7xZzkL57Ce1rixbos4xJJcTI2lA6e
	BMWxz8R3F2zHeXpWEoMh12OG1QSIFvqfkEOoDs2rFRWpabnHedKw1bzZlzgXzOZp
	/bgvMchPim+B7KagHF+Yti5f5CYpcfY1gAjVbufJmACCS1snlP8JbCgydkNRGU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XHRWx6
	Ac/03v9ELMv/IE8x7+f0OWIzWjSGS0j0iPVjBy7YmlW5qRVQzNi26xhDF3cS2hXg
	wRzFIk5YGqowXJoh9ORcz6K4U7BQ8+aLak96CRWH+vK9IDCq4dK5xebBqvbgxjRI
	H87R26TTTAVHsNMPL4H+SV6snpImS6dGMJoCo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 691663F019;
	Tue, 17 Mar 2015 18:32:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D48F73F018;
	Tue, 17 Mar 2015 18:32:19 -0400 (EDT)
In-Reply-To: <54FED916.6020607@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 10 Mar 2015 12:44:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 791B4CDA-CCF5-11E4-9FD7-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265673>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 03/06/2015 06:08 AM, Torsten B=C3=B6gershausen wrote:
>> On 03/05/2015 05:07 PM, Michael Haggerty wrote:
>>> One likely reason for fdopen() to fail is the lack of memory for
>>> allocating a FILE structure. When that happens, try freeing some
>>> memory and calling fdopen() again in the hope that it will work the
>>> second time.
>>>
>>> This change was suggested by Jonathan Nieder [1]
>>>
>>> In the first patch it is unsatisfying that try_to_free_routine() is
>>> called with a magic number (1000) rather than sizeof(FILE). But the=
 C
>>> standard doesn't guarantee that FILE is a complete type, so I can't
>>> think of a better approach. Suggestions, anybody?
>>=20
>> it's not the sizeof(FILE) which is critical, it is the size of the b=
uffer
>> associated with a FILE
>>=20
>> http://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdio.h.html
>>=20
>> BUFSIZ may be  your friend, and if it is not defined, 4096 may be a
>> useful default.
>
> Good point. If this patch series is not dropped as being useless, I w=
ill
> make this change.

OK, it has been a week since anybody mentioned this series.  What's
the verdict?  Taking what you said in $gmane/265228 into account, I
am taking the lack of reroll or follow-up as a sign of lost interest,
and if that is the case I'd drop the series before it hits 'next'.

Thanks.
