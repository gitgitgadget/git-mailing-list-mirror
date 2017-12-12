Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC191F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbdLLABt (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:01:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55592 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751289AbdLLABs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:01:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE7C6B3169;
        Mon, 11 Dec 2017 19:01:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=31i9G34LCUNs
        CH44qZ1/orlOpJs=; b=KWr0eOguXe+oZGTECH+FRRvcpz8urirQP5mng9CpMCM5
        IZ04EjRqgM7nbwaOdqvAOyv+AbmdwJr32JjqBKOYL9dn9JImR1yynZkTktH3eXCL
        3MN7lXOSGix2uMuhaoCQfTx3GXzRZmrIdHwxcKZj0ocawEvqO71PVHOJa/QZsWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IMA6ec
        c8we+o72rGTuwAyb6xsogq7IITvTCVJbVaTc3gautUxIzR0xzrzpGipS1wYrc+lH
        M1+/uMFu5fq+KxgkO9b3ZRqDc4uX1/qlu4QAjCz/fyVuxQLPP+63DsnUVbvtdxiA
        oWw5X8CQwj0NFXpLupj/DcmaljcC4N0k3ppzs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A68CBB3168;
        Mon, 11 Dec 2017 19:01:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18C42B3167;
        Mon, 11 Dec 2017 19:01:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] clone: support 'clone --shared' from a worktree
References: <20171211231612.29275-1-sunshine@sunshineco.com>
Date:   Mon, 11 Dec 2017 16:01:45 -0800
In-Reply-To: <20171211231612.29275-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 11 Dec 2017 18:16:12 -0500")
Message-ID: <xmqq4low4xw6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A55027BE-DECF-11E7-B4F9-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> When worktree functionality was originally implemented, the possibility
> of 'clone --local' from within a worktree was overlooked, with the
> result that the location of the "objects" directory of the source
> repository was computed incorrectly, thus the objects could not be
> copied or hard-linked by the clone. This shortcoming was addressed by
> 744e469755 (clone: allow --local from a linked checkout, 2015-09-28).
>
> However, the related case of 'clone --shared' (despite being handled
> only a few lines away from the 'clone --local' case) was not fixed by
> 744e469755, with a similar result of the "objects" directory location
> being incorrectly computed for insertion into the 'alternates' file.
> Fix this.
>
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/clone.c         | 3 ++-
>  t/t2025-worktree-add.sh | 6 ++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b22845738a..6ad0ab3fa4 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -452,7 +452,8 @@ static void clone_local(const char *src_repo, const=
 char *dest_repo)
>  {
>  	if (option_shared) {
>  		struct strbuf alt =3D STRBUF_INIT;
> -		strbuf_addf(&alt, "%s/objects", src_repo);
> +		get_common_dir(&alt, src_repo);
> +		strbuf_addstr(&alt, "/objects");
>  		add_to_alternates_file(alt.buf);
>  		strbuf_release(&alt);
>  	} else {

Makes sense.  Will queue.

Thanks.
