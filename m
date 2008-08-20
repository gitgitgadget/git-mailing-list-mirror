From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Tue, 19 Aug 2008 21:07:59 -0700
Message-ID: <7vpro4tjkw.fsf@gitster.siamese.dyndns.org>
References: <1219198703-2388-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 06:09:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVf0X-0007Q0-Cs
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 06:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbYHTEIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 00:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbYHTEIK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 00:08:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbYHTEIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 00:08:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D69D157155;
	Wed, 20 Aug 2008 00:08:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E95B857154; Wed, 20 Aug 2008 00:08:04 -0400 (EDT)
In-Reply-To: <1219198703-2388-1-git-send-email-mlevedahl@gmail.com> (Mark
 Levedahl's message of "Tue, 19 Aug 2008 22:18:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 986BA636-6E6D-11DD-A109-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92961>

Mark Levedahl <mlevedahl@gmail.com> writes:

> git clone does not complain if a trailing '/' is included in the origin
> URL, but doing so causes resolution of a submodule's URL relative to the
> superproject to fail. Regardless of whether git is changed to remove the
> trailing / before recording the URL, we should avoid this issue in
> submodule as existing repositories can have this problem.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  git-submodule.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ea6357b..fa9dd3a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -34,7 +34,7 @@ resolve_relative_url ()
>  	remote=$(get_default_remote)
>  	remoteurl=$(git config "remote.$remote.url") ||
>  		die "remote ($remote) does not have a url in .git/config"
> -	url="$1"
> +	url="${1%/}"
>  	while test -n "$url"
>  	do
>  		case "$url" in

Hmm, the case arms outside the context looks like this:

	while test -n "$url"
	do
		case "$url" in
		../*)
			url="${url#../}"
			remoteurl="${remoteurl%/*}"
			;;
		./*)
			url="${url#./}"
			;;
		*)
			break;;
		esac
	done
	echo "$remoteurl/$url"

If you call "resolve_relative_url ../", the first arm used to fire once
and stripped one level away, but with your patch it does not do so
anymore, and returns "$remoteurl/.." instead?

I know you are primarily interested in making sure that "../foo" and
"../foo/" are handled the same way, but somehow this change does not feel
right.  How about stripping the trailing slash from the end result?
