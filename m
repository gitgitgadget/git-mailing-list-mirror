Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22124C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59F7227BF
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XoqHi25w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLSSL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:11:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65341 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSSLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:11:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9697E3023E;
        Thu, 19 Dec 2019 13:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MRktqqqWYixZiLJuQKb5qDsugBU=; b=XoqHi2
        5wFGEHvge2tJSYDhx+tFBiVDS+Qu172Uqiaeq7ibkIfbhZa22RZ4u6S/I0ROdfJb
        pFwUWQFd18gntqvd0x5IaHvWRNUs9RPkt6k9/D01HHuW13X27aHLN4eDoxIGMXe/
        MYRzwxOiboMA0Ev7IfS6dUHgEu4ymRwYXIUP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vi+aEcE/behohux5pvr06MD90bhygHjf
        GTIAN2fGb2PGowGXN51aHce/a08TpCjKVSriYXp9N1ByTobAWT8IFAY3SjUsi72r
        kJGiALpaNyrHBySmVW36XFy1Oj2uhqEFlBwaY+l3M9fUOce9+fp44ZEWK2jWXupy
        WALqj6oNq+M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EA263023D;
        Thu, 19 Dec 2019 13:11:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 001EC3023C;
        Thu, 19 Dec 2019 13:11:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Ed Maste <emaste@FreeBSD.org>, git@vger.kernel.org,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] sparse-checkout: improve OS ls compatibility
References: <20191219015833.49314-1-emaste@FreeBSD.org>
        <20191219024518.GA3411@dcvr>
Date:   Thu, 19 Dec 2019 10:11:21 -0800
In-Reply-To: <20191219024518.GA3411@dcvr> (Eric Wong's message of "Thu, 19 Dec
        2019 02:45:18 +0000")
Message-ID: <xmqqpngkb2ye.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6D4DEB2-228A-11EA-8CD7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> But using a shell for loop seems doable, here, since there
> doesn't seem to be wonky characters.  I've done this in the past
> when I had to fix a system without "ls".
>
> This goes on top of your patch:
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 3a3eafa653..a431d05643 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -6,7 +6,7 @@ test_description='sparse checkout builtin tests'
>  
>  ls_no_git()
>  {
> -	ls -1 "$1" | grep -v .git
> +	( cd "$1" && for i in *; do echo "$i"; done )
>  }

Hmph, my honest me is very tempted to say

 (1) don't run your tests as 'root', as that would break many tests
     with prerequisite SANITY

 (2) fix your "ls" to behave

but if you want to list paths that match shell glob *, this would do

	(cd "$1" && printf "%s\n *)

without any loop (other than the one printf gives us implicitly for
free), wouldn't it?

Note that the helper function's name no longer reflects what it does
with such a change, so it needs to be renamed.  Together with style
fix, perhaps

	ls_no_dot () {
		(cd "$1" && printf "%s\n *)
	}

is what we want, if somebody wants to keep using a broken /bin/ls?
