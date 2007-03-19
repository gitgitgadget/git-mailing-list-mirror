From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] mergetool: Use merge.tool config option.
Date: Sun, 18 Mar 2007 17:18:24 -0700
Message-ID: <7vwt1em6gf.fsf@assigned-by-dhcp.cox.net>
References: <11742343911678-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net, tytso@mit.edu
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:44:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT5z5-0001iP-Cy
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 01:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933426AbXCSAoJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 20:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933510AbXCSAoJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 20:44:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40087 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933426AbXCSAoI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 20:44:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319004408.QMWE321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 20:44:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cQk71W0081kojtg0000000; Sun, 18 Mar 2007 20:44:07 -0400
In-Reply-To: <11742343911678-git-send-email-jbowes@dangerouslyinc.com> (James
	Bowes's message of "Sun, 18 Mar 2007 12:13:11 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42552>

James Bowes <jbowes@dangerouslyinc.com> writes:

> If no merge program was supplied on the commandline, and the config option
> merge.tool was set to a valid value, then mergetool would unset $merge_tool
> and instead try to find an installed merge program. This patch removes the code
> that unset $merge_tool, so the merge.tool config option will always be used, if
> set.

The problem description looks correct, but I think the original
meant to reject configuration value for merge_tool that is not
supported with the version of the script (and screwed up).

> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
> ---
>  git-mergetool.sh |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 52386a5..19788a1 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -288,10 +288,6 @@ done
>  
>  if test -z "$merge_tool"; then
>      merge_tool=`git-config merge.tool`
> -    if test $merge_tool = kdiff3 -o $merge_tool = tkdiff -o \
> -	$merge_tool = xxdiff -o $merge_tool = meld ; then
> -	unset merge_tool
> -    fi
>  fi
>  
>  if test -z "$merge_tool" ; then

IOW, wouldn't this be a better way?

        if test -z "$merge_tool"
        then
                merge_tool=`git-config merge.tool`
                case "$merge_tool" in
                kdiff3 | tkdiff | xxdiff | meld | emerge)
                        ;; # happy
                *)
                        echo >&2 "We do not know how to drive $merge_tool"
                        echo >&2 "Resetting to default..."
                        unset merge_tool
                        ;;
                esac
        fi
