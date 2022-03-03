Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761E2C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 22:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiCCWNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCCWNF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 17:13:05 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251E3DA49
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 14:12:18 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6444186228;
        Thu,  3 Mar 2022 17:12:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dAGEHW50qEs13Odl2Hey2xnOFHAnZURUoLG92v
        3i8dA=; b=eoN8euquYTh7jaSTPjep8lyrecAc6JzJZdwYX89iF1RZJY3S5PiDLh
        Evidaj28xy5V6axrpLHcdoLnzFE2w7H80uFSTTaLPoauKPC8NGTNh8MHVYwImJMn
        b39Lzak0jA5p3Zos8utA8Vk7WcV9GJusnnKkzPsEYM4S49IUf9Owg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEBBA186227;
        Thu,  3 Mar 2022 17:12:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4D3EA186226;
        Thu,  3 Mar 2022 17:12:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] test-lib.sh: Use GLIBC_TUNABLES instead of
 MALLOC_CHECK_ on glibc >= 2.34
References: <20220303090640.190307-1-gitter.spiros@gmail.com>
Date:   Thu, 03 Mar 2022 14:12:14 -0800
In-Reply-To: <20220303090640.190307-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Thu, 3 Mar 2022 09:06:40 +0000")
Message-ID: <xmqq8rtq8z41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB9D795C-9B3E-11EC-84A5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Compared to the first version, the code has been simplified, based on Junio's
> indications, introducing some redundancy in the setting of the glibc variables
> covered by the patch

I think we can even lose the separate case statement and write its
body inside if/then...fi.  The following shows the result of
shuffling the lines to do so.

>  	setup_malloc_check () {
> +		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
> +		   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
> +		   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null

I am wondering if we want to make sure "getconf" returned a string
that begins with "glibc " before stripping that prefix.  Hopefully
such a paranoia is probably unneeded.

> +		then
> +			g=
> +			LD_PRELOAD="libc_malloc_debug.so.0"
> +			for t in \
> +				glibc.malloc.check=1 \
> +				glibc.malloc.perturb=165
> +			do
> +				g="${g##:}:$t"

Cute.  As this strips a constant, we do not need to be ##greedy
and using just a single # would suffice, right?

> +			done
> +			GLIBC_TUNABLES=$g
> +			export LD_PRELOAD GLIBC_TUNABLES
> +			;;
> +		fi
>  		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
>  		export MALLOC_CHECK_ MALLOC_PERTURB_
>  	}
>  	teardown_malloc_check () {
>  		unset MALLOC_CHECK_ MALLOC_PERTURB_
> +		unset LD_PRELOAD GLIBC_TUNABLES
>  	}
>  fi

especially the teardown side unsets these unconditionally.
