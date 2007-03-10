From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-parse-remote: Support dummy remote `.' in branch.<name>.remote
Date: Fri, 09 Mar 2007 16:17:31 -0800
Message-ID: <7v1wjy3qas.fsf@assigned-by-dhcp.cox.net>
References: <45F182DC.9090507@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Sat Mar 10 01:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPpHV-0001I6-HY
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 01:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767676AbXCJARf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 19:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767680AbXCJARe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 19:17:34 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34952 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767676AbXCJARd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 19:17:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310001734.HELS3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 19:17:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YoHY1W0091kojtg0000000; Fri, 09 Mar 2007 19:17:32 -0500
In-Reply-To: <45F182DC.9090507@lu.unisi.ch> (Paolo Bonzini's message of "Fri,
	09 Mar 2007 16:53:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41824>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

> This patch adds support for a dummy remote `.' to avoid having to declare
> a fake remote like
>
> 	[remote "local"]
> 		url = .
> 		fetch = refs/heads/*:refs/heads/*

For one thing, I do not think it would help Andy's original
example of reusing what we already have in refs/remotes
hierarchy if you faked it with refs/heads/*:refs/heads/*
wildcard like the above.

Why not

	[remote "local"]
        	url = .
                fetch = refs/heads/*

or even

	[remote "local"]
        	url = .
                fetch = refs/*

except that we currently do not have non-storing globbing
pattern defined?

I am actually Ok with the idea of built-in ".", but I really do
not like it to even pretend storing the fetched results in local
branches.  If you stop thinking in terms of "tracking fetch"
that stores the result in some local branch, you do not have to
have branch.forcelocalupdates.

By the way, I do not understand the semantics of that
configuration variable at all.

> +branch.forcelocalupdates::
> +	If set to true, merges from the local repository (i.e. when
> +	branch.<name>.remote is the special setting `.`) are performed
> +	even if they do not result in a fast forward update.  The default
> +	is true.

Really, when does fetching from refs/heads/<blah> into refs/heads/<blah>
result in anything but "already up-to-date"?

I think you can get rid of this ridiculous "we obtain
refs/heads/master from ourselves and store it in the same branch
of ours".  The only thing you want here is to leave FETCH_HEAD
in a state that is usable by git-pull.  Wouldn't that be much
cleaner?

> @@ -128,6 +134,13 @@ get_remote_default_refs_for_fetch () {
>  	case "$data_source" in
>  	'')
>  		set explicit "HEAD:" ;;
> +	builtin)
> +		if test $(git-config --bool "branch.forcelocalupdates" || echo true) = true
> +		then
> +			set $(expand_refs_wildcard . +refs/heads/*:refs/heads/*)
> +		else
> +			set $(expand_refs_wildcard . refs/heads/*:refs/heads/*)
> +		fi ;;
>  	config)
>  		set $(expand_refs_wildcard "$1" \
>  			$(git-config --get-all "remote.$1.fetch")) ;;

Especially this above hunk is not something I'd like to see so
the patch won't be applied as-is in this round, but just for
future reference...

The --bool option makes sure the git-config command either says
"true", "false" or silently exit with non-zero, in which case
you would let echo say "true".  In that sense, it is not a
problem in this particular patch, but in general it makes me
worried when I see somebody feeds $() without quoting to test as
its argument.
