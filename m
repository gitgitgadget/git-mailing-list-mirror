Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F8F1FAF4
	for <e@80x24.org>; Thu,  9 Feb 2017 03:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdBIDaI (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 22:30:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:52003 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751369AbdBIDaH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 22:30:07 -0500
Received: (qmail 22306 invoked by uid 109); 9 Feb 2017 03:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Feb 2017 03:23:27 +0000
Received: (qmail 13343 invoked by uid 111); 9 Feb 2017 03:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 22:23:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 22:23:25 -0500
Date:   Wed, 8 Feb 2017 22:23:25 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH] gc: ignore old gc.log files
Message-ID: <20170209032325.bspll66ux6n2pj4n@sigill.intra.peff.net>
References: <20170209020222.23642-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170209020222.23642-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 09:02:22PM -0500, David Turner wrote:

> The intent of automatic gc is to have a git repository be relatively
> low-maintenance from a server-operator perspective.  Of course, large
> operators like GitHub will need a more complicated management strategy,
> but for ordinary usage, git should just work.
> 
> In this commit, git learns to ignore gc.log files which are older than
> (by default) one day old.  It also learns about a config, gc.maxLogAge
> to manage this.
> 
> So git should never get itself into a state where it refuses to do any
> maintenance, just because at some point some piece of the maintenance
> didn't make progress.  That might still happen (e.g. because the repo
> is corrupt), but at the very least it won't be because Git is too dumb
> to try again.

Sounds like a good goal and approach.

> +gc.maxLogAge::
> +	If the file gc.log exists, then `git gc --auto` won't run
> +	unless that file is more than maxLogAge seconds old.  Default
> +	is 86400, one day.

For other time-based config, we use approxidate with a relative time,
like "1 day ago". I think it would make sense for this to match, as it
makes the config a little more readable.

You can follow the prune_expire example which is right below your new
config variable in all of the hunks of your patch. Though I think
ultimately that isn't parsed inside gc, so you'd eventually look at how
"prune --expire" is handled (which I think is via parse_expiry_date()).

> @@ -291,8 +293,19 @@ static int report_last_gc_error(void)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	int ret;
> +	struct stat st;
> +	const char *gc_log_path = git_path("gc.log");

I usually try to avoid assigning the result of git_path(), because it's
a static buffer. In this case it's fine, because you don't call any
complex calls during the lifetime of the variable. But I consider
assigning to be a bad practice.

Using git_pathdup() or git_path_buf() is safer (but you do need to
remember to free() as appropriate).

Speaking of leaks, I think report_last_gc_error() will always leak the
strbuf contents when it is non-empty.

> +	if (stat(gc_log_path, &st)) {
> +		if (errno == ENOENT)
> +			return 0;
> +		return error(_("Can't read %s"), gc_log_path);
> +	}

I'm not quite clear on the life-cycle of this log file.

I think the current code works like this:

  - if a non-empty gc.log exists, we bail

  - when we daemonize, we take a lock via gc.log.lock

  - if we wrote anything to the lockfile log, then we move it into place
    (essentially blocking further auto-gc)

  - otherwise, we rollback the lockfile and leave gc.log untouched

That leaves a few quirks with your new strategy:

  - if our new run was unsuccessful (as judged by having non-empty log
    output), we'd probably want to overwrite the old logfile with our
    new log. Following the current-code logic we do, which is good.

  - if our new run is successful (empty log), we'll leave the old,
    crufty log in place. Probably process_log_file() should unlink() the
    original gc.log while holding the lock.

And here are a few things I noticed that I think aren't caused by your
patch, but are in the same area and might be worth examining:

  - we're not very atomic. After a day, two simultaneous auto-gc's might
    both ignore the gc.log file and continue to run. I don't think it
    matters, though. One of them will win the race to pick up
    gc.log.lock, and the other will immediately fail.

  - It looks like we clear the gc.log file only under another detached
    auto-gc. It seems like manually running a successful "git gc" should
    clear it, too.

  - We block further gc only based on the presence of data on stderr
    from the sub-programs. But _not_ if the sub-programs fail. So a
    program silently exiting with code 128 will stop further gc
    processing, but not prevent another auto-gc from running. Which
    is...weird. Maybe this can't happen, though, because I think we
    write our own error() in such cases, which makes such a failure
    inherently non-silent.

> +	if (time(NULL) - st.st_mtime > gc_max_log_age_seconds)
> +		return 0;

Hmm. What happens if the file has a timestamp in the future due to clock
skew? As long as time_t is signed, I think it's OK, but if it wraps, it
does the wrong thing here. You could rearrange the subtraction to handle
this. But I think if you start using approxidate, it will give you an
a cutoff time, and you can just do:

  if (st.st_mtime < gc_log_expiration)
	return 0; /* too old to care about */

> -	ret = strbuf_read_file(&sb, git_path("gc.log"), 0);
> +	ret = strbuf_read_file(&sb, gc_log_path, 0);

I would have written this as an open(), followed by an fstat() on the
file we opened, and then finally reading the contents if it's fresh
enough. But I'm not sure if that level of atomicity matters. We're not
doing any of this under lock.

-Peff
