From: David Kastrup <dak@gnu.org>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 19:07:08 +0200
Message-ID: <87fvum694z.fsf@fencepost.gnu.org>
References: <87k3jy6cyc.fsf@fencepost.gnu.org> <vpqli4ekdni.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6kjI-0000i1-Gd
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab3HFRHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:07:24 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:52466 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756131Ab3HFRHY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:07:24 -0400
Received: from localhost ([127.0.0.1]:51508 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1V6kjC-00024B-JG; Tue, 06 Aug 2013 13:07:22 -0400
Received: by lola (Postfix, from userid 1000)
	id 1625BEAC27; Tue,  6 Aug 2013 19:07:08 +0200 (CEST)
In-Reply-To: <vpqli4ekdni.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	06 Aug 2013 18:05:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231761>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Could not apply 16de9d2... Make tempo range empo 20~30 be input as
>> empo 20-30 instead
>
> Indeed. The source of the problem is that our "die" shell function
> interprets \t (because it uses "echo").
>
> A simple fix would be this:
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 7a964ad..97258d5 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -53,7 +53,7 @@ die () {
>  die_with_status () {
>         status=$1
>         shift
> -       echo >&2 "$*"
> +       printf >&2 "%s\n" "$*"
>         exit "$status"
>  }
>  
> It does not sound crazy as the shell function "say" right below uses the
> same printf "%s\n" "$*",

Sounds reasonable, though I don't know off-hand (not having the source
here) whether using "say" inside of die_with_status (and thus not having
two different places to maintain) might not be feasible instead.  It's
not like die_with_status is going to be called often enough to become a
performance hog.

> but I'm wondering whether this could have other bad implications
> (e.g. if there are escape sequences in the commit message, aren't we
> going to screw up the terminal?).

One person's escape sequences are another's multibyte characters.  Less
cheesy, it would seem that the above change is a strict improvement and
requires little thought to implement.

Not interpreting escape sequences is orthogonal from output
sanitization.

-- 
David Kastrup
