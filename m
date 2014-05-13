From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: getbundle changed in mercurial 3.0
Date: Tue, 13 May 2014 13:33:30 -0700
Message-ID: <xmqqzjilmnad.fsf@gitster.dls.corp.google.com>
References: <1400008359-18267-1-git-send-email-1007380@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:33:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJOY-0001bA-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbaEMUdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:33:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54348 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbaEMUdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:33:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31BC61712F;
	Tue, 13 May 2014 16:33:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hi1ocNTtVHLQWqFdp8N5XN8w78I=; b=gd7OmJ
	T0UYBdqmL65/EFgAExBgllFthFslKkiqgVo+y1fK1XoyVgJk2E+HVFbNYh3Vh5fk
	zC/Tz38j43bPAzg9pYlOSplwcZEYwIX2oCL0NbxHmv2MtQIG9/oxs7NoCcM9Ce8A
	y7wPdjy4XmnWJfnMfJEpUuPzfY8ZG9MN3tgfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZYx6zL8VeknqY95bIt2DcWxPs235gtAe
	Ru+n/7C+KLpj5Ao37aY7dHJ57h3f7lmtwJ9O7H2cPYVsEf8gmmJRz0yLsdSZkFZJ
	vs9moyICzLEYwjJFsB6WznIs+JBKe9cGQQ+z4cO9j2D2SEclCi2VXJfLvqTi5EDJ
	vaAbxexFSIw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 283DA1712A;
	Tue, 13 May 2014 16:33:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E74EE170DF;
	Tue, 13 May 2014 16:33:31 -0400 (EDT)
In-Reply-To: <1400008359-18267-1-git-send-email-1007380@gmail.com> (William
	Giokas's message of "Tue, 13 May 2014 14:12:39 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D94CEEC0-DADD-11E3-8C37-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248822>

William Giokas <1007380@gmail.com> writes:

> In mercurial 3.0, getbundle was moved to the changegroup module, and
> gained a new argument. Due to this we cannot simply start using
> getbundle(...) imported from either one unconditionally, as that would
> cause errors in mercurial 3.0 without changing the syntax, and errors in
> mercurial <3.0 if we do change it.
>
> The try:except block at the beginning of git-remote-hg.py tries first to
> import mercurial.changegroup.getbundle, and if that fails we set the
> function 'getbundle' to work correctly with mercurial.repo.getbundle by
> removing the first argument.
>
> Signed-off-by: William Giokas <1007380@gmail.com>
> ---
>
> I have tested this briefly with mercurial 3.0, but have not yet really run
> through its paces. The tests that are included in next do pass with
> mercurial 3.0.
>
>  git-remote-hg.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-remote-hg.py b/git-remote-hg.py
> index 34cda02..3dc9e11 100755
> --- a/git-remote-hg.py
> +++ b/git-remote-hg.py
> @@ -14,6 +14,13 @@
>  
>  from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
>  
> +try:
> +    from mercurial.changegroup import getbundle
> +
> +except ImportError:
> +    def getbundle(__empty__, **kwargs):
> +        return repo.getbundle(**kwargs)
> +
>  import re
>  import sys
>  import os
> @@ -985,7 +992,7 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
>      if not checkheads(repo, remote, p_revs):
>          return None
>  
> -    cg = repo.getbundle('push', heads=list(p_revs), common=common)
> +    cg = getbundle(repo, 'push', heads=list(p_revs), common=common)
>  
>      unbundle = remote.capable('unbundle')
>      if unbundle:

Thanks.  I agree with you that this would probably be a better
way to future-proof the code without unconditionally including what
may not be used at all, as you said in the other thread.

I can be pursuaded to queue this particular patch for maintenance
tracks after 2.0 final to my tree, but I do not think I would want
to keep taking patches to this area myself in the longer run.

The way I envision the longer term shape of git-remote-hg.py in the
contrib/ is either one of these two:

 (1) manage it just like contrib/hooks/multimail/, keeping a
     reasonably fresh and known-to-be-good snapshot, while making it
     clear that my tree is not the authoritative copy people should
     work off of;

 (2) treat it just like contrib/emacs/vc-git.el, which found a
     better home and left my tree at 78513869 (emacs: Remove the no
     longer maintained vc-git package., 2009-02-07); or

The first one may be more preferrable between the two, if only
because distros would need time to adjust where they pick up the
source material to package up, but it still needs cooperation with
the "authoritative upstream" and this project to allow us to at
least learn when the good time to import such good snapshots.  In
the case of vc-git, the separation was not about lack of will to
coordinate, but because it was not necessary to keep it in my tree,
as the "better home" was where the users expect to find the latest
and greatest anyway.

If Felipe turns out to be a maintainer users do not trust for
remote-hg, it is possible that you and other people can maintain it
and work with git.git better by forking off of his tree.  It is far
early to know if that will be the case at this point, and I
personally do not think that will happen (no, I do not have a
concrete reason I can cite to explain why I think that way).

But even in such an extreme hypothetical case, the difference it
makes to my tree would only be to take (1) or (2) and point to that
forked remote-hg repository, instead of Felipe's, as the source of
the "authoritative copy".  And I wouldn't be taking individual
patches directly to my tree in either case.
