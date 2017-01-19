Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989E920A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbdASTqu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:46:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61586 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754438AbdASTqs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:46:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 058856059D;
        Thu, 19 Jan 2017 14:44:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aq7xs3K27uXd+3wCmOCJF0T+lSE=; b=rpmIw3
        uSqZsiOdrCu3uITYgvuO/kGzDaykTS0BclnCASAz5N/OW2nigDWCtrfER0V7lWcA
        grfk5I5G91ydUU1878/s/qMyL4zHPUadV5I50TAlmaAa6QjXT1XxL7EYpSk58N7u
        +hpnn67QJtXDuEVDrcOhpVVviRQcv0A3Cy0eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vxrBjODk63GAa0qXYUXv80NIJVhzHKxK
        ofoVCGXTxmdosQDPqaQHB1e3S+Ypvy0Tt3phpSz/oVInXorhZ3wDhGhlnxohvU2y
        s7QTcvEQnDlM30QM2/G6Qg4zYDWVLyLnWhXFzzVnuHZy+sg8c/IZmVHU4qeInXBx
        5okNgoLQHTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF4A76059C;
        Thu, 19 Jan 2017 14:44:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5448A60595;
        Thu, 19 Jan 2017 14:44:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The design of refs backends, linked worktrees and submodules
References: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
Date:   Thu, 19 Jan 2017 11:44:09 -0800
In-Reply-To: <CACsJy8CHoroX2k9GqOFmXkvvPCPN4SBeCg+6aC2WSWNSKVmWQw@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 19 Jan 2017 18:55:30 +0700")
Message-ID: <xmqq8tq625ti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B3D47C-DE7F-11E6-8DC4-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> ... A bit worried about transactions though,
> because I think per-repo and per-worktree updates will be separated in
> two transactions. But that's probably ok because future backends, like
> lmdb, will have to go through the same route anyway.

If we have per-worktree ref-store, what can be done as a useful
thing by future backends like lmdb may be to use the same single
database to store shared and per-worktree refs, similar to the way
Michael mentioned in his response to your message I am responding
to, i.e.

    I kindof think that it would have been a better design to store the
    references for all linked worktrees in the main repository's ref-store.
    For example, the "bisect" refs for a worktree named "<name>" could have
    been stored under "refs/worktrees/<name>/bisect/*".

The current design is heavily influenced by how "contrib/workdir"
lays things out, for the latter of which I take the blame X-<, but
perhaps the files backend can be retrofitted to use that layout in
the longer term?

