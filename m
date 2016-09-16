Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5FF207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965642AbcIPUxU (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 16:53:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965431AbcIPUxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 16:53:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E575F3F003;
        Fri, 16 Sep 2016 16:53:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6z54kOOWNwELbM0QxG6tU0ziVAc=; b=m9H+r5
        dhsFGr05Sdfb0K04hLDH3GSrQRPV+JCiZfqmIygQTYqXgGh+BCXg8uDd6HHTdOAc
        7iBGX+cNlHk+edY67Nbc/90WBJf+uUBap3D8YPYnsXfa9e5uAcQLU/90gcbJEIy6
        lvipH7N48Am2s7d1k/k/Id4uX/87wNQ2lWOnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E9WKBKEBH/9DryNaTEa2McVZFpziqZzA
        TAWJ5dct+OZFVixhPpj66ymaAW5lM6mmqokKW5S6z+eVc91/5+QIjmiPeKhg21Ad
        sty7Mw8kJKV8A7cs08dMBq1BEv0lu82Ee5f+pebjMvtYzm1nQfBj7MKDfSOiqa7r
        x2XEvb3R6cc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEB113F002;
        Fri, 16 Sep 2016 16:53:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 675F23F000;
        Fri, 16 Sep 2016 16:53:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Wern <kevin.m.wern@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/11] Resumable clone: create service git-prime-clone
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
        <1473984742-12516-2-git-send-email-kevin.m.wern@gmail.com>
Date:   Fri, 16 Sep 2016 13:53:15 -0700
In-Reply-To: <1473984742-12516-2-git-send-email-kevin.m.wern@gmail.com> (Kevin
        Wern's message of "Thu, 15 Sep 2016 20:12:12 -0400")
Message-ID: <xmqqzin7in2c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97EAA4CA-7C4F-11E6-9877-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Wern <kevin.m.wern@gmail.com> writes:

> Create git-prime-clone, a program to be executed on the server that
> returns the location and type of static resource to download before
> performing the rest of a clone.
>
> Additionally, as this executable's location will be configurable (see:
> upload-pack and receive-pack), add the program to
> BINDIR_PROGRAMS_NEED_X, in addition to the usual builtin places. Add
> git-prime-clone executable to gitignore, as well
>
> Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
> ---

I wonder if we even need a separate service like this.

Wouldn't a new protocol capability that is advertised from
upload-pack sufficient to tell the "git clone" that it can
and should consider priming from this static resource?

> +static void prime_clone(void)
> +{
> +	if (!enabled) {
> +		fprintf(stderr, _("prime-clone not enabled\n"));
> +	}
> +	else if (url && filetype){
> +		packet_write(1, "%s %s\n", filetype, url);
> +	}
> +	else if (url || filetype) {
> +		if (filetype)
> +			fprintf(stderr, _("prime-clone not properly "
> +					  "configured: missing url\n"));
> +		else if (url)
> +			fprintf(stderr, _("prime-clone not properly "
> +					  "configured: missing filetype\n"));
> +	}
> +	packet_flush(1);
> +}

Two minor comments:

 - For whom are you going to localize these strings?  This program
   is running on the server side and we do not know the locale
   preferred by the end-user who is sitting on the other end of the
   connection, no?

 - Turn "}\n\s+else " into "} else ", please.

