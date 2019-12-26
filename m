Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1963EC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73D620740
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PPAr7fEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLZTWV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:22:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62625 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLZTWU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:22:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2EA39F1B4;
        Thu, 26 Dec 2019 14:22:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nopxgbLxU0FXGJfM78aBXZrl6YI=; b=PPAr7f
        EOyeWNSrh+O+TVJYYoZr131fWDRhYiR2xzyYGQbiMjoTwUhrdtOv+A9M9RAQDTIT
        6+g3pEIkfj0vtwTy/uHRWYWhX/yhYse6CVAMFRLSbVwVJy0fj/GOPyRH+k/PIPiK
        0sOZcFgjHXLGMraR741I+RwycvqIJp3lVMigU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J85TycovMGyqVOeU+KyNRk42lm6rhEOp
        qW+w9P7grITMyOi1iLDwwQNUMKGSk4Ztf3g6wWw5lhT6pWRnnpShD88CqnbS2GMQ
        1P1kM/wAIK86hNjvDalKLlsspXAx/ZwxgkqtrrpoSXkZrj5z3XsLwj/kWPEQ1CWk
        XC+QWrdBg2U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B7099F1B3;
        Thu, 26 Dec 2019 14:22:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5249C9F1B0;
        Thu, 26 Dec 2019 14:22:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Disallow writing, but not fetching commits with file names containing backslashes
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 11:22:11 -0800
In-Reply-To: <pull.682.git.git.1577382151.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 26 Dec 2019 17:42:30
        +0000")
Message-ID: <xmqqk16ilwnw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05B6FED0-2815-11EA-B9C7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> I would appreciate reviews with a particular eye on keeping users safe: I am
> not 100% certain that all relevant file writes go through the index (I think 
> that they all go through the index, but I might have well missed a corner
> case).

There are peripheral commands that do not use the index at all, such
as "archive"; piping "git archive" output to unarchiver that writes
into the filesystem would be a way.  But I do not think that
qualifies as an attack vector you are looking for.
