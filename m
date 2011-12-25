From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Sat, 24 Dec 2011 19:13:37 -0800
Message-ID: <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
References: <20111224234212.GA21533@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sun Dec 25 04:14:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ReeXF-0007Al-Th
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 04:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab1LYDNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 22:13:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab1LYDNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 22:13:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EA3371B0;
	Sat, 24 Dec 2011 22:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d7cu9PrGjYXeKmfH0S8obLIR4qY=; b=GA/KnA
	lRM+wwN6KhSqq2zOz9uMyVEJOnwAxrPiso9xYh74gXwFL/W0DAHErrqg5j4zOkVw
	d3oMGTRV33RZXI7hCc06ZESdWA6YpamJwAR1Ut4Nr6ifqtr/VhPME8kg/zCteazr
	1nkffPotFkZsDLNjfXSHG4nj/YbyiaAzwfx1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lfEUy6iPueXiilb3yM7dsec/EoJNpTB+
	R5/gpUvpRtuTY6CNDcBLQ+kM21HjdT29sJdN1caHoHpMo1UTvBuK6aWz+uyKnEMq
	ASmtoNDCdTVJuFaToRn9+9BWTN6E8+OijWm1gpZ4j9hgkyw8jqBFjE0AkLe7BoWE
	vsg+BKifldQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26AFF71AF;
	Sat, 24 Dec 2011 22:13:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87AB671AD; Sat, 24 Dec 2011
 22:13:39 -0500 (EST)
In-Reply-To: <20111224234212.GA21533@gnu.kitenet.net> (Joey Hess's message of
 "Sat, 24 Dec 2011 19:42:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71270D52-2EA6-11E1-A5C8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187675>

Joey Hess <joey@kitenet.net> writes:

> The post-fetch hook is fed on its stdin all refs that were newly fetched.
> It is not allowed to abort the fetch (or pull), but can modify what
> was fetched or take other actions.
>
> One example use of this hook is to automatically merge certain remote
> branches into a local branch. Another is to update a local cache
> (such as a search index) with the fetched refs. No other hook is run
> near fetch time, except for post-merge, which doesn't always run after a
> fetch, which is why this additional hook is useful.
>
> Signed-off-by: Joey Hess <joey@kitenet.net>

A typical "'git pull' invokes 'git fetch' and then lets 'git merge' (or
'git rebase') integrate the work on the current branch with what was
fetched" sequence goes like this:

 - 'git fetch':
  . grabs the necessary objects from the remote;
  . decides what remote tracking branches are updated to point
    at what objects, and what updates are to be denied;
  . updates remote tracking branches accordingly; and
  . writes $GIT_DIR/FETCH_HEAD to communicate what have been fetched
    and what are to be merged.

 - 'git merge':
  . reads $GIT_DIR/FETCH_HEAD to learn what commits to be merged; and
  . merges the commits to the current branch.

Even though we do not add arbitrary hooks on the client side that could
easily be implemented by wrapping the client side commands (i.e. you could
implement "git myfetch" that runs "git fetch" followed by whatever script
that mucks with the result of the fetch) in general, I can see that it
would be useful to have a hook that can tweak the result of the fetch run
inside of the "git pull", because you cannot tell "git pull" to run "git
myfetch" instead of "git fetch".

Because the sequence of "git fetch" followed by "git merge", both commands
issued by the end user, should be equivalent to "git pull" from an end
user's point of view, the hook must be called from near the end of "git
fetch" if we were to have such a hook that tweaks the result of the fetch
inside "pull". IOW, the implementation, even though logically it belongs
to "pull", has to be inside "fetch", not "pull".

In that sense, I am not fundamentally opposed to the idea of adding a post
fetch hook that allows tweaking of the result.

*HOWEVER*

If we _were_ to sanction the use of the hook to tweak the result, I do not
want to see it implemented as an ad-hoc hack that tells the hook writers
that it is _entirely_ their responsiblity to update the remote tracking
branches from what it fetched, and also update $GIT_DIR/FETCH_HEAD to
maintain consistency between these two places.

A very cursory look at the patch tells me that there are a few problems
with it.  It does not seem to affect what will go to $GIT_DIR/FETCH_HEAD
at all, and hence it does not have any way to affect the result of the
fetch that does not store it to any of our remote tracking branches.

> The #1 point of confusion for git-annex users is the need to run
> "git annex merge" after fetching. That does a union merge of newly
> fetched remote git-annex branches into the local git-annex branch.

That use case sounds like that "git fetch" is called as a first class UI,
which is covered by "git myfetch" (you can call it "git annex fetch")
wrapper approach, the canonical example of a hook that we explicitly do
not want to add. It also does not seem to call for mucking with the result
of the fetch at all.

Perhaps the two concepts should be separated into different hooks?
