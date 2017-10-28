Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1F820562
	for <e@80x24.org>; Sat, 28 Oct 2017 14:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbdJ1OVW (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 10:21:22 -0400
Received: from ikke.info ([178.21.113.177]:53552 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbdJ1OVW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 10:21:22 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 4E26844039D; Sat, 28 Oct 2017 16:21:20 +0200 (CEST)
Date:   Sat, 28 Oct 2017 16:21:20 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Anthony Wong <anthony.wong@canonical.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cherry-pick: add --keep-existing-origin option
Message-ID: <20171028142120.GA12833@alpha.vpn.ikke.info>
References: <20171028120440.2022-1-yp@anthonywong.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171028120440.2022-1-yp@anthonywong.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 08:04:40PM +0800, Anthony Wong wrote:
> When cherry-picking from a commit whose commit message already
> contains the "(cherry picked from commit ...)" line, this option will
> not add another one. This is useful when you are cherry-picking from a
> bunch of commits, some are cherry-picks and already contains the
> upstream hash but some do not. Use with -x.
> 
> Signed-off-by: Anthony Wong <yp@anthonywong.net>
> ---
>  Documentation/git-cherry-pick.txt |  8 ++++++++
>  builtin/revert.c                  |  2 ++
>  sequencer.c                       | 14 ++++++++------
>  sequencer.h                       |  1 +
>  4 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index d35d771fc..7a074511f 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -71,6 +71,14 @@ OPTIONS
>  	development branch), adding this information can be
>  	useful.
>  
> +--keep-existing-origin::
> +	This option has to be used with -x to take effect. When
> +	cherry-picking from a commit whose commit message already
> +	contains the "(cherry picked from commit ...)" line, this
> +	option will not add another one. This is useful when you are
> +	cherry-picking from a bunch of commits, some are cherry-picks
> +	and already contains the upstream hash but some do not.
> +
>  -r::
>  	It used to be that the command defaulted to do `-x`
>  	described above, and `-r` was to disable it.  Now the
> diff --git a/builtin/revert.c b/builtin/revert.c
> index b9d927eb0..a1900cc1d 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -122,6 +122,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>  			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>  			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> +			OPT_BOOL(0, "keep-existing-origin", &opts->keep_existing_origin, N_("do not add another hash if one already exists, use with -x")),
>  			OPT_END(),
>  		};
>  		options = parse_options_concat(options, cp_extra);
> @@ -157,6 +158,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  				"--ff", opts->allow_ff,
>  				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
>  				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
> +				"--keep-existing-origin", opts->keep_existing_origin,
>  				NULL);
>  	}
>  
> diff --git a/sequencer.c b/sequencer.c
> index f2a10cc4f..c96add16e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1050,12 +1050,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  			strbuf_addstr(&msgbuf, p);
>  
>  		if (opts->record_origin) {
> -			strbuf_complete_line(&msgbuf);
> -			if (!has_conforming_footer(&msgbuf, NULL, 0))
> -				strbuf_addch(&msgbuf, '\n');
> -			strbuf_addstr(&msgbuf, cherry_picked_prefix);
> -			strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> -			strbuf_addstr(&msgbuf, ")\n");
> +			if (!opts->keep_existing_origin || strstr(msgbuf.buf, cherry_picked_prefix) == NULL) {
> +				strbuf_complete_line(&msgbuf);
> +				if (!has_conforming_footer(&msgbuf, NULL, 0))
> +					strbuf_addch(&msgbuf, '\n');
> +				strbuf_addstr(&msgbuf, cherry_picked_prefix);
> +				strbuf_addstr(&msgbuf, oid_to_hex(&commit->object.oid));
> +				strbuf_addstr(&msgbuf, ")\n");
> +			}
>  		}
>  	}
>  
> diff --git a/sequencer.h b/sequencer.h
> index 6f3d3df82..a907c0947 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -24,6 +24,7 @@ struct replay_opts {
>  	int allow_empty;
>  	int allow_empty_message;
>  	int keep_redundant_commits;
> +	int keep_existing_origin;
>  	int verbose;
>  
>  	int mainline;
> -- 
> 2.14.1
> 

I'm wondering if it isn't better to detect that there is already an
origin present and not add another one. 

Or are there situations where you do want multiple cherry-pick origins?

Kevin
