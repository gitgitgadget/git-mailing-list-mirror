Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BF91FAA8
	for <e@80x24.org>; Tue, 16 May 2017 12:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753284AbdEPMb6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 08:31:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52587 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbdEPMbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 08:31:42 -0400
Received: (qmail 30740 invoked by uid 109); 16 May 2017 12:31:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 12:31:34 +0000
Received: (qmail 27271 invoked by uid 111); 16 May 2017 12:32:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 08:32:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 08:31:32 -0400
Date:   Tue, 16 May 2017 08:31:32 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com
Subject: Re: [PATCH 19/19] diff.c: color moved lines differently
Message-ID: <20170516123132.gekwt6fjbmadubnp@sigill.intra.peff.net>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-20-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170514040117.25865-20-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 13, 2017 at 09:01:17PM -0700, Stefan Beller wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874d51..90403c06e3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1051,14 +1051,22 @@ This does not affect linkgit:git-format-patch[1] or the
>  'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
>  command line with the `--color[=<when>]` option.
>  
> +color.moved::
> +	A boolean value, whether a diff should color moved lines
> +	differently. The moved lines are searched for in the diff only.
> +	Duplicated lines from somewhere in the project that are not
> +	part of the diff are not colored as moved.
> +	Defaults to false.

I wanted to play with this series to see how it looked on a few commits.
Since this was the only documentation change, I tried "git -c
color.moved=true diff ...". But it doesn't seem to work.

If we grep for diff_color_moved_default, we can see it declared:

> diff --git a/diff.c b/diff.c
> index dbab7fb44e..6372e0eb25 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -31,6 +31,7 @@ static int diff_indent_heuristic; /* experimental */
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> +static int diff_color_moved_default;
>  static int diff_context_default = 3;
>  static int diff_interhunk_context_default;
>  static const char *diff_word_regex_cfg;

and we can see it parsed:

> @@ -234,6 +247,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_use_color_default = git_config_colorbool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "color.moved")) {
> +		diff_color_moved_default = git_config_bool(var, value);
> +		return 0;
> +	}

But then nobody uses it. ;)

I suspect diff_setup() needs to copy the default into the diff_options
struct?

By reading the code, I found --color-moved, which did work. Yay. So then
I wanted to see how it looked on a wide variety of commits. So I ran
"git log -p --color-moved", but it segfaulted. :-/

I didn't dig, but here's what valgrind says, in case it helps:

  $ valgrind ./git --no-pager log --oneline -p --color-moved
  [...]
  fcdb8874d diff: buffer all output if asked to
  ==8801== Invalid write of size 4
  ==8801==    at 0x1FD521: builtin_diff (diff.c:2869)
  ==8801==    by 0x1FF3CB: run_diff_cmd (diff.c:3582)
  ==8801==    by 0x1FF7F9: run_diff (diff.c:3670)
  ==8801==    by 0x202CC8: diff_flush_patch (diff.c:4664)
  ==8801==    by 0x204123: diff_flush_patch_all_file_pairs (diff.c:5125)
  ==8801==    by 0x204682: diff_flush (diff.c:5249)
  ==8801==    by 0x22CE18: log_tree_diff_flush (log-tree.c:775)
  ==8801==    by 0x22D063: log_tree_diff (log-tree.c:842)
  ==8801==    by 0x22D195: log_tree_commit (log-tree.c:871)
  ==8801==    by 0x1648CE: cmd_log_walk (log.c:365)
  ==8801==    by 0x1659B0: cmd_log (log.c:689)
  ==8801==    by 0x11A434: run_builtin (git.c:371)
  ==8801==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
  ==8801== 
  ==8801== 
  ==8801== Process terminating with default action of signal 11
  (SIGSEGV)
  ==8801==  Access not within mapped region at address 0x8
  ==8801==    at 0x1FD521: builtin_diff (diff.c:2869)
  ==8801==    by 0x1FF3CB: run_diff_cmd (diff.c:3582)
  ==8801==    by 0x1FF7F9: run_diff (diff.c:3670)
  ==8801==    by 0x202CC8: diff_flush_patch (diff.c:4664)
  ==8801==    by 0x204123: diff_flush_patch_all_file_pairs (diff.c:5125)
  ==8801==    by 0x204682: diff_flush (diff.c:5249)
  ==8801==    by 0x22CE18: log_tree_diff_flush (log-tree.c:775)
  ==8801==    by 0x22D063: log_tree_diff (log-tree.c:842)
  ==8801==    by 0x22D195: log_tree_commit (log-tree.c:871)
  ==8801==    by 0x1648CE: cmd_log_walk (log.c:365)
  ==8801==    by 0x1659B0: cmd_log (log.c:689)
  ==8801==    by 0x11A434: run_builtin (git.c:371)

It does show one commit correctly; fcdb8874d (your commit, but picked up
from the list, so my commit sha1) is the second one. I don't know if
that's coincidence, or maybe there's something that's not properly
between diff runs.

-Peff
