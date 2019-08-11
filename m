Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1AC1F45A
	for <e@80x24.org>; Sun, 11 Aug 2019 22:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfHKWjC (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Aug 2019 18:39:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54911 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHKWjC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Aug 2019 18:39:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 536EA7694A;
        Sun, 11 Aug 2019 18:38:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UPXX+ExSZtLh5p3bYdRjwYaGp7Y=; b=vxzOyP
        sPwW5qz5HGBHwa8BJVVb09OV9/gglgfT1g1wbeAD1S4mDX0nmcDk/EWnOIQje0O0
        NiG51UtaMr4UWZdCgy7cTa5qX9Emp3rdx6CgBuMEbCy3uAZpmy+WeCH57htwKTwQ
        57KPuuy4tKbPyjNHhM9Wgo6IKD/ssAuQBxCjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yKW/NQtz7WGsyw2e4wEsyHt7mnO7i1mt
        xmHXKA2pyrDTd0OqzMVO82i3CTN+Or03AFaxgrYUqi8ckd813mI4YLUDCrxfJs/M
        gfwVqVJ2Xm6ivc+ZB3ZWfcoa2pIsu7NnccVnjZzu85mWf6fSX4wyGGiamZzL3S8a
        CAnnU/5wq9I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CB9A76949;
        Sun, 11 Aug 2019 18:38:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7CBC876941;
        Sun, 11 Aug 2019 18:38:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Farhan Khan" <farhan@farhan.codes>
Cc:     git@vger.kernel.org
Subject: Re: How to determine when to stop receiving pack content
References: <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes>
Date:   Sun, 11 Aug 2019 15:38:50 -0700
In-Reply-To: <c1754835efe3aa8a5ac93ee2db4a99c5@farhan.codes> (Farhan Khan's
        message of "Sat, 10 Aug 2019 23:47:22 +0000")
Message-ID: <xmqq7e7jcop1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB61D838-BC88-11E9-B548-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Farhan Khan" <farhan@farhan.codes> writes:

> I am trying to write an implementation of git clone over ssh and
> am a little confused how to determine a server response has
> ended. Specifically, after a client sends its requested 'want',
> the server sends the pack content over. However, how does the
> client know to stop reading data? If I run a simple read() of the
> file descriptor:
>
> A. If I use reading blocking, the client will wait until new data is available, potentially forever.
> B. If I use non-blocking, the client might terminate reading for new data, when in reality new data is in transit.

It's TCP stream, so blocking read will tell you when the the other
side finishes talking to you and disconnects.  Your read() will
signal EOF.  If you are paranoid and want to protect your reader
against malicious writer, then you cannot trust anything the other
side says (including possibly any "I have N megabyte of data" kind
of length information), so you'd need to set up a timeout to get
yourself out of a stuck read, but that is neither a news nor a
rocket surgery ;-)

The "upload-pack" (the component that talks with your "fetch" and
"clone"), after negotiating what objects to include in the data
transfer with the program on your side, produces a pack data stream,
and is allowed to send additional "garbage" after that.

The receiving end, after finishing the negotiation, reads the pack
data stream (there is only one packfile contents in it) and parses
it according to the packfile format so that it can find the end
(cf. Documentation/technical/pack-format.txt).

After seeing the end of the pack stream, anything that follows is
"garbage" and is generally passed through to the standard output.

There are two codepaths on the receiving end ("unpack-objects" and
"index-pack --stdin").  Most likely an initial "clone" would end up
following the latter, but for educational purposes, the unpack-objects
may be easier to follow.  These two codepaths are morally equivalent
at the higher conceptual levels.
