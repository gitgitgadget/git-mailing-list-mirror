Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6906C2BA19
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437AD20678
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 21:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="egbVRU//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgDEVdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 17:33:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDEVdS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 17:33:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4524C515C;
        Sun,  5 Apr 2020 17:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f1GrlYTwe4GUJfMy3drTNy31820=; b=egbVRU
        //FnHCLJ5/mR9Kgu25Z1Qyh7E5J7hSxkAYQ81piwyBOCDRPyWGiaHukitQ3iPGem
        m+VouYwPtdXeCeoSN3RJz7adfrfDz5xRFMftFKSkp7ymrDRduq5klNHPIzbDiuS6
        uxHQdfF/jyD+oJ/bLRtRzGUI64KNlBL/UuUDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hVXWM6T7hCfK1aZCsbHh/zXvSDYCzToP
        2exOOn4e12Z1Cs/FnSVyoMfWZee26oerDMvUi0gJy39sRCSx2r8cKN4KAknxf1Vm
        dcdIjoeBUt6dayy8Iqfk/FR26uZQZzW+sWKtOXe310CXmgzHx3CTr8748B9cwQav
        umuMKQjo42s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB24BC515B;
        Sun,  5 Apr 2020 17:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32A3FC5153;
        Sun,  5 Apr 2020 17:33:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 03/23] sequencer: stop leaking buf
References: <cover.1584782450.git.liu.denton@gmail.com>
        <cover.1585962672.git.liu.denton@gmail.com>
        <76585e5b1367a3adf18d761b2af9356ee64b46fd.1585962672.git.liu.denton@gmail.com>
Date:   Sun, 05 Apr 2020 14:33:08 -0700
In-Reply-To: <76585e5b1367a3adf18d761b2af9356ee64b46fd.1585962672.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 3 Apr 2020 21:11:16 -0400")
Message-ID: <xmqqzhbpwrcb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BE5CFD8-7785-11EA-9CB9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In read_populate_opts(), we call read_oneliner() _after_ calling
> strbuf_release(). This means that `buf` is leaked at the end of the
> function.

I do not think the above makes much sense.  _release() will free the
piece of memory occupied by .buf and reinitializes the strbuf, and
in doing so there is no leak.  read_oneliner() called after it
allocates and reads into there.  Freeing the resource needs to be
done after the caller is done with what read_oneliner() has read.

There is a leak, because read_oneliner() gets called and before the
code has a chance to do strbuf_reease() there is an error return.
That does not have anything to do with the call to strbuf_release()
in the middle of the function.

But that leak has nothing to do with the release called before
read_oneliner().

> Always clean up the strbuf by going to `done_rebase_i` whether or not
> we return an error.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  sequencer.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e528225e78..faab0b13e8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2485,6 +2485,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  {
>  	if (is_rebase_i(opts)) {
>  		struct strbuf buf = STRBUF_INIT;
> +		int ret = 0;
>  
>  		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
>  			if (!starts_with(buf.buf, "-S"))
> @@ -2525,7 +2526,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  			opts->keep_redundant_commits = 1;
>  
>  		read_strategy_opts(opts, &buf);
> -		strbuf_release(&buf);
> +		strbuf_reset(&buf);

As read_oneliner() has a strbuf_reset() at the beginning *anyway*,
why not just get rid of the call to _release() here instead?  After
all, there is no _release() or _reset() before the call to read_oneliner()
in the next hunk, or two calls to read_oneliner() inside the
read_strategy_opts() function called in the above.

>  		if (read_oneliner(&opts->current_fixups,
>  				  rebase_path_current_fixups(), 1)) {
> @@ -2538,12 +2539,16 @@ static int read_populate_opts(struct replay_opts *opts)
>  		}
>  
>  		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
> -			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0)
> -				return error(_("unusable squash-onto"));
> +			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0) {
> +				ret = error(_("unusable squash-onto"));
> +				goto done_rebase_i;
> +			}
>  			opts->have_squash_onto = 1;
>  		}
>  
> -		return 0;
> +done_rebase_i:
> +		strbuf_release(&buf);
> +		return ret;

This part indeed IS the right fix to the existing leak.

>  	}
>  
>  	if (!file_exists(git_path_opts_file()))
