Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5710FC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 20:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442594AbiEFUZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 16:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442564AbiEFUZX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 16:25:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D28E612B3
        for <git@vger.kernel.org>; Fri,  6 May 2022 13:21:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA6CE17F27D;
        Fri,  6 May 2022 16:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s0i+dtPKAKl6hJnA8cK6mARvm7qFIQXm4MsHZ+
        //xFo=; b=e0g5/rD/OBHYNhuRLoxL346WYfQgTlrllgK9mZezPty71dJhbjqLlT
        LAR5yE54Vzq1nIBWxmGdm6O1NcBgMH1TkuKTH2zMREXciymi9cT7xeUmgCHzb5kU
        i8cPGKwdK/EhZEaoftlhBkptQ6f7rNkeNuhuAkoomGnzquIli3DIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C3F9B17F27B;
        Fri,  6 May 2022 16:21:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54F5D17F27A;
        Fri,  6 May 2022 16:21:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] dir.c: avoid gcc warning
References: <cover.1651859773.git.git@grubix.eu>
        <cd50ec73ddafaaeba04298ae79cbf625cc0d7697.1651859773.git.git@grubix.eu>
Date:   Fri, 06 May 2022 13:21:33 -0700
In-Reply-To: <cd50ec73ddafaaeba04298ae79cbf625cc0d7697.1651859773.git.git@grubix.eu>
        (Michael J. Gruber's message of "Fri, 6 May 2022 20:04:05 +0200")
Message-ID: <xmqqy1zejtte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FBA070C-CD7A-11EC-8903-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Related to -Wstringop-overread.
>
> In fact, this may be a false positive, but reading until the correct end
> is desirable here anyways.

But the correct end is start + (end - start), not start + (end -
start + 1), isn't it?  We've stripped trailing junk like /.git and
end is point at one byte beyond the end of URL to the repository.

E.g. for "https://auth@host/", we have advanced start to point at
"h" at the beginning of "host", and we have moved end back from
pointing at the NUL at the end to point at "/" at the end of
"host/".

We are trying to make sure that the resulting "host" string between
start and end do not have a slash to apply this special case.

If the original URL were "https://auth@host:4321/", the end points
at "/" at the end of "host:4321/", making the string to be checked
to "host:4321" and we are trying to see it has no '/' in it (which
is the case).  By extending the string by one, memchr() will see the
'/' at the end that is outside.

This seems to be a behaviour breaking change and I am not sure what
we are trying to achieve with it.  Is this a suggestion made by a
broken compiler you have, or something?

Puzzled....

> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 26c4d141ab..32fcaae4c0 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3145,7 +3145,7 @@ char *git_url_basename(const char *repo, int is_bundle, int is_bare)
>  	 * result in a dir '2222' being guessed due to backwards
>  	 * compatibility.
>  	 */
> -	if (memchr(start, '/', end - start) == NULL
> +	if (memchr(start, '/', end - start + 1) == NULL
>  	    && memchr(start, ':', end - start) != NULL) {
>  		ptr = end;
>  		while (start < ptr && isdigit(ptr[-1]) && ptr[-1] != ':')
