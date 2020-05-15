Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F3C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6FA020643
	for <git@archiver.kernel.org>; Fri, 15 May 2020 22:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgEOWW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 18:22:56 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:19967 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgEOWW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 18:22:56 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jZijG-0003ug-BE; Fri, 15 May 2020 23:22:54 +0100
Subject: Re: [PATCH] diff: add config option relative
To:     Laurent Arnoud <laurent@spkdev.net>, git@vger.kernel.org
References: <20200515155706.GA1165062@spk-laptop>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <baa06609-11fe-28e7-2b8b-8590b9e37104@iee.email>
Date:   Fri, 15 May 2020 23:22:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515155706.GA1165062@spk-laptop>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Laurent,

On 15/05/2020 16:57, Laurent Arnoud wrote:
> The `diff.relative` boolean option set to `true` to show only changes on the
> current directory and show relative pathnames.
>
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> ---
>  Documentation/config/diff.txt   |  4 +++
>  diff.c                          |  7 +++++
>  t/t9904-diff-relative-config.sh | 48 +++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100755 t/t9904-diff-relative-config.sh
>
> diff --git Documentation/config/diff.txt Documentation/config/diff.txt
> index ff09f1cf73..1d311358d8 100644
> --- Documentation/config/diff.txt
> +++ Documentation/config/diff.txt
> @@ -105,6 +105,10 @@ diff.mnemonicPrefix::
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
>  
> +diff.relative::
> +	If set to "true", 'git diff' does not show changes outside of the directory
> +	and show pathnames relative.

This last part sounded stilted. Maybe "and shows pathnames relative to
the current directory", assuming I've understood what it was meant to
say (and possible the same change in the commit message)

Philip
> +
>  diff.orderFile::
>  	File indicating how to order files within a diff.
>  	See the '-O' option to linkgit:git-diff[1] for details.
> diff --git diff.c diff.c
> index d1ad6a3c4a..24b7a0ae08 100644
> --- diff.c
> +++ diff.c
> @@ -48,6 +48,7 @@ static const char *diff_order_file_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> +static int diff_relative;
>  static int diff_stat_graph_width;
>  static int diff_dirstat_permille_default = 30;
>  static struct diff_options default_diff_options;
> @@ -386,6 +387,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_no_prefix = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.relative")) {
> +		diff_relative = git_config_bool(var, value);
> +		return 0;
> +	}
>  	if (!strcmp(var, "diff.statgraphwidth")) {
>  		diff_stat_graph_width = git_config_int(var, value);
>  		return 0;
> @@ -4558,6 +4563,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>  		options->b_prefix = "b/";
>  	}
>  
> +	options->flags.relative_name = diff_relative;
> +
>  	options->color_moved = diff_color_moved_default;
>  	options->color_moved_ws_handling = diff_color_moved_ws_default;
>  
> diff --git t/t9904-diff-relative-config.sh t/t9904-diff-relative-config.sh
> new file mode 100755
> index 0000000000..a92d53ca25
> --- /dev/null
> +++ t/t9904-diff-relative-config.sh
> @@ -0,0 +1,48 @@
> +#!/bin/sh
> +
> +test_description='config diff.relative'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git commit --allow-empty -m empty &&
> +	echo content >file1 &&
> +	mkdir subdir &&
> +	echo other content >subdir/file2 &&
> +	git add . &&
> +	git commit -m one
> +'
> +
> +check_diff () {
> +	dir=$1
> +	shift
> +	expect=$1
> +	shift
> +	relative_opt=$1
> +	shift
> +	short_blob=$(git rev-parse --short "$(git hash-object subdir/file2)")
> +	cat >expected <<-EOF
> +	diff --git a/$expect b/$expect
> +	new file mode 100644
> +	index 0000000..$short_blob
> +	--- /dev/null
> +	+++ b/$expect
> +	@@ -0,0 +1 @@
> +	+other content
> +	EOF
> +	test_expect_success "-p $*" "
> +		test_config -C $dir diff.relative $relative_opt &&
> +		git -C '$dir' diff -p $* HEAD^ >actual &&
> +		test_cmp expected actual
> +	"
> +}
> +
> +check_diff . file2 false --relative=subdir/
> +check_diff . file2 false --relative=subdir
> +check_diff . file2 true --relative=subdir/
> +check_diff . file2 true --relative=subdir
> +check_diff subdir file2 false --relative
> +check_diff subdir file2 true --relative
> +check_diff subdir file2 true
> +
> +test_done

