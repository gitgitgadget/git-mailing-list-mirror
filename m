Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A542D20954
	for <e@80x24.org>; Fri,  1 Dec 2017 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbdLASWl (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 13:22:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:45750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750914AbdLASWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 13:22:40 -0500
Received: (qmail 18215 invoked by uid 109); 1 Dec 2017 18:22:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Dec 2017 18:22:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8088 invoked by uid 111); 1 Dec 2017 18:22:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 01 Dec 2017 13:22:59 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Dec 2017 13:22:38 -0500
Date:   Fri, 1 Dec 2017 13:22:38 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, stolee@gmail.com
Subject: Re: [PATCH] sha1_file: use strbuf_add() instead of strbuf_addf()
Message-ID: <20171201182238.GA27688@sigill.intra.peff.net>
References: <20171201174956.143245-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171201174956.143245-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 01, 2017 at 12:49:56PM -0500, Derrick Stolee wrote:

> Replace use of strbuf_addf() with strbuf_add() when enumerating
> loose objects in for_each_file_in_obj_subdir(). Since we already
> check the length and hex-values of the string before consuming
> the path, we can prevent extra computation by using the lower-
> level method.

Makes sense. It's a shame that "addf" is turning out to be so slow (I'm
still mildly curious if that differs between Windows and glibc, but
there are so many other variables between the two platforms it's hard to
test).

> One consumer of for_each_file_in_obj_subdir() is the abbreviation
> code. OID abbreviations use a cached list of loose objects (per
> object subdirectory) to make repeated queries fast, but there is
> significant cache load time when there are many loose objects.
> 
> Most repositories do not have many loose objects before repacking,
> but in the GVFS case the repos can grow to have millions of loose
> objects. Profiling 'git log' performance in GitForWindows on a
> GVFS-enabled repo with ~2.5 million loose objects revealed 12% of
> the CPU time was spent in strbuf_addf().

Yeah, we haven't heavily micro-optimized the case for having lots of
loose objects. The general philosophy about having lots of loose objects
is: don't. You're generally going to pay a system call for each access,
which is much heavier-weight than packfiles.

I think abbreviation-finding is the exception there, though, because we
literally just readdir() the entries and never do anything else with
them.

> Add a new performance test to p4211-line-log.sh that is more
> sensitive to this cache-loading. By limiting to 1000 commits, we
> more closely resemble user wait time when reading history into a
> pager.
> 
> For a copy of the Linux repo with two ~512 MB packfiles and ~572K
> loose objects, running 'git log --oneline --raw --parents -1000'
> had the following performance:
> 
>  HEAD~1            HEAD
> ----------------------------------------
>  7.70(7.15+0.54)   7.44(7.09+0.29) -3.4%

Thanks for including numbers. I think the setup here highlights a
weakness of the perf suite that we've discussed: if there's a
performance regression for your case, nobody is likely to notice because
they won't test on a repo with 500k loose objects.

Probably "repo with a bunch of loose objects" ought to be a stock
repository profile for doing regression runs.

> diff --git a/sha1_file.c b/sha1_file.c
> index 8ae6cb6285..2160323c4a 100644

This overall looks good, but I noticed one bug and a few cosmetic
improvements.

> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1914,17 +1914,18 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
>  	}
>  
>  	oid.hash[0] = subdir_nr;
> +	strbuf_add(path, "/", 1);

Maybe:

  strbuf_addch(path, '/');

would be a bit more readable (it's also a tiny bit faster, but this
isn't part of the tight loop).

> +	baselen = path->len;

We set this here so that the '/' is included as part of the base. Makes
sense, but can we now drop the earlier setting of baselen before the
opendir() call?

>  	while ((de = readdir(dir))) {
>  		if (is_dot_or_dotdot(de->d_name))
>  			continue;
>  
> -		strbuf_setlen(path, baselen);
> -		strbuf_addf(path, "/%s", de->d_name);
> -
>  		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
>  		    !hex_to_bytes(oid.hash + 1, de->d_name,
>  				  GIT_SHA1_RAWSZ - 1)) {
> +			strbuf_setlen(path, baselen);
> +			strbuf_add(path, de->d_name, GIT_SHA1_HEXSZ - 2);

Moving this code into the conditional makes sense here, since that's
where we know the actual size. But what about the case when we _don't_
hit this conditional. We still do:

  if (cruft_cb)
        cruft_cb(path->buf);

which is now broken (it will just get the directory name without the
entry appended).

I think the optimized versions probably needs to be something more like:

  while (de = readdir(...)) {
      strbuf_setlen(path, baselen);
      if (size is HEXSZ - 2) {
          strbuf_add(path, de->d_name, HEXSZ - 2);
	  obj_cb(path->buf);
      } else if (cruft_cb) {
          strbuf_addstr(path, de->d_name);
	  cruft_cb(path->buf);
      }
  }

Two other thoughts:

  - from past discussions, I suspect most of your performance
    improvement actually comes from avoiding addf(), and the difference
    between addstr() and add() may be negligible here. It might be worth
    timing strbuf_addstr(). If that's similarly fast, that means we
    could keep the logic out of the conditional entirely.

  - there's an extra micro-optimization there, which is that if there's
    no obj_cb, we have no need to assemble the full path at all. I doubt
    it makes much of a difference, as most callers would pass an object
    callback (I'd be surprised if we even have one that doesn't).

-Peff
