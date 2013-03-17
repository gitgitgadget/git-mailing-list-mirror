From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pack-refs: add fully-peeled trait
Date: Sat, 16 Mar 2013 22:50:17 -0700
Message-ID: <7vvc8qshgm.fsf@alter.siamese.dyndns.org>
References: <20130316090018.GA26708@sigill.intra.peff.net>
 <20130316090116.GB26855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:50:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6Ua-0001M2-HI
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab3CQFuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 01:50:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab3CQFuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 01:50:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B912E9CBC;
	Sun, 17 Mar 2013 01:50:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kCbycfSEnu5klREqnK8X3HouOw=; b=Y8fiBE
	IRKAccO5KlZMd0r/CPkw/s7vB356wQi22HyVhDuVGqJ0JcJR1VSwF1GQupxY6//Z
	xrCj1VtVFG95lj/xUOOTKsO7BVzhss07wSiUzvcbHa1N589x4yRIsIdqnd9XgV4g
	uM6VlJX6rgfk0+pOxklf3hcYLXtFuANuh1glE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=plR6DAlZSC45VgyqUw8ITG/5L2qMG3Da
	TqbPhXK5QlTPboicQhpkInImf+5rALqyLIW0H8/uaaW4+6rVBUTKdc1AX6ThrCzf
	GyOm+GVQkx52XFFazy6XfuBjEQdg9Zh0bCOIugnyUqMVvk6k31GQREJa/yc/Jw0r
	cKKlj8A6xAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C589CBB;
	Sun, 17 Mar 2013 01:50:20 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 089B59CBA; Sun, 17 Mar 2013
 01:50:18 -0400 (EDT)
In-Reply-To: <20130316090116.GB26855@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 16 Mar 2013 05:01:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D561F14-8EC6-11E2-A813-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218335>

Jeff King <peff@peff.net> writes:

> The simplest fix would be to always unset the
> REF_KNOWS_PEELED flag for refs outside of refs/tags that do
> not have a peel line (if it has a peel line, we know it is
> valid, but we cannot assume a missing peel line means
> anything). But that loses an important optimization, as
> upload-pack should not need to load the object pointed to by
> refs/heads/foo to determine that it is not a tag.

I think the patch makes sense and in line with what we already
discussed in the thread.

I however wonder if the above implies it may make sense to add this
on top?  Perhaps it is not worth it, because it makes a difference
only to a repository with annotated tags outside refs/tags hierarchy
and still has the packed-refs file that was created with an older
version of Git, so we can just tell "repack with new Git" to users
with such a repository.

 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 7f84efd..afc4dde 100644
--- a/refs.c
+++ b/refs.c
@@ -847,8 +847,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		    refline[0] == '^' &&
 		    strlen(refline) == 42 &&
 		    refline[41] == '\n' &&
-		    !get_sha1_hex(refline + 1, sha1))
+		    !get_sha1_hex(refline + 1, sha1)) {
 			hashcpy(last->u.value.peeled, sha1);
+			last->flag |= REF_KNOWS_PEELED;
+		}
 	}
 }
 
