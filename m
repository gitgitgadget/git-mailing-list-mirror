Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DFC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 18:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbhLQSQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:16:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbhLQSQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 13:16:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4082417E50A;
        Fri, 17 Dec 2021 13:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xFMRFt1VUX4R
        DfnumaLGf2FnQy4IBqJ+hveO3wlCyUg=; b=MHeyjRUMqW+q/Wc0sHR7gymdUO7n
        j1LXtY9yBTsW411vDMP7JaA7IpsLnyc3HhsuSMKI6qMAWvWUtYs0e/3neLROwHHS
        n2cEpkzKE/5ZwfGV9w2CfS56/JfH6LM58D0Bs6R0Ra/djX7xN/Ssuy2I1Xtb3nCJ
        moA9/iYC7C42PpU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3904517E509;
        Fri, 17 Dec 2021 13:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 934A917E507;
        Fri, 17 Dec 2021 13:16:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Dotan Cohen <dotancohen@gmail.com>, git@vger.kernel.org,
        Christoph Junghans <ottxor@gentoo.org>
Subject: Re: Git bug: Filter ignored when "--invert-grep" option is used.
References: <CAKDXFkMvXJm5+5Qxz2N5NH-s+nptayG_7+yTSPxynZxkOcaVKw@mail.gmail.com>
        <xmqqzgp134i4.fsf@gitster.g>
        <CAKDXFkOXNPTjQRvj7sy54YhH1QGFUsEXYeLKCShJP7_xueRseQ@mail.gmail.com>
        <xmqqee6cbalb.fsf@gitster.g>
        <e2e7759e-aa97-1117-6df2-f93a12afb094@web.de>
Date:   Fri, 17 Dec 2021 10:16:00 -0800
In-Reply-To: <e2e7759e-aa97-1117-6df2-f93a12afb094@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 17 Dec 2021 17:48:49 +0100")
Message-ID: <xmqqbl1f5c7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 649FD55A-5F65-11EC-BE25-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Subject: [PATCH] log: let --invert-grep only invert --grep
>
> The option --invert-grep is documented to filter out commits whose
> messages match the --grep filters.  However, it also affects the
> header matches (--author, --committer), which is not intended.

I re-read the log message that introduced this feature, and I agree
with the "not intended" part.  I do not think the change itself was
even done with awareness that the header matches may also be
affected, and there is no test for it to see the interaction.

> Move the handling of that option to grep.c, as only the code there can
> distinguish between matches in the header from those in the message
> body.  If --invert-grep is given then enable extended expressions (not
> the regex type, we just need git grep's --not to work), negate the body
> patterns and check if any of them match by piggy-backing on the
> collect_hits mechanism of grep_source_1().

Nice.  The original says that --files-without-matches being a
negation of --files-with-matches was what triggered them to have the
bit in the revisions, not in grep_opt, by the way.

> Collecting the matches in struct grep_opt is a bit iffy, but with
> "last_shown" we have a precedent for writing state information to that
> struct.

I think this is perfectly fine.  apply_state, grep_opt,
diff_options, and rev_info are used the same way within their
subsystems to carry in options that affect behaviour, carry around
the state of the machinery, and carry out the result.  The word
"option" does make it sound it is an input-only thing, but others
are not much better ;-).

> diff --git a/grep.c b/grep.c
> index fe847a0111..beef5fe47e 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -699,6 +699,14 @@ static struct grep_expr *compile_pattern_expr(stru=
ct grep_pat **list)
>  	return compile_pattern_or(list);
>  }
>
> +static struct grep_expr *grep_not_expr(struct grep_expr *expr)
> +{
> +	struct grep_expr *z =3D xcalloc(1, sizeof(*z));
> +	z->node =3D GREP_NODE_NOT;
> +	z->u.unary =3D expr;
> +	return z;
> +}

A bit surprising to see that we already had GREP_NODE_NOT without a
helper to create a node.  Not updating compile_pattern_not() to use
this new helper does make this patch simpler to read by allowing
readers to focus on what matters, which is very much appreciaed.

The rest of the patch looks good to me, too.
