From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Thu, 29 Oct 2015 13:19:48 +0000
Message-ID: <56321CF4.60807@ramsayjones.plus.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 14:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrn7j-0000Xs-U4
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 14:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901AbbJ2NUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 09:20:05 -0400
Received: from avasout07.plus.net ([84.93.230.235]:49823 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbJ2NUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 09:20:03 -0400
Received: from [10.0.2.15] ([87.114.3.134])
	by avasout07 with smtp
	id b1Ko1r0092tV80P011Kp8S; Thu, 29 Oct 2015 13:19:50 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=qQ71F3v+nKp5qei/W0vv8w==:117 a=qQ71F3v+nKp5qei/W0vv8w==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=rFqcR7ryqxiMIlW0MOUA:9
 a=neOeIBpVD1tDQDR8:21 a=ZCzpTby6hO0RQlSc:21 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280439>



On 28/10/15 23:21, Stefan Beller wrote:
> This replaces origin/sb/submodule-parallel-update
> (anchoring at 74367d8938, Merge branch 'sb/submodule-parallel-fetch'
> into sb/submodule-parallel-update)
> 
> What does it do?
> ---
> This series should finish the on going efforts of parallelizing
> submodule network traffic. The patches contain tests for clone,
> fetch and submodule update to use the actual parallelism both via
> command line as well as a configured option. I decided to go with
> "submodule.jobs" for all three for now.
> 
> What is new in v2?
> ---
> * The patches got reordered slightly
> * Documentation was adapted
> 
> Interdiff below
> 
> Stefan Beller (8):
>   run_processes_parallel: Add output to tracing messages
>   submodule config: keep update strategy around
>   submodule config: remove name_and_item_from_var
>   submodule-config: parse_config
>   fetching submodules: Respect `submodule.jobs` config option
>   git submodule update: have a dedicated helper for cloning
>   submodule update: expose parallelism to the user
>   clone: allow an explicit argument for parallel submodule clones
> 
>  Documentation/config.txt        |   7 ++
>  Documentation/git-clone.txt     |   6 +-
>  Documentation/git-submodule.txt |   7 +-
>  builtin/clone.c                 |  23 +++-
>  builtin/fetch.c                 |   2 +-
>  builtin/submodule--helper.c     | 244 ++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh                |  54 ++++-----
>  run-command.c                   |   4 +
>  submodule-config.c              |  98 ++++++++++------
>  submodule-config.h              |   3 +
>  submodule.c                     |   5 +
>  t/t5526-fetch-submodules.sh     |  14 +++
>  t/t7400-submodule-basic.sh      |   4 +-
>  t/t7406-submodule-update.sh     |  27 +++++
>  14 files changed, 418 insertions(+), 80 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0de0138..785721a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2643,12 +2643,12 @@ submodule.<name>.ignore::
>  	"--ignore-submodules" option. The 'git submodule' commands are not
>  	affected by this setting.
>  
> -submodule::jobs
> +submodule.jobs::
>  	This is used to determine how many submodules can be operated on in
>  	parallel. Specifying a positive integer allows up to that number
> -	of submodules being fetched in parallel. Specifying 0 the number
> -	of cpus will be taken as the maximum number. Currently this is
> -	used in fetch and clone operations only.
> +	of submodules being fetched in parallel. This is used in fetch
> +	and clone operations only. A value of 0 will give some reasonable
> +	default. The defaults may change with different versions of Git.
>  
>  tag.sort::
>  	This variable controls the sort ordering of tags when displayed by
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index affa52e..01bd6b7 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -216,9 +216,10 @@ objects from the source repository into a pack in the cloned repository.
>  	The result is Git repository can be separated from working
>  	tree.
>  
> --j::
> ---jobs::
> +-j <n>::
> +--jobs <n>::
>  	The number of submodules fetched at the same time.
> +	Defaults to the `submodule.jobs` option.

Hmm, is there a way to _not_ fetch in parallel (override the
config) from the command line for a given command?

ATB,
Ramsay Jones

>  
>  <repository>::
>  	The (possibly remote) repository to clone from.  See the
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index f5429fa..c70fafd 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -374,10 +374,11 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
>  	clone with a history truncated to the specified number of revisions.
>  	See linkgit:git-clone[1]
>  
> --j::
> ---jobs::
> +-j <n>::
> +--jobs <n>::
>  	This option is only valid for the update command.
>  	Clone new submodules in parallel with as many jobs.
> +	Defaults to the `submodule.jobs` option.
>  
>  <path>...::
>  	Paths to submodule(s). When specified this will restrict the command
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5ac2d89..22b9924 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -727,10 +727,7 @@ static int checkout(void)
>  		struct argv_array args = ARGV_ARRAY_INIT;
>  		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
>  
> -		if (max_jobs == -1)
> -			if (git_config_get_int("submodule.jobs", &max_jobs))
> -				max_jobs = 1;
> -		if (max_jobs != 1) {
> +		if (max_jobs != -1) {
>  			struct strbuf sb = STRBUF_INIT;
>  			strbuf_addf(&sb, "--jobs=%d", max_jobs);
>  			argv_array_push(&args, sb.buf);
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c3d438a..67dba1c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -476,9 +476,10 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	/* Overlay the parsed .gitmodules file with .git/config */
>  	git_config(git_submodule_config, NULL);
>  
> -	if (max_jobs == -1)
> -		if (git_config_get_int("submodule.jobs", &max_jobs))
> -			max_jobs = 1;
> +	if (max_jobs < 0)
> +		max_jobs = config_parallel_submodules();
> +	if (max_jobs < 0)
> +		max_jobs = 1;
>  
>  	run_processes_parallel(max_jobs,
>  			       update_clone_get_next_task,
> 
