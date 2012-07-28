From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sat, 28 Jul 2012 12:22:11 +0200
Message-ID: <20120728102209.GA13370@book.hvoigt.net>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, jens.lehmann@web.de
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 12:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv4Ac-0002XB-Ke
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 12:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab2G1KWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 06:22:25 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:59027 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab2G1KWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 06:22:25 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sv4A0-0001wm-A0; Sat, 28 Jul 2012 12:22:12 +0200
Content-Disposition: inline
In-Reply-To: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202428>

Hi Stefan,

neat patch. See below for a few notes.

On Fri, Jul 27, 2012 at 11:37:34AM -0700, Stefan Zager wrote:
> diff --git a/git-submodule.sh b/git-submodule.sh
> index dba4d39..761420a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -491,6 +492,20 @@ cmd_update()
>  		-r|--rebase)
>  			update="rebase"
>  			;;
> +		-j|--jobs)
> +			case "$2" in
> +			''|-*)
> +				jobs="0"
> +				;;
> +			*)
> +				jobs="$2"
> +				shift
> +				;;
> +			esac
> +			# Don't preserve this arg.
> +			shift
> +			continue
> +			;;
>  		--reference)
>  			case "$2" in '') usage ;; esac
>  			reference="--reference=$2"
> @@ -529,6 +544,12 @@ cmd_update()
>  		cmd_init "--" "$@" || return
>  	fi
>  
> +	if test "$jobs" != "1"
> +	then
> +		module_list "$@" | awk '{print $4}' | xargs -L 1 -P "$jobs" git submodule update $orig_args

I do not see orig_args set anywhere in submodule.sh. It seems the
existing usage of it in cmd_status() is a leftover from commit
98dbe63 when this variable got renamed to orig_flags.

I will follow up with a patch to that location.

Another problem here is the passing of arguments. Have a look at
a7eff1a8 to see how this was solved for other locations.

The next thing I noticed is that the parallelism is not recursive. You
drop the option and only execute the first depth in parallel. How about
using the amount of modules defined by arguments left in $@ as an
indicator whether you need to fork parallel execution or not. If there
is exactly one you do the update if there are more you do the parallel
thing. That way you can just keep passing the --jobs flag to the
subprocesses.

The next question to solve is UI: Since the output lines of the parallel
update jobs will be mixed we need some way to distinguish them. Imagine
one of the update fails somewhere how do we find out which it was?

Two possible solutions come to my mind:

 1. Prefix each line with a job number. This way you can distinguish
    which process outputted what and still have immediate feedback.

 2. Cache the output (to stderr and stdout) of each job and output it
    once one job is done. I imagine this needs some infrastructure which
    we need to implement. We already have some ideas how to collect such
    output in C here[1].

I would prefer solution 2 since the output of 1 will be hard to read but
I guess we could start with 1 and then move over to 2 later on.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/197747
