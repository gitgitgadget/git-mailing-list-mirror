Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39841F453
	for <e@80x24.org>; Fri,  2 Nov 2018 15:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeKCAbC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 20:31:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32907 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKCAbC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 20:31:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so2398978wrn.0
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EBrX6i+kDcD1n3eCbUaUDlIBBT8+N+ACMCbscqFUcug=;
        b=vXt3JPV5N91ZWvOItjRu9jgzHWfobaWhgWnH1bG59PM/7Qyh1n+H62iu7tsmDD+yKB
         5y61+4Tc9oUqbq0lyiLIG8LXw34z5+VlfJjqjJiTlOrPhrACaAKQPw2ZQhclc+OjQC8m
         IYLJCi1xVYP/LRucYQHn9/r3oiMYJQByaq1FKuW80/Cje2OzX1j5Ituw0GtabEsXcQR1
         6vX5tcSHH4jiPqpOJbu5J7Z1wY7G5ZIoaHazjZbA8vJ84Ru8ZGssi6IXOqWLkxzAQASD
         v86wVZS0TrBI9xT0VihWlvdCK45kcP70lGlpOaAaPPR99gud2wDqXBMtxlwUsJsENcS+
         p1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EBrX6i+kDcD1n3eCbUaUDlIBBT8+N+ACMCbscqFUcug=;
        b=h+MbWS75aRMMwwwv4dT3Hi5LWfVUuKB3wD6lQI4Wjrwa4dD+4pjK+nRpbsM/FLXwqX
         f2pxnCMOf7eKEdoIUUbGlfkwcLD5aTmaEkxBRcLpxX55sfHa+ZI1/w07WGQW5T7ZNj1F
         wdxedBJq58QjPqteEmHSSSrm59ep7buhvutiFfFRUTcNxqglXMYctYe6ivp74XJThwfT
         HfTLv3vb1F46R4VbAqRnBx1FS5/cWuGZR2kouIjXMJKfqbUfESPjWjWIN4zxMW+mSR09
         Nqlg6CrdrxGR3E7MJrAsfvF1nEEnXtRr9Plcq0a735m/vUM8pqHmlpwrGcUdJyzp9KiA
         ZsiA==
X-Gm-Message-State: AGRZ1gJTHJsPiunoCv2c6YqrcofFujoyjcuOyvZMNGWd+Cs25ndyNtNG
        lYyTEbIOl+taynY/hI2UJkCxZpM843k=
X-Google-Smtp-Source: AJdET5fFiCysdaxY6EXsuOOFxGWDPsZZbnvcWA8+2WGE/k1AlC0OHhVAgWopq8XEHIwXD1byD6N5fg==
X-Received: by 2002:a5d:4d46:: with SMTP id a6-v6mr10586324wru.316.1541172214282;
        Fri, 02 Nov 2018 08:23:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j203-v6sm27400713wmd.46.2018.11.02.08.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 08:23:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     benpeart@microsoft.com, git@vger.kernel.org
Subject: Re: [PATCH v1] add: speed up cmd_add() by utilizing read_cache_preload()
References: <20181102133050.10756-1-peartben@gmail.com>
Date:   Sat, 03 Nov 2018 00:23:32 +0900
In-Reply-To: <20181102133050.10756-1-peartben@gmail.com> (Ben Peart's message
        of "Fri, 2 Nov 2018 09:30:50 -0400")
Message-ID: <xmqqy3abo64r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> From: Ben Peart <benpeart@microsoft.com>
>
> During an "add", a call is made to run_diff_files() which calls
> check_remove() for each index-entry.  The preload_index() code
> distributes some of the costs across multiple threads.

Nice.  I peeked around and noticed that we already do this in
builtin_diff_index() before running run_diff_index() when !cached,
and builtin_diff_files(), of course.

> Because the files checked are restricted to pathspec, adding individual
> files makes no measurable impact but on a Windows repo with ~200K files,
> 'git add .' drops from 6.3 seconds to 3.3 seconds for a 47% savings.

;-)

> diff --git a/builtin/add.c b/builtin/add.c
> index ad49806ebf..f65c172299 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -445,11 +445,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  
> -	if (read_cache() < 0)
> -		die(_("index file corrupt"));
> -
> -	die_in_unpopulated_submodule(&the_index, prefix);
> -
>  	/*
>  	 * Check the "pathspec '%s' did not match any files" block
>  	 * below before enabling new magic.

It is not explained why this is not a mere s/read_cache/&_preload/
in the log message.  I can see it is because you wanted to make the
pathspec available to preload to further cut down the preloaded
paths, and I do not think it has any unintended (negatie) side
effect to parse the pathspec before populating the in-core index,
but that would have been a good thing to mention in the proposed log
message.

> @@ -459,6 +454,10 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		       PATHSPEC_SYMLINK_LEADING_PATH,
>  		       prefix, argv);
>  
> +	if (read_cache_preload(&pathspec) < 0)
> +		die(_("index file corrupt"));
> +
> +	die_in_unpopulated_submodule(&the_index, prefix);
>  	die_path_inside_submodule(&the_index, &pathspec);
>  
>  	if (add_new_files) {
>
> base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
