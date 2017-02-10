Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD761FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 20:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbdBJUIm (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 15:08:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:53136 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752557AbdBJUIm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 15:08:42 -0500
Received: (qmail 31882 invoked by uid 109); 10 Feb 2017 20:08:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 20:08:41 +0000
Received: (qmail 19323 invoked by uid 111); 10 Feb 2017 20:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Feb 2017 15:08:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2017 15:08:39 -0500
Date:   Fri, 10 Feb 2017 15:08:39 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v3] gc: ignore old gc.log files
Message-ID: <20170210200838.kuwpldsgzvkjlmri@sigill.intra.peff.net>
References: <20170210192019.13927-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170210192019.13927-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 10, 2017 at 02:20:19PM -0500, David Turner wrote:

> @@ -76,10 +77,47 @@ static void git_config_date_string(const char *key, const char **output)
>  static void process_log_file(void)
>  {
>  	struct stat st;
> -	if (!fstat(get_lock_file_fd(&log_lock), &st) && st.st_size)
> +	if (fstat(get_lock_file_fd(&log_lock), &st)) {
> +		if (errno == ENOENT) {
> +			/*
> +			 * The user has probably intentionally deleted
> +			 * gc.log.lock (perhaps because they're blowing
> +			 * away the whole repo), so thre's no need to
> +			 * report anything here.  But we also won't
> +			 * delete gc.log, because we don't know what
> +			 * the user's intentions are.
> +			 */

Hrm. Does fstat actually trigger ENOENT in that case? There's no
pathname lookup happening at all. A simple test on Linux seems to show
that it does not. Build:

	#include <unistd.h>
	#include <fcntl.h>
	#include <sys/stat.h>
	
	int main(int argc, char **argv)
	{
		struct stat st;
		int fd = open(argv[1], O_WRONLY|O_CREAT|O_EXCL, 0600);
		unlink(argv[1]);
		fstat(fd, &st);
		return 0;
	}

and run:

  strace ./a.out tmp

which shows:

  open("tmp", O_WRONLY|O_CREAT|O_EXCL, 056660) = 3
  unlink("tmp")                           = 0
  fstat(3, {st_mode=S_IFREG|S_ISUID|S_ISGID|0640, st_size=0, ...}) = 0

But maybe there are other systems emulating fstat() would trigger here.
I dunno.

> +		} else {
> +			FILE *fp;
> +			int fd;
> +			int saved_errno = errno;
> +			/*
> +			 * Perhaps there was an i/o error or another
> +			 * unlikely situation.  Try to make a note of
> +			 * this in gc.log.  If this fails again,
> +			 * give up and leave gc.log as it was.
> +			 */
> +			rollback_lock_file(&log_lock);
> +			fd = hold_lock_file_for_update(&log_lock,
> +						       git_path("gc.log"),
> +						       LOCK_DIE_ON_ERROR);

If there was an i/o error, then gc.log.lock still exists. And this
attempt to lock will therefore fail, calling die(). Which would trigger
our atexit() to call process_log(), which would hit this code again, and
so forth. I'm not sure if we'd actually recurse when an atexit handler
calls exit(). But it seems questionable.

I'm also not sure why we need to re-open the file in the first place. We
have an open descriptor (and we even redirected stderr to it already).
Why don't we just write to it?

> @@ -113,6 +151,9 @@ static void gc_config(void)
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_date_string("gc.pruneexpire", &prune_expire);
>  	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
> +	if (!git_config_get_value("gc.logexpiry", &value))
> +		parse_expiry_date(value, &gc_log_expire_time);
> +

Should you be using git_config_date_string() here? It looks like it does
some extra sanity-checking. It annoyingly just gets the string, and
doesn't parse it. Perhaps it would be worth adding a
git_config_date_value() helper.

Or alternatively, save the date string here, and then parse once later
on, after having resolved all config (and overwritten the default
value).

> @@ -448,5 +506,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		warning(_("There are too many unreachable loose objects; "
>  			"run 'git prune' to remove them."));
>  
> +	if (!daemonized)
> +		unlink(git_path("gc.log"));
> +

I think this is a good thing to do, though I'd have probably put it in a
separate patch. I guess that's a matter of taste.

> +test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
> +	keep=$(ls .git/objects/pack/*.pack|head -1|sed -e "s/pack$/keep/") &&
> +	test_commit foo &&
> +	test_commit bar &&
> +	git repack &&
> +	test_config gc.autopacklimit 1 &&
> +	test_config gc.autodetach true &&
> +	echo fleem >.git/gc.log &&
> +	test_must_fail git gc --auto 2>err &&
> +	test_i18ngrep "^error:" err &&
> +	test-chmtime =-86401 .git/gc.log &&
> +	git gc --auto
> +'

This gives only 1 second of leeway. I wonder if we could end up getting
bogus failures due to system clock adjustments, or even skew between the
filesystem and OS clocks. Perhaps we should set it farther back, like a
few days.

(It also relies on the 1-day default. That's probably OK, though we
could also set an explicit default for the test, which would exercise
the config code path, too).

-Peff
