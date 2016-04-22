From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: include taggerdate in considering the best name
Date: Fri, 22 Apr 2016 11:40:39 -0700
Message-ID: <xmqqa8klpjvc.fsf@gitster.mtv.corp.google.com>
References: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
	<20160422181103.GA5920@sigill.intra.peff.net>
	<xmqqeg9xpkhb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 20:40:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atg0U-0005cl-KL
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 20:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbcDVSkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 14:40:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751172AbcDVSkm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 14:40:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35FB4149A6;
	Fri, 22 Apr 2016 14:40:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sQSUhxkePr58Qll3B7OlWVxrfOI=; b=II0f3S
	buiWjN7qhrm7xTAwaoFufmw9KFG0XwAGRtbQaUE3/qRzvE9aDIk2rV/A2fAVusdB
	uIClrF8zwtfl9Tfc8O1kuVBOLRP8H71b3Ug6IFSElpLNA7amNyiptyfo4nfJejFO
	PKMuSlost6PkAaqIT5lVeseeyhS5sPaEvNXtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9T0l0+0hHwkml5PIiwf8YGHrDTMjbCB
	b7KY/ViGp4Koebh0JFFvmnPrV5j90gjMzhM+8JXsRyVWzCLSSlTrMLjgciQKqFZi
	ns6Y9OMCjzdZgoTz3UL/B4IBUZm50Zz+s0MYAPHG9OHBbO7L8ZaJBhr9M3fk7zyl
	9OXWarlaKeg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D8E9149A5;
	Fri, 22 Apr 2016 14:40:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 895C5149A4;
	Fri, 22 Apr 2016 14:40:40 -0400 (EDT)
In-Reply-To: <xmqqeg9xpkhb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 Apr 2016 11:27:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B689C47E-08B9-11E6-8EBC-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292243>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> That turned out to be quite simple (I wasn't sure originally if we'd
>> actually visit all of the tags, which is why I had conceived of this as
>> an initial pass; but of course it makes sense that we'd have to see all
>> of the tags in the existing code).
>> ...
>> We could _also_ tweak the merge-weight as Linus's patch did, just
>> because 10000 has more basis than 65535. But I think it really matters a
>> lot less at this point.
>
> I agree, but if we were to go this route of keeping track of "some"
> attribute of the tip the traversal started from, I wonder if it is
> better to keep the actual tag object, not just its tagger date as an
> unsigned long, in the new field.

Actually, I take it back.  The "object" approach would not give us
enough flexibility to go beyond "date".  A light-weight tag that
directly point at a commit object can still yield "date" (probably
"committerdate" to be compared with other dates, be it the committer
date from another commit or the tagger date from a real tag), but if
we later wanted to do a v:refname kind of comparison, we'd need to
keep the name of the ref (we cannot go back from the commit object
to the refname), so at that point, we would be talking about adding
yet another field anyway to hold the refname, in addition to the
field we would be adding at this step.  As we do not want to be
always doing "name to object to date" conversion in this codepath,
adding an "unsigned long" date field is the right thing to do here.
A more elaborate future can add refname (or refname and object) as
additional fields, but we can wait because even after that update
the codepath to do date comparison likely would want to have direct
access to the date field anyway.
