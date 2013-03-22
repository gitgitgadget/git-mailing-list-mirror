From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] remote.c: introduce branch.<name>.pushremote
Date: Fri, 22 Mar 2013 10:37:46 -0700
Message-ID: <7vppyr72tx.fsf@alter.siamese.dyndns.org>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 18:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ5uz-0006Nd-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 18:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660Ab3CVRhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 13:37:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422640Ab3CVRht (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 13:37:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF9CA532;
	Fri, 22 Mar 2013 13:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3cIY+xwAlKeJX7D4j+3L6oMc5E8=; b=nrkHWV
	YEsNMyDnZapv0puG3T4s+S8MJk4aMBcj+UMzArHWnzgN7d78dpkcBAep+raU7lOR
	nvVlctLYAvYtx9JLhV/xNg9/PXFYsHAhRB6a18zyCAENNl79J+v7WUgo4AfgAUP8
	liwmfBihS7gB7N0PTWnOZRj9K7nQnnp+TgRzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJgLXfh8lLDOSQRFJ2LQPLFnvqlAkjmc
	WND7ZNFnLtCP/lsUSH6nPV3QOP5smMEfAFuAf3weaJ5xWg5DJkrMFk4tRMI8Lw3o
	nAGsGLTGKj7IceEI/pv7awaXW+KtFEE1pyazj0T2n/dLCssscGbv71Xp+urk47Ka
	GNiLdlDv758=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53258A531;
	Fri, 22 Mar 2013 13:37:48 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3369A52B; Fri, 22 Mar 2013
 13:37:47 -0400 (EDT)
In-Reply-To: <1363938756-13722-7-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 22 Mar 2013 13:22:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3633A13E-9317-11E2-B7E8-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218826>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This new configuration variable overrides `remote.pushdefault` and
> `branch.<name>.remote` for pushes.  In a typical triangular-workflow
> setup, you would want to set `remote.pushdefault` to specify the
> remote to push to for all branches, and use this option to override it
> for a specific branch.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/config.txt | 18 ++++++++++++++----
>  remote.c                 |  4 ++++
>  t/t5516-fetch-push.sh    | 15 +++++++++++++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 09a8294..6595cd6 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -726,9 +726,18 @@ branch.<name>.remote::
>  	When on branch <name>, it tells 'git fetch' and 'git push'
>  	which remote to fetch from/push to.  The remote to push to
>  	may be overridden with `remote.pushdefault` (for all branches).
> -	If no remote is configured, or if you are not on any branch,
> -	it defaults to `origin` for fetching and `remote.pushdefault`
> -	for pushing.
> +	The remote to push to, for the current branch, may be further
> +	overridden by `branch.<name>.pushremote`.  If no remote is
> +	configured, or if you are not on any branch, it defaults to
> +	`origin` for fetching and `remote.pushdefault` for pushing.

Nice write-up. It may be easier to read if the new text is in a
separate paragraph, though.

> +branch.<name>.pushremote::
> +	When on branch <name>, it overrides `branch.<name>.remote`
> +	when pushing.  It also overrides `remote.pushdefault` when
> +	pushing from branch <name>.

Perhaps s/when pushing/for pushing/; Or "Specify what remote to push
to when on branch <name>, overriding `branch.<name>.remote` and
`remote.pushdefault`."

> +	In a typical triangular-workflow
> +	setup,...

Is there an "atypical triangular-workflow"?  Drop "typical" and
explain what you mean by triangular, perhaps like

	When you pull from one place (e.g. your upstream) and push
	to another place (e.g. your own publishing repository),

Then the rest of the text flows more naturally without ever
introducing a new lingo "triangular" that is not in glossary.

> +	... you would want to set `remote.pushdefault` to specify
> +	the remote to push to for all branches, and use this option to
> +	override it for a specific branch.
