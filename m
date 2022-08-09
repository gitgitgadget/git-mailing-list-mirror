Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B07C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiHINWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiHINWq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:22:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD911900D
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:22:45 -0700 (PDT)
Received: (qmail 30814 invoked by uid 109); 9 Aug 2022 13:22:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Aug 2022 13:22:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2202 invoked by uid 111); 9 Aug 2022 13:22:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Aug 2022 09:22:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Aug 2022 09:22:44 -0400
From:   Jeff King <peff@peff.net>
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v2] rev-list: support human-readable output for
 `--disk-usage`
Message-ID: <YvJfpNSKMIPqVQmD@coredump.intra.peff.net>
References: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>
 <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 08, 2022 at 08:35:21AM +0000, Li Linchao via GitGitGadget wrote:

> The '--disk-usage' option for git-rev-list was introduced in 16950f8384
> (rev-list: add --disk-usage option for calculating disk usage, 2021-02-09).
> This is very useful for people inspect their git repo's objects usage
> infomation, but the resulting number is quit hard for a human to read.
> 
> Teach git rev-list to output a human readable result when using
> '--disk-usage'.

OK. When adding --disk-usage, I never really dreamed people would use it
for human output, since "du .git" is usually a suitable approximation. :)
But I don't have any real objection. I'm curious what your use case is
like, if you don't mind sharing. We used it at GitHub for computing
per-fork sizes for analysis, etc (so the result was always fed into
another script).

>  Documentation/rev-list-options.txt |  5 +++-
>  builtin/rev-list.c                 | 42 ++++++++++++++++++++++++------
>  t/t6115-rev-list-du.sh             | 22 ++++++++++++++++
>  3 files changed, 60 insertions(+), 9 deletions(-)

The patch itself looks pretty sensible (and thanks Ævar for the first
round of review; the suggestions there all looked good). A few small
comments:

> @@ -481,8 +485,13 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
>  	if (!bitmap_git)
>  		return -1;
>  
> -	printf("%"PRIuMAX"\n",
> -	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
> +	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
> +	if (human_readable)
> +		strbuf_humanise_bytes(&disk_buf, size_from_bitmap);
> +	else
> +		strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)size_from_bitmap);
> +	puts(disk_buf.buf);
> +	strbuf_release(&disk_buf);

It's not a lot of duplicated lines, but since it is implementing policy
logic, I think it would be nice to move the formatting decision into a
function. Something like:

  static void show_disk_usage(off_t size)
  {
	struct strbuf sb = STRBUF_INIT;
	if (human_readable)
		strbuf_humanise_bytes(&sb, size);
	else
		strbuf_addf(&sb, "%"PRIuMAX, (uintmax_t)size_from_bitmap);
	puts(sb.buf);
	strbuf_release(&sb);
  }

and then you can call it from here, and from the non-bitmap path below.

(Also, while typing it out, I noticed that you don't need the extra ""
after PRIuMAX; that just concatenates an empty string).

> -		if (!strcmp(arg, "--disk-usage")) {
> -			show_disk_usage = 1;
> -			info.flags |= REV_LIST_QUIET;
> -			continue;
> +		if (skip_prefix(arg, "--disk-usage", &arg)) {
> +			if (*arg == '=') {
> +				if (!strcmp(++arg, "human")) {
> +					human_readable = 1;
> +					show_disk_usage = 1;
> +					info.flags |= REV_LIST_QUIET;
> +					continue;
> +				} else
> +					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);
> +			} else {
> +				show_disk_usage = 1;
> +				info.flags |= REV_LIST_QUIET;
> +				continue;
> +			}
>  		}

We can put the common parts of each side of the conditional into the
outer block to avoid repeating ourselves. Also, your code matches
--show-disk-usage-without-an-equals, since it nows uses skip_prefix().
You could fix that by checking for '\0' in *arg. So together, something
like:

  if (skip_prefix(arg, "--disk-usage", &arg)) {
	if (*arg == '=') {
		if (!strcmp(++arg, "human"))
			human_readable = 1;
		else
			die(...);
	} else if (*arg) {
		/*
		 * Arguably should goto a label to continue chain of ifs?
		 * Doesn't matter unless we try to add --disk-usage-foo
		 * afterwards
		 */
		usage(rev_list_usage);
	}
	show_disk_usage = 1;
	info.flags |= REV_LIST_QUIET;
	continue;
  }

-Peff
