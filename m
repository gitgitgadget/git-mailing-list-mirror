From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized mmfile_t
Date: Tue, 16 Feb 2016 13:27:07 -0800
Message-ID: <xmqqmvr0mjmc.fsf@gitster.mtv.corp.google.com>
References: <56C2459B.5060805@uni-graz.at>
	<20160216011258.GA11961@sigill.intra.peff.net>
	<20160216050915.GA5765@flurp.local>
	<20160216055043.GB28237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan =?utf-8?Q?Fr=C3=BChwi?= =?utf-8?Q?rth?= 
	<stefan.fruehwirth@uni-graz.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 22:27:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVn9Q-0000Rl-5q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 22:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbcBPV1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 16:27:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56395 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755140AbcBPV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 16:27:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE3F3459DD;
	Tue, 16 Feb 2016 16:27:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/zHLme/2i5gKyn3golzYzS48cXs=; b=AeNBVA
	EjDUyhJqkTbLY8/pNF0BRxjyhyfSkyNfBVhrp5A4y+Aylqs25Hc5LqFJjvjSUYyd
	9aJdZ7N11Cld+srxRvJoqiRq+mgXT1NUxjsYvo7avBUDcZQ1m7wdxXZ6nZQ68ABf
	71Kp0E87gKTEXOYwwUF+pLpGuhUbIJG5LlEM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HIKyXsb6qnF7vb5qSWXkn0t+AniZ2y2s
	U6QT/uuO4K6rXOqxiJQuRioQlMlqUB2u0rvHOwRBpnF3eN2ej2Z6SWxE3ZWG1H7u
	cdRSbzDR5njKM/vM9xn2AFGQVYOOaUG/Qra1h0Wtfv2fkxMIyO1TRGpD+7TgVwVU
	F5ni/d+QQ9g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5E2C459DB;
	Tue, 16 Feb 2016 16:27:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2A9DD459D8;
	Tue, 16 Feb 2016 16:27:08 -0500 (EST)
In-Reply-To: <20160216055043.GB28237@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 16 Feb 2016 00:50:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0859C794-D4F4-11E5-98F4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286435>

Jeff King <peff@peff.net> writes:

> Yeah, maybe. There were two reasons I avoided adding a test.
>
> One, I secretly hoped that by dragging my feet we could get consensus on
> just ripping out merge-tree entirely. ;)
>
> Two, I'm not sure what the test output _should_ be. I think this case is
> buggy. So we can check that we don't corrupt the heap, which is nice,
> but I don't like adding a test that doesn't test_cmp the expected output
> (and see my earlier comments re: thinking hard).

Three, I know the existence of the program is not more than "we
could do something like this" illustration by Linus, and its output
is in no way _designed_ to be so.  We know today that it does not do
add/add conflict correctly thanks to this thread, but if we are
going to keep this program, we'd need to start from really designing
what its behaviour _should_ be, before casting the desirable
behaviour into stone with tests.

> But if we are going to keep it, maybe some exercise of the code is
> better than none.

So, "exercise" is better than none in the sense that it would
validate that "the command does something without barfing", but I
think there is a downside to casting its current behaviour as the
expected output in stone, if we are going to keep it.
