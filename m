From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/29] refname_is_safe(): insist that the refname already be normalized
Date: Wed, 27 Apr 2016 10:59:53 -0700
Message-ID: <xmqqinz39bl2.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:00:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTkn-0007G6-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbcD0R75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 13:59:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752636AbcD0R75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 13:59:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 91C3515A6E;
	Wed, 27 Apr 2016 13:59:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f1yKxVEdFyp+SHHX63n2XUhUPXg=; b=NMocNd
	ODx7Eoh66gn6NQz3f8nvBTMudLhqeuYDXgHUy4LDP8Vqt2g4DA3ynWMmLyO8MGiS
	VGWhofOG42ZKK92Nw6qxLAvXSlVbbtpm+ETom2Q0sk1H7c/xd5v3h4FZHe/pQdDI
	9ZRHZIA1C4sQBjxifteQZMOplBSq5uCB94QJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dSW1djlD5M+me9T13Kfe5P5WcT2k8ZAt
	6gyIPN35MOnGcOCbUaafDiyBCXN/Ypzzs827OBsrf/bktqMnTyDBj8m7kSirEtHF
	CoMJSPaPVzj9wATU7ffqX45lxQ/ZESFKZw94ku+NBuga/pe0KztsYR6vBhonI7yf
	CVWeZMNIVxc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 887E515A6D;
	Wed, 27 Apr 2016 13:59:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D235915A6B;
	Wed, 27 Apr 2016 13:59:54 -0400 (EDT)
In-Reply-To: <a8e1e1a9e6a48fbb20fab2144279b93a48db584a.1461768689.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Wed, 27 Apr 2016 18:57:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D8E28B28-0CA1-11E6-82B7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292777>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Does anybody have a use case for allowing un-normalized reference
> names like "refs/foo/../bar///baz"? I'm pretty certain they would not
> be handled correctly anyway, especially if they are not stored as
> loose references.

I wondered what codepath this follows:

    $ git rev-parse mhagger/wip//split-under-lock

get_sha1_basic() calls to dwim_ref() to learn real_ref and its
value.

dwim_ref() repeatedly gives the string to a known dwim rule, and the
"refs/remotes/%.*s" rule is expected to find that the user meant to
name "refs/remotes/mhagger/wip//split-under-lock".

This, still with doubled slash, is passed to resolve_ref_unsafe(),
which has a call to !refname_is_safe(refname) to reject the request.

So I think this will move the rejection early in the codepath than
how we reject the ref with doubled slash in the current code, but
the end result would be the same for this example.  The same is true
for heads//master or refs/heads//master.

There is another call to refname_is_safe() in resolve_ref_unsafe(),
which applies the sanity check to the string from a symref.  We seem
to allow

    $ git symbolic-ref refs/heads/SSS refs/heads//master

and we end up storing "ref: refs/heads//master" (or make a symbolic
link with doubled slashes), but the current code considers the
resulting symbolic link as "dangling".  Again, this change moves the
rejection a bit earlier in the codepath, without changing the end
result, I'd think.
