From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo = bar"
Date: Mon, 13 Oct 2014 14:56:18 -0700
Message-ID: <xmqqppdv1vnh.fsf@gitster.dls.corp.google.com>
References: <20141010060636.GA15057@peff.net>
	<20141010061114.GB15277@peff.net> <20141013161022.GA20520@google.com>
	<20141013211524.GB15969@peff.net> <20141013213132.GA32245@google.com>
	<CAPc5daX7UBvxCw60VUW4rUkKYbD8Do+=Nczq=z=ykoykZA+ywQ@mail.gmail.com>
	<20141013213808.GB32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:56:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnbQ-0006Q7-Ai
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbaJMV4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:56:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53536 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753124AbaJMV4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:56:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF49016B1B;
	Mon, 13 Oct 2014 17:56:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I/tJwCt6sgSx+OAjb+U2f6Z3fjE=; b=S0VLiu
	7RFsnEPic3PCVin7XTxhnkDjANwrlMEVJbHUpHy5NdvfRNrN52A8FvAXzy70iwrg
	UegDpURShf8idOzZyaUSHkYhAhrCCBLfj+1qMw2BENYLL4Hecf7g/FuqZUfvfOrc
	7zvnNCEBE17IloIkii2CSSVVzH/SH3L9gZBTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WhGrmOVb2E0RS7VI7UN0rtvw7B6V1M7F
	Aq2Pe2IN67Ilo+ykQXxKhp9gDdXjVdIdgs+pLMgXObcvM+xCrMNmEypMsdVtg0+8
	VpK3j0RHbqiV2GK1b7r44ReFR8T+zHnuqwT5BrWk4byf2E2sv/MiAyEaoqJgHS4X
	IvfRFCiF4aI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C68B816B1A;
	Mon, 13 Oct 2014 17:56:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 392AA16B19;
	Mon, 13 Oct 2014 17:56:20 -0400 (EDT)
In-Reply-To: <20141013213808.GB32245@google.com> (Jonathan Nieder's message of
	"Mon, 13 Oct 2014 14:38:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3D51E46-5323-11E4-B45F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> On Mon, Oct 13, 2014 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> It could segfault after producing the good output, but sure,
>>> count-objects code doesn't change very often.
>>
>> "Doesn't change very often" is not the issue. Here we are not testing
>> if it can count correctly without crashing, which *is* the real reason
>> why it is perfectly fine to use $(git count-objects | sed ...) pattern here.
>>
>> There of course should be a test for count-objects to make sure it
>> counts correctly without crashing.
>
> That also makes sense, but it is a pretty big change from the general
> strategy used in git tests today.

I would have to say that you are mistaken in reading what the
"strategy used today" is.  There is a subtle trade-off involved.

When we test, say, "git add a b", we may want to test these things:

    - "git add" when given addable paths a and b finishes without
      crashing;

    - "git add" will leave these paths in the index as expected.

And we write

	git add a b &&
	test_write_lines a b >expect &&
        git ls-files a b >actual &&
        test_cmp expect actual

NOT because we expect "printf" (which underlies test_write_lines) or
"git ls-files" could somehow misbehave and dump core, but primarily
because compared to an alternative, e.g.

	git add a b || return 1
        test_write_lines a b >expect
        git ls-files a b >actual
        test_cmp expect actual

it is far cleaner and easier to read with a rhythm.  It is just an
added bonus that we may catch errors due to filesystem quota when
writing to "expect" or ls-files crashing.  If the alternative had
enough advantage over the established pattern (and here is where the
trade off comes in---you need a certain taste to judge the
advantage), it is perfectly fine to trade the exit value off and
favor the advantage the alternative offers (e.g. a test that is
easier to read).

Between these two, it is very sensible to take A. over B.

    A.
	git create-garbage &&
	test $(git count-objects | sed ... | wc -l) = 0

    B.
	git create-garbage &&
	test_when_finished "rm -f tmp" &&
        git count-objects >tmp &&
        test $(sed ... tmp | wc -l) = 0

It will shift the trade-off if the more verbose alternative gets
wrapped into a helper that is well constructed, though, because
readability advantage of A over B melts away when we do so.
