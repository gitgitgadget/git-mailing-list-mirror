Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A871F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 13:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755625AbcIFNhu (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 09:37:50 -0400
Received: from avasout08.plus.net ([212.159.14.20]:36652 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754815AbcIFNhs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 09:37:48 -0400
Received: from [10.0.2.15] ([209.93.82.95])
        by avasout08 with smtp
        id gDdi1t00923PrXV01DdjqP; Tue, 06 Sep 2016 14:37:45 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Y6S6iVWN c=1 sm=1 tr=0
 a=MrGUH+yfTxdMEvUZuMmDjA==:117 a=MrGUH+yfTxdMEvUZuMmDjA==:17
 a=N659UExz7-8A:10 a=1XWaLZrsAAAA:8 a=POmjlrRxirlZQ2oF6tcA:9 a=pILNOxqGKmIA:10
 a=nJcEw6yWrPvoIXZ49MH8:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCHv4] diff.c: emit moved lines with a different color
To:     Stefan Beller <stefanbeller@gmail.com>, git@vger.kernel.org
References: <20160906070151.15163-1-stefanbeller@gmail.com>
Cc:     jnareb@gmail.com, gitster@pobox.com, jacob.keller@gmail.com,
        Stefan Beller <sbeller@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <87a1ddbf-2499-d5b4-55c4-aeed2b72acce@ramsayjones.plus.com>
Date:   Tue, 6 Sep 2016 14:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160906070151.15163-1-stefanbeller@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/09/16 08:01, Stefan Beller wrote:
[snip]
> This patch was motivated by e.g. reviewing 3b0c4200 ("apply: move
> libified code from builtin/apply.c to apply.{c,h}", 2016-08-08)
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
>  * moved new data structures into struct diff_options
>  * color.moved=bool as well as --[no-]color-moved to {dis,en}able the new feature
>  * color.diff.movedfrom and color.diff.movedto to control the colors
>  * added a test
>  
>  Documentation/config.txt               |  12 +-
>  Documentation/diff-options.txt         |   7 ++
>  contrib/completion/git-completion.bash |   2 +
>  diff.c                                 | 211 +++++++++++++++++++++++++++++++--
>  diff.h                                 |  16 ++-
>  t/t4015-diff-whitespace.sh             |  44 +++++++
>  6 files changed, 282 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0bcb679..5daf77a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -974,14 +974,22 @@ This does not affect linkgit:git-format-patch[1] or the
>  'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
>  command line with the `--color[=<when>]` option.
>  
> +color.moved::
> +	A boolean value, whether a diff should color moved lines
> +	differently. The moved lines are searched for in the diff only.
> +	Duplicated lines from somewhere in the project that are not
> +	part of the diff are not colored as moved.
> +	Defaults to true.
> +
>  color.diff.<slot>::
>  	Use customized color for diff colorization.  `<slot>` specifies
>  	which part of the patch to use the specified color, and is one
>  	of `context` (context text - `plain` is a historical synonym),
>  	`meta` (metainformation), `frag`
>  	(hunk header), 'func' (function in hunk header), `old` (removed lines),
> -	`new` (added lines), `commit` (commit headers), or `whitespace`
> -	(highlighting whitespace errors).
> +	`new` (added lines), `commit` (commit headers), `whitespace`
> +	(highlighting whitespace errors), `movedfrom` (removed lines that
> +	reappear), `movedto` (added lines that were removed elsewhere).
>  
>  color.decorate.<slot>::
>  	Use customized color for 'git log --decorate' output.  `<slot>` is one
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 705a873..13b6a2a 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -234,6 +234,13 @@ ifdef::git-diff[]
>  endif::git-diff[]
>  	It is the same as `--color=never`.
>  
> +--[no-]color-moved::
> +	Show moved blocks in a different color.
> +ifdef::git-diff[]
> +	It can be changed by the `diff.ui` and `color.diff`
> +	configuration settings.
> +endif::git-diff[]
> +
>  --word-diff[=<mode>]::
>  	Show a word diff, using the <mode> to delimit changed words.
>  	By default, words are delimited by whitespace; see
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 9c8f738..9827c2e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2115,6 +2115,8 @@ _git_config ()
>  		color.diff.old
>  		color.diff.plain
>  		color.diff.whitespace
> +		color.diff.movedfrom
> +		color.diff.movedto
>  		color.grep
>  		color.grep.context
>  		color.grep.filename
> diff --git a/diff.c b/diff.c
> index 534c12e..47685f3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -18,6 +18,7 @@
>  #include "ll-merge.h"
>  #include "string-list.h"
>  #include "argv-array.h"
> +#include "git-compat-util.h"
>  
>  #ifdef NO_FAST_WORKING_DIRECTORY
>  #define FAST_WORKING_DIRECTORY 0
> @@ -30,6 +31,7 @@ static int diff_compaction_heuristic; /* experimental */
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> +static int diff_color_moved_default = -1;
>  static int diff_context_default = 3;
>  static const char *diff_word_regex_cfg;
>  static const char *external_diff_cmd_cfg;
> @@ -52,6 +54,8 @@ static char diff_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_YELLOW,	/* COMMIT */
>  	GIT_COLOR_BG_RED,	/* WHITESPACE */
>  	GIT_COLOR_NORMAL,	/* FUNCINFO */
> +	GIT_COLOR_BLUE,		/* MOVED FROM */
> +	GIT_COLOR_MAGENTA,	/* MOVED TO */
>  };
>  
>  static int parse_diff_color_slot(const char *var)
> @@ -72,6 +76,10 @@ static int parse_diff_color_slot(const char *var)
>  		return DIFF_WHITESPACE;
>  	if (!strcasecmp(var, "func"))
>  		return DIFF_FUNCINFO;
> +	if (!strcasecmp(var, "movedfrom"))
> +		return DIFF_FILE_MOVED_FROM;
> +	if (!strcasecmp(var, "movedto"))
> +		return DIFF_FILE_MOVED_TO;
>  	return -1;
>  }
>  
> @@ -180,6 +188,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_use_color_default = git_config_colorbool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "color.moved")) {
> +		diff_color_moved_default = git_config_bool(var, value);
> +		return 0;
> +	}
>  	if (!strcmp(var, "diff.context")) {
>  		diff_context_default = git_config_int(var, value);
>  		if (diff_context_default < 0)
> @@ -287,6 +299,26 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  	return git_default_config(var, value, cb);
>  }
>  
> +static int diff_line_moved_entry_cmp(const struct diff_line_moved_entry *a,
> +				     const struct diff_line_moved_entry *b,
> +				     const void *unused)
> +{
> +	return strcmp(a->line, b->line) &&
> +	       a->hash_prev_line == b->hash_prev_line;

I doubt it would make much difference, but my knee-jerk reaction to
this was to suggest swapping the order of the expression, thus:

	return a->hash_prev_line == b->hash_prev_line &&
		strcmp(a->line, b->line);

... but perhaps it doesn't read quite so well, and probably wouldn't affect
performance much (except in strange edge cases), so it may not be worth it.

ATB,
Ramsay Jones

