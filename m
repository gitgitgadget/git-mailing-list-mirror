From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Mon, 02 May 2011 09:33:02 -0700
Message-ID: <7v7ha9ngsf.fsf@alter.siamese.dyndns.org>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net> <20110429223433.GA3434@sigill.intra.peff.net> <m2k4ecy6rv.fsf@igel.home> <7vfwp0uwu4.fsf@alter.siamese.dyndns.org> <m21v0kw1es.fsf@igel.home> <4DBE6E77.3030703@drmicha.warpmail.net> <BANLkTinxszGhtYobuvci5Yi8eTHW+pi2wA@mail.gmail.com> <4DBE8FD8.90303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 02 19:39:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGx5j-0000Kc-2P
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab1EBRjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 13:39:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1EBRjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 13:39:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B771656A7;
	Mon,  2 May 2011 13:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=27/J5+J8YjGk3473XV9J2sAOFYs=; b=TwCgjcELZ48QhF8IYH2R
	UGMtUZMNDi6s1kv3rnsr45pJllBCwkFGtqwtmTq11lD3PZuZ1jNyTcfNoDYcbOc5
	PfMpE0SliBjDtfqOeMKBF3vXyIvE6fOPjaBd/VQMVIYU6bI2Evq8tCzm8MfX5tsg
	+eM3g6G3WChVBDad16MtyEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PeYF6IW1aun7XZQn+sZeHY8YO2gEZz9tF7jhCCeDlGNDKr
	zzLlrodDqiBlVsrG4shhb6lD1X1d32lMg0zIwhOcjRtGUcH3Rp0kST14VFhf4ZkH
	Lj4RNOT6aFFEkwBqTlq1N5hCh1dT+v9LjmRasvb8Kcbbtw5AoEjolOxyMsMSM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9519856A5;
	Mon,  2 May 2011 13:41:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6F6B056A4; Mon,  2 May 2011
 13:41:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64982634-74E3-11E0-B3EC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172606>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Introducing a shortcut ~n for HEAD~n does not introduce new
> inconsistencies (it's a shortcut for a commit, for every command which
> takes a commit) - and does not contradict introducing -n at all, btw.

I thought we already ruled out ~n because many shells think ~n is a path.

> But introducing -n means introducing a range like revision argument to a
> command which does not grok ranges at all, so that is a much deeper
> decision.

I do not think so.

When I originally wrote format-patch and rebase, Linus was finishing up
making the "range notation" easier to use around rev-list (and later log).
It was not apparent to me that what these two commands operated were a
range, by deviating from the "log" syntax two commands could take their
operand in a more workflow-specific way (which in turn led to a shorter
keystrokes, as you only wrote only one endpoint because the other end was
implicit).

The original syntax of format-patch (which by the way is still supported)
is to give what we call the upstream these days, like this:

	git format-patch origin

which then is internally turned into a moral equivalent of

	git rev-list --no-merges origin..HEAD

to find out which commit to output (and run "git diff-tree -p --stdin"
on).  The command originally only accepted this short-hand form without
giving the users ways to affect underlying "range" any other way.  But
later we found that it is better allow users to use the "log" syntax, for
reasons including:

 - HEAD may not always be the topic you want to submit; and
 - you may not want to submit all commits since the fork point
   (i.e. endpoint might want to be HEAD~4 or mytopic~3).

The history behind "rebase" is pretty similar.  Again, with the original
syntax you give the "upstream":

	git rebase origin
	git rebase origin mytopic

and again these were internally turned into a moral equivalent of

	... optionally "git checkout mytopic" if given
	git rev-list --no-merges origin..HEAD

to find out which commit to replay on top of the updated base (this is a
natural consequence that the original "rebase" was "format-patch" piped
into "am").

"git rebase origin.." and "git rebase origin..mytopic" would be a way to
express this operation more naturally.  The former would rebase the
current branch, and the latter would checkout mytopic branch and rebase
it.

One extra reason (which does not apply to format-patch) that rebase wasn't
done that way was purely technical.  Back then, unless you are prepared to
parse these range arguments yourself, once you feed them to rev-parse
machinery, you wouldn't be able to tell if the user said "origin..mytopic"
or "origin..mytopic^0".  The former should rebuild mytopic branch while
the latter should leave mytopic branch intact and instead give you a
rebuilt history for mytopic branch on a detached HEAD.

I think these days the internal rev-parse machinery passes enough
information down add_pending_object() codepath (and in a scripted
Porcelain, you can say "rev-parse --symbolic origin..HEAD" to pry it
apart), so it should be possible to express what range "rebase" wants to
operate on in its natural notation that is used by the log family of
commands, if we wanted to.
