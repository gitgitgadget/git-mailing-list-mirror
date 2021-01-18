Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8FC433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D194122EBF
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 23:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbhARXZ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 18:25:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51886 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbhARXZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 18:25:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B91C1A3998;
        Mon, 18 Jan 2021 18:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oxRaTc82olTD2/Qluqmkvpja3uI=; b=KAb6do
        x5IhOjAcinWwTeEiVjqUlKGdBzWAwZXqqdhGnQWVRVQmXO0iolDFbtTsL+BMnFFC
        fPyYjqL47Ahm2ArupV6WNrSP0/hgLYxzRUFfmQXaA2+yLIXhkbNH6LrQTfPooBdy
        J90Wlt2feVjtbdPdkX8JYtpbyoWUAgUBnXeh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M+xNIYjOvQCzmRaBIrLIcvggM4tkK0GO
        Mij3L8opj5IvKB2WW+mhAp1IUrjXVLLKFtMiMu6gBwnfq/rPurwlM0CkAvnhLgkm
        FlQnustw23TJFjmAnOxestMiN+J2bEdRpbt3BmglfW47mkrvpldG99EMVZ2Nr8Gn
        8VOAQ7BJPr4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B06BFA3996;
        Mon, 18 Jan 2021 18:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F7F9A3993;
        Mon, 18 Jan 2021 18:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicholas Guriev <nicholas@guriev.su>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] mergetools: support difftool.tabbed setting
References: <2fb58fd30ae730ccd3e88ec51b5fe6d80ab7a8c7.camel@guriev.su>
        <20210118210003.3071205-1-nicholas@guriev.su>
        <20210118210003.3071205-2-nicholas@guriev.su>
Date:   Mon, 18 Jan 2021 15:25:12 -0800
In-Reply-To: <20210118210003.3071205-2-nicholas@guriev.su> (Nicholas Guriev's
        message of "Tue, 19 Jan 2021 00:00:01 +0300")
Message-ID: <xmqqv9btj09z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A15361A-59E4-11EB-9742-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicholas Guriev <nicholas@guriev.su> writes:

> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 78f3647ed9..2a1edbb9b9 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -195,6 +195,11 @@ setup_tool () {
>  		false
>  	}
>  
> +	# Clear combo function declared by a previous tool (if any) to
> +	# unambiguously indicate that the current one supports the feature or
> +	# not.
> +	unset -f diff_combo_cmd
> +

I know this is so that you can use "type diff_combo_cmd" in a
different part of the patch, but I do not think you want to be
fooled by an unrelated ~/bin/diff_combo_cmd that the user may have
under the home directory.

Instead, the fallback definitions can have

	diff_combo_supported () {
		return 1
	}

and have backends that does support diff_combo_supported to override
with their own

	diff_combo_supported () {
		return 0
	}

And then, the part of is_difftool_tabbed that wants to see if the
current backend supports the operation can become:

	test "$GIT_DIFFTOOL_TABBED" = true &&
	test "${GIT_DIFF_PATH_TOTAL=0}" -gt 1 &&
-	type diff_combo_cmd >/dev/null 2>&1
+	diff_combo_supported
 }

That way, you do not have to do "unset -f" up above.


> @@ -250,6 +255,28 @@ trust_exit_code () {
>  	fi
>  }
>  
> +# Check whether tabbed mode is requested and current loaded tool supports it.
> +is_difftool_tabbed () {
> +	: "${GIT_DIFFTOOL_TABBED=$(git config --type=bool \
> +		--default=false difftool.tabbed || echo bad value)}"
> +	case $(printf "%s" "$GIT_DIFFTOOL_TABBED" | tr '[:upper:]' '[:lower:]') in
> +	yes|on|true|1)
> +		GIT_DIFFTOOL_TABBED=true
> +		;;
> +	no|off|false|0|'')
> +		GIT_DIFFTOOL_TABBED=false
> +		;;
> +	*)
> +		echo "error: bad boolean value of GIT_DIFFTOOL_TABBED" >&2
> +		exit 1
> +		;;
> +	esac
> +
> +	test "$GIT_DIFFTOOL_TABBED" = true &&
> +	test "${GIT_DIFF_PATH_TOTAL=0}" -gt 1 &&
> +	type diff_combo_cmd >/dev/null 2>&1
> +}
