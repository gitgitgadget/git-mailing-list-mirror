From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] peel_ref: check object type before loading
Date: Thu, 04 Oct 2012 13:41:40 -0700
Message-ID: <7vd30yx94r.fsf@alter.siamese.dyndns.org>
References: <20121004075609.GA1355@sigill.intra.peff.net>
 <20121004080253.GC31325@sigill.intra.peff.net>
 <7vbogiys47.fsf@alter.siamese.dyndns.org>
 <20121004194150.GA13955@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:15:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtho-00033L-D8
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab2JDUlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:41:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701Ab2JDUln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:41:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA44F95FD;
	Thu,  4 Oct 2012 16:41:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tLYypnYbnI080ZN/vmPD2KXPj0w=; b=qMe7rh
	FwVRsHJx+fEIVlKXtccjO5yBkrpqWgJEtqD/ZTx2a0csohFEjy4dzUMal51IyvcK
	hg0ot5AG/9F4Zs/FDmF2+bQJ1BJ33gKlFZ7ZllySNmmrUQdLf/e82vqJUSFaG0iM
	ZXa2KyO+COtxSVbZp66PBIbpKif8+WfqCxKEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0j7d7YsQB3/0EUYSladp3aKCQAPmxS0
	cRN4NVaqu6lCm2dUCSW8n0dZAuspqQSZBVd55QvJIJN2sGksUkNmE4dK8T+bBYPK
	H7Uaewlst/u10X6ADuFruZSjZNYp9WpNSgOewl+NRSJQakI2/iOnhdLsfgwKnN7F
	tI5OsSUsuls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9774195FC;
	Thu,  4 Oct 2012 16:41:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC44F95F9; Thu,  4 Oct 2012
 16:41:41 -0400 (EDT)
In-Reply-To: <20121004194150.GA13955@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 15:41:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E730450C-0E63-11E2-B242-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207051>

Jeff King <peff@peff.net> writes:

> [1] One thing I've been toying is with "external alternates"; dumping
>     your large objects in some realtively slow data store (e.g., a
>     RESTful HTTP service). You could cache and cheaply query a list of
>     "sha1 / size / type" for each object from the store, but getting the
>     actual objects would be much more expensive. But again, it would
>     depend on whether you would actually have such a store directly
>     accessible by a ref.

Yeah, that actually has been another thing we were discussing
locally, without coming to something concrete enough to present to
the list.

The basic idea is to mark such paths with attributes, and use a
variant of smudge/clean filter that is _not_ a filter (as we do not
want to have the interface to this external helper to be "we feed
the whole big blob to you").  Instead, these smudgex/cleanx things
work on a pathname.

 - Your in-tree objects store a blob that records a description of
   the large thing.  Call such a blob a surrogate.  "clone", "fetch"
   and "push" all deal only with surrogates so your in-history data
   will stay small.

 - When checking out, the attributes mechanism kicks in and runs the
   "not filter" variant of smudge with the data in the surrogate.

   The surrogate records how to get the real thing from where, and
   how to validate what you got is correct.  A hand-wavy example may
   look like this:

   	get: download http://cdn.example.com/67def20
        sha1sum: f84667def209e4a84e37e8488a08e9eca3f208c1

   to tell you to download a single URL with whatever means suitable
   for your platform (perhaps curl or wget), and verify the result
   by running sha1sum.  Or it may involve

	get: git-fetch git://git.example.com/images.git/ master
        object: 85a094f22f02c54c740448f6716da608a5e89a80

   to tell you to "git fetch" from the given git-reachable resource
   into some place and grab the object via "git cat-file", possibly
   streaming it out.  The details do not matter at this point in the
   design process.

   The smudgex helper is responsible for caching previously fetched
   large contents, maintaining association between the surrogate
   blob and its real data, so that once the real thing is
   downloaded, and the contents of the path needs to change to
   something else (e.g. user checks out a different branch) and
   then change to the previous thing again (e.g. user comes back to
   the original branch), it does not download it again.

 - When checking if the working tree is clean relative to the index,
   the smudgex/cleanx helper will be consulted.  It will be given
   the surrogate data in the index and the path in the working tree.
   We may want to allow the helper implementation to give a read-only
   hardlink directly into helper's cache storage, so that it can
   consult its database of surrogate-to-real mapping and perform
   this verification cheaply by inode comparison, or something.

 - When running "git add" a modified large stuff prepared in the
   working tree, cleanx helper is called to prepare a new surrogate,
   and that is what is registered in the index.  The helper is also
   responsible for storing the new large stuff away and arrange it
   to be retrievable when others see and use this surrogate.

The initial scope of supporting something like that in core-git
would be to add the necessary infrastracture to arrange such smudgex
and cleanx helpers are called when a path is marked as a surrogate
in the attribute system, and supply a sample helper.
