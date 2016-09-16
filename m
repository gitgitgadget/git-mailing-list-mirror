Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F46D207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 20:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965484AbcIPUrO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 16:47:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59116 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965082AbcIPUrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 16:47:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0A083EF09;
        Fri, 16 Sep 2016 16:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bLXxTl8srxQA/fAJVfOSuTkxJF8=; b=G19eF9
        XtBm8/YGT0sgwf9LbIYQyNWUqMUfjiKOc5Qwq/wyyc/T3nnDJvqG08yyqwfs3eCR
        CDldViJyTOc/i2cQx5EkK6TCtw0XbwSC97PMluIs11mcaAclUuhw5mlDrjTE8map
        FEGqeiIX9CqJFlV/GlFehxLc6cOskAl7LTFYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lk+VPV3M60Ikxw0jJ2V+GOq9caFEblS8
        G1P4DwT9/35B11X8iDQxr5P3YQ/hTC+kImyLLMVZFNheY641nwDrmWbhvniZ5gMR
        BpRpsWDmy7EruH0H5sDD7vE89/EzW51A8KbXWHjW3/EED9/ZfSNL0fNn7xiczyf/
        gS+VP+taDCY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E92D63EF04;
        Fri, 16 Sep 2016 16:47:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 703183EEFF;
        Fri, 16 Sep 2016 16:47:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Resumable clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Date:   Fri, 16 Sep 2016 13:47:09 -0700
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com> (Kevin
        Wern's message of "Thu, 15 Sep 2016 20:12:11 -0400")
Message-ID: <xmqq4m5fk1wy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDC90494-7C4E-11E6-82D9-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

> It's been a while (sent a very short patch in May), but I've
> still been working on the resumable clone feature and checking up on
> the mailing list for any updates. After submitting the prime-clone
> service alone, I figured implementing the whole thing would be the best
> way to understand the full scope of the problem (this is my first real
> contribution here, and learning while working on such an involved
> feature has not been easy). 

It may not have been easy but I hope it has been a fun journey for
you ;-)

> On the client side, the transport_prime_clone and
> transport_download_primer APIs are built to be more robust (i.e. read
> messages without dying due to protocol errors), so that git clone can
> always try them without being dependent on the capability output of
> git-upload-pack. transport_download_primer is dependent on the success
> of transport_prime_clone, but transport_prime_clone is always run on an
> initial clone. Part of achieving this robustness involves adding
> *_gentle functions to pkt_line, so that prime_clone can fail silently
> without dying.

OK.

> Right now, a manually resumable directory is left behind only if the
> *client* is interrupted while a new junk mode, JUNK_LEAVE_RESUMABLE,
> is set (right before the download). For an initial clone, if the
> connection fails after automatic resuming, the client erases the
> partial resources and falls through to a normal clone. However, once a
> resumable directory is left behind by the program, it is NEVER
> deleted/abandoned after it is continued with --resume.

Sounds like you made a sensible design decision here.

> 	- When running with ssh and a password, the credentials are
> 	  prompted for twice. I don't know if there is a way to
> 	  preserve credentials between executions. I couldn't find any
> 	  examples in git's source.

We leave credentail reuse to keyring services like ssh-agent.

