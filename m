Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138361F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdAZWYZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 17:24:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62365 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751745AbdAZWYY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 17:24:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CB63633DA;
        Thu, 26 Jan 2017 17:23:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K06Gx3RBlw84a2SUrwKa3XjJyks=; b=EIQDpD
        lw9pkw4nwl39sb9hoV9VWXAVC3jM5A+Ikkt5CIQCrTRTJJB0fPvMnL6KhIoVLfwm
        rJacT3FYUhDDN+Gr9UCnt0iae2PbBL3ehxX9d3+ur7k6PUIQyCyRgRkKXvOikPTT
        lB+s/Mvt1F/1g6Ciw15SiDlU8AeOdFlpDldqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pSU1JLEfG5x5Gxic1fakOhs0YKYohKjY
        p8Ydl6rzpsP1R/b3cQ6mr78+fCEoLGPgT3YI9xsej82Ffaf/OHtvbpbwKI+VUgeY
        +OrW1IbCSQQusi2PybhOJKUiEQKi8Ks7Cu5eGNGsks0EdKTC0pCsBKIWWeLMM5UX
        g06YimuMKyk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EE53633D9;
        Thu, 26 Jan 2017 17:23:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88D85633D8;
        Thu, 26 Jan 2017 17:23:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 02/14] upload-pack: allow ref name and glob requests
References: <cover.1485381677.git.jonathantanmy@google.com>
        <cover.1485381677.git.jonathantanmy@google.com>
        <d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com>
Date:   Thu, 26 Jan 2017 14:23:36 -0800
In-Reply-To: <d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Wed, 25 Jan 2017 14:02:55 -0800")
Message-ID: <xmqqd1f931g7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15B18D6E-E416-11E6-A6EE-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Currently, while performing packfile negotiation [1], upload-pack allows
> clients to specify their desired objects only as SHA-1s. This causes:
> (a) vulnerability to failure when an object turns non-existent during
>     negotiation, which may happen if, for example, upload-pack is
>     provided by multiple Git servers in a load-balancing arrangement,
>     and
> (b) dependence on the server first publishing a list of refs with
>     associated objects.
>
> To eliminate (a) and take a step towards eliminating (b), teach
> upload-pack to support requests in the form of ref names and globs (in
> addition to the existing support for SHA-1s) through a new line of the
> form "want-ref <ref>" where ref is the full name of a ref, a glob
> pattern, or a SHA-1. At the conclusion of negotiation, the server will
> write "wanted-ref <SHA-1> <name>" for all requests that have been
> specified this way.

I am not sure if this "at the conclusion of" is sensible.  It is OK
to assume that what the client side has is fixed, and it is probably
OK to desire that what the server side has can change, but at the
same time, it feels quite fragile to move the goalpost in between.

Stepping back a bit, in an environment that involves multiple server
instances that have inconsistent set of refs, can the negotiation
even be sensibly and safely implemented?  The first server the
client contacts may, in response to a "have", say "I do have that
commit so you do not have to send its ancestors to me.  We found one
cut-off point.  Please do explore other lines of histories."  The
next server that concludes the negotiation exchange may not have
that commit and will be unable to produce a pack that excludes the
objects reachable from that commit---wouldn't that become a problem?

One way to prevent such a problem from hurting clients may be for
these multiple server instances to coordinate and make sure they
have a shared perception of the common history among them.  Some
pushes may have come to one instance but may not have propagated to
other instances, and such a commit cannot be accepted as usable
"have" if the servers anticipate that the final client request would
go to any of the servers.  Otherwise the multiple server arrangement
would not work safely, methinks.

And if the servers are ensuring the safety using such a mechanism,
they can use the same mechanism to restrain "faster" instances from
sending too fresh state of refs that other instances haven't caught
up to, which would mean they can present a consistent set of refs to
the client in the first place, no?

So I am not sure if the mechanism to request history by refname
instead of the tip commit would help the multi-server environment as
advertised.  It may help solving other problems, though (e.g. like
"somebody pushed to update after the initial advertisement was sent
out" which can happen even in a single server environment).

> The server indicates that it supports this feature by advertising the
> capability "ref-in-want". Advertisement of this capability is by default
> disabled, but can be enabled through a configuration option.

OK.

> To be flexible with respect to client needs, the server does not
> indicate an error if a "want-ref" line corresponds to no refs, but
> instead relies on the client to ensure that what the user needs has been
> fetched. For example, a client could reasonably expand an abbreviated
> name "foo" to "want-ref foo", "want-ref refs/heads/foo", "want-ref
> refs/tags/foo", among others, and ensure that at least one such ref has
> been fetched.

Cute.  This may be one way to implement the DWIM thing within the
constraint of eventually wanting to go to "client speaks first, the
server does not advertise things the client is not interested in"
world.  

But at the same time it may end up bloating the set of refs the
client asks instead.  Instead of receiving the advertisement and
then sending one request after picking the matching one from it,
the client needs to send "refs/{heads,tags,whatever}/foo".
