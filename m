From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/4] Restructuring git-merge.sh
Date: Wed, 26 Mar 2008 09:17:46 -0700
Message-ID: <7vr6dxe9xx.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803252056n122cae6cv1a6f4e46a5fb5096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 17:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeYM2-0007xu-9g
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 17:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbYCZQR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 12:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYCZQR6
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 12:17:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756946AbYCZQR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 12:17:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B900C2F83;
	Wed, 26 Mar 2008 12:17:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0840A2DDF; Wed, 26 Mar 2008 12:17:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78288>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> for preparation of new feature:

Full sentence, please?

>
>    Head reduction before selecting merge strategy
>
> Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
> ---
>  git-merge.sh |  166 ++++++++++++++++++++++++++++++----------------------------
>  1 files changed, 85 insertions(+), 81 deletions(-)
>
> diff --git a/git-merge.sh b/git-merge.sh
> index 17f40f2..2acd2cc 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -207,6 +207,29 @@ parse_config () {
>         args_left=$#
>  }
>
> +# Find real parents
> +# Set the following variables as followd:
> +#   real_parents: The parents specified on the command line
> +#   common:       All common ancestors or not_queried
> +#   ff_head:      Fast forward of head

"Fast forward of head"?  Puzzled, and sorry I cannot offer a better
rewrite for this one as I do not quite get what you are trying to say
here.

> +find_real_parents () {
> +       real_parents=$(git rev-parse "$@")
> +       real_parents=${real_parents#$LF}

What is this "#$LF" for?  rev-parse begins its output with an empty line
and you want to strip it?

> +       if test $# = 1
> +       then
> +               common=$(git merge-base --all $head "$@")
> +               if test "$common" = $head
> +               then
> +                       ff_head=$1
> +               else
> +                       ff_head=$head
> +               fi

So for a single-remote merge, merge-base is run and common is set.

> @@ -339,87 +364,66 @@ do
> +if true
> +then

This caught my attention before looking at 3/4 ;-).

> -       # An octopus.  If we can reach all the remote we are up to date.
> -       up_to_date=t
> -       for remote
> -       do
> -               common_one=$(git merge-base --all $head $remote)
> -               if test "$common_one" != "$remote"
>                 then
> -                       up_to_date=f
> -                       break
>                 fi
> -       done
> -       if test "$up_to_date" = t
> -       then
> -               finish_up_to_date "Already up-to-date. Yeeah!"
>                 exit 0
>         fi

This optimization seems to have been lost, even though it was supposed to
be just code restructuring.

> +fi
> +
> +case "$real_parents" in
> +?*"$LF"?*)
> +       # We have more than one parent
> +       common=$(git show-branch --merge-base $head $real_parents)
>         ;;
> +*)
> +       # We have exactly one parent
> +       test "$common" != not_queried || common=$(git merge-base --all
> $head $real_parents)

How can "not_queried" be possible here?
