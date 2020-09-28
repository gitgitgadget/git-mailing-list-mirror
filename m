Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CAC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C436206C9
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qRAw9Mqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgI1XYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:24:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58514 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgI1XYO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:24:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7FB68E3E3;
        Mon, 28 Sep 2020 18:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IQ6QyQRGRvhgUcZQ1snVDChdKnM=; b=qRAw9M
        qwxCNI6+livDwkJBHc22YDIHoPrQtDt2kyky4xxUrX4iuQglpJroeXLvMD2InE3G
        ivR1WV0vWxDrEpyqzTzW8KxTAYBlegx6awDhbCyMs0l4g7Q6WwK/tvLkbh2Tafc9
        tm99q+/HBlNTfcAQEAPYt437ARltZ9pUauqe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aZxTbcTpRy8EvHQEcDqnN/oq7bZc+giS
        /24u/8GzvIkw3kmLk7ULWrwXR68tavpiwywy5sO8L5AZEdk5aIqVT46U4BIYjK1C
        4eJjNBo7lbJnh8oToiGzxRUAJZD1vvwsBVp0m/ahvnRdUERNCh0VdRXKlDIxxFDj
        MpH+ZBHzPtA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA5408E3E1;
        Mon, 28 Sep 2020 18:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 287638E3E0;
        Mon, 28 Sep 2020 18:07:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: when -R, also reverse list of sections
References: <20200928212038.1625698-1-jonathantanmy@google.com>
Date:   Mon, 28 Sep 2020 15:07:42 -0700
In-Reply-To: <20200928212038.1625698-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 28 Sep 2020 14:20:38 -0700")
Message-ID: <xmqqy2ktk11t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 082F344C-01D7-11EB-9F4A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> A patch changing a symlink into a file is written with 2 sections (in
> the code, represented as "struct patch"): firstly, the deletion of the
> symlink, and secondly, the creation of the file. When applying that
> patch with -R, the sections are reversed, so we get:
>
>  (1) creation of a symlink, then
>  (2) deletion of a file.

Good observation.

But I have to wonder if it breaks the support for (arguably outside
the Git usecase) input that has more than one patch that touches the
same path to blindly reverse the order of all patches (instead of
the obvious implementation of the fix for the above stated problem
--- i.e. make sure the first patch is a deletion of a symlink and
what immediately follows is a creation of a regular file, and swap
them only in such a case).
