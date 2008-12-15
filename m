From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] gc: make --prune useful again by accepting an optional
 parameter
Date: Mon, 15 Dec 2008 15:07:54 -0600
Message-ID: <j2kXTHA5qGwfTMznJutKnr1RHH7prDrQbr4BYlw-pt2V9gVgqTSERQ@cipher.nrlssc.navy.mil>
References: <alpine.DEB.1.00.0812152121260.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCKiy-0000k4-41
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 22:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716AbYLOVKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 16:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755615AbYLOVKN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 16:10:13 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43625 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbYLOVKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 16:10:12 -0500
Received: by mail.nrlssc.navy.mil id mBFL7tST005083; Mon, 15 Dec 2008 15:07:55 -0600
In-Reply-To: <alpine.DEB.1.00.0812152121260.30769@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Dec 2008 21:07:54.0601 (UTC) FILETIME=[32A06590:01C95EF9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103208>

Johannes Schindelin wrote:
> With this patch, "git gc --no-prune" will not prune any loose (and
> dangling) object, and "git gc --prune=5.minutes.ago" will prune
> all loose objects older than 5 minutes.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

<snip>

> diff --git a/builtin-gc.c b/builtin-gc.c
> index bbc41ac..078c5b3 100644
> --- a/builtin-gc.c
> +++ b/builtin-gc.c
> @@ -199,14 +199,15 @@ static int need_to_gc(void)
>  
>  int cmd_gc(int argc, const char **argv, const char *prefix)
>  {
> -	int prune = 0;
>  	int aggressive = 0;
>  	int auto_gc = 0;
>  	int quiet = 0;
>  	char buf[80];
>  
>  	struct option builtin_gc_options[] = {
> -		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects (deprecated)"),
> +		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
> +			"prune unreferenced objects (deprecated)",

The help string still contains "deprecated".

> +			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
>  		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
>  		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
>  		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
> @@ -255,9 +256,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
>  		return error(FAILED_RUN, argv_repack[0]);
>  
> -	argv_prune[2] = prune_expire;
> -	if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
> -		return error(FAILED_RUN, argv_prune[0]);
> +	if (prune_expire) {
> +		argv_prune[2] = prune_expire;
> +		if (run_command_v_opt(argv_prune, RUN_GIT_CMD))
> +			return error(FAILED_RUN, argv_prune[0]);
> +	}


When --no-prune is used, not only will packed loose objects not be pruned,
but the cleanup of temporary files that git-prune performs will not be done.

Maybe this should be relaxed from "will not prune _any_ loose object" to "will
not prune any unreferenced object".

If something like:

   if (!prune_expire)
   	prune_expire = "never";

is added after option parsing, then I think this will satisfy people's requests
and it will also apply nicely on top of Nico's patch to avoid unpacking objects
when prune_expire == "now".

-brandon
