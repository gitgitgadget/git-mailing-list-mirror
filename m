From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Improve request-pull to handle non-rebased branches
Date: Tue, 24 Apr 2007 22:38:11 -0700
Message-ID: <7v1wi910ak.fsf@assigned-by-dhcp.cox.net>
References: <20070424164019.GA5780@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 07:38:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgaD1-0004mf-1I
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 07:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXDYFiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 01:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754583AbXDYFiO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 01:38:14 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37243 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbXDYFiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 01:38:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425053812.RMHP1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 25 Apr 2007 01:38:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rHeC1W00G1kojtg0000000; Wed, 25 Apr 2007 01:38:12 -0400
In-Reply-To: <20070424164019.GA5780@spearce.org> (Shawn O. Pearce's message of
	"Tue, 24 Apr 2007 12:40:19 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45497>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> -revision=$1
> +base=$1
>  url=$2
>  head=${3-HEAD}
>  
> -[ "$revision" ] || usage
> +[ "$base" ] || usage
>  [ "$url" ] || usage
>  
> -baserev=`git-rev-parse --verify "$revision"^0` &&
> +baserev=`git-merge-base "$base" "$head"` &&
>  headrev=`git-rev-parse --verify "$head"^0` || exit
>  
> +PAGER=
> +export PAGER
>  echo "The following changes since commit $baserev:"
> -git log --max-count=1 --pretty=short "$baserev" |
> -git-shortlog | sed -e 's/^\(.\)/  \1/'
> +git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'

I know the message says "since commit X", so taking merge base
feels technically correct from that point of view.  But I am not
convinced this is a good change.

It is acceptable to send a pull request from somewhat stale side
branch.  git projects (not necessarily git.git itself, but the
project with distributed management style that git aims to
support well) are inherently peer-to-peer, not hub-and-spoke, so
subsystem people should not be forced to rebase to get included.

However, I think the common courtesy _should_ be for pull
requestor to be confident that what s/he is requesting to be
pulled would result in sensible merge results, before sending
such a pull request.

And one way to show that you did your side of due diligence is
to say "This would merge to your tip".  Taking merge-base and
saying only "I forked from you this long time ago" makes the
output convey a wrong message.  I would certainly be suspicious
of a message that says "Here are fixes since v1.3.0", even if
the changes are isolated to the files that never changed since
v1.3.0.

>  echo "are found in the git repository at:" 
>  echo
> -echo "  $url"
> +echo "  `get_remote_url "$url"`"
>  echo

If you can verify headrev is at the tip of a branch (and that is
what you are asking to be pulled), I think we would want to see
the branch name at the end.  A recent example from the kernel
list:

   On Thu, 19 Apr 2007, Avi Kivity wrote:
   > 
   > Please pull from the 'linus' branch of
   > 
   >   git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git

   *please* put the branch-name after the git repo, so that I can 
   cut-and-paste without noticing only afterwards that the diffstat doesn't 
   match what it was supposed to, and I got the wrong commits, and have to 
   undo and re-do the pull..

   Yeah, I didn't do that mistake this time, and in fact, I seldom do, but 
   every time the branch is mentioned somewhere else than with the actual 
   repo to pull, I get nervous. 

   So I've said this a million times before, but I'll say it one more 
   time: if it's not the main branch, the message should be

      Please pull from the 'linus' branch of

        git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git linus

      to get the following changes: ...

   so that when I cut-and-paste the URL (you didn't think I'd try to type it 
   in by hand, did you?) I get the branch automatically.

> -git log  $baserev..$headrev | git-shortlog ;
> -git diff -M --stat --summary $baserev..$headrev
> +git shortlog ^$baserev $headrev
> +git diff -M --stat --summary $baserev $headrev

Use of the merge base revision for the last diff makes sense.
There should not be any difference for the shortlog if there is
only one merge base (and if there is more than one, then using
only one of them is probably buggy), so I think you would want
to say "shortlog $base..$headrev" instead (iow keep the original
for this shortlog).
