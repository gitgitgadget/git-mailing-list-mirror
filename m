Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26DA7207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 20:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbcILUbf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 16:31:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56838 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750832AbcILUbe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 16:31:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1ADA43D843;
        Mon, 12 Sep 2016 16:31:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HjCLeOmTjW3EY/Qat5II8m+C7i4=; b=QVdOvS
        GsT00MFC7reZ5JFisqx2XM6Hp6PQZV1vxyTeczWT015eCVdMtTiEGCdyQCFcYjsV
        j5MaSTFz/rv0TAANkQt3A1Q3St72UWtOOnAobGYrD4hyK/Db+dsx5zAl0Ybt75u5
        2WdIYlbOjFgVNPUD+E+LHBQLr6O84aJhFP43A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GLMif6eZPOW8v/8F7OsiMU6SwfiGqKML
        3D6vcYwvaLrv/tIm/+M0zNL4oq63pJniMLdYNBomd8g6v6TQUZjqdBgarJ2oQk3R
        Mb48IgM6eHunum+CX4ezFWFPntoazPuFazzKzNd3NfbCREGXLynQAaTLIO/elKLO
        nse4QtbWzMg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 128333D842;
        Mon, 12 Sep 2016 16:31:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 915C13D841;
        Mon, 12 Sep 2016 16:31:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Peart" <peartben@gmail.com>
Cc:     <git@vger.kernel.org>, <pclouds@gmail.com>,
        "'Ben Peart'" <benpeart@microsoft.com>
Subject: Re: [PATCH v2] checkout: eliminate unnecessary merge for trivial checkout
References: <20160909192520.4812-1-benpeart@microsoft.com>
        <xmqq1t0sagcm.fsf@gitster.mtv.corp.google.com>
        <13ef001d20d21$2d2ea840$878bf8c0$@gmail.com>
Date:   Mon, 12 Sep 2016 13:31:30 -0700
In-Reply-To: <13ef001d20d21$2d2ea840$878bf8c0$@gmail.com> (Ben Peart's message
        of "Mon, 12 Sep 2016 14:12:07 -0400")
Message-ID: <xmqqtwdkzwpp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4866560-7927-11E6-9466-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Peart" <peartben@gmail.com> writes:

> I completely agree that optimizing within merge_working_tree would provide 
> more opportunities for optimization.  I can certainly move the test into
> that function as a first step.

Note that "optimizing more" was not the primary point of my
response.

Quite honestly, I'd rather see us speed up _ONLY_ obviously correct
and commonly used cases, while leaving most cases that _MAY_ turn
out to be optimizable (if we did careful analysis) unoptimized, and
instead have them handled by generic but known to be correct
codepath, if it means we do NOT to have to spend mental bandwidth to
analyze not-common case--that is a much better tradeoff.

The suggestion to move the check one level down in the callchain was
primarily to avoid the proposed optimization from being overly eager
and ending up skipping necessary parts of what merge_working_tree()
does (e.g. like I suspected in the review that the proposed patch
skips the check for "you have unmerged entries" situation).
