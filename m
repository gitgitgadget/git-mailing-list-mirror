From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 06 Jan 2015 10:25:56 -0800
Message-ID: <xmqqtx03pxzf.fsf@gitster.dls.corp.google.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
	<F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:26:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8YpQ-0001bC-U5
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888AbbAFS0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:26:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753379AbbAFSZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:25:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E4282C21D;
	Tue,  6 Jan 2015 13:25:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g/3Sz1cTa6h8yT45AVeHdjopotk=; b=HoWVAZ
	tZSo9Lpe/MyBCO5NNL9Z/jsyp8KYmcToCaN+/H/XaAPZIhakhkPCCqEwZbbarLL8
	RV04Xag09o7H9MIwMlFgAvMOQvaBm676Gly7Mjo4vLasnz2Mu0RjleEYi0XotDpd
	kpEfMah98LyrZ+2Sls3i5WlI4luOkHExLmRJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hxy3vSLMPkqfPLU24+G5n9OpF7hFf/Lw
	vnJWDuO1k1TRZ+n9csKmLchfVK1PGW7eoEvHhxfL900ZuaHC6NbgzMtRKVrqQfxo
	WXoYTg1JfXhj38Cej04e7ug6DdHUSgum2rhSng23O/oAnwT00NdCawoNCD71LaLm
	XX5Wt3yLaSU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94B7E2C21C;
	Tue,  6 Jan 2015 13:25:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD0982C21A;
	Tue,  6 Jan 2015 13:25:57 -0500 (EST)
In-Reply-To: <F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com> (Kyle J. McKay's
	message of "Tue, 6 Jan 2015 04:27:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7560337C-95D1-11E4-BA77-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262083>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> So despite the name of the test, the actual tree contents do not seem
> to be examined.

Yes, but the thing is, thanks to refs/notes restriction, there is no
need to do such examination [*1*].

Note that it is an entirely different matter when you deliberately
violate the expectation using plumbing (e.g. update-ref).  Users of
plumbing commands are expected to know what they are doing, so the
level of safety we need to give them can be much lower than Porcelain
commands such as 'git notes'.  

But when you stick to Porcelain commands, it is very hard to mix
refs/notes/* with refs/heads/* and refs/remotes/* by mistake.  You
have to really work on it by doing something unusual to have a non
commit in refs/heads/*, a commit in refs/notes/*, or a regular
non-note commit in refs/notes/*.

Once you lift the existing restriction, that easy safety goes away,
so the burden of giving a reasonable safety in some other way falls
on the one who is dropping refs/notes restriction.

That is exactly what I meant by that the existing safety pays price
of not being able to store notes outside refs/notes, which may be
too high a price to pay.

>> Although I am not fundamentally against allowing to store notes
>> outside refs/notes/, it is different from "anywhere is fine".
>> Can't we do this widening in a less damaging way?
>
> Without arbitrarily restricting where notes can be stored it seems to
> me the only option would be to have the notes machinery actually
> inspect the tree of any existing notes ref it's passed.

As I said earlier (assuming you read footnotes before you read a new
paragraph), the ship has already sailed.

Obvious two sensible ways forward are to do a blacklist (i.e. allow
anywhere except for known non-notes namespaces like refs/heads/) or
do a whitelist (i.e. allow refs/<some-known-space> in addition to
refs/notes) of the namespace, and the latter is vastly preferrable
than the former, because you can practically *never* crawl back a
namespace once you give it to the general public, even if you later
find it a grave error to open it too widely and need a more
controlled access [*2*].  And the name of the game for a software
that can be relied for a long haul is to avoid painting ourselves in
a corner that we cannot get out of.

If we add refs/remote-notes/* to the whitelist now, and if later it
turns out to be not so ideal and we would prefer another layout for
remotes, e.g. refs/remotesNew/*/{heads,notes,tags}/, we can add
refs/remotesNew/*/notes/ to the whitelist _without_ breaking those
who have already started using refs/remote-notes/*.  That is why
I said whitelist is preferrable than blacklist.


[Footnote]

*1* I actually do not think a tree examination would help very much
    here.  IIRC, somebody decided long time ago that it would be a
    good idea to be able to store a path that is not a fanned-out
    40-hex in a notes tree and 'git notes merge' would accept such a
    notes-tree.  Although I doubt that the resulting notes-tree
    produced by 'notes merge' is carefully designed one (as opposed
    to whatever the implementation happens to do) with sensible
    semantics, people may already be relying on it.

*2* The above 'notes-tree can store non fanned-out 40-hex' is a good
    example why you need to start strict and loosen only when it
    becomes necessary.  Despite that even Git itself does not use
    that "facility" to do anything useful AFAIK, only because we
    started with a loose variant that allows arbitrary garbage, we
    cannot retroactively tighten the definition of what a notes-tree
    should look like without risking to break practice of other
    people.
