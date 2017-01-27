Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62151F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdA0SoS (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:44:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59897 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbdA0Sne (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:43:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 945A961E27;
        Fri, 27 Jan 2017 13:43:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TKuhDjMgFp3caJfj1wnejIUi0eo=; b=yhNSvb
        77iYjQVdy5/i80gOQqchgZRIYTpzJEz2M64bGHkAt3R7s3KBg4sGy1xVfYDiTGZK
        H4hGTtFRPmq/CXN54ayLwlgtGvP2zftJEyeLyMlsMeGt28wD3VZO8JoPvq3DVe38
        Rs0VapvBRVorefROHEyZfVV6tsen95WZ9wqEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OA4GJuDrZgqDJIdQpbv+GQmgIAwuEOv4
        VcCz+bskLQSZ+ypeuZEvlqOJKLdrtXyjguizTf7RihRR+Gm5VSZm8aXmjIhWkxrA
        bBhM/Pod2LQUvfsvNOlMEcJMWVfIdET6tMqsFG4VTYuLSm0v+9/GKK8Vo2FX/Mmv
        VoM0OiVYMO8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A6BD61E26;
        Fri, 27 Jan 2017 13:43:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDB1661E25;
        Fri, 27 Jan 2017 13:43:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
References: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de>
Date:   Fri, 27 Jan 2017 10:43:26 -0800
In-Reply-To: <c1c6ccae4e60608259809914e8ff3d3d5e1ead5a.1485524999.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 27 Jan 2017 14:50:09 +0100
        (CET)")
Message-ID: <xmqqd1f8z6lt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DFC85AE-E4C0-11E6-A2C8-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Heiko Voigt <hvoigt@hvoigt.net>
>
> The previous implementation said that the filesystem information on
> Windows is not reliable to determine whether a file is executable. To
> gather this information it was peeking into the first two bytes of a
> file to see whether it looks executable.
>
> Apart from the fact that on Windows executables are defined as such by
> their extension (and Git has special code to support "executing" scripts
> when they have a she-bang line) it leads to serious performance
> problems: not only do we have to open many files now, it gets even
> slower when a virus scanner is running.

Heiko, around here (before going into the details of how severe the
problem is and how wonderful the result applying of this change is)
is the best place to summarize the solution.  E.g.

	Because the definition of "executable" on Windows is based
	on the file extension, update the function to declare that a
	file with ".exe" extension without opening and reading the
	early bytes from it.  This avoids serious performance issues.

I paraphrased the rest only so that the description of the solution
(i.e. "instead of opening and peeking, we trust .exe suffix") fits
well in the surrounding text; the important part is to say what the
change does clearly.

I agree with the reasoning and the execution of the patch, except
that 

 - "correct behaviour" in the title makes it appear that this is a
   correctness thing, but this is primarily a performance fix.

 - It is a bit strange that "MZ" is dropped in the same patch
   without any mention.

The latter may be "correctness" fix, in that earlier we treated any
file that happens to begin with MZ as an executable, regardless of
the filename, which may have misidentified a non-executable file as
an executable.  If that is what is going on, it deserves to be
described in the log message.

> diff --git a/help.c b/help.c
> index 53e2a67e00..bc6cd19cf3 100644
> --- a/help.c
> +++ b/help.c
> @@ -105,7 +105,22 @@ static int is_executable(const char *name)
>  		return 0;
>  
>  #if defined(GIT_WINDOWS_NATIVE)
> -{	/* cannot trust the executable bit, peek into the file instead */
> +	/*
> +	 * On Windows there is no executable bit. The file extension
> +	 * indicates whether it can be run as an executable, and Git
> +	 * has special-handling to detect scripts and launch them
> +	 * through the indicated script interpreter. We test for the
> +	 * file extension first because virus scanners may make
> +	 * it quite expensive to open many files.
> +	 */
> +	if (ends_with(name, ".exe"))
> +		return S_IXUSR;
> +
> +{
> +	/*
> +	 * Now that we know it does not have an executable extension,
> +	 * peek into the file instead.
> +	 */
>  	char buf[3] = { 0 };
>  	int n;
>  	int fd = open(name, O_RDONLY);
> @@ -113,8 +128,8 @@ static int is_executable(const char *name)
>  	if (fd >= 0) {
>  		n = read(fd, buf, 2);
>  		if (n == 2)
> -			/* DOS executables start with "MZ" */
> -			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
> +			/* look for a she-bang */
> +			if (!strcmp(buf, "#!"))
>  				st.st_mode |= S_IXUSR;
>  		close(fd);
>  	}
>
> base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
