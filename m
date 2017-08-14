Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEA2D20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdHNRIK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:08:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54922 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751570AbdHNRIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:08:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85C15ABF8F;
        Mon, 14 Aug 2017 13:08:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7TcfndRytWraKX0dlAl7VhMPok=; b=A2vU/C
        bP5KdNwW98AIEloift+WAu2zZ5ZvIYnX3vd227W3AjCvfWdvqlop2BCpMKWOKptI
        lvSBd+SBihE9NQB1uRvLWvP4D1eAyn2GPl5VUu+fYbeo/usBAdmPtSkviXXwwmfy
        Ons418aTw4BYSrCt+nArSiFc5eGakJaD/wqoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h7Aq3dTQl4bam1Q2D9VD6OFIyEypabvW
        n2ML94veRqg3ZtpGYEwpTksgNFsn7HWQ3xKkrqnffOhDVS+mefjTH/a+cirEHpqZ
        WRm03CH21+CExpExRK7P2jz4nMeCAHWeaP01e6lZvaeP10ZgwQBLG2oWcK3Ii00u
        3Amczm5T7sY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CFACABF8E;
        Mon, 14 Aug 2017 13:08:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C75B7ABF8C;
        Mon, 14 Aug 2017 13:08:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/9] Convert pack-objects to size_t
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause>
        <87fc215e-b860-10f5-5c5e-60652502fae8@ramsayjones.plus.com>
        <20170813183026.GC31079@mail.zuhause>
        <627042be-ab86-e9da-8c4e-5aac3278f5c6@ramsayjones.plus.com>
        <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 14 Aug 2017 10:08:05 -0700
In-Reply-To: <xmqqtw1bw1v6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 13 Aug 2017 15:15:41 -0700")
Message-ID: <xmqqfucuw00a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24262FF4-8113-11E7-898D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One interesting question is which of these two types we should use
> for the size of objects Git uses.  
>
> Most of the "interesting" operations done by Git require that the
> thing is in core as a whole before we can do anything (e.g. compare
> two such things to produce delta, have one in core and apply patch),
> so it is tempting that we deal with size_t, but at the lowest level
> to serve as a SCM, i.e. recording the state of a file at each
> version, we actually should be able to exceed the in-core
> limit---both "git add" of a huge file whose contents would not fit
> in-core and "git checkout" of a huge blob whose inflated contents
> would not fit in-core should (in theory, modulo bugs) be able to
> exercise the streaming interface to handle such case without holding
> everything in-core at once.  So from that point of view, even size_t
> may not be the "correct" type to use.

A few additions to the above observations.

 - We have varint that encodes how far the location from a delta
   representation of an object to its base object in the packfile.
   Both encoding and decoding sides in the current code use off_t to
   represent this offset, so we can already reference an object that
   is far in the same packfile as a base.

 - I think it is OK in practice to limit the size of individual
   objects to size_t (i.e. on 32-bit arch, you cannot interact with
   a repository with an object whose size exceeds 4GB).  Using off_t
   would allow occasional ultra-huge objects that can only be added
   and checked in via the streaming API on such a platform, but I
   suspect that it may become too much of a hassle to maintain.

   It may help reducing the maintenance if we introduced obj_size_t
   that is defined to be size_t for now, so that we can later swap
   it to ofs_t or some larger type when we know we do need to
   support objects whose size cannot be expressed in size_t, but I
   do not offhand know what the pros-and-cons with such an approach
   would look like.

Thanks.
