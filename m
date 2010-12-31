From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 3/3] filter-branch: support --submodule-filter
Date: Fri, 31 Dec 2010 18:31:23 +0100
Message-ID: <201012311831.24057.j6t@kdbg.org>
References: <cover.1293809100.git.trast@student.ethz.ch> <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: jeffrey.freeman@syncleus.com, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 31 18:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYipL-0006Gc-AU
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 18:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819Ab0LaRb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Dec 2010 12:31:27 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:17336 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753701Ab0LaRb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Dec 2010 12:31:26 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3A6FFA7EB6;
	Fri, 31 Dec 2010 18:30:18 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2190619F69E;
	Fri, 31 Dec 2010 18:31:24 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164393>

On Freitag, 31. Dezember 2010, Thomas Rast wrote:
> This new filter gets each submodule's current sha1 and path on stdin,
> separated by a tab.  It can then emit a new submodule sha1 and/or
> path, and filter-branch will:
>
> * if the path differs, remove the submodule at the old path;
>
> * add/replace the new sha1 at the new path.
>
> Additionally, returning an empty new sha1 deletes the submodule.
>
> You can tie this together with the last two commits to filter the
> super-project after a subproject filtering as follows:
>
>   ( cd sub1 && git filter-branch --dump-map map <filters|args> )
>   ( cd sub2 && git filter-branch --dump-map map <filters|args> )
>   cat sub1/map sub2/map > map
>   git filter-branch --load-map map \
>   	--submodule-filter "map $(cut -f1)" \
> 	<args>
>
> Other use-cases should also be covered since we also pass through the
> path.

As I said, I'm not particularly fond of a new --submodule-filter because it is 
just a special --index-filter.

Your implementation is highly problematic:

> +	if [ "$filter_submodule" ]; then
> +		git ls-files -s |
> +		grep '^160000' |
> +		while read mode sha1 stage path; do
> +			printf "$sha1\t$path\n" |
> +			{ eval "$filter_submodule" ||
> +				die "submodule filter failed: $filter_submodule"; } |

This 'die' will not do anything useful except to write an error message.

> +			read newsha1 newpath

This 'read' is part of a pipe, and as such many shells run it in a sub-shell; 
the values that it reads do not survive the pipe, hence, the subsequent code 
does not do what you intend it.

In this case, you can put everything from 'read' to the last 'fi' below inside 
a block { } because there are no process states that need to survive the 
pipe.

> +			if [ -z "$newsha1" ] || [ "$path" != "$newpath" ]; then
> +				git update-index --remove "$path" ||
> +					die "failed to remove submodule $path"
> +			fi
> +			if [ -n "$newsha1" ] && [ "$sha1" != "$newsha1" ]; then
> +				git update-index --add --replace --cacheinfo \
> +					160000 "$newsha1" "$newpath" ||
> +					die "failed to add submodule $newpath"
> +			fi
> +		done

The whole if-branch is a pipe, and it's parts are run in a sub-shell (although 
shells are allowed to optimize this). This means that the 'die' calls will 
only exit the pipe, but not terminate filter-branch. You at least need to 
have '|| exit' behind the last 'fi' and &&-join the if-statements.

> +	fi
> +
>  	parentstr=
>  	for parent in $parents; do
>  		for reparent in $(map "$parent"); do

-- Hannes
