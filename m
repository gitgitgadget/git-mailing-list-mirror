Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EC820133
	for <e@80x24.org>; Mon,  6 Mar 2017 19:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbdCFTZe (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 14:25:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61047 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753330AbdCFTZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 14:25:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C75C96C8FE;
        Mon,  6 Mar 2017 14:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AeXPDsxDArRt+FsLD3Gmb3UYAHs=; b=LMB5J/
        0zx8Xz2bxiArW118ceyAeEa86tmuZXFH1mt0cJ2nctuPsOgzHbyvfSUYNvZ9heS+
        ydJAzeQ+ozph/89Rat2b4NViwVovt+phDBmlo6/4L6v4UHp0nTZs9h//kQJ+UMwU
        e13IRRZg2pRCz0B8Xu2Nd5sLavdXzVs71R36s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hHK8HbGXDswTmu7kkA6/gorHDV9sorav
        BKM0QiOEEiB0BA2ydjwI0ASbzxYUYgBZhxegkxlC2ZRXrESnB2+MSB0gwpQUgDN3
        lrWVDGSpo5YjLw5WOdZnyulsKAbiHI+n4brRpvrQ9fs5Fbv7M1VodUaBSXr8ORKL
        qc4AmncDCE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0CB96C8FD;
        Mon,  6 Mar 2017 14:18:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3558A6C8FC;
        Mon,  6 Mar 2017 14:18:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Thomas <markbt@efaref.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 0/4] Shallow clones with on-demand fetch
References: <20170304191901.9622-1-markbt@efaref.net>
Date:   Mon, 06 Mar 2017 11:18:30 -0800
In-Reply-To: <20170304191901.9622-1-markbt@efaref.net> (Mark Thomas's message
        of "Sat, 4 Mar 2017 19:18:57 +0000")
Message-ID: <xmqqr32anri1.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFE7EDC0-02A1-11E7-9F79-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Thomas <markbt@efaref.net> writes:

> This is a proof-of-concept, so it is in no way complete.  It contains a
> few hacks to make it work, but these can be ironed out with a bit more
> work.  What I have so far is sufficient to try out the idea.

Two things that immediately come to mind (which may or may not be
real issues) are 

 (1) What (if any) security model you have in mind.

     From object-confidentiality's point of view, this needs to be
     enabled only on a host that allows
     uploadpack.allowAnySHA1InWant but even riskier.

     From DoS point of view, you can make a short 40-byte request to
     cause the other side emit megabytes of stuff.  I do not think
     it is a new problem (anybody can repeatedly request a clone of
     large stuff), but there may be new ramifications.

 (2) If the interface to ask just one object kills the whole idea
     due to roundtrip latency.

     You may want to be able to say "I want all objects reachable
     from this tree; please give me a packfile of needed objects
     assuming that I have all objects reachable from this other tree
     (or these other trees)".

