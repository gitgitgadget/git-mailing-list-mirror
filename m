Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43B41F461
	for <e@80x24.org>; Mon,  8 Jul 2019 19:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbfGHTBj (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 15:01:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50973 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfGHTBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 15:01:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E1C914C9C3;
        Mon,  8 Jul 2019 15:01:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kz0E5xprPLf1DKMf/ixriOE7JbE=; b=GZGIXZ
        E4HiAYdQzS8ajDWC7c9u1Y8gMCGRc07mAoEtNZbH74DFeEz0+rcyo4lEDFDQNgAS
        W9So6Cr+mZ/CouC/Q/dhtYRMj7W/igsRuuDBRH27Lpv4qmE9ZGtBTHVhaUFJQSHz
        xlTIE81sN/T9FSeoUJg8bo1YgtYSUz5bnWUMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PzaXkjz9X9omobMHvkxvQgFSbheKbgLY
        4GSANkf61VHFJRUByP12l5BAv4fuyF1j77Kp5g0y9bamrD3jS5BidN3w35g+ea8Z
        xcZWQ/HugBCUACZYK4gun+TmomsP0Hud+mQ4lJN9joD/9tdL7BVg2ahCkhBY0SFG
        V2F+smwxBrM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DECF14C9C2;
        Mon,  8 Jul 2019 15:01:37 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A67B314C9BF;
        Mon,  8 Jul 2019 15:01:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     paulus@samba.org, max@max630.net, git@vger.kernel.org
Subject: Re: [PATCH] gitk: fix --all behavior combined with --not
References: <20190704080907.GA45656@book.hvoigt.net>
Date:   Mon, 08 Jul 2019 12:01:35 -0700
In-Reply-To: <20190704080907.GA45656@book.hvoigt.net> (Heiko Voigt's message
        of "Thu, 4 Jul 2019 10:09:07 +0200")
Message-ID: <xmqq4l3wz6y8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF603F7E-A1B2-11E9-86A1-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> In commit 4d5e1b1319 ("gitk: Show detached HEAD if --all is specified",
> 2014-09-09) the intention was to have detached HEAD shown when the --all
> argument is given.

The "do we have --all?" test added by that old commit is not quite
satisfying in the first place.  E.g. we do not check if there is a
double-dash before it.  This change also relies on an ancient design
mistake of allowing non-dashed options before a dashed one, adding
more to dissatisfaction by making a future change to correct the
design mistake harder.

I think in the longer term we should consider changing "git
rev-parse --all" to include HEAD in the concept of "all refs"
instead.  But in the meantime, this patch is not making things
drastically wrong, so let's take it as is.

Thanks.

>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index a14d7a1..19d95cd 100755
> --- a/gitk
> +++ b/gitk
> @@ -295,7 +295,7 @@ proc parseviewrevs {view revs} {
>      if {$revs eq {}} {
>  	set revs HEAD
>      } elseif {[lsearch -exact $revs --all] >= 0} {
> -	lappend revs HEAD
> +	linsert revs 0 HEAD
>      }
>      if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
>  	# we get stdout followed by stderr in $err
