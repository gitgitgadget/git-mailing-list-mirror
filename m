Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE5BC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F0A61051
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 09:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbhHJJuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 05:50:13 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:49544 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbhHJJuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 05:50:09 -0400
Date:   Tue, 10 Aug 2021 09:49:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628588985;
        bh=P0E85WRikv930WDKCP+Cj2ahmOiKMlDIFowoAiEUuPE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=tuYEEv9F0JOC7or3TG5Rc8CjMDNe6oJmMie2vi58dG1s4pgAWJyyrrMGI9AYUUE0M
         2WqqpAvv9OxT+HmGaj5YMAHyo/uS37TXRQO0+f4I/+CMKY7zYsSpG3Dl+BqnYJLzL5
         BXKjfl9OlOZgizZK40hVdiLCLQgFlR0l2YJlkU7W0bEQQucIggimlyxKLB1E71N0BM
         9cIh3MV864dhRtEwzsyv7+hcUYaW8nSwdIHUGIcj7GX2JLRrQSmhKRRqpipfQxEGof
         RvilU0rSC/zo6QgHgU9EX+hbX0vIRHCn3RNdFdU5uhTderoAQrT+VdIH0Z0LJvZS73
         mjJ2Z+AZM0UPg==
To:     git@vger.kernel.org
From:   Kim Altintop <kim@eagain.st>
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, jrnieder@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH 3/3] docs: clarify the interaction of transfer.hideRefs and namespaces
Message-ID: <20210810114941.GE41632@schmidt.localdomain>
In-Reply-To: <20210809175530.75326-4-kim@eagain.st>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210809175530.75326-4-kim@eagain.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/config/transfer.txt b/Documentation/config/tra=
nsfer.txt
> index 505126a780..09ebb399ce 100644
> --- a/Documentation/config/transfer.txt
> +++ b/Documentation/config/transfer.txt
> @@ -52,13 +52,16 @@ If you have multiple hideRefs values, later entries o=
verride earlier ones
>  (and entries in more-specific config files override less-specific ones).
>  +
>  If a namespace is in use, the namespace prefix is stripped from each
> -reference before it is matched against `transfer.hiderefs` patterns.
> -For example, if `refs/heads/master` is specified in `transfer.hideRefs` =
and
> -the current namespace is `foo`, then `refs/namespaces/foo/refs/heads/mas=
ter`
> -is omitted from the advertisements but `refs/heads/master` and
> -`refs/namespaces/bar/refs/heads/master` are still advertised as so-calle=
d
> -"have" lines. In order to match refs before stripping, add a `^` in fron=
t of
> -the ref name. If you combine `!` and `^`, `!` must be specified first.
> +reference before it is matched against `transfer.hiderefs` patterns. For
> +example, if `refs/heads/master` is specified in `transfer.hideRefs` and =
the
> +current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master`=
 is
> +omitted from the advertisements. If `uploadpack.allowRefInWant` is set,
> +`upload-pack` will treat `want-ref refs/heads/master` in a protocol v2
> +`fetch` command as if `refs/heads/master` was unknown. Note, however, th=
at
> +`receive-pack` will still advertise the object id `refs/heads/master` is
> +pointing to, but will conceil the name of the ref. In order to match ref=
s
> +before stripping, add a `^` in front of the ref name. If you combine `!`=
 and
> +`^`, `!` must be specified first.
>  +
>  Even if you hide refs, a client may still be able to steal the target
>  objects via the techniques described in the "SECURITY" section of the

I'd appreciate some feedback on this one before rerolling. Having looked at=
 the
code many times recently, it makes sense to me, but that could be different=
 for
someone with less fresh memory. Thanks!

