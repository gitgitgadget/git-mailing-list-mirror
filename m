Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF48D1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcHLWZ4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:25:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732AbcHLWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:25:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 858C335A2E;
	Fri, 12 Aug 2016 18:25:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SU+TikIifSqX1u+liVmyBJJ3lRY=; b=LkhLFU
	eSCA2N6f6bH/P/6DqXVgJiXHUKoGUmmH7MGNMyDmBrbObIedzgfdHiK26Jt4wZoH
	FhFSHiZO+1e9xydV7ALuKBlXoeb7yVGC/4HFKrWLzfPXShIBgZDMtx68JwVG31uF
	X4IkcllACdztuC1p46btthpcAf96/g/eVm5RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m6vpR4LV3tGoE2DaqP5Nm8NzZ2Kz3xdg
	3QylpQpDRsT4Nd+Xvf8N7xerfuhnLExsJON6UQsa1TGevD31bBCneuOmYLk/b6LN
	qLL0065UwZssHWg+sK58p2SB/E+SF++UZ68gG5MEuat4ZU5k9V6LVHk75LzdNzty
	dy+9p0K4CbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CA1C35A2D;
	Fri, 12 Aug 2016 18:25:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED70C35A2C;
	Fri, 12 Aug 2016 18:25:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv4 5/8] clone: factor out checking for an alternate path
References: <20160811231405.17318-1-sbeller@google.com>
	<20160811231405.17318-6-sbeller@google.com>
Date:	Fri, 12 Aug 2016 15:25:52 -0700
In-Reply-To: <20160811231405.17318-6-sbeller@google.com> (Stefan Beller's
	message of "Thu, 11 Aug 2016 16:14:02 -0700")
Message-ID: <xmqqa8ghvd3j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC0D5CA6-60DB-11E6-A67C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +	struct strbuf sb = STRBUF_INIT;
> +	char *ref_git = compute_alternate_path(item->string, &sb);

Who owns the memory for ref_git?

> -	if (!access(mkpath("%s/shallow", ref_git), F_OK))
> -		die(_("reference repository '%s' is shallow"), item->string);
> +	if (!ref_git)
> +		die("%s", sb.buf);

Presumably the second argument to compute_alternate_path() is a
strbuf to receive the error message?  It is unfortunate that the
variable used for this purpose is a bland "sb", but perhaps that
cannot be helped as you would reuse that strbuf for a different
purpose (i.e. not to store the error message, but to formulate a
pathname).

> -	if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
> -		die(_("reference repository '%s' is grafted"), item->string);
> +	strbuf_addf(&sb, "%s/objects", ref_git);
> +	add_to_alternates_file(sb.buf);
>  
> -	strbuf_addf(&alternate, "%s/objects", ref_git);
> -	add_to_alternates_file(alternate.buf);
> -	strbuf_release(&alternate);
> -	free(ref_git);
> +	strbuf_release(&sb);

I am wondering about the loss of free() here in the first comment.

> +/*
> + * Compute the exact path an alternate is at and returns it. In case of
> + * error NULL is returned and the human readable error is added to `err`
> + * `path` may be relative and should point to $GITDIR.
> + * `err` must not be null.
> + */
> +char *compute_alternate_path(const char *path, struct strbuf *err)
> +{
> +	char *ref_git = NULL;
> +	const char *repo, *ref_git_s;
> +	struct strbuf err_buf = STRBUF_INIT;

Why do you need "err_buf", instead of directly writing the error to
"err", especially if "err" is not optional?

> + ...
> +out:
> +	if (err_buf.len) {
> +		strbuf_addbuf(err, &err_buf);
> +		free(ref_git);
> +		ref_git = NULL;
> +	}
> +
> +	strbuf_release(&err_buf);
> +	return ref_git;
> +}

So ref_git is a piece of memory on heap, and the caller is
responsible for not leaking it.
