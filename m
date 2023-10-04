Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA8E8FDBF
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 01:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjJDBNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjJDBNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 21:13:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA4AF
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 18:13:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EAAC2DF47;
        Tue,  3 Oct 2023 21:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=VamEpLy48whJ7POq4gPoskveJrljmbxnS5mLNh
        xwu9g=; b=ueXN0choUfFOWB5CEGvTCmQTsBalNH8L0z5eax2ypGWwtKqLkUpo8b
        sgiT/Kds1FyMZmLVDCm/4ANtbbzwW6lneVJSFzoePmuiGrGzFyfFXhkrFwKg/qB9
        BO3OT/ZpNwBri+ibaoIWSjo9QAoGe7kPBrI9L9YldNQRGIj9aJE4g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 979DC2DF46;
        Tue,  3 Oct 2023 21:13:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 352BF2DF42;
        Tue,  3 Oct 2023 21:13:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jesse Hopkins <jesse.hops@gmail.com>, git@vger.kernel.org
Subject: Re: Possible to update-ref remote repository?
In-Reply-To: <20231003200018.GB1562@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Oct 2023 16:00:18 -0400")
References: <CAL3By--HowOL1ffKBPfmwnfUdJd4KXcnkpS2BgkbO=9E2WnHKw@mail.gmail.com>
        <xmqqo7hjfumj.fsf@gitster.g>
        <CAL3By-_jrYDenCc8HSrtnR3cZD19z7bvwVOOoO4XG+6aNFxyeQ@mail.gmail.com>
        <20231003200018.GB1562@coredump.intra.peff.net>
Date:   Tue, 03 Oct 2023 18:13:36 -0700
Message-ID: <xmqqil7ntcjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F8197E8-6253-11EE-8260-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> All that said, I do think it might be reasonable for git-push to support
> this directly.

Yup.  It certainly is simpler if you can leverage existing helpers.

It will become even simpler in a reasonably modularlized world that
hopefully may materialize before we all retire ;-).  I am hoping
that some of the folks who are interested in and talking about
libification can be fooled into doing the necessary work to
introduce proper abstraction, in addition to whatever they are
doing.

Wouldn't it be great if you can have an in-core repository object,
that knows what its object store is, has an index_state object that
is tied to that object store, has a reference database whose values
point into the object store, and if you can choose and mix these
repository components' implementations?  If done right, parts of the
above set of components can be replaced with mock implementations
that are in-core only.

To run "git push --repoint-only there 01beef23:master", you should
be able to start your process totally outside an repository, yet
create an in-core-only repository instance with an in-core-only
object store instance, and because you took the object name to push
on the command line, your in-core object store can "lie" to a call
"create an in-core object for this SHA-1" by returning a fake
in-core commit object, and your in-core-only ref database has that
commit pointed at by some ref.  Then because higher level "client"
code to walk revisions, enumerate refs, etc., would all implement
what they need to do by calling vtable of these in-core objects, you
can do the "repoint-only" push without being in any repository, as
such an implementation would not touch any filesystem (you can then
plug in different implementation of object store etc., and even make
them perform reasonably well if you manage to do the abstraction
right).

But that would probably be at least 6 months away, even if we had a
handful of competent developers totally dedicated to the effort
without any distraction, which I do not know how likely it is to
happen.


