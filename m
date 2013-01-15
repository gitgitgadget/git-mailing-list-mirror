From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] ignore memcmp() overreading in bsearch() callback
Date: Tue, 15 Jan 2013 08:55:32 -0800
Message-ID: <7vmwwa4c8r.fsf@alter.siamese.dyndns.org>
References: <7v38y38hhm.fsf@alter.siamese.dyndns.org>
 <20130115155043.GA21815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9np-0004z8-4V
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab3AOQzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:55:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65132 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab3AOQzf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:55:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09D53BD06;
	Tue, 15 Jan 2013 11:55:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=veJm5fxsLoyZIKfgEb67d2fCsms=; b=OCvD6+
	Ho35OfB2+WYTPfrUPfLzG+vyrtqHLowlA/EqGkehL6AOZyvfIE0n4o0F9HnDjW6t
	5ltZ+4y8lY6BKmgeHpW5+QQ9b2ngJWq2FXuw8N2njOTj4qK4XF04/6/pkIzDzAwh
	5XKaw24ClRk8T4sq5HG4y800n+lyvBpArvjM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcZWNhYqAjhTcrxfSqv1q+Q5Gn+DG0/t
	Om7wzxfAOBF/zW66+qlAmopP6iSj9/i2tNEC5WNKmOJY68XgiMMYl7XaF+0IEhNy
	CBPe4qSfsHuTQHaUM2+wNC84YCnQvo66Udc2kGylrNlcP990Tw+pT2SuNGe0u/1F
	boiDh0cqmNw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED1C8BD04;
	Tue, 15 Jan 2013 11:55:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EE57BD03; Tue, 15 Jan 2013
 11:55:34 -0500 (EST)
In-Reply-To: <20130115155043.GA21815@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Jan 2013 07:50:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60E86318-5F34-11E2-8136-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213649>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 14, 2013 at 03:36:21PM -0800, Junio C Hamano wrote:
>
>> It appears that memcmp() uses the usual "one word at a time"
>> comparison and triggers valgrind in a callback of bsearch() used in
>> the refname search.  I can easily trigger problems in any script
>> with test_commit (e.g. "sh t0101-at-syntax.sh --valgrind -i -v")
>> without this suppression.
>
> Out of curiosity, what platform do you see this on? I can't reproduce on
> glibc.

    Debian GNU/Linux 6.0.6 (squeeze), on Linux 2.6.32-5-amd64.
    libc-bin              2.11.3-4
    valgrind-3.6.0.SVN-Debian
    gcc                   4:4.4.5-1

>> diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
>> index 0a6724f..032332f 100644
>> --- a/t/valgrind/default.supp
>> +++ b/t/valgrind/default.supp
>> @@ -49,3 +49,11 @@
>>  	Memcheck:Addr4
>>  	fun:copy_ref
>>  }
>> +
>> +{
>> +	ignore-memcmp-reading-too-much-in-bsearch-callback
>> +	Memcheck:Addr4
>> +	fun:ref_entry_cmp_sslice
>> +	fun:bsearch
>> +	fun:search_ref_dir
>> +}
>
> Given that it is valgrind-clean on my platform, and reading the code I
> don't see any problems, I think it probably is a false positive, and
> this suppression makes sense.

Thanks for a sanity check.
