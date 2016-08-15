Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E521F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 20:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbcHOUki (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 16:40:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:55798 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932404AbcHOUkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 16:40:37 -0400
Received: (qmail 10150 invoked by uid 109); 15 Aug 2016 20:40:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 20:40:37 +0000
Received: (qmail 19621 invoked by uid 111); 15 Aug 2016 20:40:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 16:40:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 16:40:34 -0400
Date:	Mon, 15 Aug 2016 16:40:34 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160815204034.rrjn57wigxtjpgye@sigill.intra.peff.net>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
 <20160815195729.16826-4-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160815195729.16826-4-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 09:57:29PM +0200, Christian Couder wrote:

> From: Jeff King <peff@peff.net>
> 
> Receive-pack feeds its input to either index-pack or
> unpack-objects, which will happily accept as many bytes as
> a sender is willing to provide. Let's allow an arbitrary
> cutoff point where we will stop writing bytes to disk.
> 
> What has already been written to disk can be cleaned
> outside of receive-pack.

This second paragraph hints at a related problem.

Git is generally happy to leave tmp_pack_* around to be cleaned up later
next time git-gc runs. Including its default 2-week grace time.

So imagine that tries to "git push" in a loop. And each time they push,
you say "nope, that's too big". And each time you acquire a new 2GB
tmp_pack file. If your goal was to prevent somebody from streaming
straight to your filesystem and filling up your disk, then it wasn't
very successful. :)

The simple fix is to call register_tempfile() in open_pack_file(), and
just have index-pack clean up the file on its way out.

But there are harder cases. For instance, imagine somebody pushes a
500MB file, and you have a pre-receive hook that says "too big; I won't
accept this". And then they push in a loop, as before. You've accepted
the incoming pack into the repository by the time the pre-receive runs.
You can't just delete it, because you don't know if other simultaneous
processes have started to depend on the objects.

To solve that, I have patches that put incoming packfiles into a
"quarantine" area, then run the connectivity check and pre-receive hooks
with the quarantine accessible via GIT_ALTERNATE_OBJECT_DIRECTORIES. And
then we either move the quarantine packs into the real repo, or blow
away the tmpdir, depending on whether the hooks said the objects were
OK.

Those are patches I plan to share upstream but just haven't gotten
around to yet.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 92e1213..7627f7f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -46,6 +46,7 @@ static int transfer_unpack_limit = -1;
>  static int advertise_atomic_push = 1;
>  static int advertise_push_options;
>  static int unpack_limit = 100;
> +static off_t max_input_size;
>  static int report_status;
>  static int use_sideband;
>  static int use_atomic;
> @@ -212,6 +213,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (strcmp(var, "receive.maxsize") == 0) {
> +		max_input_size = git_config_ulong(var, value);
> +		return 0;
> +	}

Another off_t/ulong mismatch. I think you want git_config_int64() here.

> @@ -1650,6 +1656,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>  		if (fsck_objects)
>  			argv_array_pushf(&child.args, "--strict%s",
>  				fsck_msg_types.buf);
> +		if (max_input_size)
> +			argv_array_pushf(&child.args, "--max-input-size=%lu",
> +				max_input_size);

And here, PRIuMAX and uintmax_t. Or perhaps simpler, just store the
value as a string here and pass it on to index-pack (which would then
need to learn to handle suffixes like "2g"). We do a similar trick in
repack; see b861e23 (repack: propagate pack-objects options as strings,
2014-01-22).

> diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
> new file mode 100755
> index 0000000..d3a4d1a
> --- /dev/null
> +++ b/t/t5546-push-limits.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description='check input limits for pushing'
> +. ./test-lib.sh
> +
> +test_expect_success 'create known-size commit' '
> +	test-genrandom foo 1024 >file &&
> +	git add file &&
> +	test_commit one-k
> +'
> +
> +test_expect_success 'create remote repository' '
> +	git init --bare dest &&
> +	git --git-dir=dest config receive.unpacklimit 1
> +'

We're going to do basically the same battery of tests against an
unpacklimit of "1" (to catch index-pack) and of "10" (to catch
unpack-objects). It might be clearer to just have a for-loop like:

  for unpacklimit in 1 100
  do
	test_expect_success 'create remote repository' '
		rm -rf dest &&
		git init --bare dest &&
		git -C dest config receive.unpacklimit $unpacklimit
	'

	test_expect_success 'receive.maxsize rejects push' '
		git -C dest config receive.maxsize 512 &&
		test_must_fail git push dest HEAD &&
	'

	test_expect_success 'bumping limit allows push' '
		git -C dest config receive.maxsize 4k &&
		git push dest HEAD
	'
  done

and it's probably worth a comment at the top of the loop explaining what
the heck those numbers mean. :)

-Peff
