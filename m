From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re attr API further revamp
Date: Mon, 13 Jun 2016 14:54:56 -0700
Message-ID: <xmqqk2hsbvpr.fsf@gitster.mtv.corp.google.com>
References: <xmqqtwgwbygg.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYy4ic1nYgPEHLCfoUZYkzPw3bBq+8kTyRi13nNwQHGFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 23:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCZp5-0006q0-3t
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 23:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbcFMVzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 17:55:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964859AbcFMVzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 17:55:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B2CDC24954;
	Mon, 13 Jun 2016 17:54:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4i9F4b+ahvEPclnujiBbYNdPfA0=; b=wWHdE2
	+CK066EmVobtjjjJBx9fEShsa3nOaNc/NtqU+XMjBJC1M4hR2Gc0SdRtZLNX+Nqo
	jwmi0up0z3Ib1LkqZSWpyfBkcHbuX7NkKcpUY4SGAm2w8Q3UpLSKUsGBgMJPCKjK
	dM6RJIP+Jmf7QQa2ezBYhzqwzmb7QqSZYMGuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gNV/pilkPdQnw/0ZV2ojRvK0VJCoTO9y
	MCgAT7CukigZP5fQXzjwz1/qFiD/5JW0mt5s25SF6KTnzt2zK+IdUI/u9maoLSpq
	Q7pR958v7cRrt4LTcZblrtG2U9Vk++AITgF38zZE8ECnVEdVSDGGrcp8dIZ3N8FF
	EQqjIuajDW4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AA96B24953;
	Mon, 13 Jun 2016 17:54:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 309AE24951;
	Mon, 13 Jun 2016 17:54:58 -0400 (EDT)
In-Reply-To: <CAGZ79kYy4ic1nYgPEHLCfoUZYkzPw3bBq+8kTyRi13nNwQHGFw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 13 Jun 2016 14:31:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7881A176-31B1-11E6-8DE7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297247>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Jun 13, 2016 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I hate to be doing this, but we need yet another revamp to the attr
>> API that affects all the callers.
>
> So you don't mean origin/jc/attr-more by this?

Not really; the tip of attr-more needs to be discarded after this
realization, but otherwise there is no API revamping in what is
queued on that topic.

> (Given that we have jc/attr and jc/attr-more, the third thing could go
> with jc/even-more-attr. Though I do not propose that)

The latter was merely because I couldn't rewind and rebuild the
former during the pre-release freeze.  The fixup! in the latter will
be squashed into the former, etc...

>>         static struct git_attr_check *ccheck;
>>         const char *values[NUM_ATTRS];
>>
>>         git_attr_check_initl(&ccheck, "crlf", "ident", ..., NULL);
>>         git_attr_check(path, ccheck, values);
>
> and later on each thread will do a

This will have to do nothing; it is "static", and will be held to
the end of the lifetime of the program.

You _can_ allocate the check structure per thread and free them when
thread exits, but the usage pattern that appear in convert.c is
oblivious to the threading.
