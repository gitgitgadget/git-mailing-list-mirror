From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetch: Auto-following tags should check connectivity, not existence
Date: Thu, 19 Apr 2007 23:39:30 -0700
Message-ID: <7v4pnb4kil.fsf@assigned-by-dhcp.cox.net>
References: <4624F183.D4B6BBB1@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 08:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HemmN-0004FE-RA
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 08:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423040AbXDTGjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 02:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423042AbXDTGjc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 02:39:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35485 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423040AbXDTGjb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 02:39:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420063931.BTRR1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 02:39:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pJfW1W00Q1kojtg0000000; Fri, 20 Apr 2007 02:39:31 -0400
In-Reply-To: <4624F183.D4B6BBB1@eudaptics.com> (Johannes Sixt's message of
	"Tue, 17 Apr 2007 18:10:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45068>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> git-fetch's auto-following of tags fetches all tags for which it finds
> objects in the local repository. I feel it were better if not object
> existence, but connectivity to the existing refs was checked, like this:
>
> diff --git a/git-fetch.sh b/git-fetch.sh
> index fd70696..1b3c459 100755
> --- a/git-fetch.sh
> +++ b/git-fetch.sh
> @@ -314,11 +314,12 @@ case "$no_tags$tags" in
>         taglist=$(IFS=' ' &&
>         echo "$ls_remote_result" |
>         git-show-ref --exclude-existing=refs/tags/ |
>         while read sha1 name
>         do
> -           git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
> +           t=$(git-rev-list --max-count=1 "$sha1" --not --all 2>
> /dev/null) &&
> +           test -z "$t" || continue
>             echo >&2 "Auto-following $name"
>             echo ".${name}:${name}"
>         done)
>     esac
>     case "$taglist" in

I think "something like this" is a sensible thing to do, on top
of the updates to "rev-list --objects" to verify the blob we
list actually exists.

However, I think --max-count=1 defeats what you are trying to
do.  Revision limiting will only look at commits, and if you
have all commits that lead to the "$sha1" commit from some of
the existing refs, but lack some blobs or trees that belong to
some of the commits that are not the first commit that will be
listed, their absense will not be noticed.
