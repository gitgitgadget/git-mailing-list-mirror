Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF852021E
	for <e@80x24.org>; Tue, 15 Nov 2016 18:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbcKOSDO (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 13:03:14 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51972 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752300AbcKOSDN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 13:03:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F8DE4B2DA;
        Tue, 15 Nov 2016 13:03:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dOc5uBSNiFIfmxVmDfTe7h745P8=; b=ZZ6LAf
        xjDvX6yRdCdXE7uWWD9jbsDY3TRT/FesB/4fJAXcaeb6i0bAo3DF3z25az0t3pep
        iCnGxnesQ0evI7zDb+ELBMGC+7jtAzMpkOWbvI+yWSgNpNLD283gCpVjtSlkqwOH
        QY8/Ov6DVV+UDDNGnmxmPeyKQrUnN6QqeyZN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fjjreyb4zS7EIpGhHbuFe4I/kmTDfsFq
        w+gBl74JpXqx/xhsbm0N0fBGWwZWUL0Xft5WP+rUrPLHD38BK8XErMiNsgNog9sf
        cF9Ow8l8fAP3trNkydq0LySYC6AF9XcYXS35UtzWuTPjdgPLtTEhLuS0Vx8nY/XS
        22YV8ar5ffo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05A4F4B2D9;
        Tue, 15 Nov 2016 13:03:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 715AC4B2D8;
        Tue, 15 Nov 2016 13:03:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
        <20161115010356.GA29602@starla>
        <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
Date:   Tue, 15 Nov 2016 10:03:10 -0800
In-Reply-To: <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com> (Lars
        Schneider's message of "Tue, 15 Nov 2016 15:29:09 +0100")
Message-ID: <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C579E3F0-AB5D-11E6-9582-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> The filter itself would need to be aware of parallelism
>> if it lives for multiple objects, right?
>
> Correct. This way Git doesn't need to deal with threading...

I think you need to be careful about three things (at least; there
may be more):

 * Codepaths that check out multiple cache entries do rely on the
   order of checkout.  We checkout removals first to make room so
   that creation of a path X can succeed if an existing path X/Y
   that used to want to see X as a directory can succeed (see the
   use of checkout_entry() by "git checkout", which does have two
   separate loops to explicitly guarantee this), for example.  I
   think "remove all and then create" you do not specifically have
   to worry about with the proposed change, but you may need to
   inspect and verify there aren't other kind of order dependency.

 * Done naively, it will lead to unmaintainable code, like this:

   + struct list_of_cache_entries *list = ...;
     for (i = 0; i < active_nr; i++)
   -    checkout_entry(active_cache[i], state, NULL);
   +    if (checkout_entry(active_cache[i], state, NULL) == DELAYED)
   +       add_cache_to_queue(&list, active_cache[i]);
   + while (list) {
   +    wait_for_checkout_to_finish(*list);
   +    list = list->next;
   + }

   I do not think we want to see such a rewrite all over the
   codepaths.  It might be OK to add such a "these entries are known
   to be delayed" list in struct checkout so that the above becomes
   more like this:

     for (i = 0; i < active_nr; i++)
        checkout_entry(active_cache[i], state, NULL);
   + checkout_entry_finish(state);

   That is, addition of a single "some of the checkout_entry() calls
   done so far might have been lazy, and I'll give them a chance to
   clean up" might be palatable.  Anything more than that on the
   caller side is not.

 * You'd need to rein in the maximum parallelism somehow, as you do
   not want to see hundreds of competing filter processes starting
   only to tell the main loop over an index with hundreds of entries
   that they are delayed checkouts.

