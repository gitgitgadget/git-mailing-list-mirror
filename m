Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D7F2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 20:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbcISUJq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 16:09:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51491 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751119AbcISUJp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 16:09:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CDA740CBF;
        Mon, 19 Sep 2016 16:09:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3rPis4JuEYfOekSlDKWFoVuoy9o=; b=VRdf7A
        lEtYoxNdzioEtqaJr60vX1DIoVybbZsLgfteiwNgf0kpRohNHzykj9f8JrYqQ0WW
        8JYhmMYkwdPiPIAN84w+d4lWL1zzmd6+xyQ0FJKBSRpp0w1vB154PeozfL0IiE9M
        y+LxUrBesziNIXg/1p90qw3aNrKzoZRCxI2F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SUmETd1Y5B+o4UUIaCv9gZaK5dkmLZRN
        3sNzm7cg0aVQNmxJkBLX++vhjFkTCJgE/oA+L0OSq8Ng3ZVlI38vNtHATs2WrhUI
        E8xJ3ZyqZMeYvELIVpuWKMkVvhI2LjCYf8BJDX6MCpqFHiILRnpPAf3oJDJWNnXI
        EUtve0QGK9A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 242E740CBD;
        Mon, 19 Sep 2016 16:09:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99C6A40CBC;
        Mon, 19 Sep 2016 16:09:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 2/2] serialize collection of refs that contain submodule changes
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914175130.GB7613@sandbox>
        <xmqqd1k3losd.fsf@gitster.mtv.corp.google.com>
        <20160919195118.GB62429@book.hvoigt.net>
Date:   Mon, 19 Sep 2016 13:09:41 -0700
In-Reply-To: <20160919195118.GB62429@book.hvoigt.net> (Heiko Voigt's message
        of "Mon, 19 Sep 2016 21:51:18 +0200")
Message-ID: <xmqqeg4fejne.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0140E6C6-7EA5-11E6-B966-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> I am not sure if I understand you correctly here. With the "ref cache layer"
> you are referring to add_submodule_odb() which is called indirectly from
> submodule_needs_pushing()? Those revs are only used to check whether the hash
> we need on the remote side exists in the local submodule. That should not
> change due to a push. The actual check whether the commit(s) exist on the
> remote side is done using a 'rev-list' in a subprocess later.

I was wondering what would happen in this scenario:

 * You have ON_DEMAND set, which causes "git -C sub push origin" to
   push out what are new, updating the remote tracking branches in
   the submodule, sub/.git/refs/remotes/origin/*.

 * Then you check again.  If you used for-each-ref-in-submodule, the
   updated refs/remotes/origin/* may not have been re-read.

But you check by spawning "rev-list ... --not --remotes" as a
separate process in submodule_needs_pushing(), and that will force
the new process to read the updated state, so it turns out that I
was overly worried without good reason ;-)

It may matter once somebody tries to internalize the external
rev-list call done via start_command() interface to an internal
call, though.  But we are not there yet.
