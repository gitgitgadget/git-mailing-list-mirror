Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC711FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 05:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750825AbdDAFhT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 01:37:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55241 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750796AbdDAFhS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 01:37:18 -0400
Received: (qmail 20139 invoked by uid 109); 1 Apr 2017 05:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 05:37:19 +0000
Received: (qmail 15674 invoked by uid 111); 1 Apr 2017 05:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 01:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 01:37:16 -0400
Date:   Sat, 1 Apr 2017 01:37:16 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Stanca <robert.stanca7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [GSOC] remove_temporary_files(): reimplement using
 iterators
Message-ID: <20170401053716.yzxqxokuz3awqki4@sigill.intra.peff.net>
References: <20170401002458.3494-1-robert.stanca7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170401002458.3494-1-robert.stanca7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 01, 2017 at 03:24:58AM +0300, Robert Stanca wrote:

> @@ -49,12 +51,7 @@ static void remove_temporary_files(void)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	size_t dirlen, prefixlen;
> -	DIR *dir;
> -	struct dirent *e;
> -
> -	dir = opendir(packdir);
> -	if (!dir)
> -		return;
> +	struct dir_iterator *diter = dir_iterator_begin(packdir);
>  
>  	/* Point at the slash at the end of ".../objects/pack/" */
>  	dirlen = strlen(packdir) + 1;
> @@ -62,14 +59,13 @@ static void remove_temporary_files(void)
>  	/* Hold the length of  ".tmp-%d-pack-" */
>  	prefixlen = buf.len - dirlen;
>  
> -	while ((e = readdir(dir))) {
> -		if (strncmp(e->d_name, buf.buf + dirlen, prefixlen))
> +	while (dir_iterator_advance(diter) == ITER_OK) {
> +		if (strncmp(diter->relative_path, buf.buf + dirlen, prefixlen))
>  			continue;
>  		strbuf_setlen(&buf, dirlen);
> -		strbuf_addstr(&buf, e->d_name);
> +		strbuf_addstr(&buf, diter->relative_path);
>  		unlink(buf.buf);
>  	}
> -	closedir(dir);

I think you could actually clean this code up more. The dir_iterator
already does this strbuf magic to hold the full path, so you should be
able to just run "unlink(iter->path.buf)", get rid of the extra strbuf
entirely.

We use that strbuf for the prefix-comparison, too, but the way it is
done is rather confusing. AFAICT, we could just be comparing against
"packtmp + strlen(packdir) + 1". Though it would be simpler still to
make "packtmp" just the basename, rather than the full path.

I do agree with the point Junio raised, though, that this loop isn't
recursive, but dir_iterator is. I think there was talk elsewhere of
giving it more options, so perhaps it could be taught a non-recursive
version. Until we have that, though, I'm not sure this is a good spot to
convert.

-Peff
