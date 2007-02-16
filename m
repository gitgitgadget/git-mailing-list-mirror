From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected transfer
Date: Thu, 15 Feb 2007 18:11:37 -0800
Message-ID: <7vodnuc0me.fsf@assigned-by-dhcp.cox.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
	<11715851972838-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 03:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHsZj-0002QU-FW
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 03:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423031AbXBPCLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 21:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423032AbXBPCLj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 21:11:39 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40408 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423031AbXBPCLi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 21:11:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216021138.SMOO1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 21:11:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q2Bd1W00N1kojtg0000000; Thu, 15 Feb 2007 21:11:37 -0500
In-Reply-To: <11715851972838-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Thu, 15 Feb 2007 19:19:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39878>

Mark Levedahl <mdl123@verizon.net> writes:

> +# find the refs to carry along and get sha1s for each.
> +refs=
> +fullrevargs=
> +for arg in $gitrevargs ; do
> +	#ignore options and basis refs, get unambiguous ref name for things
> +	# we will transport (e.g., user gives master, have heads/master and
> +	# remotes/origin/master, we keep the former).

I am not sure if that is a good behaviour.  What if user gives
xyzzy and there are tags/xyzzy and remotes/origin/xyzzy?

I suspect it would be much safer to error out in ambiguous cases.

> +# we do things a slow way if max-age or min-age are given
> +fast=
> +[ "${fullrevargs##*--max-age}" == "$fullrevargs" ] && \
> +[ "${fullrevargs##*--min-age}" == "$fullrevargs" ] && fast=1

Style.

Our scripts tend to spell the test command "test" and equality test
operator as single '='.  Also they tend to say:

        case "$fullrevargs" in
        *--max-age* | *--min-age*) ... 
        esac

> +	# get immediate parents of each commit to include
> +	parents=
> +	for c in $commits ; do
> +		parents="$parents $(git-rev-list --parents $c | head -1 | cut -b42-)"
> +	done

Nicely done, but you seemed to have used "head -n 1" elsewhere,
which is more portable.

> +	# factor out what will be in this bundle, the remainder are the bundle's pre-requisites.
> +	# double up commits in this as we only want things that are only in parents to appear once
> +	prereqs=$(printf "%s\n" $parents $commits $commits | \
> +		sort | \
> +		uniq -c | \
> +		grep ' 1 ' \
> +		| sed 's/ *1 //')

Don't pipe output of grep to sed ;-).

> +else
> +	prereqs=$(git-rev-list --objects-edge $fullrevargs | \
> +		grep '^-' | sed 's/-//')
> +fi

Likewise.  The latter is:

	... | sed -ne 's/^-//p'

> +# create refs and pack
> +[ -e "$bfile" ] && rm -f "$bfile" 2>/dev/null
> +printf "%s\n" $prereqs > .gitBundleReferences

Our scripts assume $GIT_DIR/ is writable but not necessarily the
working directory when they have to use temporary files.  Also
please clean temporaries even when you error out with traps.

	tmp=$GIT_DIR/bundle_tmp$$
	references="$tmp-references"
        pack="$tmp-pack"
        trap 'rm -f "$tmp-*"' 0 1 2 3 15

        echo "-" >>"$references" &&
        git-show-ref $refs >>"$references" &&
        (git-rev-list ... >"$pack") || exit
