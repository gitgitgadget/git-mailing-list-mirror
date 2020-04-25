Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4690C2BA19
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 05:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A1820748
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 05:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aAc+mNaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgDYFId (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 01:08:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDYFIc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 01:08:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB18ED4D22;
        Sat, 25 Apr 2020 01:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ShJ2pkCaD/xSJLGs1e+A7Q98J/M=; b=aAc+mN
        aAhw+W/QLagxbSlrIfsKM7bq8jAMZ1ugcpzPsL94BkoEvsQgPLLC3B+25ITbUFiN
        rWMZt0Gka/qmoTh5D7GWZ2z5czlW962ZRyRoN0jzYIGhSWiie6Zu3HUs8Fm94vk9
        gRkiC84dmV9yu64XMk79rKrC2paV1CtdNQ2Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fEUWyDHl9ACvzBQkWbUtOHGpn7jwJC+L
        AyecTa4eZSGcP4qQIWwN9SJyZh5q8Xc9zz5LvhjM9nDa5tC1ePceZ5hdZnFy+6OJ
        G0OxQisMVr5MUrYqbBZYQJb6RCJ/W29cokejfIpdcSZ9cNGhp1uVbZr4atuwxC25
        REnNcpIOaWE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E356AD4D21;
        Sat, 25 Apr 2020 01:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39236D4D20;
        Sat, 25 Apr 2020 01:08:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 1/2] fetch-pack: in protocol v2, in_vain only after ACK
References: <cover.1587775989.git.jonathantanmy@google.com>
        <51174e53527f9b29bb0a5ebb8726f07333113dfb.1587775989.git.jonathantanmy@google.com>
Date:   Fri, 24 Apr 2020 22:08:26 -0700
In-Reply-To: <51174e53527f9b29bb0a5ebb8726f07333113dfb.1587775989.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 24 Apr 2020 17:56:01 -0700")
Message-ID: <xmqqlfmk9mph.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC8FD99A-86B2-11EA-9DDF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching, Git stops negotiation when it has sent at least
> MAX_IN_VAIN (which is 256) "have" lines without having any of them
> ACK-ed. But this is supposed to trigger only after the first ACK, as
> pack-protocol.txt says:
>
>   However, the 256 limit *only* turns on in the canonical client
>   implementation if we have received at least one "ACK %s continue"
>   during a prior round.  This helps to ensure that at least one common
>   ancestor is found before we give up entirely.
>
> The code path for protocol v0 observes this, but not protocol v2,
> resulting in shorter negotiation rounds but significantly larger
> packfiles. Teach the code path for protocol v2 to check this criterion
> only after at least one ACK was received.

Makes sense.

I think we can instead use in_vain==NULL as a signal that we haven't
seen any ack yet and that shrinks the patch somewhat ([Patch 1/2]
becomes +6/-4 from +9/-4 for fetch-pack.c).  I do not know if the
result is easier to follow (as there is one less variable to keep in
mind), though.  The callee is probably easier to reason about (it
needs to worry about the *in_vain variable only when it is given---
you cannot beat the simplicity of it), but the caller side may
become harder to reason about, especially without any comment where
in_vain_p becomes non-NULL.  Your version has an assignment to make
"seen_ack" to true there, which makes it very clear without any
comment what is going on.

So I dunno.  I've queued your version and discarded the following.

 fetch-pack.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..7b837b6a76 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1156,8 +1156,9 @@ static int add_haves(struct fetch_negotiator *negotiator,
 			break;
 	}
 
-	*in_vain += haves_added;
-	if (!haves_added || *in_vain >= MAX_IN_VAIN) {
+	if (in_vain)
+		*in_vain += haves_added;
+	if (!haves_added || (in_vain && *in_vain >= MAX_IN_VAIN)) {
 		/* Send Done */
 		packet_buf_write(req_buf, "done\n");
 		ret = 1;
@@ -1444,6 +1445,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	int haves_to_send = INITIAL_FLUSH;
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
+	int *in_vain_p = NULL;
 
 	if (args->no_dependents) {
 		negotiator = NULL;
@@ -1499,7 +1501,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			}
 			if (send_fetch_request(negotiator, fd[1], args, ref,
 					       &common,
-					       &haves_to_send, &in_vain,
+					       &haves_to_send, in_vain_p,
 					       reader.use_sideband))
 				state = FETCH_GET_PACK;
 			else
@@ -1512,7 +1514,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				state = FETCH_GET_PACK;
 				break;
 			case 1:
-				in_vain = 0;
+				in_vain_p = &in_vain;
 				/* fallthrough */
 			default:
 				state = FETCH_SEND_REQUEST;
