From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 12:00:11 -0700
Message-ID: <7vwr1jiwn8.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
 <7v1ujrkc9p.fsf@alter.siamese.dyndns.org>
 <CAN0XMOKBPirJFzHM_QgDC8TGimoEhjWoAVA+JhaLzto4-SVvmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:00:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwHg5-0000id-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab2GaTAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:00:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab2GaTAO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:00:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 080358410;
	Tue, 31 Jul 2012 15:00:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nelmEFni5kVf9Oj0lAsKZsqKdU0=; b=mPykIH
	ko6WYQ8zR3r4XE2NeTuJoaYgj/e53iaqZ30IW9TCQOERrTVlwA2Q6VrRVMK4iwFN
	nQOpmEg4+YwH/KoEcwVSqSrXEEghVfjaWfAjuTWcOmH8MwJLSxFUJwfQZns1JjUs
	o5yBiRkiOqTtgFDpWrUO153wxweVDHm4kudeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fGAI7PcQFqZjL1ZDjsE7UXIyBzf4QQjC
	qBjFPIjhFER5bmbhm7gk1D2cH92/1Y+UZ/OZBQwjISTRV3zTDxbH3vG+FXQW/Hnh
	XpmDOp1NAmPobiKCCGfxducYFVWrnh7CXQh5wXV4rujdYN68JhoZ6uEDqQW9dXVo
	0A0SBo4K02A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9345840E;
	Tue, 31 Jul 2012 15:00:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48BA5840A; Tue, 31 Jul 2012
 15:00:13 -0400 (EDT)
In-Reply-To: <CAN0XMOKBPirJFzHM_QgDC8TGimoEhjWoAVA+JhaLzto4-SVvmw@mail.gmail.com> (Ralf
 Thielow's message of "Tue, 31 Jul 2012 20:55:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F55C2628-DB41-11E1-A500-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202670>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Tue, Jul 31, 2012 at 8:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +       /* Avoid iconv_open()/iconv_close() if there is nothing to convert */
>> +       for (i = 0; i < argc; i++) {
>> +               if (has_utf8(argv[i], (size_t)-1, NULL))
>> +                       break;
>> +       }
>> +       if (argc <= i)
>> +               return; /* no utf8 found */
>
> sorry, but "argc" can never be smaller than "i", right?

Yeah, but it is idiomatic to have an inverse of the exit condition
of the preceding for loop here to catch an early exit, and writing
it as "if (i == argc)", while technically correct, would break the
pattern.
