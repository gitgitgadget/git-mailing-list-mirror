From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Fri, 1 Apr 2016 15:41:28 +0100
Message-ID: <56FE8898.20906@ramsayjones.plus.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: norio.nomura@gmail.com
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com,
	git@vger.kernel.org, sunshine@sunshineco.com,
	jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 16:41:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am0Gl-00045J-2r
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 16:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759047AbcDAOlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 10:41:44 -0400
Received: from avasout08.plus.net ([212.159.14.20]:33209 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758815AbcDAOln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 10:41:43 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id d2hW1s00C2D2Veb012hYG6; Fri, 01 Apr 2016 15:41:36 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=f3w_sU_0F_gpLjWKvpQA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1459469849-9643-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290540>



On 01/04/16 01:17, Stefan Beller wrote:
> Thanks Junio for review!
> 
> v3:
>  * This is a resend of the last two patches of the series, i.e. it replaces
>    44859d6626d4 and efdef1e2e in sb/submodule-helper-clone-regression-fix
>   
>  * use absolute_path for sm_gitdir

Hi Stefan,

In response to v1 of this series, I sent you a fixup patch to suppress a
sparse warning (submodule: don't use an integer as a NULL pointer, 21-02-2016).

In v2, you introduced a second identical warning (rather, for the same
reason: using 0 as a NULL pointer as the second argument to strbuf_detach()).

I was just about to send another patch, when you sent this out. As a result,
you have suppressed the new warning, but the original remains.

So, ...

>  * removed todo
>  * we need to free the intermediate sm_gitdir, so rename that to sm_gitdir_rel
>    and free it afterwards.
>  * while we currently do not support an absolute `path`, we eventually might.
>    If `path` is absolute it would be a pointer to `argv`, which would lead to a
>    crash. Duplicate the path and the crash is prevented.
>  (* I thought we could use it as well for `path`, but we cannot; as 
>    get_git_work_tree() != cwd)
>  * diff to sb/submodule-helper-clone-regression-fix:
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 89cbbda..be7bf5f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -153,12 +153,13 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>  
>  static int module_clone(int argc, const char **argv, const char *prefix)
>  {
> -	const char *path = NULL, *name = NULL, *url = NULL;
> +	const char *name = NULL, *url = NULL;
>  	const char *reference = NULL, *depth = NULL;
>  	int quiet = 0;
>  	FILE *submodule_dot_git;
> -	char *sm_gitdir, *p;
> -	struct strbuf rel_path = STRBUF_INIT; /* for relative_path */
> +	char *sm_gitdir_rel, *p, *path = NULL;
> +	const char *sm_gitdir;
> +	struct strbuf rel_path = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	struct option module_clone_options[] = {
> @@ -198,26 +199,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		die(_("submodule--helper: unspecified or empty --path"));
>  
>  	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> -	sm_gitdir = strbuf_detach(&sb, NULL);
> -
> -
> -	if (!is_absolute_path(sm_gitdir)) {
> -		char *cwd = xgetcwd();
> -		strbuf_addf(&sb, "%s/%s", cwd, sm_gitdir);
> -		sm_gitdir = strbuf_detach(&sb, 0);
> -		free(cwd);
> -	}
> +	sm_gitdir_rel = strbuf_detach(&sb, NULL);

... this is good, but ...

> +	sm_gitdir = absolute_path(sm_gitdir_rel);
>  
>  	if (!is_absolute_path(path)) {
> -		/*
> -		 * TODO: add prefix here once we allow calling from non root
> -		 * directory?
> -		 */
> -		strbuf_addf(&sb, "%s/%s",
> -			    get_git_work_tree(),
> -			    path);
> +		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
>  		path = strbuf_detach(&sb, 0);

... can you please fix this up.

Thanks!

ATB,
Ramsay Jones


> -	}
> +	} else
> +		path = xstrdup(path);
>  
>  	if (!file_exists(sm_gitdir)) {
>  		if (safe_create_leading_directories_const(sm_gitdir) < 0)
> @@ -240,6 +229,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	submodule_dot_git = fopen(sb.buf, "w");
>  	if (!submodule_dot_git)
>  		die_errno(_("cannot open file '%s'"), sb.buf);
> +
>  	fprintf_or_die(submodule_dot_git, "gitdir: %s\n",
>  		       relative_path(sm_gitdir, path, &rel_path));
>  	if (fclose(submodule_dot_git))
> @@ -255,8 +245,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  			       relative_path(path, sm_gitdir, &rel_path));
>  	strbuf_release(&sb);
>  	strbuf_release(&rel_path);
> -	free(sm_gitdir);
> -
> +	free(sm_gitdir_rel);
> +	free(path);
>  	free(p);
>  	return 0;
>  }
> 
> v2:
>  * reworded commit message for test (Thanks Junio!)
>  * instead of "simplifying" the path handling in patch 2, we are prepared
>    for anything the user throws at us (i.e. instead of segfault we
>        die(_("submodule--helper: unspecified or empty --path"));
>    (Thanks Eric, Jacob for pushing back here!)
>  * reword commit message for patch 3 (safe_create_leading_directories_const is
>    not a check, Thanks Junio!)
>  * patch 4 (the fix): That got reworked completely. No flow controlling
>    conditions in the write out phase!
>  * patch 5 is a bonus! (replace fprintf by fprintf_or die) When implementing
>    that I wondered if we also have close_or_die and open_or_die, but that doesn't
>    seem to be the case.
> 
> Thanks,
> Stefan
> 
> v1:
> 
> It took me longer than expected to fix this bug.
> 
> It comes with a test and minor refactoring and applies on top of
> origin/sb/submodule-helper, such that it can be merged into 2.7, 2.8 as well
> as master.
> 
> Patch 1 is a test which fails; it has a similar layout as the
> real failing repository Norio Nomura pointed out, but simplified to the
> bare essentials for reproduction of the bug.
> 
> Patch 2&3 are not strictly necessary for fixing the isseu, but it removes
> stupid code I wrote, so the resulting code looks a little better.
> 
> Patch 4 fixes the issue by giving more information to relative_path,
> such that a relative path can be found in all cases.
> 
> Thanks,
> Stefan
> 
> Stefan Beller (2):
>   submodule--helper, module_clone: always operate on absolute paths
>   submodule--helper, module_clone: catch fprintf failure
> 
>  builtin/submodule--helper.c | 32 ++++++++++++++------------------
>  t/t7400-submodule-basic.sh  |  2 +-
>  2 files changed, 15 insertions(+), 19 deletions(-)
> 
