From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Multi-threaded 'git clone'
Date: Tue, 17 Feb 2015 15:32:48 -0800
Message-ID: <xmqqegpoxgf3.fsf@gitster.dls.corp.google.com>
References: <20150217052007.CC8B713FECF@smtp.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	David Lang <david@lang.hm>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNrdQ-0002bL-WC
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 00:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbbBQXcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 18:32:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964AbbBQXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 18:32:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D696E39C4D;
	Tue, 17 Feb 2015 18:32:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m/yLDDOV6ZY28IUyQtKGPNee2HU=; b=xK/TSh
	m+MapB1NwhyWEHc7ALdehhKst7Cqd3/nDmVmrF5F+lQDPkc1Chk2UtQFoXuJJfgd
	pXuy+Ibtf8pDjyzUB/FalXo3PoWlZEgQiPP8JEb1544xe5b8gvkug9KJ1YscjV5B
	9pgbBvvufNI6vMDwHoZ7LZ8zApwP+UpSQ4YqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RPh1PtK3VfcfXsBHO3sFC6RtbwthAOOA
	/jKHbPeYh9XgiTIXxdBREeTuLao+eLr7F7NvP/q5W4Z3rHECrGVafQBi5WEMJLkh
	UsQsZzczgjVp2CbGesFM5vjg1VFNoGJa/Y4rqXLiEonhHJSf7bTXhmuuAF/GgX9v
	dEnn4NOh8Gc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB98E39C4C;
	Tue, 17 Feb 2015 18:32:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2378639C49;
	Tue, 17 Feb 2015 18:32:50 -0500 (EST)
In-Reply-To: <20150217052007.CC8B713FECF@smtp.codeaurora.org> (Martin Fick's
	message of "Mon, 16 Feb 2015 22:20:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4959EA14-B6FD-11E4-B4B4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264000>

Martin Fick <mfick@codeaurora.org> writes:

> Sorry for the long winded rant. I suspect that some variation of all
> my suggestions have already been suggested, but maybe they will
> rekindle some older, now useful thoughts, or inspire some new ones.
> And maybe some of these are better to pursue then more parallelism?

We avoid doing a grand design document without having some prototype
implementation, but I think the limitation of the current protocol
has become apparent enough that we should do something about it, and
we should do it in a way that different implementations of Git can
all implement.

I think "multi-threaded clone" is a wrong title for this discussion,
in that the user does not care if it is done by multi-threading the
current logic or in any other way.  The user just wants a faster
clone.

In addition, the current "fetch" protocol has the following problems
that limit us:

 - It is not easy to make it resumable, because we recompute every
   time.  This is especially problematic for the initial fetch aka
   "clone" as we will be talking about a large transfer [*1*].

 - The protocol extension has a fairly low length limit [*2*].

 - Because the protocol exchange starts by the server side
   advertising all its refs, even when the fetcher is interested in
   a single ref, the initial overhead is nontrivial, especially when
   you are doing a small incremental update.  The worst case is an
   auto-builder that polls every five minutes, even when there is no
   new commits to be fetched [*3*].

 - Because we recompute every time, taking into account of what the
   fetcher has, in addition to what the fetcher obtained earlier
   from us in order to reduce the transferred bytes, the payload for
   incremental updates become tailor-made for each fetch and cannot
   be easily reused [*4*].

I'd like to see a new protocol that lets us overcome the above
limitations (did I miss others? I am sure people can help here)
sometime this year.



[Footnotes]

*1* The "first fetch this bundle from elsewhere and then come back
    here for incremental updates" raised earlier in this thread may
    be a way to alleviate this, as the large bundle can be served
    from a static file.

*2* An earlier "this symbolic ref points at that concrete ref"
    attempt failed because of this and we only talk about HEAD.

*3* A new "fetch" protocol must avoid this "one side blindly gives a
    large message as the first thing".  I have been toying with the
    idea of making the fetcher talk first, by declaring "I am
    interested in your refs that match refs/heads/* or refs/tags/*,
    and I have a superset of objects that are reachable from the
    set of refs' values X you gave me earlier", where X is a small
    token generated by hashing the output from "git ls-remote $there
    refs/heads/* refs/tags/*".  In the best case where the server
    understands what X is and has a cached pack data, it can then
    send:

    - differences in the refs that match the wildcards (e.g. "Back
      then at X I did not have refs/heads/next but now I do and it
      points at this commit.  My refs/heads/master is now at that
      commit.  I no longer have refs/heads/pu.  Everything else in
      the refs/ hierarchy you are interested in is the same as state
      X").

    - The new name of the state Y (again, the hashed value of the
      output from "git ls-remote $there refs/heads/* refs/tags/*")
      to make sure the above differences can be verified at the
      receiving end.

    - the cached pack data that contains all necessary objects
      between X and Y.

    Note that the above would work if and only if we accept that it
    is OK to send objects between the remote tracking branches the
    fetcher has (i.e. the objects it last fetched from the server)
    and the current tips of branches the server has, without
    optimizing by taking into account that some commits in that set
    may have already been obtained by the fetcher from a
    third-party.

    If the server does not recognize state X (after all it is just a
    SHA-1 hash value, so the server cannot recreate the set of refs
    and their values from it unless it remembers), the exchange
    would have to degenerate to the traditional transfer.

    The server would want to recognize the result of hashing an
    empty string, though.  The fetcher is saying "I have nothing"
    in that case.


*4* The scheme in *3* can be extended to bring the fetcher
    step-wise.  If the server's state was X when the fetcher last
    contacted it, and since then the server received multiple pushes
    and has two snapshots of states, Y and Z, then the exchange may
    go like this:

    fetcher: I am interested in refs/heads/* and refs/tags/* and I
             have your state X.

    server:  Here is the incremental difference to the refs and the
             end result should hash to Y.  Here comes the pack data
             to bring you up to date.

    fetcher: (after receiving, unpacking and updating the
             remote-tracking refs) Thanks.  Do you have more?

    server:  Yes, here is the incremental difference to the refs and the
             end result should hash to Z.  Here comes the pack data
             to bring you up to date.

    fetcher: (after receiving, unpacking and updating the
             remote-tracking refs) Thanks.  Do you have more?

    server:  No, you are now fully up to date with me.  Bye.


    
