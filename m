Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D1C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31020733
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sy9YCOCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBJWYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:24:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51787 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWYw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:24:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86947A1703;
        Mon, 10 Feb 2020 17:24:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VaUXQQhXQ7GhH5wBDWQAzTGMh3U=; b=Sy9YCO
        CLRQIkA8JJMyFetgCqPw9rpgB3litj3jGZIv+5KgvIHNe4b4Gtz8h5wZWFZzKdEp
        x8+qK+hgCEToqsFU3R71y2aZ7/JLQ1kmQrSNyWi2bcel8FUD+IYSadFDbFux4Dc9
        XHDWMXYJUepXt2/UIVROURTa0W+MZG8axHC3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lXKoSxAZCgFG9jUJ71+HPxvUIZ8zB/YC
        npLr+VaHGcRqy62YMM4U5ijB7Lco5mU0irclEzFo/xH/ibF1Xe+mOuvOxgsZx3Vl
        leg1wti8jv8XxxSmwD1Q/+hgDwrzPN/vMC6Vy/OGzubft62PrgUbjfmIwU0zYdZn
        fG1oC6L5HAs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80382A1702;
        Mon, 10 Feb 2020 17:24:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B2050A1700;
        Mon, 10 Feb 2020 17:24:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v4 2/6] git-p4: create new function run_git_hook
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <596b18e5e50a956d9c52ad4a90fab3e6d309d356.1581372376.git.gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:24:47 -0800
In-Reply-To: <596b18e5e50a956d9c52ad4a90fab3e6d309d356.1581372376.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Mon, 10 Feb 2020 22:06:12
        +0000")
Message-ID: <xmqqr1z2xeq8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26A389F2-4C54-11EA-A7B3-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2337,12 +2405,15 @@ def run(self, args):
>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>                       (len(commits), num_shelves))
>  
> -        hooks_path = gitConfig("core.hooksPath")
> -        if len(hooks_path) <= 0:
> -            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> -
> -        hook_file = os.path.join(hooks_path, "p4-pre-submit")
> -        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
> +        try:
> +            if not run_git_hook("p4-pre-submit"):
> +                print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nYou can skip " \
> +                    "this pre-submission check by adding\nthe command line option '--no-verify', " \
> +                    "however,\nthis will also skip the p4-changelist hook as well.")
> +                sys.exit(1)
> +        except Exception as e:
> +            print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
> +                "with the error '{0}'".format(e.message) )
>              sys.exit(1)

If I am reading the patches correctly, we do not have the
"--no-verify" option at this point in the series.  Shouldn't this
step limit itself to replace the removed lines we see above
with just a singlie liner:

	if not run_git_hook("p4-pre-submit"):
		sys.exit(1)

instead?

Also, af the end of these 6-patch series, I do not see a change to
guard this part of the code with "if not self.no_verify" like the
previous round did.


