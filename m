From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC/PATCH 08/18] revert: refactor code into a new pick_commits()
 function
Date: Fri, 26 Nov 2010 22:50:55 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1011262215540.14365@iabervon.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org> <20101125212050.5188.13304.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Nov 27 04:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMBoU-0007WL-W4
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 04:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab0K0Du5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 22:50:57 -0500
Received: from iabervon.org ([66.92.72.58]:40421 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab0K0Du4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 22:50:56 -0500
Received: (qmail 28985 invoked by uid 1000); 27 Nov 2010 03:50:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Nov 2010 03:50:55 -0000
In-Reply-To: <20101125212050.5188.13304.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162298>

On Thu, 25 Nov 2010, Christian Couder wrote:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/revert.c |   38 ++++++++++++++++++++++----------------
>  1 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 443b529..1f20251 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -578,36 +578,28 @@ static void read_and_refresh_cache(const char *me)
>  	rollback_lock_file(&index_lock);
>  }
>  
> -static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
> +static int pick_commits(struct args_info *infos)
>  {
> -	struct args_info infos;
>  	struct rev_info revs;
>  	struct commit *commit;
>  
> -	memset(&infos, 0, sizeof(infos));
> -	git_config(git_default_config, NULL);
> -	infos.action = revert ? REVERT : CHERRY_PICK;
> -	me = revert ? "revert" : "cherry-pick";
> -	setenv(GIT_REFLOG_ACTION, me, 0);
> -	parse_args(argc, argv, &infos);
> -
> -	if (infos.allow_ff) {
> -		if (infos.signoff)
> +	if (infos->allow_ff) {
> +		if (infos->signoff)
>  			die("cherry-pick --ff cannot be used with --signoff");
> -		if (infos.no_commit)
> +		if (infos->no_commit)
>  			die("cherry-pick --ff cannot be used with --no-commit");
> -		if (infos.no_replay)
> +		if (infos->no_replay)
>  			die("cherry-pick --ff cannot be used with -x");
> -		if (infos.edit)
> +		if (infos->edit)
>  			die("cherry-pick --ff cannot be used with --edit");
>  	}
>  
>  	read_and_refresh_cache(me);
>  
> -	prepare_revs(&revs, &infos);
> +	prepare_revs(&revs, infos);
>  
>  	while ((commit = get_revision(&revs))) {
> -		int res = do_pick_commit(&infos, commit);
> +		int res = do_pick_commit(infos, commit);
>  		if (res)
>  			return res;
>  	}
> @@ -615,6 +607,20 @@ static int revert_or_cherry_pick(int argc, const char **argv, int revert, int ed
>  	return 0;
>  }
>  
> +static int revert_or_cherry_pick(int argc, const char **argv, int revert, int edit)
> +{
> +	struct args_info infos;
> +
> +	git_config(git_default_config, NULL);
> +	me = revert ? "revert" : "cherry-pick";
> +	setenv(GIT_REFLOG_ACTION, me, 0);
> +	memset(&infos, 0, sizeof(infos));
> +	infos.action = revert ? REVERT : CHERRY_PICK;
> +	parse_args(argc, argv, &infos);
> +
> +	return pick_commits(&infos);
> +}
> +

I think it would be more obvious to put this into cmd_revert and 
cmd_cherry_pick, and have them call pick_commits directly. In fact, you 
could probably make things more clear by calling your "struct args_info" 
instead "struct pick_commits_args" (like a lot of other 
"struct {cmd}_args" we already have for similar situations).

While there's no reason to do it here, pick_commits() is a sensible 
operation that other builtins might want to call, particularly with the 
error return instead of die(), so it would be nice to name things suitably 
for that usage. That also avoids Junio's objection to the arguments to 
revert_or_cherry_pick() by not having the function with the objectionable 
arguments at all.

For that matter, you have a lot of commits in this series that put globals 
into a struct and pass the struct around and change the arguments to the 
functions that actually do things. I think it would be easier to 
understand if you squashed all of these together into a single commit, 
which does all of the necessary changes to function prototypes. And I 
think it would be similarly better to have a single commit that makes all 
of the places that call die() not do that, rather than getting some of 
them in each of several patches.

>  int cmd_revert(int argc, const char **argv, const char *prefix)
>  {
>  	return revert_or_cherry_pick(argc, argv, 1, isatty(0));
> -- 
> 1.7.3.2.504.g59d466
> 
> 
> 
