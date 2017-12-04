Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD40420954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdLDR7C (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:59:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751246AbdLDR7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:59:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29629CB8C2;
        Mon,  4 Dec 2017 12:59:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cGAmWjtcyVOl6Esu0XIH7j/4c3g=; b=ahuqg7
        tOuVDx+gYDg0hY6rHkLdhadXtaWF4Dsjv7RzZQ7lWKZ1PfjMsZBQHKnQjcm/ny1b
        PJXPEpVWtZCia+5j3lQ75KWVlY5B3KpjDTebulvxoWVVUPypgg1S7eW7eel4xEPw
        h+B/x0N7slhTfIGqHA30jfIxy0WvCpToCQpqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qgJVqs/dviesGLDHkI8h/spfZwTNG/fN
        G6/+Rd0GOqQlEfh2WkP3kqgDPYtCvpeJ8plhOlIJQOKiO/dk8fkODtiS3epNasAW
        AMmhKJMunedfzb3ixk1cxKXwdmyuy+9m8rAsVAhFMrf+J4mUI/JDdDNy3x8ufvu8
        bwTKytDlW64=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20F49CB8C1;
        Mon,  4 Dec 2017 12:59:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 885E9CB8C0;
        Mon,  4 Dec 2017 12:58:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Abel <rabel@robertabel.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
        <20171201233133.30011-1-rabel@robertabel.eu>
Date:   Mon, 04 Dec 2017 09:58:58 -0800
In-Reply-To: <20171201233133.30011-1-rabel@robertabel.eu> (Robert Abel's
        message of "Sat, 2 Dec 2017 00:31:32 +0100")
Message-ID: <xmqqindmml25.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDF4133C-D91C-11E7-A167-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Abel <rabel@robertabel.eu> writes:

> __git_eread is used to read a single line of a given file (if it exists)
> into a variable without the EOL. All six current users of __git_eread
> use it that way and don't expect multi-line content.

Changing $@ to $2 does not change whether this is about "multi-line"
or not.  What you are changing is that the original was prepared to
be given two or more variable names, and split an input line at IFS
into multiple tokens to be assigned to these variables, but with
this change, the caller can only use one variable and this function
will not split the line and store it into that single variable.

The above can easily be fixed with a bit of rewording, perhaps like:

    ... that way.  We do not need to split the line into tokens and
    assign them to multiple variables---reading only into a single
    variable needs to be supported.

While reviewing this patch, I also wondered if the "read" wants to
become "read -r" or something that is even safer than simply
avoiding tokenization, but after scanning to see exactly which files
__git_eread is used to read from, I do not think it matters (the
input will not have a backslash that would want to be protected from
'read'), so this should be OK.

> Signed-off-by: Robert Abel <rabel@robertabel.eu>
> ---
>  contrib/completion/git-prompt.sh | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index c6cbef38c..41a471957 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -278,11 +278,12 @@ __git_ps1_colorize_gitstring ()
>  	r="$c_clear$r"
>  }
>  
> +# Helper function to read the first line of a file into a variable.
> +# __git_eread requires 2 arguments, the file path and the name of the
> +# variable, in that order.
>  __git_eread ()
>  {
> -	local f="$1"
> -	shift
> -	test -r "$f" && read "$@" <"$f"
> +	test -r "$1" && read "$2" <"$1"
>  }
>  
>  # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
