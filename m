Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FB5207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbdEBDRz (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:17:55 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33645 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdEBDRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:17:54 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so7156469pgc.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 20:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=roJx3Y98GD0/j4cscZJKSteV6ZK8ndiyO2fG/dy4Qsc=;
        b=BE3ddC8lmznYKPBmIrMCKEb1lfokcw4W7SQFwkjnqkmYcGlQ/jzGmY8h/6KjfesAej
         lqC0eExhp+88tPlR01e3pq/7YaxaZKS/XPkbDtjoAB+B+QNIqyOD1kToKlBLUSJSdyst
         11JzzFs8Xqg8lOiwdW+mWNEVAwtuR2RgquZXHlRrfntiZ9AU/HPF1lrbWntvyYarCOnN
         jR3IMi/Cev6OxpELRlDNoKoWmwbhQumOmjf3whnjjTESZ/6Oe076vZOABkKLv71P7i6x
         VuLV0Diets3HEgjXdqgAyfvcIyue4pjhAhVaUYiXZ42GyFzJwzbwGhQOeaT+GjXXy2Rj
         Nrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=roJx3Y98GD0/j4cscZJKSteV6ZK8ndiyO2fG/dy4Qsc=;
        b=W9tZHI7abmkxHmzWCMs6E61SEErKTvs8avUcx1349DD1DjatXHgkTiy4viRzNZiBM8
         FL6suRQdNnuV6FHtIo416TTtyfaMT4GqwSabAJhAQIQkS4dJuDRXRRdgZuSsAvnpFgOW
         TpNkfuF45aii0Gb5v15lJ1sRUL7afOfDPgu0EDILNEfM+7kGHBqmBbuWMj/dhKNi2E96
         1dFf3t2h0acL4LO/E5BX9zek+tyL4cT2VmLn6PXVbewj9gZZrYE2o7bnlF1HeKyOB2mY
         YMGSK6sX8NcXie/udGOB/SRk6697b6JcoqYHMQe/n5SGkILVVejEHu9HOrPpT/cOtwmt
         uYSg==
X-Gm-Message-State: AN3rC/7DaG4NzWL/J0Ll0mzYBkpK62FFFsR6/I2ZxrH08Jucgc7tB1PB
        1hE3cCH/ceVyTg==
X-Received: by 10.98.212.1 with SMTP id a1mr30767441pfh.34.1493695068597;
        Mon, 01 May 2017 20:17:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id e5sm31789372pga.13.2017.05.01.20.17.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 20:17:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 25/25] submodule_uses_worktrees(): plug memory leak
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <f3a803b812e74c7ea4166fdc443a16129784d133.1493387231.git.johannes.schindelin@gmx.de>
Date:   Mon, 01 May 2017 20:17:46 -0700
In-Reply-To: <f3a803b812e74c7ea4166fdc443a16129784d133.1493387231.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 28 Apr 2017 16:04:46 +0200
        (CEST)")
Message-ID: <xmqqlgqgdk11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There is really no reason why we would need to hold onto the allocated
> string longer than necessary.

Yup.  The longer we make the duration between the allocation and the
standard release, the more likely future code would add early returns
that forget to release the memory.

Looks correct; will queue.


> Reported by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/worktree.c b/worktree.c
> index bae787cf8d7..89a81b13de3 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -399,6 +399,7 @@ int submodule_uses_worktrees(const char *path)
>  
>  	/* The env would be set for the superproject. */
>  	get_common_dir_noenv(&sb, submodule_gitdir);
> +	free(submodule_gitdir);
>  
>  	/*
>  	 * The check below is only known to be good for repository format
> @@ -418,7 +419,6 @@ int submodule_uses_worktrees(const char *path)
>  	/* See if there is any file inside the worktrees directory. */
>  	dir = opendir(sb.buf);
>  	strbuf_release(&sb);
> -	free(submodule_gitdir);
>  
>  	if (!dir)
>  		return 0;
