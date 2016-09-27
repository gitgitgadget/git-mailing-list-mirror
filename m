Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4098220986
	for <e@80x24.org>; Tue, 27 Sep 2016 22:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbcI0WHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 18:07:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61970 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752586AbcI0WHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 18:07:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFC3A3F029;
        Tue, 27 Sep 2016 18:07:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i+2rsDgx9xlvDkIR5WbsxYeZUwY=; b=on4dMp
        1vKjXgrfhWyi4rKTIzDHVqGFpr2k53RLGDXd4IO4DoSr+Z4mPvwivSDZQVaTw7CW
        bbhqtpVr78Z07fZb14dI7wAAofdJHlQ3aPW9nCV+lrCpbp+mt5WOPY9jj0yYkI/5
        Qknap05os9ZFxxdZyWr7jkKIONiUtdl0VDgqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OCwdTqXx/Ai5nUEAje4VeZF/JUssue6J
        pbuABFQvKHLS5iWyRDkw9cpf6/OwnZCn2Smll6Un+aEqxzEk+sNuIMaY6Ymlbdf0
        egUlsfG/0GGrSKR4VJvem7BmeQt5UryMW67rJFFmOhb1Romni30muRUSywVhhenU
        yoDwVvS4Btg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D71B03F028;
        Tue, 27 Sep 2016 18:07:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B6453F027;
        Tue, 27 Sep 2016 18:07:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Resumable clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <20160927215143.GA32622@starla>
Date:   Tue, 27 Sep 2016 15:07:35 -0700
In-Reply-To: <20160927215143.GA32622@starla> (Eric Wong's message of "Tue, 27
        Sep 2016 21:51:43 +0000")
Message-ID: <xmqqshslkndk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CCCCD1C4-84FE-11E6-844E-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

>> [primeclone]
>> 	url = http://location/pack-$NAME.pack
>> 	filetype = pack
>
> If unconfigured, I wonder if a primeclone pack can be inferred by
> the existence of a pack bitmap (or merely being the biggest+oldest
> pack for dumb HTTP).

That would probably be a nice heuristics but it is unclear who
should find that out at runtime.  The downloading side would not
have a visiblity into directory listing.

>> git clone --resume <resumable_work_or_git_dir>
>
> I think calling "git fetch" should resume, actually.
> It would reduce the learning curve and seems natural to me:
> "fetch" is jabout grabbing whatever else appeared since the
> last clone/fetch happened.

I hate say this but it sounds to me like a terrible idea.  At that
point when you need to resume, there is not even ref for "fetch" to
base its incremental work off of.  It is better to keep the knowledge
of this "priming" dance inside "clone".  Hopefully the original "clone"
whose connection was disconnected in the middle would automatically
attempt resuming and "clone --resume" would not be as often as needed.
