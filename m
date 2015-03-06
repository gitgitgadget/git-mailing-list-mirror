From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] [GSoC][MICRO] Forbid "log --graph --no-walk"
Date: Fri, 06 Mar 2015 11:07:00 +0100
Message-ID: <54F97C44.8070204@web.de>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Dongcan Jiang <dongcan.jiang@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 11:07:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTpAD-0005fy-DY
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 11:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbbCFKHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 05:07:19 -0500
Received: from mout.web.de ([212.227.17.11]:59959 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbbCFKHR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 05:07:17 -0500
Received: from [192.168.178.27] ([79.253.128.80]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MDxGV-1YFjsS2d2t-00HQQO; Fri, 06 Mar 2015 11:07:15
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
X-Provags-ID: V03:K0:u+Z4veCmGTH960z0OPCAbpWXpjacQoNBJ18PxtGAhriIRxlUeE5
 ttfTwFaPjAqkAKKmCEye3S6r8uWV411LIzvJ9pSAE6OK8S/hk957tUmFMp7wRlwXvqKfrrr
 eT8CxPfFS2WEgmmVHaYLzddtB9y56yhbMLZnd65Gv/1JERK3cOh5fBOVNCqP4HPW+sZcQAG
 nqMUOyxkk0Bi09Mf2CUqQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264908>

Am 06.03.2015 um 09:55 schrieb Dongcan Jiang:
> Because --graph is about connected history while --no-walk is about discrete points.
>
> revision.c: Judge whether --graph and --no-walk come together when running git-log.
> buildin/log.c: Set git-log cmd flag.
> Documentation/rev-list-options.txt: Add specification on the forbidden usage.
>
> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
> ---
>   Documentation/rev-list-options.txt | 2 ++
>   builtin/log.c                      | 1 +
>   revision.c                         | 4 ++++
>   revision.h                         | 3 +++
>   4 files changed, 10 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4ed8587..eea2c0a 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -679,6 +679,7 @@ endif::git-rev-list[]
>   	given on the command line. Otherwise (if `sorted` or no argument
>   	was given), the commits are shown in reverse chronological order
>   	by commit time.
> +	Cannot be combined with `--graph` when running git-log.
>
>   --do-walk::
>   	Overrides a previous `--no-walk`.
> @@ -781,6 +782,7 @@ you would get an output like this:
>   	on the left hand side of the output.  This may cause extra lines
>   	to be printed in between commits, in order for the graph history
>   	to be drawn properly.
> +	Cannot be combined with `--no-walk` when running git-log.
>   +
>   This enables parent rewriting, see 'History Simplification' below.
>   +
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..7bf5adb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -627,6 +627,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>   	git_config(git_log_config, NULL);
>
>   	init_revisions(&rev, prefix);
> +	rev.cmd_is_log = 1;
>   	rev.always_show_header = 1;
>   	memset(&opt, 0, sizeof(opt));
>   	opt.def = "HEAD";
> diff --git a/revision.c b/revision.c
> index 66520c6..5f62c89 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1399,6 +1399,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
>
>   	revs->commit_format = CMIT_FMT_DEFAULT;
>
> +	revs->cmd_is_log = 0;
> +
>   	init_grep_defaults();
>   	grep_init(&revs->grep_filter, prefix);
>   	revs->grep_filter.status_only = 1;
> @@ -2339,6 +2341,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>
>   	if (revs->reflog_info && revs->graph)
>   		die("cannot combine --walk-reflogs with --graph");
> +	if (revs->no_walk && revs->graph && revs->cmd_is_log)
> +		die("cannot combine --no-walk with --graph when running git-log");

Why only for git log?  Doesn't the justification given in the commit 
message above apply in general?

>   	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
>   		die("cannot use --grep-reflog without --walk-reflogs");
>
> diff --git a/revision.h b/revision.h
> index 0ea8b4e..255982a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -146,6 +146,9 @@ struct rev_info {
>   			track_first_time:1,
>   			linear:1;
>
> +	/* cmd type */
> +	unsigned int  cmd_is_log:1;
> +
>   	enum date_mode date_mode;
>
>   	unsigned int	abbrev;
>
