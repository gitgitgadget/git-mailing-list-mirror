From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/5] submodule: prepare for recursive checkout of submodules
Date: Fri, 27 Dec 2013 14:42:54 +0100
Message-ID: <52BD83DE.7070104@web.de>
References: <20131226155857.GL20443@google.com> <20131226160239.GM20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 27 14:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwXhE-0005Bs-2x
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 14:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab3L0Nm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 08:42:57 -0500
Received: from mout.web.de ([212.227.15.3]:53601 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab3L0Nm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 08:42:56 -0500
Received: from [192.168.178.41] ([84.132.152.21]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Lvjn6-1VORJC3DG0-017UBJ for <git@vger.kernel.org>;
 Fri, 27 Dec 2013 14:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131226160239.GM20443@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:d5jzO3Le2zSG+WtpgtPDBb6lbZd9o52G4zFVKiuewWJL3Bg3Nh5
 rWmjIbuwviYFa82m8XUdB9HMQQnlDaSfo8ENd4O5FvY6QUoqZ7mcSRfMKwGNqnxGBcQ0Z9i
 M6FkJqw6dL+Qs6AAwaJ2bGFAWKGU9dRN43Xc1woZe3gqZCF5ygBTkDGx7EZKfCr19vCkxqC
 ECh+gGYt6OJw1HjdPGM2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239727>

Am 26.12.2013 17:02, schrieb Jonathan Nieder:
> From: Jens Lehmann <Jens.Lehmann@web.de>
> Date: Mon, 18 Jun 2012 22:17:59 +0200
> 
> This commit adds the functions needed for configuration, for setting the
> default behavior and for determining if a submodule path should be updated
> automatically.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Should probably be squashed into a patch that uses and documents this
> configuration.

I'm not so sure. At the end of the day at least am, bisect, checkout,
checkout-index, cherry-pick, merge, pull, read-tree, rebase, reset
& stash should have learned this option (and all porcelain must honor
the autoupdate setting by default, plumbing only when requested by
giving the "--recurse-submodules=config" option to make life easier
for scripting). And I think they should learn this one command per
commit, making this one - and the yet-to-be-programmed one introducing
the autoupdate flag - the base for them.

>  submodule.c | 36 ++++++++++++++++++++++++++++++++++++
>  submodule.h |  3 +++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index 613857e..3f18d4d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -16,6 +16,8 @@ static struct string_list config_name_for_path;
>  static struct string_list config_fetch_recurse_submodules_for_name;
>  static struct string_list config_ignore_for_name;
>  static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
> +static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
> +static int option_update_recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  static struct string_list changed_submodule_paths;
>  static int initialized_fetch_ref_tips;
>  static struct sha1_array ref_tips_before_fetch;
> @@ -382,6 +384,34 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>  	}
>  }
>  
> +int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
> +{
> +	switch (git_config_maybe_bool(opt, arg)) {
> +	case 1:
> +		return RECURSE_SUBMODULES_ON;
> +	case 0:
> +		return RECURSE_SUBMODULES_OFF;
> +	default:
> +		if (!strcmp(arg, "checkout"))
> +			return RECURSE_SUBMODULES_ON;
> +		die("bad %s argument: %s", opt, arg);
> +	}
> +}
> +
> +int submodule_needs_update(const char *path)
> +{
> +	struct string_list_item *path_option;
> +	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
> +	if (!path_option)
> +		return 0;
> +
> +	/* update can't be "none", "merge" or "rebase" */
> +
> +	if (option_update_recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
> +		return 1;
> +	return config_update_recurse_submodules != RECURSE_SUBMODULES_OFF;
> +}
> +
>  void show_submodule_summary(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
> @@ -589,6 +619,12 @@ int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  	return ret;
>  }
>  
> +void set_config_update_recurse_submodules(int default_value, int option_value)
> +{
> +	config_update_recurse_submodules = default_value;
> +	option_update_recurse_submodules = option_value;
> +}
> +
>  static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
>  {
>  	int is_present = 0;
> diff --git a/submodule.h b/submodule.h
> index 7beec48..055918c 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -22,12 +22,15 @@ void gitmodules_config(void);
>  int parse_submodule_config_option(const char *var, const char *value);
>  void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
>  int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
> +int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
> +int submodule_needs_update(const char *path);
>  void show_submodule_summary(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
>  		unsigned dirty_submodule, const char *meta,
>  		const char *del, const char *add, const char *reset);
>  void set_config_fetch_recurse_submodules(int value);
> +void set_config_update_recurse_submodules(int default_value, int option_value);
>  void check_for_new_submodule_commits(unsigned char new_sha1[20]);
>  int fetch_populated_submodules(const struct argv_array *options,
>  			       const char *prefix, int command_line_option,
> 
