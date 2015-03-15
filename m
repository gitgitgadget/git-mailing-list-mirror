From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Sun, 15 Mar 2015 18:51:57 +0100
Message-ID: <5505C6BD.5000809@web.de>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 18:52:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCiD-0006Ml-6j
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 18:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbbCORwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 13:52:10 -0400
Received: from mout.web.de ([212.227.17.11]:57089 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbbCORwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 13:52:08 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M8iPI-1Yh8sH2wUG-00CCgJ; Sun, 15 Mar 2015 18:52:01
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
X-Provags-ID: V03:K0:O7O/XzLunPuYf0kxFK/s868B6KXz4b2AwG1Hoy5hoJtlx18gYPL
 I3ENJx0O2/NbQ/CYl3093LnXdxFCCJgfyhO5zNc0Z2osCA2vWRNxqx8NNRiZgHbcN3zAJrz
 JKhWfkWEW2NebCPfOhqy+lp/z6LkDrlBNAbag0ZUnXKEIIny+s1BzTiFQLvXx8bd39rPe5s
 7lN3yMggTLWh1gwd8ofPQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265503>

On 2015-03-15 14.49, Alexander Kuleshov wrote:

Thanks for working on Git, some minor remarks/suggestions inline.
> This patch introduces new --exclude option for the git add
> command.
"This patch" is redundant. Shorter may be:
Introduce the --exclude option for git add

> 
> We already have core.excludesfile configuration variable which indicates
> a path to file which contains patterns to exclude. This patch provides
same here: Provide the ability to pass ....
> ability to pass --exclude option to the git add command to exclude paths
> from command line in addition to which found in the ignore files.
"found" ?? Would "specified" be better?
> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  builtin/add.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 3390933..5c602a6 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -244,6 +244,16 @@ static int ignore_removal_cb(const struct option *opt, const char *arg, int unse
>  	return 0;
>  }
>  
> +struct string_list exclude_list = STRING_LIST_INIT_NODUP;
> +struct exclude_list *el;
> +
> +static int exclude_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	struct string_list *exclude_list = opt->value;
> +	string_list_append(exclude_list, arg);
> +	return 0;
When we always return 0, the function can be void ?
> +}
> +
>  static struct option builtin_add_options[] = {
>  	OPT__DRY_RUN(&show_only, N_("dry run")),
>  	OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -255,6 +265,9 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
>  	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
>  	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
> +	{ OPTION_CALLBACK, 0, "exclude", &exclude_list, N_("pattern"),
What does pattern mean ?
Is it the same as a "pathspec", used in Documentation/git-add.txt
> +	  N_("do no add files matching pattern to index"),
> +	  0, exclude_cb },
>  	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
>  	  NULL /* takes no arguments */,
>  	  N_("ignore paths removed in the working tree (same as --no-all)"),
> @@ -298,6 +311,7 @@ static int add_files(struct dir_struct *dir, int flags)
>  
>  int cmd_add(int argc, const char **argv, const char *prefix)
>  {
> +	int i;
Do we need "i" here ?
>  	int exit_status = 0;
>  	struct pathspec pathspec;
>  	struct dir_struct dir;
> @@ -381,6 +395,11 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		if (!ignored_too) {
or could it be declared here  ?
>  			dir.flags |= DIR_COLLECT_IGNORED;
>  			setup_standard_excludes(&dir);
> +
> +			el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
> +			for (i = 0; i < exclude_list.nr; i++)
> +				add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
> +
>  		}
>  
>  		memset(&empty_pathspec, 0, sizeof(empty_pathspec));
> @@ -446,5 +465,6 @@ finish:
>  			die(_("Unable to write new index file"));
>  	}
>  
> +	string_list_clear(&exclude_list, 0);
>  	return exit_status;
>  }
> 
