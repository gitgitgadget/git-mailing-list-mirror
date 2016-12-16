Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1BD31FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756112AbcLPV2G (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:28:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753187AbcLPV2E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:28:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 632CB576D4;
        Fri, 16 Dec 2016 16:28:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nySO8O9zcx7oT4FR/6JL71cK/zI=; b=uRRWP2
        Ba+p+otn2eGMhq0XqY8UdOHgrD5uzVphz4exNNc1nHeW7j5QytJ+nyqCO9spoG/d
        SOb484+fZ2NoHOK0jij+yLaiES4sbE8lXgyJy7m40Q7a2uVQKB9e2Fj6l+I9NGOO
        LdD53hmNPATKYOoDKIpONEuZXJX9WCxvSlNcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jP1iofMvsm3k5jBlVRStasu2FKNnc4S1
        IqCx56P9e0OI2O9F9fz7pvPRA+euUbcaFEMs8/J9uj+zSm0OQWTBPcbByw0/EPRW
        2VPoh1/V8sbGgtP8DiXnSZXAiiC7//tybDHWbJIBPOxnNDZ/rQe20ZCGpnuwDdwH
        9gjsxoDQYXg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59BF8576D3;
        Fri, 16 Dec 2016 16:28:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA1D4576D2;
        Fri, 16 Dec 2016 16:28:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
References: <1481922331.28176.11.camel@frank>
Date:   Fri, 16 Dec 2016 13:28:00 -0800
In-Reply-To: <1481922331.28176.11.camel@frank> (David Turner's message of
        "Fri, 16 Dec 2016 16:05:31 -0500")
Message-ID: <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86820B8C-C3D6-11E6-94C2-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> I'm a bit confused by the message "disabling bitmap writing, as some
> objects are not being packed".  I see it the my gc.log file on my git
> server.

> 1. Its presence in the gc.log file prevents future automatic garbage
> collection.  This seems bad.  I understand the desire to avoid making
> things worse if a past gc has run into issues.  But this warning is
> non-fatal; the only consequence is that many operations get slower.  But
> a lack of gc when there are too many packs causes that consequence too
> (often a much worse slowdown than would be caused by the missing
> bitmap).
>
> So I wonder if it would be better for auto gc to grep gc.log for fatal
> errors (as opposed to warnings) and only skip running if any are found.
> Alternately, we could simply put warnings into gc.log.warning and
> reserve gc.log for fatal errors. I'm not sure which would be simpler.  

I am not sure if string matching is really a good idea, as I'd
assume that these messages are eligible for i18n.

329e6e8794 ("gc: save log from daemonized gc --auto and print it
next time", 2015-09-19) wanted to notice that auto-gc is not
making progress and used the presense of error messages as a cue.
In your case, I think the auto-gc _is_ making progress, reducing
number of loose objects in the repository or consolidating many
packfiles into one, and the message is only about the fact that
packing is punting and not producing a bitmap as you asked, which
is different from not making any progress.  I do not think log vs
warn is a good criteria to tell them apart, either.

In any case, as the error message asks the user to do, the user
eventually wants to correct the root cause before removing the
gc.log; I am not sure report_last_gc_error() is the place to correct
this in the first place.

> 2. I don't understand what would cause that message.  That is, what bad
> thing am I doing that I should stop doing?  I've briefly skimmed the
> code and commit message, but the answer isn't leaping out at me.

Enabling bitmap generation for incremental packing that does not
cram everything into a single pack is triggering it, I would
presume.  Perhaps we should ignore -b option in most of the cases
and enable it only for "repack -a -d -f" codepath?  Or detect that
we are being run from "gc --auto" and automatically disable -b?  I
have a feeling that an approach along that line is closer to the
real solution than tweaking report_last_gc_error() and trying to
deduce if we are making any progress.


