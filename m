From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: add archive.restrictRemote option
Date: Thu, 27 Feb 2014 10:37:30 -0800
Message-ID: <xmqqtxbkz9jp.fsf@gitster.dls.corp.google.com>
References: <20140227040504.GA2242@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 19:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ5q1-0005C6-Se
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 19:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbaB0Shh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 13:37:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbaB0Shg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 13:37:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5E2B6EE13;
	Thu, 27 Feb 2014 13:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6KBoIp2hWpEZjEx1Y/kcvtHlag=; b=YKr8oQ
	81DehcvoOJrv4bRBWdQNPmFFd/k5KG7q7RwJvzOhSOnW8Dltq5RaNLTA7cBBYmRe
	PIYB2jEHqtNJSuPp71Z3A2y+DDkgX40ss4d58G4McpMcQzSA8mIl8lROZR8BaLPL
	6f40uzaU+P4lXv/JbuVHymMQOMkGroCOBiyiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1MoVMEVOnNN9HlyAgNAvwNwnkjAmhNM
	x7nKgvi67nmuwhsNffMhGxpNH7MWrfU+I2on97TJR/rB6FfaUkwL8U37zhYsO7lE
	EIVedpHTmC1ByLJ2Nl1+/GWZyQ9nA5nDeFhgkI8JlfxAGmpd84SUL8sA77AG2kna
	eyehcOGK+lE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A35426EE12;
	Thu, 27 Feb 2014 13:37:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C65136EE11;
	Thu, 27 Feb 2014 13:37:32 -0500 (EST)
In-Reply-To: <20140227040504.GA2242@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 26 Feb 2014 23:05:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3859C0AE-9FDE-11E3-AD21-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242836>

Jeff King <peff@peff.net> writes:

> From: Scott J. Goldman <scottjg@github.com>
>
> In commit ee27ca4, we started restricting remote git-archive
> invocations to only accessing reachable commits. This
> matches what upload-pack allows, but does restrict some
> useful cases (e.g., HEAD:foo). We loosened this in 0f544ee,
> which allows `foo:bar` as long as `foo` is a ref tip.
> However, that still doesn't allow many useful things, like:
>
>   1. Commits accessible from a ref, like `foo^:bar`, which
>      is reachable
>
>   2. Arbitrary sha1s, even if they are reachable.
>
> We can do a full object-reachability check for these cases,
> but it can be quite expensive if the client has sent us the
> sha1 of a tree; we have to visit every sub-tree of every
> commit in the worst case.
>
> Let's instead give site admins an escape hatch, in case they
> prefer the more liberal behavior.  For many sites, the full
> object database is public anyway (e.g., if you allow dumb
> walker access), or the site admin may simply decide the
> security/convenience tradeoff is not worth it.
>
> This patch adds a new config option to turn off the
> restrictions added in ee27ca4. It defaults to on, meaning
> there is no change in behavior by default.
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks.

Do GitHub people have general aversion against signing off (or
sending out, for that matter) their own patches, unless they were
already active here before they joined GitHub, by the way?

I like the general idea and this escape hatch would be a good thing
to have.

A few comments:

 - Seeing the word combination "restrict"+"remote" before reading
   the explanation made me think "hmph, only allow remote archive
   from certain hosts but not from others?"  We are restricting the
   objects and only on the remote usage, not restricting remotes, so
   somebody else may be able to come up with a less misleading name.

 - It might be better to call the escape hatch "allow something"
   that defaults to "false".  It is merely the issue of perception,
   but having a knob to be limiting that defaults to true gives a
   wrong impression that in an ideal world remote archive ought to
   be loose and we are artificially limiting it by default.

But these are just my "reactions"; neither is an objection to the
posted patch as-is.

> ---
>  Documentation/git-archive.txt |  7 +++++++
>  archive.c                     | 13 +++++++++++--
>  t/t5000-tar-tree.sh           |  9 +++++++++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
> index b97aaab..486cb08 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -121,6 +121,13 @@ tar.<format>.remote::
>  	user-defined formats, but true for the "tar.gz" and "tgz"
>  	formats.
>  
> +archive.restrictRemote::
> +	If true, archives can only be requested by refnames. If false,

As this does not affect local use of "git archive", "requested by
refnames" may need to be clarified further.  Perhaps "remote
archives can be requested only for published refnames" or something.

Just to help starting further discussion to pick brains of others,
this paragraph could have been like this, I would think.

    archive.serveArbitraryObjectToRemote::

        By default, remote archives can be requested only for
        published refnames (e.g. "git archive --remote=origin
        master" is OK, but "git archive --remote=origin ae9677f" is
        not), to prevent peeking into unreachable commits that have
        been pruned from the repository.  This configuration
        variable can be set to bypass this security measure.

The phrase "serve arbitrary object to remote" would reflect the
purpose of the escape hatch better, I would think, but it is not a
great short-and-sweet name.

Thanks.
