Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361071FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933745AbcLAUmT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:42:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60905 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753531AbcLAUmS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:42:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 559735483C;
        Thu,  1 Dec 2016 15:42:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y9g430sWEBmrg8jyrETw7OjqE9Q=; b=YtlLrF
        Nk3iH94z8wPB9q5fByAZ/d6znkgiNJLRo7sUtbnSBYTDp7RPar1+S27WmbV/cnYa
        XXWdLYU+ewqNfAEfHHYded1yrCmHexh82DiCqoUJegbyJWYFn3vlC2G4LWdtCYXA
        DfmLJ1RJIeNeJlJLsvAf73LkBVESAhUC6i4cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cUiJzWs3/O12pGciy2aeVWdfVPslfKMu
        SCWNSM0pn5oncNmYp6RkHQMcZwJZhmo0Um3v1rOQtY6eerc0yhQdfLyFkTupKrWc
        mmcNAhpoNNMOg7ulh3DcprWsZKaMKbLfH3Zsz61AmFpebO1LH4wd+WHQm7tQOrWi
        nEPulyrfJIw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B9AD5483B;
        Thu,  1 Dec 2016 15:42:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C27295483A;
        Thu,  1 Dec 2016 15:42:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Austin English <austinenglish@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/install-webdoc.sh: quote a potentially unsafe shell expansion
References: <CACC5Q1eFM_G4wKopkbxabLEu8+nbt66wF1jKSoTuL1vnS5Tb4Q@mail.gmail.com>
Date:   Thu, 01 Dec 2016 12:42:15 -0800
In-Reply-To: <CACC5Q1eFM_G4wKopkbxabLEu8+nbt66wF1jKSoTuL1vnS5Tb4Q@mail.gmail.com>
        (Austin English's message of "Wed, 30 Nov 2016 19:22:56 -0600")
Message-ID: <xmqqfum78jq0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A58C773C-B806-11E6-9495-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Austin English <austinenglish@gmail.com> writes:

> diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
> index ed8b4ff..5fb2dc5 100755
> --- a/Documentation/install-webdoc.sh
> +++ b/Documentation/install-webdoc.sh
> @@ -18,7 +18,7 @@ do
>  	else
>  		echo >&2 "# install $h $T/$h"
>  		rm -f "$T/$h"
> -		mkdir -p $(dirname "$T/$h")
> +		mkdir -p "$(dirname "$T/$h")"
>  		cp "$h" "$T/$h"
>  	fi
>  done

We know $h is safe without quoting (see what the for loop iterates
over a list and binding each element of it to this variable), but T
is the parameter given to this script, which comes from these

install-html: html
	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)

install-webdoc : html
	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)

in the Makefile.  So quoting the result of $(dirname "$T/$h") is
just as necessary as quoting the argument given to this dirname.

But I do not think it is sufficient, if we are truly worried about
people who specify a path that contains IFS whitespace in DESTDIR,
WEBDOC_DEST, htmldir and other *dir variables used in the Makefile.
The references to these variables, when they are mentioned on the
command lines of Makefile actions, all need to be quoted.  The
remainder of the Makefile tells me that we decided that we are not
worried about those people at all.

So while I could take your patch as-is, I am not sure how much value
it adds to the overall callchain that would reach the location that
is updated by the patch.  If you run

	make DESTDIR="/tmp/My Temporary Place" install

it would still not do the right thing even with your patch, I would
suspect.

Thanks.
