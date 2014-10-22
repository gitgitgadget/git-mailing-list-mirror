From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Wed, 22 Oct 2014 10:11:40 -0700
Message-ID: <xmqqfveghvw3.fsf@gitster.dls.corp.google.com>
References: <1413884908.4175.49.camel@seahawk>
	<20141021144838.GA11589@seahawk>
	<xmqqd29l1f3p.fsf@gitster.dls.corp.google.com>
	<1413963706.11656.5.camel@seahawk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 19:12:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgzS9-00022D-NW
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 19:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbaJVRMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2014 13:12:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753411AbaJVRLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2014 13:11:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E900C17E2A;
	Wed, 22 Oct 2014 13:11:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TLu/CNtXi6Bys+KXS0IfCJHsaUM=; b=tSDa91
	x8ZpHzTeGduCGbFpJnrSCx7cQQgtvYeNBeSK63j/63g5GctB98g4CX9BI0KiiEyM
	8k+MPXpQRQvh7Z3n802ZXXOSQfxKxB1nQrj+UlBvzRMmcyoKw3s0hZaMoXEYpV33
	3ceWJUVcAy3uAbqGi9UzKXEQSSsUmIkR5pEYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=suNQC5EUylO6CLcx3mfyqvdogW32ijt5
	mjMjvxPS5WFRanaxVUByjlciZ3gpJgvhLWAobdZUDgIIaqWksqfgut45BKDHVuea
	cGqb2hc8+GfBnce+NIAi6TBbSm/NNrAaXTalDQyvUUpfAsVfcOw2Zw4PRZW4xzm7
	04K43Wg/QeI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF53117E29;
	Wed, 22 Oct 2014 13:11:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D45517E27;
	Wed, 22 Oct 2014 13:11:42 -0400 (EDT)
In-Reply-To: <1413963706.11656.5.camel@seahawk> (Dennis Kaarsemaker's message
	of "Wed, 22 Oct 2014 09:41:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E5B5942-5A0E-11E4-B4A5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On di, 2014-10-21 at 10:56 -0700, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>> 
>> > By not clearing the request buffer in stateless-rpc mode, fetch-pack
>> > would keep sending already known-common commits, leading to ever bigger
>> > http requests, eventually getting too large for git-http-backend to
>> > handle properly without filling up the pipe buffer in inflate_request.
>> > ---
>> > I'm still not quite sure whether this is the right thing to do, but make
>> > test still passes :) The new testcase demonstrates the problem, when
>> > running t5551 with EXPENSIVE, this test will hang without the patch to
>> > fetch-pack.c and succeed otherwise.
>> 
>> IIUC, because "stateless" is just that, i.e. the server-end does not
>> keep track of what is already known, not telling what is known to be
>> common in each request would fundamentally break the protocol.  Am I
>> mistaken?
>
> That sounds plausible, but why then does the fetch complete with this
> line removed, and why does 'make test' still pass?

The fetch-pack program tries to help the upload-pack program(s)
running on the other end find what nodes in the graph both
repositories have in common by sending what the repository on its
end has.  Some commits may not be known by the other side (e.g. your
new commits that haven't been pushed there that are made on a branch
forked from the common history), and some others may be known
(i.e. you drilled down the history from the tips of your refs and
reached a commit that you fetched from the common history
previously).  The latter are ACKed by the upload-pack process and
are remembered to be re-sent to the _next_ incarnation of the
upload-pack process when stateless RPC is in use.

With your patch, you stop telling the upload-pack process what these
two programs already found to be common in their exchange.  After
the first exchange, fetch-pack and upload-pack may have noticed that
both ends have version 2.0, but because you do not convey that fact
to the other side, the new incarnation of upload-pack may end up
deciding that the version 1.9 is the newest common commit between
the two, and sending commits between 1.9 and 2.0.

If you imagine an extreme case, it would be easy to see why "the
fetch completes" and "make test passes" are not sufficient to say
anything about this change.  Even if you break the protocol in in a
way different from your patch, by not sending any "have", such a
butchered "fetch-pack" will become "fetch everything from scratch",
aka "clone".  The end result will still have correct history and
"fetch completes" would be true.

But I'd prefer deferring a more detailed analysis/explanation to
Shawn, as stateless RPC is his creation.
