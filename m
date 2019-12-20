Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AECC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B032082E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 21:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D61B2UXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfLTVfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:35:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60716 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfLTVfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 16:35:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB3013A473;
        Fri, 20 Dec 2019 16:34:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FVrUy/4eKEvev2jtWmrxudpQf0E=; b=D61B2U
        XZOc2bn5wFhoUTidwIExJBl+22geFIh6RhI791WDGHRFwvsJEu87fC+I7qCpoWS+
        hUvOMJO9gObqN8y4hLwU58m4zNAwl3rv3PhOnZf17RqpPdoDYzcBtF09GZH8AlFw
        +uCu9BJ+RESiqesr6q0HU2swQRzOp6EMP4tUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CS//TS1v3GmPt/ov5sbPXFzAeYYUqvHQ
        bmTSjJubxJu39pMB8H2h46nJvdCFZwmZ9+35MNELujLEePsYvPaa0OBtZtceVnHi
        a4j8CMpOr12sdIDaqrAdJxVCCp2NU2rHqgRXfpZM0vQRZyVg+x3v5TBMDXDcnClN
        rMJCRzYsWZo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E1E3A472;
        Fri, 20 Dec 2019 16:34:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 172293A470;
        Fri, 20 Dec 2019 16:34:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, liu.denton@gmail.com,
        plroskin@gmail.com, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 03/15] rebase, sequencer: remove the broken GIT_QUIET handling
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <b99feebae111814be75dd99b5547539f8a764339.1576861788.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 13:34:55 -0800
In-Reply-To: <b99feebae111814be75dd99b5547539f8a764339.1576861788.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 20 Dec 2019
        17:09:36 +0000")
Message-ID: <xmqqeewy8yv4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9168E762-2370-11EA-B73E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> The GIT_QUIET environment variable was used to signal the non-am
> backends that the rebase should perform quietly.  The preserve-merges
> backend does not make use of the quiet flag anywhere (other than to
> write out its state whenever it writes state), and this mechanism was
> broken in the conversion from shell to C.  Since this environment
> variable was specifically designed for scripts and the only backend that
> would still use it is no longer a script, just gut this code.

Nice to see a useless code go ;-)
