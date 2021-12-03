Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D67C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbhLCTzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:55:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60110 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353627AbhLCTzW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 14:55:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FF8B164AAE;
        Fri,  3 Dec 2021 14:51:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U8JuhJk7zh8S454m3BUEkpfsJ+1eija07dX8uT
        Us408=; b=gaUuqbslwrujkLNYV8FStmLjRvu1ZPSBrVKl99QiIFztR5nV+NFjy+
        24l1WE5Rau7uKy1cnydfQ6abfn8Mo0p+kNbAXn6XM5HKshBKxzHdRLDtnf4zYyp7
        62tKZ1DUSCv2zTCSA6TGk2rzB+M+/td+kxPBxwwEwPDp5ywdPl0ps=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0898A164AAB;
        Fri,  3 Dec 2021 14:51:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1333B164AAA;
        Fri,  3 Dec 2021 14:51:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
Subject: Re: [PATCH 00/17] cruft packs
References: <cover.1638224692.git.me@ttaylorr.com>
Date:   Fri, 03 Dec 2021 11:51:51 -0800
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 29 Nov 2021 17:25:02 -0500")
Message-ID: <xmqq5ys5sbzc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 766487DE-5472-11EC-B7B0-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This series implements "cruft packs", a pack which stores accumulated
> unreachable objects, along with a new ".mtimes" file which tracks each
> object's last known modification time.

Let me rephrase the above to test my understanding, since I need to
write a summary for the  "What's cooking" report.

 Instead of leaving unreachable objects in loose form when packing,
 or ejecting them into loose form when repacking, gather them in a
 packfile with an auxiliary file that records the last-use time of
 these objects.

That way, we do not have to waste so many inodes for loose objects
that is not likely to be used, which feels like a win.

>   - The final patch handles object freshening for objects stored in a
>     cruft pack.

I am not going to read it today, but I think this is the most
interesting part of the series.  Instead of using mtime of an
individual loose object file, we'd need to record the time of
last use for each object in a pack.

Stepping back a bit, I do not see how we can get away without doing
the same .mtimes file for non-cruft packs.  An object that is in a
non-cruft pack may be referenced immediately after the repack that
created the pack, but the ref that was referencing the object may
have gone away and now the pack is a month old.  If we were to
repack the object, we do not know when was the last time the object
was reachable from any of the refs and index entries (collectively
known as anchor points).  Of course, recording all mtimes for all
packed objects all the time would involve quite a lot of overhead.
I am guessing (I will not spend time today to figure it out myself)
that .mtimes update at runtime will happen in-place (i.e. via
seek(2)+write(2), or pwrite()), and I wonder what the safety concern
would be (which is the primary reason why we tend not to do in-place
updates but recreate-and-rename updates).

Thanks for working on such an interesting topic.
