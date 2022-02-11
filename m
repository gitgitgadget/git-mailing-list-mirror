Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF6C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352466AbiBKSMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:12:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343603AbiBKSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 13:12:12 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60ADCE9
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 10:12:09 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 224E711263D;
        Fri, 11 Feb 2022 13:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ahCEjZRNpNfX8G6jGyzL+Mwbh6Mv1NGbI0jBw3
        9BX4k=; b=jMU0X2A32J6dOsz0o4Zon1ruSUGmkbSeFj0OQIL7DYGK1I0uWCR6KS
        GPXTxIi2XdSqzExj18G/d4XtqpbYFi1wSPZcIQusHpF+zk5Ofgo3nckDbVuK5i37
        0SjodnRHrLZyjKt+TlaH27iegMrbMqlVrsjVLZoUt7zEfhwH1Nb7o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09DFF11263C;
        Fri, 11 Feb 2022 13:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE45111263B;
        Fri, 11 Feb 2022 13:12:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
        <20220211163627.598166-4-alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 10:12:06 -0800
In-Reply-To: <20220211163627.598166-4-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 11 Feb 2022 09:36:27 -0700")
Message-ID: <xmqq1r09clxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FC16818-8B66-11EC-8205-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v3: no changes
> ---
>  gitk-git/gitk | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Please base a patch on gitk part to base on Paul's tree, not mine,
meaning that the first few lines of diff should begin like so:

	diff --git a/gitk b/gitk
	index ...
	--- a/gitk
	+++ b/gitk

and not as part of the series.

What the first two patches want to do is a good thing regardless, so
I'll take a deeper look at them and queue them.  I am very skeptical
to log.graph=yes/no configuration for obvious reasons that setting
such a variable *will* break existing tools and users.  It is not
even "it might break but we don't know until we try", as this patch
loudly demonstrates.

Thanks.

> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 23d9dd1fe0..24099ce0b8 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -411,8 +411,8 @@ proc start_rev_list {view} {
>      }
>  
>      if {[catch {
> -        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
> -                        --parents --boundary $args "--" $files] r]
> +        set fd [open [concat | git log --no-color --no-graph -z --pretty=raw \
> +                        $show_notes --parents --boundary $args "--" $files] r]
>      } err]} {
>          error_popup "[mc "Error executing git log:"] $err"
>          return 0
> @@ -559,8 +559,9 @@ proc updatecommits {} {
>          set args $vorigargs($view)
>      }
>      if {[catch {
> -        set fd [open [concat | git log --no-color -z --pretty=raw $show_notes \
> -                        --parents --boundary $args "--" $vfilelimit($view)] r]
> +        set fd [open [concat | git log --no-color --no-graph -z --pretty=raw
> +                        $show_notes --parents --boundary $args "--"
> +                        $vfilelimit($view)] r]
>      } err]} {
>          error_popup "[mc "Error executing git log:"] $err"
>          return
