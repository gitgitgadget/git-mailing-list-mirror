From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 4/5] diff: introduce diff.submoduleFormat configuration
 variable
Date: Tue, 02 Oct 2012 21:44:24 +0200
Message-ID: <506B4418.2050700@web.de>
References: <1349196670-2844-1-git-send-email-artagnon@gmail.com> <1349196670-2844-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:44:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8OT-0000RO-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab2JBTo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:44:27 -0400
Received: from mout.web.de ([212.227.17.11]:53568 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab2JBTo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:44:26 -0400
Received: from [192.168.178.41] ([91.3.177.137]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MSav6-1StnWG3Vrg-00Rixc; Tue, 02 Oct 2012 21:44:24
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1349196670-2844-5-git-send-email-artagnon@gmail.com>
X-Provags-ID: V02:K0:31nFhVnBUbmoCT74pWWo8gATyEBX+xZ8CS8I3Z5PXW2
 nVH+/a0HcoMPJSKzJhvLeV1l3NiJjHJXM/B7W7j5dP5gS/P6GP
 +ju4Pp759eSO+56c+IO9P9DYfwW2IrF3SzvJmsL6VGaFnNok2Z
 ENsIzzKc0PEvy0E0oTyBuFbz7FmiDWhXOaIouGg32OHsnOrpu/
 qeVtEr4aJrOOcE04AzuBw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206841>

Am 02.10.2012 18:51, schrieb Ramkumar Ramachandra:
> Introduce a diff.submoduleFormat configuration variable corresponding
> to the '--submodule' command-line option of 'git diff'.

Nice. Maybe a better name would be "diff.submodule", as this sets the
default for the "--submodule" option of diff?

And I think you should also test in t4041 that "--submodule=short"
overrides the config setting.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/diff-config.txt    |    7 +++++++
>  Documentation/diff-options.txt   |    3 ++-
>  diff.c                           |   25 ++++++++++++++++---------
>  t/t4041-diff-submodule-option.sh |   10 ++++++++++
>  4 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index 04574f9..e445cc8 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -103,6 +103,13 @@ diff.suppressBlankEmpty::
>  	A boolean to inhibit the standard behavior of printing a space
>  	before each empty output line. Defaults to false.
>  
> +diff.submoduleFormat::
> +	Specify the format in which differences in submodules are
> +	shown.  The "log" format lists the commits in the range like
> +	linkgit:git-submodule[1] `summary` does.  The "short" format
> +	format just shows the names of the commits at the beginning
> +	and end of the range.  Defaults to short.
> +
>  diff.wordRegex::
>  	A POSIX Extended Regular Expression used to determine what is a "word"
>  	when performing word-by-word difference calculations.  Character
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index cf4b216..034c4e7 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -170,7 +170,8 @@ any of those replacements occurred.
>  	the commits in the range like linkgit:git-submodule[1] `summary` does.
>  	Omitting the `--submodule` option or specifying `--submodule=short`,
>  	uses the 'short' format. This format just shows the names of the commits
> -	at the beginning and end of the range.
> +	at the beginning and end of the range.  Can be tweaked via the
> +	`diff.submoduleFormat` configuration variable.
>  
>  --color[=<when>]::
>  	Show colored diff.
> diff --git a/diff.c b/diff.c
> index 8ea40f9..4cb8dd2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -28,6 +28,7 @@ static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
>  static const char *diff_word_regex_cfg;
>  static const char *external_diff_cmd_cfg;
> +static const char *submodule_format_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> @@ -161,6 +162,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_stat_graph_width = git_config_int(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.submoduleformat"))
> +		return git_config_string(&submodule_format_cfg, var, value);
>  	if (!strcmp(var, "diff.external"))
>  		return git_config_string(&external_diff_cmd_cfg, var, value);
>  	if (!strcmp(var, "diff.wordregex"))
> @@ -2227,15 +2230,19 @@ static void builtin_diff(const char *name_a,
>  		line_prefix = msgbuf->buf;
>  	}
>  
> -	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
> -			(!one->mode || S_ISGITLINK(one->mode)) &&
> -			(!two->mode || S_ISGITLINK(two->mode))) {
> -		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
> -		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
> -		show_submodule_summary(o->file, one ? one->path : two->path,
> -				one->sha1, two->sha1, two->dirty_submodule,
> -				del, add, reset);
> -		return;
> +	if (!DIFF_OPT_TST(o, SUBMODULE_SHORT) &&
> +		((!one->mode || S_ISGITLINK(one->mode)) &&
> +			(!two->mode || S_ISGITLINK(two->mode)))) {
> +		if (DIFF_OPT_TST(o, SUBMODULE_LOG) ||
> +			(submodule_format_cfg &&
> +				!strcmp(submodule_format_cfg, "log"))) {
> +			const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
> +			const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
> +			show_submodule_summary(o->file, one ? one->path : two->path,
> +					one->sha1, two->sha1, two->dirty_submodule,
> +					del, add, reset);
> +			return;
> +		}
>  	}
>  
>  	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index 6c01d0c..ed4f3a8 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -43,6 +43,16 @@ EOF
>  	test_cmp expected actual
>  "
>  
> +test_expect_success 'added submodule, set diff.submoduleFormat' "
> +	git config diff.submoduleFormat log &&
> +	git add sm1 &&
> +	git diff --cached >actual &&
> +	cat >expected <<-EOF &&
> +Submodule sm1 0000000...$head1 (new submodule)
> +EOF
> +	test_cmp expected actual
> +"
> +
>  commit_file sm1 &&
>  head2=$(add_file sm1 foo3)
>  
> 
