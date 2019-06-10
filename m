Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A9A1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfFJRVg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:21:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51750 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfFJRVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:21:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C28F01401B7;
        Mon, 10 Jun 2019 13:21:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eCRrqIQdFmvp7S1dO3dWlCLlbSM=; b=koOZ0h
        5Z8IxL+yEZPDw1OSr+J+Z4r+mGDovL/DT4VYOnT1pdHQIjujZ7zSO9TvFzA42Ikn
        3Ei0fmAvhZfqx4+vyMobFnzYrNXGWhoC05j7w0KtqtE635sHU0l/rE9a3Ro7/A84
        +c4O4nvqICb9REA1zg6ku1tT+V2QARWJVYA3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BM1Bgz/iWX0siZVuTndlX8UMz0v/qHxK
        AyGCmtv/1qTgW548NE06xcRnO0hbSk3vHmu1nmukmRVrDEfW55JoAsgCpqkftarw
        ImiBeTe1WerdPFRzbphPCF7rskUbkk3OH4fSZLmerrfWh/vtSHZg625dGZoPpyfc
        1ob3A8FUW5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB79A1401B6;
        Mon, 10 Jun 2019 13:21:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 152591401B5;
        Mon, 10 Jun 2019 13:21:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] mergetool: use shell variable magic instead of `awk`
References: <cover.1560152205.git.j6t@kdbg.org>
        <d6675b02918364736ec74db937481127ab7d8990.1560152205.git.j6t@kdbg.org>
Date:   Mon, 10 Jun 2019 10:21:31 -0700
In-Reply-To: <d6675b02918364736ec74db937481127ab7d8990.1560152205.git.j6t@kdbg.org>
        (Johannes Sixt's message of "Mon, 10 Jun 2019 10:59:00 +0200")
Message-ID: <xmqq7e9tnyp0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30CB6420-8BA4-11E9-B406-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> +	# here, $IFS is just a LF
> +	for line in $f
> +	do
> +		mode=${line%% *}		# 1st word
> +		sha1=${line#"$mode "}
> +		sha1=${sha1%% *}		# 2nd word
> +		case "${line#$mode $sha1 }" in	# remainder
> +		'1	'*)
> +			base_mode=$mode
> +			;;
> +		'2	'*)
> +			local_mode=$mode local_sha1=$sha1
> +			;;
> +		'3	'*)
> +			remote_mode=$mode remote_sha1=$sha1
> +			;;
> +		esac
> +	done

OK.  $mode won't have any glob metacharacter, and there is only one
invocation of "ls-files -u", which is now two fewer processes ;-)

>  
>  	if is_submodule "$local_mode" || is_submodule "$remote_mode"
>  	then
>  		echo "Submodule merge conflict for '$MERGED':"
> -		local_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $2;}')
> -		remote_sha1=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $2;}')
>  		describe_file "$local_mode" "local" "$local_sha1"
>  		describe_file "$remote_mode" "remote" "$remote_sha1"
>  		resolve_submodule_merge
