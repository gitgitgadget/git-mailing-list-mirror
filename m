Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C64C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 21:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbiBPVtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:49:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiBPVtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 16:49:10 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4D2A795F
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 13:48:57 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF5D4F8E61;
        Wed, 16 Feb 2022 16:48:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DQX1MoafHVpH
        iTbaNRgoEFs1CaEj8NNSbGwx7WCtVx0=; b=SlGhSi2/HvOTV9+98Kpq0NWobVzJ
        oR4XMpQkfkSDVS9zdbYvW+gSqzXWZX8JcyzlIAO7Sls0hIxRrgnks0tsqyECOFUC
        h+QwaoK6L6An97D8ZBQ4/aXPSov5GR7Vhzu6lD+OdkVXq5x35FY/oj2vRIxW7pvV
        QrxD5GBFsDM1WPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7661F8E60;
        Wed, 16 Feb 2022 16:48:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 499EEF8E5F;
        Wed, 16 Feb 2022 16:48:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] diff.[ch]: have diff_free() call
 clear_pathspec(opts.pathspec)
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
        <patch-1.2-1c6c7f0f52f-20220216T105250Z-avarab@gmail.com>
Date:   Wed, 16 Feb 2022 13:48:55 -0800
In-Reply-To: <patch-1.2-1c6c7f0f52f-20220216T105250Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 16 Feb
 2022 11:56:28 +0100")
Message-ID: <xmqqh78ycwjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D8A7D70-8F72-11EC-A62D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/diff.c b/diff.c
> index c862771a589..0aef3db6e10 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6345,6 +6345,7 @@ void diff_free(struct diff_options *options)
> =20
>  	diff_free_file(options);
>  	diff_free_ignore_regex(options);
> +	clear_pathspec(&options->pathspec);
>  }
> =20
>  void diff_flush(struct diff_options *options)

Interesting.  As diff_flush() is the way to conclude the diff
session whose state was kept in the diff_options structure, it
probably makes sense to allow pathspec to be also cleared from
there.  It is somewhat surprising that we didn't do this when we
introduced diff_free(), but better late than never ;-)

> diff --git a/notes-merge.c b/notes-merge.c
> index b4a3a903e86..7ba40cfb080 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -175,7 +175,6 @@ static struct notes_merge_pair *diff_tree_remote(st=
ruct notes_merge_options *o,
>  		       oid_to_hex(&mp->remote));
>  	}
>  	diff_flush(&opt);
> -	clear_pathspec(&opt.pathspec);
> =20
>  	*num_changes =3D len;
>  	return changes;
> @@ -261,7 +260,6 @@ static void diff_tree_local(struct notes_merge_opti=
ons *o,
>  		       oid_to_hex(&mp->local));
>  	}
>  	diff_flush(&opt);
> -	clear_pathspec(&opt.pathspec);
>  }
> =20
>  static void check_notes_merge_worktree(struct notes_merge_options *o)


Looks quite sensible.  Will queue.  Thanks.

