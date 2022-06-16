Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E2C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379035AbiFPVSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378629AbiFPVSX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:18:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD62ED64
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:18:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 334A5190F78;
        Thu, 16 Jun 2022 17:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FDYWZkxt6r2gnmeGgTcnUjaxVd2lpF598ph2bv
        j7+f4=; b=otMZ/CzCmv/j42AE3z6MYnutjvQb0idAvX38Qv4Y/q2Bbyhau2XgNL
        1AfZwZcHtGmbPneUG++rFFFl0b/uMLt6F9FV+GEgaAWOUcc2WU8BJtelVYfbKcmX
        8bxpYvNxpAAzjE+OQUQlbVVYRUYvAn1H6GJBPlUH/juxNuxltBLzA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C05C190F77;
        Thu, 16 Jun 2022 17:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0EF1190F70;
        Thu, 16 Jun 2022 17:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 3/5] tests: only automatically unset matching values
 from test_config
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
        <20220616205456.19081-4-jacob.e.keller@intel.com>
Date:   Thu, 16 Jun 2022 14:18:14 -0700
In-Reply-To: <20220616205456.19081-4-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 16 Jun 2022 13:54:54 -0700")
Message-ID: <xmqq35g4s3xl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D628F19C-EDB9-11EC-AA11-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> +	# Only enable --fixed-value if we have two parameters
> +	if test $# < 2
> +	then
> +		fixedvalue=
> +	fi

Two comments:

 * Does "<" do what you expect to do?  Did you mean "-lt"?

 * Using "bug in the test script: $*" and diagnosing missing
   parameters, instead of silently ignoring the option the developer
   wrote, would be more preferrable.

> +	git ${config_dir:+-C "$config_dir"} config ${global:+--global} ${fixedvalue:+--fixed-value} --unset-all "$1" "$2"
>  	config_status=$?
>  	case "$config_status" in
>  	5) # ok, nothing to unset
> @@ -575,7 +586,7 @@ test_config () {
>  		esac
>  		shift
>  	done
> -	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} ${global:+--global} '$1'" &&
> +	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} --fixed-value ${global:+--global} '$1' '$2'" &&

Why are $1 and $2 enclosed in a pair of single quotes?  Is the
assumption that they do not contain a single quote themselves?

I guess that is true also for config_dir and shares the same
problem, so you are not introducing a new problem.

>  	git ${config_dir:+-C "$config_dir"} config ${global:+--global} "$1" "$2"
>  }
