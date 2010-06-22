From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Mon, 21 Jun 2010 21:04:31 -0700
Message-ID: <7vmxung1bk.fsf@alter.siamese.dyndns.org>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006211219.02911.johan@herland.net>
 <7vlja8if5r.fsf@alter.siamese.dyndns.org>
 <201006220035.31166.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 22 06:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQujD-0005l4-W0
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 06:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876Ab0FVEEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 00:04:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0FVEEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 00:04:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AC7BE472;
	Tue, 22 Jun 2010 00:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=SJiX8+7yWHd12oslGLUAKyhZDMc=; b=fKA/yl+/JSm4SFmSO7CWs5O
	wFp/hBK74ajds7hnqWTb0Mt5YiJG2iN2m+PykOk8kEPtPJEnPQtqQ7FNunSR1N3G
	uj0wXEzFdXlkfh/aOIWlPugqeFHTu9mx2E4FvIqWmeUGZup1ogV7MnrWrV/ezwjK
	RrdmDoWK26Xf4VdTU6VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ugLVNawUEfTJAPLN0dh8+X8pryhnqILlELMExGszbMN/4fkDO
	if9heIVLjBlL+MasJGQCjpMjtWOu9awSvg4viF/83T7I5+R8+IVqfjyzF2RV+5DU
	J9gYphOD6TKDX/IN5oUaHEVXe0nYTUNK4Ma8GJQ2WnNQc4xfn2ZmYoUmrQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 033CCBE470;
	Tue, 22 Jun 2010 00:04:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E391BE46B; Tue, 22 Jun
 2010 00:04:32 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4680A2FC-7DB3-11DF-8141-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149463>

Johan Herland <johan@herland.net> writes:

> True, but as I've argued above, I'm not sure that adding another setting 
> (aka. .merge_branch) for this special/limited kind of branch tracking is 
> worth it.

I don't think .merge_branch is necessary nor even desired.  In fact, I
think your use of .branch, especially in the variant that does not have
any submodule entry in the superproject tree, of your version (B) does not
have conceptual advantage.  You checkout the superproject first (which
would be the natural thing to do, as you may get update to its .gitmodules
there), and checkout the then-tip of the named branch of the submodule,
you would immediately get a stale checkout when you then go fetch the
updates to the submodule.

And the worst part is that you wouldn't even _notice_ that your checkout
is stale, as there is no record in the superproject which commit you were
supposed to be using to be consistent with the version the committer of
the superproject commit used to record it.

I on the other hand think what you called "hybrid" makes sense (and I
don't even think it is hybrid but rather is a natural way to do this).
With the submodule.*.branch entry, you can:

 - make sure that your checkout is consistent; if your submodule checks
   out a different commit or branch from what the superproject records in
   its tree or in its .gitmodules (e.g. you forgot to update the submodule
   when you switched superproject branch), git can notice the situation
   and can help you implement policy decisions;

 - record a commit that is different from the tip of the submodule branch
   when making a superproject commit; git can notice the situation and can
   help you implement policy decisions (e.g. you could choose to reject
   and tell the user to advance the submodule branch first before making
   the commit in the superproject);

 - use it as an advisory "existing merge commit selector", as discussed in
   this thread.

Thinking about what would happen in your (B) that doesn't record the exact
commit, I think that it doesn't have any advantage over the "hybrid" one.
The "hybrid" one can help you to make sure that what you commit in the
superproject's .gitmodules and submodule's branch tip are kept consistent.
When they are kept consistent, then switching branches in the superproject
should always flip between the tips of branches, no?
