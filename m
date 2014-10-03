From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] prune: keep objects reachable from recent objects
Date: Fri, 03 Oct 2014 14:47:57 -0700
Message-ID: <xmqq1tqolt9u.fsf@gitster.dls.corp.google.com>
References: <20141003202045.GA15205@peff.net>
	<20141003203931.GM16293@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 03 23:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaAht-00012p-OT
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 23:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbaJCVsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 17:48:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59715 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbaJCVsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 17:48:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C94140ED7;
	Fri,  3 Oct 2014 17:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ILuePTsrgIQwB+id6c9p8HQUMWc=; b=qCNzmB
	sfSKmZKPogw4HglxvBUkAdMvzOxwN0JaovU7NYAIJe72Zx4U3nvxBnK4ctQd7AAe
	Eqy7PDiKYFG13RVjL40KwY7JnhjIl6tebvs906Bd2yIJYFP64y6AF6rRVbPuYhcF
	8DfllZAfExz69Bi48M2SuCtN7F2/vFGTO0Xvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hercR4ymAkh6q8O5eRvOFKERueFEzGci
	AYmxGR/9EzTlLC4xn4UMSyFdTMwJom2yoXA23v/Q9hU9N9F7lFquY71aEMzJc06Z
	OTc8ufDGvVAIZxgVGmXFdNcxrey6LO1JAUeJ8qE59uUQCN5QneS54LpDSSFHlrNz
	9u2jK1fk8gY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 432DF40ED6;
	Fri,  3 Oct 2014 17:47:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C39C240ED5;
	Fri,  3 Oct 2014 17:47:58 -0400 (EDT)
In-Reply-To: <20141003203931.GM16293@peff.net> (Jeff King's message of "Fri, 3
	Oct 2014 16:39:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0D31AE0-4B46-11E4-B2DB-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257872>

Jeff King <peff@peff.net> writes:

> Instead, this patch pushes the extra work onto prune, which
> runs less frequently (and has to look at the whole object
> graph anyway). It creates a new category of objects: objects
> which are not recent, but which are reachable from a recent
> object. We do not prune these objects, just like the
> reachable and recent ones.
>
> This lets us avoid the recursive check above, because if we
> have an object, even if it is unreachable, we should have
> its referent:
>
>   - if we are creating new objects, then we cannot create
>     the parent object without having the child
>
>   - and if we are pruning objects, will not prune the child
>     if we are keeping the parent

Sorry but this part is beyond a simple panda brain.

I can understand this

	If we have an object, even if it is unreachable, we
	should have its referent.
        
as a description of the desired behaviour.  If we have a tree that
is unreachable, we must make sure that we do not discard blobs that
are reachable from that tree, or we would end up corrupting our
repository if we ever allow that tree to become reachable from our
refs later.

But how does that connect to these two bullet points?

>   - if we are creating new objects, then we cannot create
>     the parent object without having the child

We cannot create the parent (e.g. "tree") without having the child
(e.g. "blob that is referred to by the tree we are creating").
So this bullet point is repeating the same thing?

>   - and if we are pruning objects, will not prune the child
>     if we are keeping the parent

We will not prune "blob" that are reachable from a "tree" that we
are not yet ready to prune.  So this again is repeating the same
thing?

But these are "this is how we want our system to behave".  And if we
assume our system behaves like so, then prune would be safe.

But it is unclear how that behaviour is realized.  Puzzled...

... goes and thinks ...

With this patch applied, the system will not prune unreachable old
objects that are reachable from a recent object (the recent object
itself may or may not be reachable but that does not make any
difference).  And that is sufficient to ensure the integrity of the
repository even if you allow new objects to be created reusing any
of these unreachable objects that are left behind by prune, because
the reachability check done during prune (with this patch applied)
makes sure any object left in the repository can safely be used as a
starting point of connectivity traversal.

Ok, I think I got it now, but then do we still need to utime(2) the
loose object files for unreachable objects that are referenced by
a recent object (which is done in a later patch), or is that purely
an optimization for the next round of gc where you would have more
recent objects (i.e. you do not have to traverse to find out an old
one is reachable from a new one, as there will be fewer old ones)?
