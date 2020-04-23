Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C0C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EE62077D
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 22:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LuQIdRe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDWWEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:04:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62362 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDWWEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 18:04:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 96B42CDD6A;
        Thu, 23 Apr 2020 18:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mGqPDxPNNt0NoofGhHmxWssjz/M=; b=LuQIdR
        e1rtE/IDDYX2IpVF+Mg2nWckEK1JPemdWzdrDFiVdH3vXDQVzOaiDlD85EK4haCK
        sBfI40PcjKfLc0S9w2F6hs1AJMOCpclDemyIgXKzc06t95IlgicGOXdRGI/JGecd
        1MoG5x+2/pyEbY5ZimOQj6lmVCjjK7u6IFq6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PWI831rK/nv9Ap3RU4Czvpo4z7uw5Kqz
        9dyFVmGvzS3U+yxZgtDmFieKMh7UfSmAOWOIZJqdFtEdm2zTelRshhC+xaECeZeW
        4F+ZavHaQXPGw1Jn50Rn9NWYH2KvR6oKvd34TQDCU7gqH7vj9IKNGVT7hCjpIzn9
        sjpFZ2DOJk4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EC9CCDD69;
        Thu, 23 Apr 2020 18:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3CA3CDD68;
        Thu, 23 Apr 2020 18:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com,
        dstolee@microsoft.com
Subject: Re: [PATCH 4/4] commit-graph: close descriptors after mmap
References: <cover.1587677671.git.me@ttaylorr.com>
        <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
Date:   Thu, 23 Apr 2020 15:04:19 -0700
In-Reply-To: <e05db264cb50760cab222157b436e82adeaeadc8.1587677671.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 23 Apr 2020 15:41:13 -0600")
Message-ID: <xmqq368tg8po.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6256520C-85AE-11EA-A0FE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Jeff King <peff@peff.net>
>
> We don't ever refer to the descriptor after mmap-ing it. And keeping it
> open means we can run out of descriptors in degenerate cases (e.g.,
> thousands of split chain files). Let's close it as soon as possible.

Yikes.  

Sorry, I should have looked at the use of mmap in this topioc more
carefully when we queued the series.  It is an easy mistake to make
by anybody new to the API to leave it open while the region is in
use.

With this fix, with or without the other topics still in flight, I
do not think no code touches graph_fd.  Should we remove the
graph_fd field from the structure as well?




 commit-graph.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit-graph.h b/commit-graph.h
index a0a2c4a1e5..1254eae948 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,8 +40,6 @@ struct tree *get_commit_tree_in_graph(struct repository *r,
 				      const struct commit *c);
 
 struct commit_graph {
-	int graph_fd;
-
 	const unsigned char *data;
 	size_t data_len;
 
