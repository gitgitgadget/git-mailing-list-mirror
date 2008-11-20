From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Allow help/--help/-h to be run outside of a TopGit repo
Date: Thu, 20 Nov 2008 15:27:03 +0100
Message-ID: <20081120142702.GG10491@machine.or.cz>
References: <1227181594-15123-1-git-send-email-madduck@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 15:30:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3AWC-0005Hn-3d
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 15:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbYKTO1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 09:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756077AbYKTO1H
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 09:27:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49082 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684AbYKTO1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 09:27:06 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 107E83939836; Thu, 20 Nov 2008 15:27:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227181594-15123-1-git-send-email-madduck@debian.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101441>

On Thu, Nov 20, 2008 at 12:46:34PM +0100, martin f. krafft wrote:
> The user ought to be able to call `tg help` from anywhere in the filesystem,
> not just Git repositories, so the help parsing has to happen before the calls
> to git git binary.
> 
> Debian bug: #501982
> 
> Signed-off-by: martin f. krafft <madduck@debian.org>
> 
> ---
>  tg.sh |   28 +++++++++++++++++++++++++---
>  1 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/tg.sh b/tg.sh
> index 4dcc15e..258f8ce 100644
> --- a/tg.sh
> +++ b/tg.sh
> @@ -235,12 +235,37 @@ do_help()
>  	fi
>  }
>  
> +# Check whether we are supposed to output the help message
> +should_do_help()
> +{
> +	# we are being sourced for utility functions, never run help
> +	[ -z "$tg__include" ] || return 1
> +
> +	local prev
> +	while [ -n "$1" ]; do
> +		case "$1" in
> +		help|--help|-h)
> +			shift
> +			echo "${1:-$prev}"
> +			return 0
> +		esac
> +		prev="$1"
> +		shift
> +	done
> +
> +	# run help when there was no previous topic, meaning that there where
> +	# no arguments at all
> +	test -z "$prev"
> +}
>  
>  ## Startup
>  
>  [ -d "@cmddir@" ] ||
>  	die "No command directory: '@cmddir@'"
>  
> +# check if we should run help and get the topic while we're at it
> +help_topic="$(should_do_help "$@")" && { do_help "$help_topic"; exit 0; }
> +

Why is this so complicated? Can't you just do_help from
should_do_help()? The overall semantics seems strange anyway, though -
it seems that 'tg mail --help -r' will try to show help for '-r' instead
of 'mail'.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
