From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Simplest update to bash completions to prevent
	unbounded variable errors
Date: Tue, 13 Jan 2009 07:20:47 -0800
Message-ID: <20090113152047.GO10179@spearce.org>
References: <496C1F5F.9020604@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 16:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMl5o-000226-EP
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 16:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbZAMPUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 10:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZAMPUs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 10:20:48 -0500
Received: from george.spearce.org ([209.20.77.23]:36501 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbZAMPUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 10:20:47 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2347B38210; Tue, 13 Jan 2009 15:20:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496C1F5F.9020604@tedpavlic.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105500>

Ted Pavlic <ted@tedpavlic.com> wrote:
> Another try at fixing bash completions in "set -u" environments.

I agree with Junio; setting -u in your interactive shell is as bad
as export CDPATH.  Its crazy.

> Additionally added some comments and omitted things like Vim modelines.

These are orthogonal to the -u corrections.  They should be in a
different patch.  The comments are wecome.  The '#!bash' looks like
a good idea.  But a vim specific modeline, I don't like, for the
reasons Junio has already stated.

> +# __gitdir accepts 0 or 1 arguments (i.e., location)
> +# returns location of .git repo
>  __gitdir ()
>  {
> -	if [ -z "$1" ]; then
> +	if [ $# -eq 0 ] || [ -z "$1" ]; then

This is one of those places where [ -z "${1-}" ] is likely easier
to read then the || usage you have introduced.  We don't care if
we got no args, or we got one that is the empty string, either way
the $1 cannot be a gitdir and we need to guess it.

> @@ -111,7 +116,7 @@ __git_ps1 ()
>  			fi
>  		fi
>
> -		if [ -n "$1" ]; then
> +		if [ $# -gt 0 ] && [ -n "$1" ]; then
>  			printf "$1" "${b##refs/heads/}$r"

Eh, I'd rather see [ -n "${1-}" ] over the && test.

> -complete -o default -o nospace -F _git git
> -complete -o default -o nospace -F _gitk gitk
> +complete -o bashdefault -o default -o nospace -F _git git 2>/dev/null \
> +	|| complete -o default -o nospace -F _git git
> +complete -o bashdefault -o default -o nospace -F _gitk gitk 2>/dev/null \
> +	|| complete -o default -o nospace -F _gitk gitk

Why are we switching to bashdefault?  Is this an unrelated change
from the -u stuff and should go into its own commit, with its own
justification?

-- 
Shawn.
