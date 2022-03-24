Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5685EC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiCXEOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 00:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiCXEOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 00:14:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F2F6176
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:13:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9482018AEBF;
        Thu, 24 Mar 2022 00:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Rzibu+zm2i5qn6u2GxDEPMGpU
        Mt0U7vIEzr7Gsb9OVE=; b=rSt/37qcvkmiG+ozKfawzVPce7D9pP7R6pzVFYAnt
        XfBQy38JuG3y1hwp12Q0i93ZNcaXyGyWs+sBvczXH4MZBChAilpJIu+E5b5xotb2
        JX3iFq1kXjPxjpGg4XCxrZmwZ2/NAWFqD5XrfEwlYC3ssAmOIUY1wkXi+AHdgqIE
        cU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CCEA18AEBE;
        Thu, 24 Mar 2022 00:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EBA3818AEBC;
        Thu, 24 Mar 2022 00:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 01/27] t/helper/test-fast-rebase.c: don't leak
 "struct strbuf"
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-01.27-8fbafe61053-20220323T203149Z-avarab@gmail.com>
Date:   Wed, 23 Mar 2022 21:13:05 -0700
Message-ID: <xmqqr16sm1im.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B543EE1A-AB28-11EC-8D3B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
> write conflict state to working tree, index, and HEAD, 2021-05-20)
> changed this code to move these strbuf_release() into an if/else
> block.
>
> We'll also add to "reflog_msg" in the "else" arm of the "if" block
> being modified here, and we'll append to "branch_msg" in both
> cases. But after f9500261e0a only the "if" block would free these two
> "struct strbuf".
>
> This change is needed so that a subsequent addition of a "goto
> cleanup" pattern when adding release_revisions() doesn't solve this
> unrelated bug while it's at it.

With or without the goto-cleanup change, this fix alone is the right
fix for these leaks.  I would not have written the last paragraph if
I were working on this topic ;-)


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/helper/test-fast-rebase.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
> index fc2d4609043..993b90eaedd 100644
> --- a/t/helper/test-fast-rebase.c
> +++ b/t/helper/test-fast-rebase.c
> @@ -201,8 +201,6 @@ int cmd__fast_rebase(int argc, const char **argv)
>  		}
>  		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
>  			die(_("unable to update HEAD"));
> -		strbuf_release(&reflog_msg);
> -		strbuf_release(&branch_name);
> =20
>  		prime_cache_tree(the_repository, the_repository->index,
>  				 result.tree);
> @@ -221,5 +219,8 @@ int cmd__fast_rebase(int argc, const char **argv)
>  	if (write_locked_index(&the_index, &lock,
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		die(_("unable to write %s"), get_index_file());
> +
> +	strbuf_release(&reflog_msg);
> +	strbuf_release(&branch_name);
>  	return (result.clean =3D=3D 0);
>  }
