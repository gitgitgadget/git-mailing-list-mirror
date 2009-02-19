From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 1/2] git-gui: handle non-standard worktree locations
Date: Thu, 19 Feb 2009 03:22:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902190307390.10279@pacific.mpi-cbg.de>
References: <1235006145-16760-1-git-send-email-giuseppe.bilotta@gmail.com> <1235006145-16760-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 03:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZyYg-0001lU-If
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 03:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbZBSCVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 21:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbZBSCVK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 21:21:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:50216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752054AbZBSCVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 21:21:09 -0500
Received: (qmail invoked by alias); 19 Feb 2009 02:21:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 19 Feb 2009 03:21:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oKMVsmZYolK8lCiUctrZKFspdod0y8rt0TK0Si8
	SwONoBJtPtSbJH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1235006145-16760-2-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110609>

Hi,

whenever I read "worktree" I get cautious.

_Very_ cautious.


I mean, _VERY_ cautious.  And for a reason.

The whole idea of a worktree was bolted onto Git, so much so that almost 
invariably, every attempt at making it work properly, fails.

Honestly, I think it caused us more pain than any other part of Git, 
_including_ the nasty bugs in git_config_set().

On Thu, 19 Feb 2009, Giuseppe Bilotta wrote:

> Don't

Personally, I prefer a less colloquial (and while at it, a more concise) 
commit message.

> +# _gitdir exists, so try loading the config
> +load_config 0
> +apply_config
> +# try to set work tree from environment, falling back to core.worktree
> +if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
> +	set _gitworktree [get_config core.worktree]
> +}
>  if {$_prefix ne {}} {
> -	regsub -all {[^/]+/} $_prefix ../ cdup
> +	if {$_gitworktree eq {}} {
> +		regsub -all {[^/]+/} $_prefix ../ cdup
> +	} else {
> +		set cdup $_gitworktree
> +	}

It appears as if you redo a the logic laid out in setup.c.  Don't.  
Instead, teach rev-parse to output the path of the work tree.

Oh, wait, --show-cdup already shows that...

> @@ -1076,11 +1089,15 @@ if {$_prefix ne {}} {
>  		error_popup [strcat [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
>  		exit 1
>  	}
> -	if {[catch {cd [file dirname $_gitdir]} err]} {
> +	if {$_gitworktree eq {}} {
> +		set _gitworktree [file dirname $_gitdir]
> +	}

This is certainly wrong in bare repositories.

(If that code is only exercized in non-bare repositories, you failed to 
indicate that.  The commit message is the place for such comments.)

> +	if {[catch {cd $_gitworktree} err]} {
>  		catch {wm withdraw .}
> -		error_popup [strcat [mc "No working directory"] " [file dirname $_gitdir]:\n\n$err"]
> +		error_popup [strcat [mc "No working directory"] " $_gitworktree:\n\n$err"]
>  		exit 1
>  	}
> +	set _gitworktree [pwd]

And why do you have to cd to the worktree?  You might not be able to come 
back to the GIT_DIR, after all.

> @@ -1895,8 +1913,10 @@ proc do_gitk {revs} {
>  		}
>  
>  		set pwd [pwd]
> -		cd [file dirname [gitdir]]
> -		set env(GIT_DIR) [file tail [gitdir]]
> +		if { $_gitworktree ne {} } {
> +			cd $_gitworktree
> +		}
> +		set env(GIT_DIR) [file normalize [gitdir]]
>  
>  		eval exec $cmd $revs &
>  

Just out of curiosity: what was your method of making sure that you catch 
all sites where the worktree is assumed to be $GIT_DIR/..?

That is a most crucial information for the commit message!!!

Besides, have you read about the fallout of making "git rev-parse 
--git-dir" showing absolute paths always?

If yes, why do you ignore it in your patch?

Ciao,
Dscho
