Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 634641F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754663AbcJKWjw (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:39:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61214 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754655AbcJKWjv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:39:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E50D46ED6;
        Tue, 11 Oct 2016 18:37:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPGbxF5FDe4ofQ3FTKNAPJg1axs=; b=BcD9gm
        aVnPuUEd6iMz+XHN+OXGAz4N6GmA+ROOfsD6qHRUSTVCjUJBCNhOUcE3nQXdf0BN
        CH1Zbml4KWLw3cHqtkwfLeSZaI+TeTflhOecYW9mWaAv+mZl5QV69a0UprGlL8fU
        WLvRkuWXbAtjkqOxVmHG5KBj5NQYtr2wjNuY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D+20RVScAR8exktK9E09UnyVJgepFvrj
        VWhRCA9vZuUWFuPwcLr5eBIe64N+kqGbryNZIW/f13ctFG3IADpA/w3uvlj0suH8
        4DHfA6yBmLsPauECdKTMJG3QCYTBXA0qbvSoQnigbZXnOgAU/WFsLfbW702ipa+S
        3DTRpPlToQ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7544346ED5;
        Tue, 11 Oct 2016 18:37:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECB8746ED4;
        Tue, 11 Oct 2016 18:37:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ram Rachum <ram@rachum.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Make `git fetch --all` parallel?
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
        <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
Date:   Tue, 11 Oct 2016 15:37:02 -0700
In-Reply-To: <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Oct 2016 13:53:03 -0700")
Message-ID: <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B8D9BD4-9003-11E6-80F1-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So I do think it would be much faster, but I also think patches for this would
> require some thought and a lot of refactoring of the fetch code.
> ...
> During the negotiation phase a client would have to be able to change its
> mind (add more "haves", or in case of the parallel fetching these become
> "will-have-soons", although the remote figured out the client did not have it
> earlier.)

Even though a fancy optimization as you outlined might be ideal, I
suspect that users would be happier if the network bandwidth is
utilized to talk to multiple remotes at the same time even if they
end up receiving the same recent objects from more than one place in
the end.

Is the order in which "git fetch --all" iterates over "all remotes"
predictable and documented?  If so, listing the remotes from more
powerful and well connected place to slower ones and then doing an
equivalent of stupid

	for remote in $list_of_remotes_ordered_in_such_a_way
	do
		git fetch "$remote" &
		sleep 2
	done

might be fairly easy thing to bring happiness.
