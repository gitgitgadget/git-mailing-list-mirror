From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: add an option to suppress commit hash
Date: Mon, 07 Dec 2015 11:47:19 -0800
Message-ID: <xmqqmvtmm46w.fsf@gitster.mtv.corp.google.com>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
	<1449440196-991107-3-git-send-email-sandals@crustytoothpaste.net>
	<xmqqr3iym4rg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:47:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61kt-00037E-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbbLGTrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:47:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932543AbbLGTrW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:47:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D4BEE3110E;
	Mon,  7 Dec 2015 14:47:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=24b709s/dNnKqYLtkdm9FTo/GDg=; b=WEEy6W
	1VeTtmZBFe2H0tbKt0S7IdDH5n4LkXmrJOKQe1aJfbP+ZSxhsSGI1ZnPVpgk3bwE
	aZTVNYySg5zblP3pCYENXZLEzEgQPvRNqqXgsvfptGlwNee4j/GAXDKlzIfbT6BD
	nhE8AYgsctAGSk7ZYiHDFqtrOwYd0wP1YBUEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WiIQhzjqTepqqtbTe1r2MdsN4iCEBkOC
	pq8ZffViDHnfhyRNOUmw6elDOMlvQSUWt4MHT20rdx71KDIFM2wfk4UTXt2csQ0V
	nZvE0CbzN9aYBZNZqZYoxUlfzU4nq5grdI91yjZip5IPmAZgINnV5DA67ngD206q
	35busqk7eGw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC6CA3110D;
	Mon,  7 Dec 2015 14:47:21 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CF243110C;
	Mon,  7 Dec 2015 14:47:21 -0500 (EST)
In-Reply-To: <xmqqr3iym4rg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 07 Dec 2015 11:34:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 547F26F2-9D1B-11E5-86B9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282111>

Junio C Hamano <gitster@pobox.com> writes:

>> +--no-hash::
>> +  Output an all-zero hash in each patch's From header instead
>> +  of the hash of the commit.
>> +
>
> Two (big) problems with the option name.
>
>  - "--no-something" would mislead people to think you are removing
>    something, not replacing it with something else.  This option
>    does the latter (i.e. the first line of your output still has
>    40-hex; it's just it no longer has a useful 40-hex).
>
>  - There are many places we use hexadecimal strings in format-patch
>    output and you are not removing or replacing all of them, only
>    the commit object name on the fake "From " line.  Saying "hash"
>    would mislead readers.

I am not good at bikeshedding, but you used 'zero_commit' elsewhere
in the code.  I think that would be a much better name--perhaps use
that consistently throughout, as the local variable in options[]
array and end-user facing option name?

>
>> +test_expect_success 'format-patch --no-hash' '
>> +	git format-patch --no-hash --stdout v2..v1 >patch2 &&
>> +	cnt=$(egrep "^From 0+ Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&
>
> Don't test "any number of '0'"; test 40 '0's.  This is because the
> line format was designed to be usable by things like /etc/magic to
> detect format-patch output, and we want to notice if/when we break
> that aspect of our output format.
>
>> +	test $cnt = 3
>> +'
>> +
>>  test_done
>
> Thanks.
