Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF5F1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 19:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754598AbdCMTDN (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 15:03:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51140 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754539AbdCMTCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 15:02:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA66783803;
        Mon, 13 Mar 2017 15:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4OzFFTEk5n7IzEqf+qCi+TP1drI=; b=WPQooz
        yD6hCDA6o1Whqq523uwY0+07whggqDfQqntG9XrDAv+bychTYhsErr+UvYbNptag
        42ZV8nyIygKM1Nu/ft70ybTpaA2im1/uZ/KcbDpV4NN2cgd2ni91ETAJ+zoLAyq0
        MPEYJmV7puxfDP9vixTAnw/le5QHucaFg+pIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vUocGOGJPj59yEvO0aosmPQ8kNM8gaJC
        Tb1t5BWh+ZKXkGKiTdJmFZhjKURnTfMOeA4iN9kooQ66mJGPPi1c73ZRZpJNnxmg
        jLMwYm7mdM+V11ladVrqMDYtS9xhHNFuJFeD1MbAznxQlHvWTmttTlPpFwwtOcE9
        I/WlRWutoP8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC73483802;
        Mon, 13 Mar 2017 15:02:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EE9683801;
        Mon, 13 Mar 2017 15:02:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox>
        <20170313175640.14106-1-davvid@gmail.com>
Date:   Mon, 13 Mar 2017 12:02:40 -0700
In-Reply-To: <20170313175640.14106-1-davvid@gmail.com> (David Aguilar's
        message of "Mon, 13 Mar 2017 10:56:40 -0700")
Message-ID: <xmqqh92xrodr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1E73C66-081F-11E7-A4DA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> -		if (S_ISLNK(lmode)) {
> +		if (S_ISLNK(lmode) && !is_null_oid(&loid)) {
>  			char *content = read_sha1_file(loid.hash, &type, &size);
>  			add_left_or_right(&symlinks2, src_path, content, 0);
>  			free(content);
>  		}
>  
> -		if (S_ISLNK(rmode)) {
> +		if (S_ISLNK(rmode) && !is_null_oid(&roid)) {
>  			char *content = read_sha1_file(roid.hash, &type, &size);
>  			add_left_or_right(&symlinks2, dst_path, content, 1);
>  			free(content);

On this part I didn't comment in my previous message, but what is
the implication of omitting add-left-or-right and not registering
this symbolic link modified in the working tree to the symlinks2
table?

I am wondering if these should be more like

	if (S_ISLNK(lmode) {
		char *content = get_symlink(src_path, &loid);
		add_left_or_right(&symlinks2, src_path, content, 0);
                free(content);
	}                

with get_symlink() helper that does

 - if the object name is not 0{40}, read from the object store

 - if the object name is 0{40}, that means we need to read the real
   contents from the working tree file, so do the "readlink(2) if
   symbolic link is supported, otherwise open/read/close the stub
   file sitting there" thing.

Similary to the right hand side tree.

Discarding "content" after reading feels wasteful, as that is the
information we would be using when populating the rstate and lstaten
working trees later in the loop, but that would probably need a
larger surgery to the code to optimize, I would imagine.


