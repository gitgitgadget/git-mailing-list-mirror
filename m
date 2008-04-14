From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/2] bisect: warn if given dubious tag or branch as rev
Date: Mon, 14 Apr 2008 16:33:36 -0700
Message-ID: <7vabjw810v.fsf@gitster.siamese.dyndns.org>
References: <20080414054151.52e55e7f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 01:34:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlYC2-0002TK-BK
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 01:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbYDNXdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 19:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbYDNXdu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 19:33:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbYDNXdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 19:33:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C57283A13;
	Mon, 14 Apr 2008 19:33:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D9E6F3A11; Mon, 14 Apr 2008 19:33:41 -0400 (EDT)
In-Reply-To: <20080414054151.52e55e7f.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 14 Apr 2008 05:41:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79541>

Christian Couder <chriscool@tuxfamily.org> writes:

> This patch refactors rev parsing code in a new "bisect_parse_rev"
> function, and adds warnings in case a rev with a name that is the
> same as one of the bisect subcommands is given where a revision
> is expected.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-bisect.sh               |   47 ++++++++++++++++++++++++++++++------------
>  t/t6030-bisect-porcelain.sh |   21 +++++++++++++++++++
>  2 files changed, 54 insertions(+), 14 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 6b43461..a090b97 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -61,6 +61,31 @@ bisect_autostart() {
>  	}
>  }
>  
> +bisect_parse_rev() {
> +	rev="$1"
> +	dont_die_on_wrong_rev="$2"
> +	name="$rev^{commit}"
> +	dubious_rev_name=''
> +
> +	case "$rev" in
> +	HEAD)
> +		name='HEAD' ;;
> +	help|start|bad|good|skip|next|reset|visualize|replay|log|run)
> +		dubious_rev_name='yes' ;;
> +	esac

I see you listed all the subcommand names here but I somehow doubt this is
sensible.

The "bisect good $foo bad $bar" example from Ingo's transcript may suggest
that good/bad may incorrectly appear by copying and pasting from an
incorrect how-to guide, but on the other hand "bisect bad log" to mark the
tip of the "log" branch (or "replay or any other common words) to see
where in the development trail on that branch things got broken is a
perfectly valid and plausible thing to do.  Also when you happen to have
found something broken while you are working on a more important issue,
you may tentatively do "git tag bad $it", and keep working on that
important issue, only to come back later and use that lightweight tag to
feed "git bisect" with.  In either use case, "you named your ref the same
as bisect subcommand name, bad boy" is an unnecessary noise.
