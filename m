From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/5] submodule: teach unpack_trees() to remove submodule
 contents
Date: Fri, 27 Dec 2013 14:58:30 +0100
Message-ID: <52BD8786.1080900@web.de>
References: <20131226155857.GL20443@google.com> <20131226161202.GN20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 27 14:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwXvy-00023T-PY
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 14:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab3L0N6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 08:58:34 -0500
Received: from mout.web.de ([212.227.15.3]:63119 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab3L0N6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 08:58:33 -0500
Received: from [192.168.178.41] ([84.132.152.21]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M8iH2-1VkUBY1PFk-00CBmI for <git@vger.kernel.org>;
 Fri, 27 Dec 2013 14:58:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131226161202.GN20443@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:4a7b6hGSORhq2Io9uoCwGEkwOt/8jyloVuwLMibrgWx3b8nCfIG
 UGnw54ucvdOiNZmhzR1Q2+IkSiOkIOIYiAwC1GP79E3oYgpfMDEBFP3taRg8yoM9dn9lMHZ
 15HEoD4IGf0OwOHH5DcjzxQBUy25GH9MioIMecwGwQkJVvYs6MD3JGteMG6sUPGcfTnIKhG
 tVnYXsjoifzgY4sDPmSCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239729>

Am 26.12.2013 17:12, schrieb Jonathan Nieder:
> From: Jens Lehmann <Jens.Lehmann@web.de>
> Date: Tue, 19 Jun 2012 20:55:45 +0200
> 
> Implement the functionality needed to enable work tree manipulating
> commands to that a deleted submodule should not only affect the index
> (leaving all the files of the submodule in the work tree) but also to
> remove the work tree of the superproject (including any untracked
> files).
> 
> That will only work properly when the submodule uses a gitfile instead of
> a .git directory and no untracked files are present. Otherwise the removal
> will fail with a warning (which is just what happened until now).
> 
> Extend rmdir_or_warn() to remove the directories of those submodules which
> are scheduled for removal. Also teach verify_clean_submodule() to check
> that a submodule configured to be removed is not modified before scheduling
> it for removal.
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Should this share some code (or just the error message) with the 'git
> rm' code that checks whether a submodule is safe to remove?

Yes, that would make sense.

> rmdir_or_warn is a pretty low-level function --- it feels odd to be
> relying on the git repository layout here.  On the other hand, that
> function only has two callers, so it is possible to check quickly
> whether it is safe.
> 
> I assume this is mostly for the sake of the caller in unpack-trees?

Yup.

> In builtin/apply.c, remove_file is used for deletion and rename
> patches.  Do we want this logic take effect there, too?

I think so. Recursive update should also affect apply and am when
requested via command line or configuration. But the apply
documentation states that it also handles files outside a git
repository, so we would have to disable this logic in that case.

>  submodule.c    | 37 +++++++++++++++++++++++++++++++++++++
>  submodule.h    |  1 +
>  unpack-trees.c |  6 +++---
>  wrapper.c      |  3 +++
>  4 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 3f18d4d..a25db46 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -412,6 +412,43 @@ int submodule_needs_update(const char *path)
>  	return config_update_recurse_submodules != RECURSE_SUBMODULES_OFF;
>  }
>  
> +int depopulate_submodule(const char *path)
> +{
> +	struct strbuf dot_git = STRBUF_INIT;
> +	struct child_process cp;
> +	const char *argv[] = {"rm", "-rf", path, NULL};
> +
> +	/* Is it populated? */
> +	strbuf_addf(&dot_git, "%s/.git", path);
> +	if (!resolve_gitdir(dot_git.buf)) {
> +		strbuf_release(&dot_git);
> +		return 0;
> +	}
> +	strbuf_release(&dot_git);
> +
> +	/* Does it have a .git directory? */
> +	if (!submodule_uses_gitfile(path)) {
> +		warning(_("cannot remove submodule '%s' because it (or one of "
> +			  "its nested submodules) uses a .git directory"),
> +			  path);
> +		return -1;
> +	}
> +
> +	/* Remove the whole submodule directory */
> +	memset(&cp, 0, sizeof(cp));
> +	cp.argv = argv;
> +	cp.env = local_repo_env;
> +	cp.git_cmd = 0;
> +	cp.no_stdin = 1;
> +	if (run_command(&cp)) {
> +		warning("Could not remove submodule %s", path);
> +		strbuf_release(&dot_git);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  void show_submodule_summary(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
> diff --git a/submodule.h b/submodule.h
> index 055918c..df291cf 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -24,6 +24,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
>  int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
>  int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
>  int submodule_needs_update(const char *path);
> +int depopulate_submodule(const char *path);
>  void show_submodule_summary(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ad3e9a0..89b506a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -8,6 +8,7 @@
>  #include "progress.h"
>  #include "refs.h"
>  #include "attr.h"
> +#include "submodule.h"
>  
>  /*
>   * Error messages expected by scripts out of plumbing commands such as
> @@ -1263,14 +1264,13 @@ static void invalidate_ce_path(const struct cache_entry *ce,
>  /*
>   * Check that checking out ce->sha1 in subdir ce->name is not
>   * going to overwrite any working files.
> - *
> - * Currently, git does not checkout subprojects during a superproject
> - * checkout, so it is not going to overwrite anything.
>   */
>  static int verify_clean_submodule(const struct cache_entry *ce,
>  				  enum unpack_trees_error_types error_type,
>  				  struct unpack_trees_options *o)
>  {
> +	if (submodule_needs_update(ce->name) && is_submodule_modified(ce->name, 0))
> +		return 1;
>  	return 0;
>  }
>  
> diff --git a/wrapper.c b/wrapper.c
> index 0cc5636..425a3fd 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -2,6 +2,7 @@
>   * Various trivial helper wrappers around standard functions
>   */
>  #include "cache.h"
> +#include "submodule.h"
>  
>  static void do_nothing(size_t size)
>  {
> @@ -409,6 +410,8 @@ int unlink_or_warn(const char *file)
>  
>  int rmdir_or_warn(const char *file)
>  {
> +	if (submodule_needs_update(file) && depopulate_submodule(file))
> +		return -1;
>  	return warn_if_unremovable("rmdir", file, rmdir(file));
>  }
>  
> 
