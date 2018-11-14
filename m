Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE831F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeKNPyM (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:54:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57976 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeKNPyM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:54:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B23BF117E67;
        Wed, 14 Nov 2018 00:52:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SJKGVqALNSlEAhPB5sqY9NtH/L4=; b=iOVzrK
        A7xgEVdtMIU2/UM5WbSHoR0aMoPf2uTaMawdOs9LsC3c8rz7bj22ukOnnzvDcMiL
        qdxD3J1/kS5oUOmDZqwc5qbyOr4fTg37+ZjKcijTXw1BVIKj4EXEJVrJGYA5yYRv
        To9SMe1qezk3DoxnYGeDCO/kWnPVOfp53Z78o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AQsIyRageVemR/XDNeHTD4g1QFFqgnHd
        ZrIFOvIEW6d0XtgkrZQ5XGxIF2H4WNjfWhEifp0Jgo639SLyVi8S2NZYaPgQnTbO
        Oeyaa5zaYYqHOJUR/SmqqqYcDp9tQ5NX0+MwTDB3oeb6d4Ij8UG+GbQ/Thd3t1Wn
        uNcD+DkpEmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9895117E66;
        Wed, 14 Nov 2018 00:52:26 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 22077117E65;
        Wed, 14 Nov 2018 00:52:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Some left-over add-on for bw/config-h
References: <pull.78.git.gitgitgadget@gmail.com>
Date:   Wed, 14 Nov 2018 14:52:24 +0900
In-Reply-To: <pull.78.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Tue, 13 Nov 2018 07:05:43 -0800 (PST)")
Message-ID: <xmqqo9asnr3b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76C3D966-E7D1-11E8-8AD4-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Back when bw/config-h was developed (and backported to Git for Windows), I
> came up with this patch. It seems to not be strictly necessary, but I like
> the safety of falling back to the Git directory when no common directory is
> configured (for whatever reason).

Shouldn't that be diagnosed as an error with BUG()?  That is, if we
know there is the current repository, and if commondir is not set,
isn't it a bug that we want to look into in the start-up sequence?

The phrase "for whatever reason" makes me wonder if this is truly
"defensive programming", rather than just sweeping the bug under the
rug.

FWIW, with this toy patch applied on top of this patch, all tests
that I usually run seem to pass.

 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index c5726af14d..e667e2ebce 100644
--- a/config.c
+++ b/config.c
@@ -1669,7 +1669,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (opts->commondir)
 		repo_config = mkpathdup("%s/config", opts->commondir);
 	else if (opts->git_dir)
-		repo_config = mkpathdup("%s/config", opts->git_dir);
+		BUG("git-dir exists but no commondir?");
 	else
 		repo_config = NULL;
 
