From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH (topgit) 1/2] Implement setup_pager just like in git
Date: Wed, 7 Jan 2009 16:10:00 +0100
Message-ID: <20090107151000.GR12275@machine.or.cz>
References: <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3> <20090107144432.GC831@artemis.corp> <cover.1231254832.git.kirr@landau.phys.spbu.ru> <acaae74f79d385014e726b97f8258b2a0caa3dd0.1231254832.git.kirr@landau.phys.spbu.ru> <20090106203203.GA11274@lapse.rw.madduck.net> <20090107112754.GA15158@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 16:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKa46-0006gZ-5e
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 16:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbZAGPKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 10:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755015AbZAGPKF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 10:10:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:36364 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbZAGPKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 10:10:04 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id B804A1E4C029; Wed,  7 Jan 2009 16:10:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090107144432.GC831@artemis.corp> <20090107112754.GA15158@roro3>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104803>

On Wed, Jan 07, 2009 at 02:27:54PM +0300, Kirill Smelkov wrote:
> >From 2193b7c703c2d31c8739eec617b8c0e8c1d09b79 Mon Sep 17 00:00:00 2001
> From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> Date: Tue, 6 Jan 2009 17:56:37 +0300
> Subject: [PATCH (topgit) v2] Implement setup_pager just like in git
> 
> setup_pager() spawns a pager process and redirect the rest of our output
> to it.
> 
> This will be needed to fix `tg patch` output in the next commit.
> 
> Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

But you never use it...?

> ---
>  tg.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/tg.sh b/tg.sh
> index 8c23d26..bf9cf5c 100644
> --- a/tg.sh
> +++ b/tg.sh
> @@ -243,6 +243,60 @@ do_help()
>  	fi
>  }
>  
> +## Pager stuff
> +
> +# isatty FD
> +isatty()
> +{
> +	tty -s 0<&$1
> +}
> +
> +# setup_pager
> +# Spawn pager process and redirect the rest of our output to it
> +setup_pager()
> +{
> +	isatty 1 || return 0
> +
> +	# TG_PAGER = GIT_PAGER | PAGER
> +	# (but differentiate between GIT_PAGER='' and unset variables)
> +	# http://unix.derkeiler.com/Newsgroups/comp.unix.shell/2004-03/0792.html
> +	case ${GIT_PAGER+XXX} in
> +	'')
> +		case ${PAGER+XXX} in
> +		'')

I'm pretty sure there's been a nice trick for this, but I can't remember
it at all now.

> +			# both GIT_PAGER & PAGER unset
> +			TG_PAGER=''
> +			;;
> +		*)
> +			TG_PAGER="$PAGER"
> +			;;
> +		esac
> +		;;
> +	*)
> +		TG_PAGER="$GIT_PAGER"
> +		;;
> +	esac
> +
> +	[ -z "$TG_PAGER"  -o  "$TG_PAGER" = "cat" ]  && return 0
> +
> +
> +	# now spawn pager
> +	export LESS=${LESS:-FRSX}	# as in pager.c:pager_preexec()
> +
> +	_pager_fifo_dir="$(mktemp -t -d tg-pager-fifo.XXXXXX)"
> +	_pager_fifo="$_pager_fifo_dir/0"
> +	mkfifo -m 600 "$_pager_fifo"
> +
> +	"$TG_PAGER" < "$_pager_fifo" &
> +	exec > "$_pager_fifo"		# dup2(pager_fifo.in, 1)
> +
> +	# this is needed so e.g. `git diff` will still colorize it's output if
> +	# requested in ~/.gitconfig with color.diff=auto
> +	export GIT_PAGER_IN_USE=1
> +
> +	# atexit(close(1); wait pager)
> +	trap "exec >&-; rm "$_pager_fifo"; rmdir "$_pager_fifo_dir"; wait" EXIT
> +}

Frankly, I would have been just much happier if something like git
pager--helper would be provided for external tools to use. Seeing how it
gets reimplemented like this just pains me greatly.

On Wed, Jan 07, 2009 at 03:44:32PM +0100, Pierre Habouzit wrote:
> On Wed, Jan 07, 2009 at 11:27:54AM +0000, Kirill Smelkov wrote:
> > isatty()
> > {
> > 	tty -s 0<&$1
> > }
> 
> why not test -t 0 ? I'm not sure it's POSIX though.

It's SUS for many issues already it seems.

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
