Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A6D1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 20:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbdIFUB7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 16:01:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54979 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751985AbdIFUB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 16:01:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C36098C6C;
        Wed,  6 Sep 2017 16:01:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=UYPFYR9Jl909u7cCIL4c0XllKXU=; b=m+oUDn4yjsD2xVHt9JIS
        XDJLjJ7cVQqyC94Fvoie1ZnQlOOj4bpiK5iEAzE7cee51XLR28ULWV8MElfsXuFX
        QQ8ypHbNYOaKdcb5dG9JJsYDWPIEsDNtxM4UpeRSJLsJwXaVm80Z4EVpio4llnwr
        fODfgIrCZD+auGUWeNWOOHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=HBkMBFaNVEzCLkpXOQViHw+VWdf4C6Pg6BO6TbNkJUQFuL
        IWwI6ie7yomXD9hyrlrrCJHu24QXBuPiTNAD0br54dQIxoPXFmLB3qRs80ExMEQx
        Nw56ptflbKRyNnChQA6WmmFipL14Vu1MabAfnL5OIWZRLRLuXuvcrjeJey3Cc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 729E898C6B;
        Wed,  6 Sep 2017 16:01:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8D5798C6A;
        Wed,  6 Sep 2017 16:01:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 25/39] sha1_file: allow alt_odb_usable to handle arbitrary repositories
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
        <20170830070812.GZ153983@aiede.mtv.corp.google.com>
Date:   Thu, 07 Sep 2017 05:01:55 +0900
Message-ID: <xmqqd1734mvg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C4E2856-933E-11E7-9192-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sha1_file.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index e7c86e5363..b854cad970 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -25,6 +25,7 @@
>  #include "repository.h"
>  #include "object-store.h"
>  #include "streaming.h"
> +#include "path.h"
>  #include "dir.h"
>  #include "mru.h"
>  #include "list.h"
> @@ -281,17 +282,18 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
>  /*
>   * Return non-zero iff the path is usable as an alternate object database.
>   */
> -#define alt_odb_usable(r, p, n) alt_odb_usable_##r(p, n)
> -static int alt_odb_usable_the_repository(struct strbuf *path,
> -					 const char *normalized_objdir)
> +static int alt_odb_usable(struct repository *r, struct strbuf *path,
> +			  const char *normalized_objdir)

These token-pasting macros introduced in 07-24/39 were certainly
cute but they may be rather misleading and useless.  e.g. a natural
expectaion would be

	struct repository *r = &the_repository;
	prepare_alt_odb(r);

to work, but obviously it wouldn't.  And this step and later in
25-39/39 corrects them one by one.

I suspect that you used the token-pasting cuteness because you
thought that the callsite would not have to change in the later step
like 25/39 that removes the trick.  I also suspect that you thought
that it may be a good thing that prepare_alt_odb(r) does not work
immediately after 07/39, as the callee is not prepared.  But both of
these are misguided.

If you have two functions, A and B, that we want to update to
eventually take a "struct repository *" argument, and if A uses B in
its implementation, the endgame would be

	A(struct repository *r, ...)
	{
		...
		B(r, ...);
		...
	}

but with the ##r approach, the call to B in A in the initial
token-pasting phase would say B(the_repository, ...) so the call
will need to be changed in the step you update A's implementation to
take a caller-supplied respotory object anyway.  And the fact that a
function's first parameter is not the_repository (i.e. leaving B()'s
signature unchanged while it is not ready to take a repository) is
sufficient to mark that a function is not yet prepared to take a
caller-supplied repository object.

I found that this aspect of the structure of the series was somewhat
irritating in that (1) combining the earlier ##r thing with its fix
would have made the code that needs to be reviewed much cleaner, (2)
it wouldn't have made the patch that longer, and most importantly
(3) it is unclear why 24-7 != 39-25, i.e. it is hard to answer "is
there any ##r hack still remaining after this series?  if so why?"

The end-result of the whole series makes me think that it is going
in the right direction, though.

Thanks.
