Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331BE1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 10:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKBKQ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 06:16:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57846 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKBKQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 06:16:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC1653AC8E;
        Sat,  2 Nov 2019 06:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6rOOuSCYTWWdrfqHpiri0AdUo8s=; b=xQLSRU
        4d5vJ8OYjgJVLgBwibzktORHNx+PrkGVlat9WTdJNFjSDHm+a+caSwKYaUhyh7+Y
        DDdmjUPWW0xKcoNC0bGxCpJWNE6k1q+qP+PXJyBZSVktd1DHp4e2yzbnrtsG7W9y
        4bWdxr9ExWpzh0EpSnUOij1kly1Q340zvHz5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oMOI85e8MNBwMhrYULCPr9MR+VFSwNgW
        4wxo5lrk/+4OkUF+N4na2jyFKVRkodHdib3MiVbwCbhxSiVizOT6HhYw0Pu+FncC
        D4abMiopDV7IYWBiqD+jLoHGXeTx7+1B45vONwudCYk5XhF8x6YxfQq7sswVHBfn
        o76EzeTGjIs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C450A3AC8D;
        Sat,  2 Nov 2019 06:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 305503AC8C;
        Sat,  2 Nov 2019 06:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Davide Berardi <berardi.dav@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
References: <20191101002432.GA49846@carpenter.lan>
        <nycvar.QRO.7.76.6.1911012000160.46@tvgsbejvaqbjf.bet>
        <20191101193558.GA1169@sigill.intra.peff.net>
Date:   Sat, 02 Nov 2019 19:16:23 +0900
In-Reply-To: <20191101193558.GA1169@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 1 Nov 2019 15:35:58 -0400")
Message-ID: <xmqqh83m1t3c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2CE3334-FD59-11E9-8A34-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't know how often this would actually help users, though. It _is_ a
> pretty rare situation to ask for a non-commit. So maybe it's all
> over-engineering, and we should start with just die(). If somebody comes
> along later and wants to enhance it, it should be pretty
> straightforward.

I like that; after update_head() finishes, there are a few clean-up
things that the caller wants to do besides a checkout() call, but if
we make update_head() return a failure, perhaps the caller side
change would be as small as the attached patch.  That would go nicely
with the "make the result just barely usable" approach of leaving an
unborn master branch I suggested in a separate message, I would think.

 builtin/clone.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c46ee29f0a..fa0558fa3e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1246,7 +1246,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local, filter_options.choice);
 
-	update_head(our_head_points_at, remote_head, reflog_msg.buf);
+	err = update_head(our_head_points_at, remote_head, reflog_msg.buf) < 0;
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
@@ -1265,8 +1265,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
-	fetch_if_missing = 1;
-	err = checkout(submodule_progress);
+	if (!err) {
+		fetch_if_missing = 1;
+		err = checkout(submodule_progress);
+	}
 
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);



