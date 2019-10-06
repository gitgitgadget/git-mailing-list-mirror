Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990511F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 00:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfJFA5z (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 20:57:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64296 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfJFA5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 20:57:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABBAA19F9E;
        Sat,  5 Oct 2019 20:57:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VEsQPeSV5uFu7+2sAckdvTX1Fh8=; b=NqIiFY
        GyzJbtUinWhZYrx1F12Uq4b79vOFeYC4CPL5Lzc3qSifcGNnbGh7RBZRC+zidz5x
        qye9V42Zzoe8UsbzgdyR/asyvKjkYyLTRmS0UK6ZB5bU8ddAYOu6y2PJHXE1iJAW
        wrUe8bzQ7NOEg5V+tUbMrjfpejg1t3tC/zBD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HAXuXKCojtyBRFXoEvj7PJIIJe1M6yks
        //85cu/J6kA0Rh5QgSKcy7xwh8GWhuFR/Q+XGG9VXbT0R5q54kHVxvoWQT17CXt2
        OzOfw76etIuHxrTl/j4dx1Z/i6Ncmj8IZxLqtGYCL80J6GP5s5mmMoNP62QYjlub
        rSFhYz1JbH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A190719F9B;
        Sat,  5 Oct 2019 20:57:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1497C19F9A;
        Sat,  5 Oct 2019 20:57:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 1/2] format-patch: create leading components of output directory
References: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
Date:   Sun, 06 Oct 2019 09:57:53 +0900
In-Reply-To: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
        (Bert Wesarg's message of "Sat, 5 Oct 2019 10:43:51 +0200")
Message-ID: <xmqqa7ae667i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54110192-E7D4-11E9-BFB2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> +		switch (safe_create_leading_directories_const(output_directory)) {
> +		case SCLD_OK:
> +		case SCLD_EXISTS:
> +			break;
> +		default:
> +			die(_("could not create leading directories "
> +			      "of '%s'"), output_directory);
> +		}
>  		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
>  			die_errno(_("could not create directory '%s'"),
>  				  output_directory);

There is a slight discrepancy here in that mkdir(..., 0777) is to
honor the umask setting of the user who is running the command and
does not care about anybody else being able to (or unable to) access
the resulting directory.  On the other hand, s-c-l-d is (as you can
guess from the location the function is defined, sha1-file.c) meant
to be used to create hierarchy _inside_ $GIT_DIR/ in such a way that
anybody who needs to access the repository can access it (via
core.sharedrepository config).

I do not think it matters too much in practice, but

	$ git format-patch -o $HOME/my/patch/depot

that creates intermediate levels that can be writable by other
users, only because the repository you took the patches from was
shared with other users, may probably be seen as a security bug.
