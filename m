From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 2/2] git-gui: handle bare repos correctly
Date: Thu, 19 Feb 2009 03:25:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902190322470.10279@pacific.mpi-cbg.de>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com> <1235006145-16760-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 03:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZybZ-0002P8-N9
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 03:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZBSCYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 21:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbZBSCYJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 21:24:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:33157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751824AbZBSCYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 21:24:06 -0500
Received: (qmail invoked by alias); 19 Feb 2009 02:24:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 19 Feb 2009 03:24:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VZ+kqc8yV6wHsfHKIdjauND5EF5Jmq+UuUa7ko7
	20DdkejcCULwed
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1235006145-16760-3-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110610>

Hi,

On Thu, 19 Feb 2009, Giuseppe Bilotta wrote:

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 12c7ff3..a4c0d4b 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -122,6 +122,7 @@ unset oguimsg
>  set _appname {Git Gui}
>  set _gitdir {}
>  set _gitworktree {}
> +set _isbare {}
>  set _gitexec {}
>  set _reponame {}
>  set _iscygwin {}
> @@ -254,6 +255,23 @@ proc get_config {name} {
>  	}
>  }
>  
> +proc is_bare {} {
> +	global _isbare
> +	global _gitdir
> +	global _gitworktree
> +
> +	if {$_isbare eq {}} {
> +		if {[is_config_true core.bare]
> +			|| ($_gitworktree eq {}
> +				&& [lindex [file split $_gitdir] end] ne {.git})} {
> +			set _isbare 1
> +		} else {
> +			set _isbare 0
> +		}
> +	}
> +	return $_isbare
> +}

git rev-parse --is-bare-repository anyone?

> @@ -1913,7 +1931,7 @@ proc do_gitk {revs} {
>  		}
>  
>  		set pwd [pwd]
> -		if { $_gitworktree ne {} } {
> +		if { ![is_bare] } {

Why is this change needed at all?

> @@ -2317,10 +2335,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>  #
>  menu .mbar.repository
>  
> -.mbar.repository add command \
> -	-label [mc "Explore Working Copy"] \
> -	-command {do_explore}
> -.mbar.repository add separator
> +if {![is_bare]} {
> +	.mbar.repository add command \
> +		-label [mc "Explore Working Copy"] \
> +		-command {do_explore}
> +	.mbar.repository add separator
> +}

How did you make sure that there are no more places?

(I, for one, would expect the standard mode of staging to fail in a bare 
repository.)

Ciao,
Dscho
