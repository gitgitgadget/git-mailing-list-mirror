Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40BF202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdCOSy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 14:54:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56628 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750988AbdCOSyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 14:54:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C381C7DA78;
        Wed, 15 Mar 2017 14:54:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UJsEbxQrwiF/n3QKuEdbjNUfJ6A=; b=e54ywX
        +tr5g6qJwSH3amiOQdQAypIUDrx382Zh08QTj4XrLuTZEED1SVre2WbgWVOHlVSG
        dpylJ3AwJEuHn5jY8+NfOLl/2ZpfMV2j7gUU2Nazr8CtU3NJSN94AkE1Tbfo2yjm
        7EORbzbFvYLCHamiykYXVS7q/KLySFLk0advQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dFOv2K8T7bzxhhBQTu2pZdspbPSTPfs0
        mZwu40nsnFAJplM6l5e8cVR9cRLaRdKDc8uC8K3iDC9a3oVTHVkPCqiWWojXrzxs
        iQNtlCtdSIme2yEN4HjLUy8TkOIXGaVLcAR9+0of5WzrB5/wR2C9BZdZVKN1cjY9
        SA0XFvJ/xfg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCC5C7DA77;
        Wed, 15 Mar 2017 14:54:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3297A7DA76;
        Wed, 15 Mar 2017 14:54:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: [PATCH v2 3/3] difftool: handle modified symlinks in dir-diff mode
In-Reply-To: <20170315093130.30110-1-davvid@gmail.com> (David Aguilar's
        message of "Wed, 15 Mar 2017 02:31:30 -0700")
References: <20170315093130.30110-1-davvid@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Wed, 15 Mar 2017 11:54:14 -0700
Message-ID: <xmqq8to6fk15.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDF26D70-09B0-11E7-9930-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Detect the null object ID for symlinks in dir-diff so that difftool can
> detect when symlinks are modified in the worktree.
>
> Previously, a null symlink object ID would crash difftool.
> Handle null object IDs as unknown content that must be read from
> the worktree.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Only 3/3 was re-sent; the rest are the same.

OK, so in short you did the get_symlink() thing that was brought up
in the previous round of review and everything else fell out as a
natural consequence?  That is wonderful ;-)

> @@ -397,7 +438,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  				return error("could not write '%s'", src_path);
>  		}
>  
> -		if (rmode) {
> +		if (rmode && !S_ISLNK(rmode)) {
>  			struct working_tree_entry *entry;

It still makes me wonder why the new !S_ISLNK() is done only for the
right hand side, though.  In fact, the processing done for the left
hand side and the right hand side are vastly different even without
this patch.

I suspect this is probably because the code is not prepared to drive
the underlying "diff" when given the "-R" option (if I am reading
the code correctly, argv[] that came from the end-user is appended
to "diff --raw --no-abbrev -z", so the user could ask "difftool
--dir-diff -R ..."), in which case you would see the working tree
files as the left hand side of the diff.  In the dir-diff mode,
because you want to make only the working-tree side writable (and
reflect whatever edit the user made back to the working-tree side),
the choices you have to fix it would either be forbid "-R" (which is
less preferrable as it is a more brittle solution between the two)
or read the "diff --raw" output and swap the sides when you notice
that LHS has 0{40} with non 0 mode, which is a sign that that side
represents the working tree.

Having said all that, let's focus on the "symlink" stuff in this
series.

Thanks.
