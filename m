Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E5C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8EA2054F
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 00:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GreSMteL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDHAK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:10:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65394 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDHAK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 20:10:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B91F58740;
        Tue,  7 Apr 2020 20:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xtOntuJOr7218NGwkHV190XakEY=; b=GreSMt
        eLu6Ok+v5M2tVA1789fQLBLo54k1iay96bJUFHvfqt9UOsn1Q3sVZpMAmU1iSvlY
        0NssOVHhy7Kjw9K07HbxB4oB4VvQdi4aSsjPLvTl2V2jB06RwOjm7VYKoG2CFXW4
        pcVHCSFfx5yJ0O9YRKw4FSAcNy+sIvgoROT4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s2nlqWkKVw0d2GS2OupU9JM84dEq3LqQ
        v+PSoY8wmDwcF50DI6Gu119m0PZ4cgbqFpEPc9imJW3xTXY4W6QvPUxNQa9NqDG2
        /N9lIF1679T3vmAza2XvgUxwuOMmFlQlxOWq/y8645n1xPLHoqmXeKk82JEOyOau
        j9y2wtfLeZY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 338C75873F;
        Tue,  7 Apr 2020 20:10:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAEB85873E;
        Tue,  7 Apr 2020 20:10:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 04/22] sequencer: make file exists check more efficient
References: <cover.1585962672.git.liu.denton@gmail.com>
        <cover.1586269542.git.liu.denton@gmail.com>
        <dc4674d222317fa2f503e6e1b3cad6a78dd70676.1586269543.git.liu.denton@gmail.com>
Date:   Tue, 07 Apr 2020 17:10:23 -0700
In-Reply-To: <dc4674d222317fa2f503e6e1b3cad6a78dd70676.1586269543.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 7 Apr 2020 10:27:51 -0400")
Message-ID: <xmqqh7xurg5s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5790BCBE-792D-11EA-97B4-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> We currently check whether a file exists and return early before reading
> the file. Instead of accessing the file twice, always read the file and
> check `errno` to see if the file doesn't exist.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  sequencer.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

It's not likely for us to break strbuf_read_file() in such a way
that it would clobber errno when it sees a failure from open, so
this should be OK.  If we were racing with somebody else who is
trying to remove 'path', we may have said "ah, the file is there,
let's try to read --- oops, we cannot read it after all" with the
current code, but the updated code would take advantage of the
atomicity of open() to avoid such race.  If we can open it, we would
read it unless there is an I/O error.  If we failed to open it, we
know the file wasn't there when we attempted to read.  Good.

> diff --git a/sequencer.c b/sequencer.c
> index faab0b13e8..a961cf5a9b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -433,11 +433,9 @@ static int read_oneliner(struct strbuf *buf,
>  {
>  	int orig_len = buf->len;
>  
> -	if (!file_exists(path))
> -		return 0;
> -
>  	if (strbuf_read_file(buf, path, 0) < 0) {
> -		warning_errno(_("could not read '%s'"), path);
> +		if (errno != ENOENT && errno != ENOTDIR)
> +			warning_errno(_("could not read '%s'"), path);
>  		return 0;
>  	}
