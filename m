From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Fri, 10 Aug 2012 11:18:24 -0700
Message-ID: <7vsjbuk3v3.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
 <7v1ujrkc9p.fsf@alter.siamese.dyndns.org> <50253A1E.20706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sztn6-0005NJ-St
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759642Ab2HJSS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Aug 2012 14:18:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759614Ab2HJSS1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 14:18:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 389F79484;
	Fri, 10 Aug 2012 14:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FJT8E3cmDrIb
	0H9w0Zz+eBFTAGk=; b=ouLOWl7XzmP3DLWeeGzuQ6qcw0xcAwr6CbAR+XAa/Irg
	UyLF4SJI1aQoGdyNv6y/i4U0IhZxyfO4QDXWiSFLxEQeVVvNpsM2a3bGD+boNdKx
	C+bKCV03QJhXAqtMXHSILwNeJiAZrhFiEcilLnzpbFfh6Z/MD42aj9j5a+jzJME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ByHXcT
	j/sGvH5SugnVdNtmBrvQVl2yjINLKlNOFi/8HIth21gj+aahqJuEwF3gxDsQoODl
	tlVCWuEjjIEVxUatPGkLkkysj9cCepC+IsrViXZuY4cmkfwDFNC+yUoxoOgWyT7/
	aO1ugox4K7C9+rzAxvtkhu+HASUrFntuuNoWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 262489483;
	Fri, 10 Aug 2012 14:18:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80ACF9481; Fri, 10 Aug 2012
 14:18:25 -0400 (EDT)
In-Reply-To: <50253A1E.20706@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Fri, 10 Aug 2012 18:43:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6B55EBA-E317-11E1-8846-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203244>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 31.07.12 20:37, Junio C Hamano wrote:
>> In practice, the majority of paths do not have utf8 that needs
>> the canonicalization. Lazily call iconv_open()/iconv_close() to
>> avoid unnecessary overhead.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Ralf Thielow <ralf.thielow@gmail.com>
>> Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
>> ---
>>
>>  * This is not even compile tested, so it needs testing and
>>    benchmarking, as I do not even know how costly the calls to
>>    open/close are when we do not have to call iconv() itself.
>> ...
> Hi Junio,
>
> thanks for the optimization.
> Tested-by: Torsten B=C3=B6gershausen <tboegi@web.de>

Well, I didn't mean the correctness testing without numbers.  The
correctness of the patch after a couple of people eyeballed it was
no longer a question.

If the patch does not give any measuable performance difference to
people who exercise this codepath, it is not worth merging.  And
that is not something I can't do myself without a Mac (nor I wish to
have one to be able to do so myself).

Thanks.
