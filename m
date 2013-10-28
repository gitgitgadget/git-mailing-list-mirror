From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fetch: tag following too ambitious?
Date: Mon, 28 Oct 2013 09:34:19 -0700
Message-ID: <xmqq1u35gxro.fsf@gitster.dls.corp.google.com>
References: <526E5BBB.6080306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 28 17:34:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vapm7-0003Og-6h
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 17:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757273Ab3J1Qei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 12:34:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756591Ab3J1QeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 12:34:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C96594E2CA;
	Mon, 28 Oct 2013 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrClUjWvXBdkGIoGnyX360DN4J4=; b=NSwOJy
	46yejYGQ2FNiTGlK+deI2Gj4FeX3qdIFBrTKMAocOpVjPanaCA08yYu3PObJbuUW
	YJgEBq0daySffuq0TGe/Jm8ARZDiO0kXTiCGnLlyJZsS6VTXzyxGKk//Zz9DwOgM
	MJhjtLPqctARqkgAYNw0UBQbe3yFUQCfvmpoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lCkc1CPS6VJKSPk/NyQEs7R7jnSb3rtH
	IjCAYr77FvJP3zlqtdI2ERXXZ120Y08dxXWvgGFYX5L19fHr1BIHZfOEkWlZOSq+
	a+G17a3Lyi5lLVa4eY+jp0XYEd7OTVY/AczGOJwlZVMRiQITPegcyFW3nZeN+5Lo
	KC3eAFw9ux4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79964E2C9;
	Mon, 28 Oct 2013 16:34:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 129F44E2C7;
	Mon, 28 Oct 2013 16:34:21 +0000 (UTC)
In-Reply-To: <526E5BBB.6080306@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 28 Oct 2013 13:42:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CCBB42B8-3FEE-11E3-8A93-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236838>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> When investigating the exact semantics of tag-following, I discovered
> that the tag auto-following behavior of "git fetch" is more ambitious
> than I would have expected: it fetches any tag that references an object
> that is known to the local repository, *even if that object is not
> currently reachable* (i.e., neither reachable before the fetch or after
> the fetch of non-auto-followed references).  This makes it hard to
> renounce interest in a branch.
>
> Suppose there is a remote repo with
>
>     o---o---o        <- master
>      \
>       o---A---B      <- pu
>
> When I clone this repo, of course I get all of the commits and both
> branches.
>
> Now suppose I decide I'm not interested in "branch" anymore, so I delete
> its remote-tracking branch from my repository and change the config to
> only fetch "master":
>
>     git config remote.origin.fetch \
>             '+refs/heads/master:refs/remotes/origin/master'
>     git update-ref -d refs/remotes/origin/pu
>
> It looks like I'm free of the "pu" branch, right?
>
> But if a week later somebody pushes a tag "t" to origin that points at
> commit A, and then I do
>
>     git fetch origin
>
> then Git (un)helpfully fetches tag "t" into my repo, because even though
> commit "A" isn't reachable in my repo, it hasn't been pruned yet from
> the object database.
>
> I admit this is not likely to be a serious problem in practice, but I
> found it surprising and strangely disturbing.  I would call it a bug.

Sounds like a bug to me.  Does upload-pack to pack-object codepath
actually pack the tag object and give it to you, or is it done all
by reconnecting an existing and dangling tag back to your ref
namespace?
