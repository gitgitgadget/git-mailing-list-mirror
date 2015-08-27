From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Thu, 27 Aug 2015 17:20:25 +0200
Message-ID: <1440688825-1303-1-git-send-email-szeder@ira.uka.de>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:21:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUyzO-00049z-27
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 17:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbbH0PVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 11:21:13 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58070 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751471AbbH0PVM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2015 11:21:12 -0400
Received: from x4db275c5.dyn.telefonica.de ([77.178.117.197] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZUyzE-0003Gs-GJ; Thu, 27 Aug 2015 17:21:09 +0200
X-Mailer: git-send-email 2.5.0.418.gdd37a9b
In-Reply-To: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440688870.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276675>

Hi,

I haven't made up my mind about this feature yet, but have a few
comments about its implementation.

> diff --git a/git-stash.sh b/git-stash.sh
> index 1d5ba7a..8432435 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -33,6 +33,12 @@ else
>         reset_color=
>  fi
>  
> +if git config --get stash.showflag > /dev/null 2> /dev/null; then
> +	show_flag=$(git config --get stash.showflag)
> +else
> +	show_flag=--stat
> +fi
> +

Forking and executing processes are costly on some important platforms
we care about, so we should strive to avoid them whenever possible.

 - This hunk runs the the exact same 'git config' command twice.  Run it
   only once, perhaps something like this:

     show_flag=$(git config --get stash.showflag || echo --stat)

   (I hope there are no obscure crazy 'echo' implemtations out there
   that might barf on the unknown option '--stat'...)

 - It runs 'git config' in the main code path, i.e. even for subcommands
   other than 'show'.  Run it only for 'git stash show'.

 - This config setting is not relevant if there were options given on the
   command line.  Run it only if there are no options given, i.e. when
   $FLAGS is empty.


>  no_changes () {
>  	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
>  	git diff-files --quiet --ignore-submodules &&
> @@ -305,7 +311,7 @@ show_stash () {
>  	ALLOW_UNKNOWN_FLAGS=t
>  	assert_stash_like "$@"
>  
> -	git diff ${FLAGS:---stat} $b_commit $w_commit
> +	git diff ${FLAGS:-${show_flag}} $b_commit $w_commit
>  }
>  
>  show_help () {
> -- 
> 2.5.0
