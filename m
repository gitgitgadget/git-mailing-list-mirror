From: Henrik Tidefelt <tidefelt@isy.liu.se>
Subject: Re: Problem with "dashless options"
Date: Wed, 9 Sep 2009 18:26:37 +0200
Message-ID: <AB9C50E3-E2BB-4449-B8F9-75777ADE1602@isy.liu.se>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se> <20090909143455.GA10092@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 09 18:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlQ0Z-0007Fy-2g
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZIIQ0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 12:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbZIIQ0u
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 12:26:50 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:57295 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbZIIQ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 12:26:49 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id F3F0C25A9F;
	Wed,  9 Sep 2009 18:26:51 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 00431-06; Sun, 31 Dec 1967 01:00:02 +0100 (MET)
Received: from [130.236.59.50] (59-50.isylogon.isy.liu.se [130.236.59.50])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 2C2F025A9D;
	Wed,  9 Sep 2009 18:26:34 +0200 (MEST)
In-Reply-To: <20090909143455.GA10092@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128073>

Yes, that was a strange error.  I applied the patch, but could not  
reproduce the error any more.  Also, Gustaf Hendeby built git  
directly from the git distribution (not via MacPorts) on my machine,  
and could not reproduce the error.  Then I simply tried to clean and  
build the git from MacPorts again, and voila!, now it works.   
Something very strange must have happened during the previous build.

I am sorry for taking your time.


Henrik

On 9Sep , 2009, at 16:34 , Jeff King wrote:

> On Wed, Sep 09, 2009 at 03:21:30PM +0200, Henrik Tidefelt wrote:
>
>> Yesterday I installed a fresh git (1.6.4.2) on my system using
>> MacPorts.  Some of the git sub-commands work fine (for instance,
>> checkout, status, remote), while push gives an error as follows:
>>
>> $ git push isy next
>> fatal: BUG: dashless options don't support arguments
>
> Hmm. Very strange. The only code path that triggers this is an option
> declared with PARSE_OPT_NODASH but not PARSE_OPT_NOARG. But there are
> only two options in all of git that use PARSE_OPT_NODASH, and:
>
>   1. They are in git grep, not git push.
>
>   2. They correctly have PARSE_OPT_NOARG set.
>
> Which leads me to believe that something is writing random cruft on  
> top
> of the options struct. Either a stack overflow, or some issue  
> related to
> your compiler (either a bug in the compiler, or something non-portable
> we are doing).
>
> Can you try applying the patch below which will at least give us a bit
> more information about the offending option?
>
> Also, does 1.6.4.1 work OK? Or any other earlier version? If so,  
> can you
> try bisecting?
>
> diff --git a/parse-options.c b/parse-options.c
> index f7ce523..e93eb67 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -275,7 +275,15 @@ static int parse_nodash_opt(struct  
> parse_opt_ctx_t *p, const char *arg,
>  			continue;
>  		if ((options->flags & PARSE_OPT_OPTARG) ||
>  		    !(options->flags & PARSE_OPT_NOARG))
> -			die("BUG: dashless options don't support arguments");
> +			die("BUG: dashless options don't support arguments\n"
> +			    "buggy option is:\n"
> +			    " type: %d\n"
> +			    " short_name: %c\n"
> +			    " long_name: %s\n"
> +			    " flags: %d\n",
> +			    options->type, options->short_name,
> +			    options->long_name, options->flags
> +			);
>  		if (!(options->flags & PARSE_OPT_NONEG))
>  			die("BUG: dashless options don't support negation");
>  		if (options->long_name)
