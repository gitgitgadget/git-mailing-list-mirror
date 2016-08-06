Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30D1B1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcHFUKS (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750979AbcHFUKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D2082F9B0;
	Sat,  6 Aug 2016 13:13:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+aUZfD/st0fAjB5KZH/lgMbs394=; b=OavAA8
	Fgl0lKqbPnANPSOQMd43XXbtXesgagsyfNv89Y6hrTAW2PZfo6080R7sZabBtZg+
	cCzVhOVPPDduILKvwZ7NEEHq/of+3EXtaimBsfF/Uz1ia060SZb64zD9Fnw4v2Gm
	cXlnMlrMwn0MvOdcU8TOtTlorOOZB8jacRelQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mCy91acZckOnmme/Xi5vfJ4FBJRfZNPO
	ysfbn8HRWYUDZoOBsq1pVXcfwgnenDta+ScE6k2rw83ensXnqPaD+AaAFYHL3ytO
	rnn+FqgB+Y3OPXDj5RUd6W14N+wqgdHJ0GK9BQOw8ItMnFeLQIixMCKxm87+YMGR
	DThhCrdG4iU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 058442F9AF;
	Sat,  6 Aug 2016 13:13:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 826032F9AC;
	Sat,  6 Aug 2016 13:13:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Jens.Lehmann@web.de, git@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCHv2 5/6] submodule update: add super-reference flag
References: <20160806012318.17968-1-sbeller@google.com>
	<20160806012318.17968-6-sbeller@google.com>
Date:	Sat, 06 Aug 2016 10:13:42 -0700
In-Reply-To: <20160806012318.17968-6-sbeller@google.com> (Stefan Beller's
	message of "Fri, 5 Aug 2016 18:23:17 -0700")
Message-ID: <xmqqh9axizw9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2153295C-5BF9-11E6-B3B5-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When we have a another clone of a superproject, we may want to
> mirror the submodules using alternates. Introduce an option
> `--super-reference` that let's a user point to another superproject,
> which is assumed to have the same structure as the one they are
> running the "submodule update" command from and has all submodules
> checked out to borrow the submodule objects from within the other
> superprojects git directory.

That's much better than the previous round.

I however have trouble with the "checked out", though.  Isn't it
that it merely has to be "init"ed?  For that matter, as long as
super.git has $GIT_DIR/modules/ populated fully, it does not matter
it has checkout, and more interestingly and importantly, the
superproject mirror can even be a bare repository!

> +--super-reference <superproject repository>::
> +	This option is only valid for the update command. When update needs
> +	to clone a repository, a reference will be passed to the clone command
> +	that points at the submodule path inside the reference superproject.

"points at the submodule path inside" sounds as if we would look at

    /var/cache/super/libs/xyzzy

in the scenario in <xmqqoa57vvzl.fsf@gitster.mtv.corp.google.com>, 
when you give us "--super-reference=/var/cache/super".  Can we
clarify to avoid such a misread?

> +superreference=

Please don't name a multiple_word field "multipleword".

>  cached=
>  recursive=
>  init=
> @@ -520,6 +521,14 @@ cmd_update()
>  		--reference=*)
>  			reference="$1"
>  			;;
> +		--super-reference)
> +			case "$2" in '') usage ;; esac
> +			superreference="--super-reference=$2"
> +			shift
> +			;;
> +		--super-reference=*)
> +			superreference="$1"
> +			;;
>  		-m|--merge)
>  			update="merge"
>  			;;
> @@ -576,6 +585,7 @@ cmd_update()
>  		${prefix:+--recursive-prefix "$prefix"} \
>  		${update:+--update "$update"} \
>  		${reference:+"$reference"} \
> +		${superreference:+"$superreference"} \
>  		${depth:+--depth "$depth"} \
>  		${recommend_shallow:+"$recommend_shallow"} \
>  		${jobs:+$jobs} \
