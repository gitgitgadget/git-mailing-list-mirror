Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E1762035F
	for <e@80x24.org>; Tue, 25 Oct 2016 23:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932478AbcJYX2c (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 19:28:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53995 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932417AbcJYX2a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 19:28:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A7D5486A2;
        Tue, 25 Oct 2016 19:28:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LRRJa44m4r9iPGTf2xtyEaRhgCE=; b=stdFP8
        Y3vuKk++LShiBqKqU13982+UUsBK1ETqfBpujskP4QE6JN5UCBKm2kNyBWawnLby
        Wkkkg8kdy4+Y4ouurTSPLn0WE8A0aaHveNFZr096HIX6hVbLBkVfTWXl2LcL//8J
        OQnsJibzc1YA4z8SWLxMh2ttN5JHgmYfai694=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tz9x7GkBWKvgPanNZ/GOGIuJ/KDxVdcn
        QznRva9VShzMEr8ODMBM4SNBqgXbalm5sAoXtsRkr7X246WPjb6qy/Q5OKeIDdfV
        bMGvUyk7J/8Wfnqszm0hN8R6C6s+fuCsXAYcw7jbnsZu45JxqhVIDdL9VSTxDKAH
        YexHftN6uUE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31FFB486A1;
        Tue, 25 Oct 2016 19:28:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3AC1486A0;
        Tue, 25 Oct 2016 19:28:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset: --unmerge
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
        <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
        <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com>
Date:   Tue, 25 Oct 2016 16:28:24 -0700
In-Reply-To: <CACsJy8D4cT2EV_t6=+XTHxLmjV+NtAE+KgiN3ZiP7JQzvu29oQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 25 Oct 2016 18:11:41 +0700")
Message-ID: <xmqqmvhsc8kn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBF6C946-9B0A-11E6-8C04-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> BTW making git-add (and "git commit -a") refuse files with conflict
> markers present could prevent this mistake earlier and is probably a
> better option because the user won't have to discover 'reset
> --unmerge'.

That may help some users, but you are solving a different problem.

I do not say "save" unless I know the editor buffer contents is not
ready.  "This is ready to be saved" however is different from "This
resolution is correct", and I need the unmerged states in the index
to verify, namely by looking at "git diff" (no other parameters)
output that shows only the paths with unmerged stages and in the
compact combined diff format.

Somebody with a bright idea decided that vc-git-resolve-conflicts
variable should be on by default in Emacs 25.1 X-<, which causes
"save" after resolving conflicts to automatically run "git add", to
destroy this valuable tool.  My knee-jerk reaction, of course, to
such a default is "that's brain dead", but perhaps they did so for
some good reason that I fail to fathom.

