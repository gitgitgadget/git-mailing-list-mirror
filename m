Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5778DC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 02:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2540364DE8
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 02:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhBPC1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 21:27:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59516 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhBPC1c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 21:27:32 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AD5B9658B;
        Mon, 15 Feb 2021 21:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x4OVeYRZcYGmLZiWB0z0mPMd4cc=; b=k7Fexq
        9nhEHGLU3CkJs3m+vPvCTOQKQLnCcqzwrhd+0OZsjzDz+yT93fQxDDyip+k/FY3G
        80/MB+gGpR0RAPWSlwUGotuIqFg3RBU7TUocGa/EQVVq5w/SLekuqv8jqr/94mez
        bxyviD/czh1+iqCgC7DH2L/sfROQglNzYd+Rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bhO5bSCwYssjFNQhBjNig3n1KgkBp+Z2
        t0oy13gEh6nPCtAU6+fW9i9gsGpzfu/mvDVeIqQN29cl87ZHe7vMj8v50R51+6ZU
        HKJBQfjTYOEbgWt7jCWcmLapsIBrUsP32PX8immn+WG8bVcx8Q4DNTyAcVz0vzbR
        VtoIGl7lgFA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 515C096588;
        Mon, 15 Feb 2021 21:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D533E96587;
        Mon, 15 Feb 2021 21:26:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] write_entry(): fix misuses of `path` in error
 messages
References: <cover.1613411136.git.matheus.bernardino@usp.br>
        <bdda5f99d031abad65c296a61b3713f60d22ef16.1613411136.git.matheus.bernardino@usp.br>
Date:   Mon, 15 Feb 2021 18:26:49 -0800
In-Reply-To: <bdda5f99d031abad65c296a61b3713f60d22ef16.1613411136.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Mon, 15 Feb 2021 15:24:12 -0300")
Message-ID: <xmqqk0r8sq6u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C92FF14-6FFE-11EB-9141-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +test_expect_success 'checkout-index --temp correctly reports error on missing blobs' '
> +	test_when_finished git reset --hard &&
> +	missing_blob=$(git hash-object --stdin </dev/null) &&
> +	cat >objs <<-EOF &&
> +	100644 $missing_blob	file
> +	120000 $missing_blob	symlink
> +	EOF
> +	git update-index --index-info <objs &&

Does this depend on the fact that nobody created a blob with 0-byte
length in the test repository before this test?  It feels a bit
brittle to me, but as long as future test writers are made aware of
that they must not "git add" an empty file, this is probably OK.

But it may be more robust to do something like

	missing_blob=$(echo no such blob here | git hash-object --stdin)

perhaps?  I dunno.

> +	test_must_fail git checkout-index --temp symlink file 2>stderr &&
> +	test_i18ngrep "unable to read sha1 file of file ($missing_blob)" stderr &&
> +	test_i18ngrep "unable to read sha1 file of symlink ($missing_blob)" stderr
> +'
> +
> +test_expect_success 'checkout-index --temp correctly reports error for submodules' '
> +	git init sub &&
> +	test_commit -C sub file &&
> +	git submodule add ./sub &&
> +	git commit -m sub &&
> +	test_must_fail git checkout-index --temp sub 2>stderr &&
> +	test_i18ngrep "cannot create temporary submodule sub" stderr
> +'
> +
>  test_done

Thanks.
