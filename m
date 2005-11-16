From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] symref support for import scripts
Date: Wed, 16 Nov 2005 11:43:41 -0800
Message-ID: <7vu0ec7502.fsf@assigned-by-dhcp.cox.net>
References: <1132165648.4024.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Nov 16 20:46:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTC9-0004Ts-5e
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbVKPTnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 14:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbVKPTnq
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:43:46 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57078 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030463AbVKPTnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 14:43:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116194310.HQFI6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 14:43:10 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132165648.4024.6.camel@dv> (Pavel Roskin's message of "Wed, 16
	Nov 2005 13:27:28 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12044>

Pavel Roskin <proski@gnu.org> writes:

> Fix git import script not to assume that .git/HEAD is a symlink.
>
> Signed-off-by: Pavel Roskin <proski@gnu.org>

Thanks.

Martin and Matthias, are these OK with you two?  All of the
changes look trivially correct, so I'll take them.

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 7bd9136..efe1934 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -437,7 +437,11 @@ unless(-d $git_dir) {
>  		       "Either use the correct '-o branch' option,\n".
>  		       "or import to a new repository.\n";
>  
> -	$last_branch = basename(readlink("$git_dir/HEAD"));
> +	open(F, "git-symbolic-ref HEAD |") or
> +		die "Cannot run git-symbolic-ref: $!\n";
> +	chomp ($last_branch = <F>);
> +	$last_branch = basename($last_branch);
> +	close(F);
>  	unless($last_branch) {
>  		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
>  		$last_branch = "master";

This part, before or after Pavel's fixes, seems to refuse a
branch named 'topic/#1'.  This is not a problem for import
scripts that name their own branches based on what is in the
foreign SCM and flatten their the branch namespaces, but I'd
prefer a comment about the issue somewhere around this code, to
prevent people from copying and pasting the use of "basename()".
There is a corresponding piece in svnimport as well.
