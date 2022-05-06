Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B675C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388598AbiEFQea (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443889AbiEFQeY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 12:34:24 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C80D46
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:30:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B666417D5F0;
        Fri,  6 May 2022 12:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b0A1n5tG9/QQpIAhwuu3cp/DJZ+FnKtvKTWlxh
        gz+ZA=; b=ryJD+Vt0xi9vTPpDbjAIlJP5ald1gdNm2L0V9iVjCyhQgaqDXt0C8R
        adzugYqsp+Gg3OwhG9vlYGYpPvuf78QuSxN/9wrQDfsnuKDbp0+YFP31HugAo5nc
        b/1yQMJTxZu8XtVH41bA8E3y/coCx6YGlxB8DHgx9CuylxSMkJ15c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF95717D5ED;
        Fri,  6 May 2022 12:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5956217D5E8;
        Fri,  6 May 2022 12:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Taylor Blau <me@ttaylorr.com>, <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Crashes in t/t4058-diff-duplicates.sh
References: <YnOQmVFVRuqnanMi@pflmari> <YnSWgDdxgm+XWiLt@nand.local>
        <YnT19KB2XkBrJOLQ@pflmari>
Date:   Fri, 06 May 2022 09:30:34 -0700
In-Reply-To: <YnT19KB2XkBrJOLQ@pflmari> (Alex Riesen's message of "Fri, 6 May
        2022 12:18:28 +0200")
Message-ID: <xmqqv8uioc7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB217C58-CD59-11EC-ACBD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> Taylor Blau, Fri, May 06, 2022 05:31:12 +0200:

>> t4058.16, which blames back to ac14de13b2 (t4058: explore duplicate tree

That commit talks about "trees with duplicate entries".  Does it
mean a bad history where a tree object has two or more entries under
the same name?  We should of course be catching these things at fsck
time and rejecting at network transfer time, but I agree it is not a
good excuse for us to segfault.  We should diagnose it as a broken
tree object and actively refuse to proceed by calling die().
