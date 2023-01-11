Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864BC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 23:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjAKXZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 18:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAKXZx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 18:25:53 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42A3D5CC
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:25:49 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NskLz6DC9z1r0mv;
        Thu, 12 Jan 2023 00:25:47 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NskLz5htpz1qqlR;
        Thu, 12 Jan 2023 00:25:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id qryywI9SFbMv; Thu, 12 Jan 2023 00:25:47 +0100 (CET)
X-Auth-Info: Yqa1jXxvhutRJ49o+Ehm4rKWEJk+sTas45qtVIB7ScBp0F5BHP3IfP5DbpFAmsxW
Received: from igel.home (aftr-62-216-205-85.dynamic.mnet-online.de [62.216.205.85])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 12 Jan 2023 00:25:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id C434E2C123D; Thu, 12 Jan 2023 00:25:46 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>,
        Arthur Milchior <arthur.milchior@gmail.com>,
        git@vger.kernel.org
Subject: Re: Misleading error message on a failed `git mv`
References: <CAEcbrFc=R=3aEwEE56EvZSPSV4+RWFxt=hm7csZ7oBTR8BDQzA@mail.gmail.com>
        <Y78I5E/BCr1QQ6aL@coredump.intra.peff.net>
        <20230111214337.ybrmiyeius5xzalf@tb-raspi4>
X-Yow:  I'm not available for comment..
Date:   Thu, 12 Jan 2023 00:25:46 +0100
In-Reply-To: <20230111214337.ybrmiyeius5xzalf@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 11 Jan 2023 22:43:37
 +0100")
Message-ID: <87sfggfybp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 11 2023, Torsten Bögershausen wrote:

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 19790ce38f..58e24889c0 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -452,8 +452,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
>  		    !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
>  		    rename(src, dst) < 0) {
> +			struct stat st;
>  			if (ignore_errors)
>  				continue;
> +			if (!lstat(src, &st)) {
> +				die_errno(_("moving '%s' into destination '%s' failed"), src, dst);
> +			}

That will lose errno, though.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
