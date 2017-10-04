Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7005520281
	for <e@80x24.org>; Wed,  4 Oct 2017 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdJDLl7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 07:41:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59610 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751915AbdJDLl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 07:41:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A690CA54A4;
        Wed,  4 Oct 2017 07:41:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6PTFU5qlTkOtv3okXk2ZkzDyfHo=; b=fJTTKZ
        jOXEG4NiQhcjhINT5O+R7dEOZhCoTda+hsn79l7JMZxd0PWuBHinNPHPY5uTu6T2
        COtoLJ9RaGrLGfaixC1WcBZGnO6w/US0D7S14MaNsBFtm0C1EZ2YgK5wW+loTdgD
        LUFiB3OAseh6g0IlICDYp3WpWF4DC5L+VPjL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z9kgIu81E7cFgrK0Ws/GJYMbOl3OpNPH
        0iu2YRri9qKlOOU+ZHUZykTstEKo3MAiUQESf5OIEg0TVrYU1DgxnGfMt1swmhDt
        zI1CfUDm/yLcXeQYZ7piq/lGNpe4JK0fi/JY7fW+ojA4EU7fhZNguPOj1b8lD9S1
        UZ2PW04jNDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F392A54A3;
        Wed,  4 Oct 2017 07:41:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E160A54A2;
        Wed,  4 Oct 2017 07:41:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH 2/3] for-each-ref: let upstream/push optionally report merge name.
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <f615fcc05fa358b4c7e3531cbdbd91661be321aa.1506952571.git.johannes.schindelin@gmx.de>
        <xmqq4lrfb7jk.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 04 Oct 2017 20:41:55 +0900
In-Reply-To: <xmqq4lrfb7jk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 04 Oct 2017 18:12:47 +0900")
Message-ID: <xmqqvajv9m2k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06BB862C-A8F9-11E7-AF10-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +		if (explicit)
>> +			*s = xstrdup(merge);
>> +		else
>> +			*s = "";
>
> Here is the same "who are we trying to help---users who want to know
> where their push goes, or users who are debugging where the push
> destination is defined?" question.  I do not have a strong opinion
> either way, but I think giving the end result with fallback (i.e.
> not nullifying when the result is not explicit) may be easier to use
> by "push" users.

Now after thinking about it a bit more, I actually have a moderate
preference to doing it the way your patches do.  With programatic
%(if)%(else)%(end) support we acquired recently, the fallback can be
coded in the --format=... language if the user wanted to using the
"internal fallbacks, explicit==0, are ignored" behaviour that are
implemented by these two patches.  The reverse is not true.

I think the remaining points from my reviews are:

 - It would be better to compute precomputable stuff when used atoms
   are parsed, instead of running starts_with() in these functions;

 - We want to make sure there is no existing multi-word modifiers
   (in which case we can safely declare "multi-word" is the way we
   spell them from now on).  Or if there are existing ones, they
   already spell themselves as "multi-word".

   I have nothing against "remote-name"; I just want to make sure we
   are not making things inconsistent.  If there are only few (but
   non zero number of) multi-word modifiers that are not spelled
   "multi-word", as long as they are only few and their spelling are
   inferiour (e.g. concatenatedwords is much worse than
   concatenated-words), we could still declare "multi-word" is the
   right way to spell them going forward, declare that we will give
   them synonyms and deprecate the bad spelling out over time, and
   leave that plan as #leftover bits thing (i.e. not doing the
   deprecation of these other modifiers as part of this series.

   The only thing I want to happen in the scope of _this_ series, as
   due diligence, is to make sure we are happy with "multi-word",
   and also to know if we need a follow-up work (just yes/no,
   possibly with plans, but no actual work yet).

Thanks.
