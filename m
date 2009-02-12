From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Wed, 11 Feb 2009 19:26:12 -0500
Message-ID: <20090212002612.GC30231@coredump.intra.peff.net>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com> <1234332083-45147-2-git-send-email-jaysoffian@gmail.com> <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 01:27:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXPQb-0002Hh-K9
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 01:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbZBLA0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 19:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794AbZBLA0O
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 19:26:14 -0500
Received: from peff.net ([208.65.91.99]:33870 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755738AbZBLA0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 19:26:14 -0500
Received: (qmail 4275 invoked by uid 107); 12 Feb 2009 00:26:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 19:26:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 19:26:12 -0500
Content-Disposition: inline
In-Reply-To: <1234332083-45147-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109550>

On Wed, Feb 11, 2009 at 01:01:22AM -0500, Jay Soffian wrote:

> +static char *get_head_name(const struct ref *ref)
> +{
> +	const struct ref *remote_head = NULL;
> +	const struct ref *remote_master = NULL;
> +	const struct ref *r;
> +	for (r = ref; r; r = r->next) {
> +		if (!strcmp(r->name, "HEAD"))
> +			remote_head = r;
> +		if (!strcmp(r->name, "refs/heads/master"))
> +			remote_master = r;
> +	}
> +
> +	/* If there's no HEAD value at all, never mind. */
> +	if (!remote_head)
> +		return NULL;
> +
> +	/* If refs/heads/master could be right, it is. */
> +	if (remote_master && !hashcmp(remote_master->old_sha1,
> +				      remote_head->old_sha1))
> +		return xstrdup(abbrev_branch(remote_master->name));
> +
> +	/* Look for another ref that points there */
> +	for (r = ref; r; r = r->next)
> +		if (r != remote_head &&
> +		    !hashcmp(r->old_sha1, remote_head->old_sha1) &&
> +		    !prefixcmp(r->name, "refs/heads/"))
> +			return xstrdup(abbrev_branch(r->name));
> +
> +	/* Nothing is the same */
> +	return NULL;
> +}

Yuck. Cut and paste from builtin-clone.c. It's not so much the number of
lines here (although of course I don't like that, either) but that this
function encompasses a heuristic for matching the HEAD. Which means it
may change in the future, and I really don't want the clone behavior and
the remote behavior to diverge.

So can we refactor it into a library function?

I see that the inputs and outputs aren't exactly the same in both cases,
but I think you could do it like:

  struct ref *guess_head_ref(const struct ref *refs_with_head,
                             const struct ref *refs_that_might_match_head,
                             struct ref **remote_head_p);

and then just call:

  r = guess_head_ref(refs, refs, NULL);
  states->head_name = r ? xstrdup(abbrev_branch(r->name)) : NULL;

from git-remote, which at least keeps the changeable parts all
contained.

-Peff
