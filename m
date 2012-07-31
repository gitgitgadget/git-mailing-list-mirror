From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] macos: lazily initialize iconv
Date: Tue, 31 Jul 2012 11:19:49 -0700
Message-ID: <7v6293kd2y.fsf@alter.siamese.dyndns.org>
References: <7vk3xjked0.fsf@alter.siamese.dyndns.org>
 <CAN0XMOL6m0B0bLwdp9mviOLqYORGcnf9LMS5=+WkXhGinBrzgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 20:20:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwH3A-0007HW-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 20:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab2GaSTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 14:19:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037Ab2GaSTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 14:19:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12B497872;
	Tue, 31 Jul 2012 14:19:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TFcJP70tD4Pzs27/o1s4rxg+um0=; b=MY/ZVp
	VesYwk1Y5umD2GxnQlf+MIKjRz3Do/WkzztzRIMSjXTCNvFN7AsScob6geEVnXGM
	0bR6cnN8B7tMQLVvSmxjVPQQG7IrRgVOJ/voeIX6/3Sy0VNV5XnPbKZuCTaY7lMv
	AxqZX5JcnSG/ddfMUJGFcHMULGMtUTjwsK4fI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7YXsTblicRH4Ys5tg8GxaAyVf29lzbc
	cMBZko9zBhxETaHOscQirhRkcS0ezUpaOJSZfXeCjpCgZPrsY4Rj0fB0UreGMEQa
	v7HoEdjKiuuC3JbAcBU/44gfvE9Dfq6pCGJuhPICTWwWcoYvtMbp67zjrqNl9Uyf
	53NaUMC+Q1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E237871;
	Tue, 31 Jul 2012 14:19:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E91C7870; Tue, 31 Jul 2012
 14:19:51 -0400 (EDT)
In-Reply-To: <CAN0XMOL6m0B0bLwdp9mviOLqYORGcnf9LMS5=+WkXhGinBrzgA@mail.gmail.com> (Ralf
 Thielow's message of "Tue, 31 Jul 2012 20:10:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51C11672-DB3C-11E1-9079-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202666>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Tue, Jul 31, 2012 at 7:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +       /* Avoid iconv_open()/iconv_close() if there is nothing to convert */
>> +       for (i = 0; i < argc; i++) {
>> +               if (has_utf8(argv[i], (size_t)-1, NULL))
>> +                       break;
>> +       }
>> +       if (i < argc)
>> +               return;
>> +
>
> I'm not very familiar with this code but:
>
> before: it reencodes everything which is utf-8 in argv
> after: it reencodes *nothing* if one string in argv is not in utf-8
>
> am i wrong?

You are right.  It should avoid the whole iconv thing if we saw _no_
utf8, i.e. the last two should be:

	if (argc <= i)
        	return;

Thanks.
