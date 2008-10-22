From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase-i-p: only list commits that require rewriting in
 todo
Date: Wed, 22 Oct 2008 00:01:13 -0500
Organization: Exigence
Message-ID: <20081022000113.bacc1923.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
	<0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
	<20081020115003.GA11309@coredump.intra.peff.net>
	<7vej2a3kl5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 07:02:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsVrW-0004Y1-BC
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 07:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbYJVFBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 01:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbYJVFBN
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 01:01:13 -0400
Received: from smtp112.sat.emailsrvr.com ([66.216.121.112]:39558 "EHLO
	smtp112.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbYJVFBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 01:01:13 -0400
Received: from relay1.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay1.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 98EE0261A0A;
	Wed, 22 Oct 2008 01:01:12 -0400 (EDT)
Received: by relay1.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 1CCCA2617B5;
	Wed, 22 Oct 2008 01:01:12 -0400 (EDT)
In-Reply-To: <7vej2a3kl5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> >> + cat "$TODO" | grep -v "${rev:0:7}" > "${TODO}2" ; mv "${TODO}2"
> >> "$TODO"
> >
> > Substring expansion (like ${rev:0:7}) is not portable. At least it
> > doesn't work on FreeBSD /bin/sh, and "it's not even in POSIX", I
> > believe.
>
> True.

Thanks--sorry about that. rev:0:7 was a cute/stupid optimization to
avoid an extra `git rev-parse` call.

> I do not remember the individual patches in the series, but I have to
> say that the script at the tip of the topic is, eh, less than ideal.

Agreed. The previous dropped commits check was nicer, with just one
pass, as todo already had all of the non-dropped of the commits in it.

Now that todo has to include all commits initially to do parent probing,
the dropped commits check requires two passes, dropping lines from todo,
etc., and is a good deal uglier.

> Here is a small untested patch to fix a few issues I spotted while reading
> it for two minutes.
> 
>  * Why filter output from "rev-list --left-right A...B" and look for the
>    ones that begin with ">"?  Wouldn't "rev-list A..B" give that?

Oh--right. I was being too careful about keeping the existing rev-list
call and only changing what I needed that I didn't step back realize
that.

>  * The abbreviated SHA-1 are made with "rev-list --abbrev=7" into $TODO in
>    an earlier invocation, and it can be more than 7 letters to avoid
>    ambiguity.  Not just that "${r:0:7} is not even in POSIX", but use of
>    it here is actively wrong.

Ah, didn't think of that.

>  * There is no point in catting a single file and piping it into grep.

Right, right, I've been trying to get out of that habit.

> diff --git i/git-rebase--interactive.sh w/git-rebase--interactive.sh
> index 848fbe7..a563dea 100755
> --- i/git-rebase--interactive.sh
> +++ w/git-rebase--interactive.sh
> @@ -635,8 +635,8 @@ first and then run 'git rebase --continue' again."
>  				sed -n "s/^>//p" > "$DOTEST"/not-cherry-picks
>  			# Now all commits and note which ones are missing in
>  			# not-cherry-picks and hence being dropped
> -			git rev-list $UPSTREAM...$HEAD --left-right | \
> -				sed -n "s/^>//p" | while read rev
> +			git rev-list $UPSTREAM..$HEAD |
> +			while read rev
>  			do
>  				if test -f "$REWRITTEN"/$rev -a "$(grep "$rev" "$DOTEST"/not-cherry-picks)" = ""
>  				then
> @@ -645,7 +645,8 @@ first and then run 'git rebase --continue' again."
>  					# just the history of its first-parent for others that will
>  					# be rebasing on top of it
>  					git rev-list --parents -1 $rev | cut -d' ' -f2 > "$DROPPED"/$rev
> -					cat "$TODO" | grep -v "${rev:0:7}" > "${TODO}2" ; mv "${TODO}2" "$TODO"
> +					short=$(git rev-list -1 --abbrev-commit --abbrev=7 $rev)
> +					grep -v "^[a-z][a-z]* $short" <"$TODO" > "${TODO}2" ; mv "${TODO}2" "$TODO"
>  					rm "$REWRITTEN"/$rev
>  				fi
>  			done

Looks good--I applied this locally and it passes t3404, t3410, and
t3411. Do I need to do anything else with this, e.g. resubmit/append on
top of the previous series, or do you have it taken care of?

Thanks for reviewing this, and Jeff too. I appreciate the feedback.

I will be bullish about the use cases I'd like to see work (these
preserve merges tweaks and the config setting for `git pull`), but
humble about my patches. This one especially is not elegant, it just
passes the tests. I've been re-reading it looking for a better way to
do it and nothing is jumping out at me. Let me know if you know of a
better approach or would like me to try something else.

Thanks,
Stephen
