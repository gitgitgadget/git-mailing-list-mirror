From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make 'git request-pull' more strict about matching local/remote branches
Date: Wed, 22 Jan 2014 14:14:05 -0800
Message-ID: <xmqqwqhrwtoy.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 22 23:14:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W663x-0001H8-A7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbaAVWOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:14:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755989AbaAVWOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:14:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76FCE65852;
	Wed, 22 Jan 2014 17:14:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zx90GhtoIrzpuiNrNreI3/0rPVU=; b=nlOvQD
	4u5pGTt2tbdmuIkhJsewKCy2WN0Z7SU9MaWYpceiN2DFVYRBoXwFHotxLcFcq3QE
	ZOCSZUD1oiJXCZD9tC4gj1jGobw9MijPMtSWehv1KvN3mkA4eocDLHfaxmYrZB3m
	RcU/+AvLIc18NM9EyQEWAkYizwEhm3MmS3Uq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aQgJ+2t2Gt+pNga+x+3BgDMgQ3lIqych
	HJ9t75qO2OpwM4Khn3QJ5CbeIfEBox8Lt45FbhQkVRwl8KonHW7W+X6HU58/pNKf
	yU4/+l7KROclCFzwncM37Mmauyms2/aMWp3Y43/484nMm+ZWsO25ZzdONsfsGFeI
	01q3gDOzQiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46CB86584F;
	Wed, 22 Jan 2014 17:14:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEC286584B;
	Wed, 22 Jan 2014 17:14:09 -0500 (EST)
In-Reply-To: <alpine.LFD.2.11.1401221243090.18459@i7.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 22 Jan 2014 13:08:54 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8464D24C-83B2-11E3-AA7D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240867>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That may be very helpful if your local tree doesn't match the layout of 
> the remote branches, but for the common case it's been a recurring 
> disaster, when "request-pull" is done against a delayed remote update, and 
> it rewrites the target branch randomly to some other branch name that 
> happens to have the same expected SHA1 (or more commonly, leaves it 
> blank).

Thinking about this a bit more...

> Comments? It passes the tests I put it through locally, but I did *not* 
> make it pass the test-suite, since it very much does change the rules. 
> Some of the test suite code literally tests for the old completely broken 
> case (at least t5150, subtests 4 and 5).

I looked at 5150.4 and found that what it attempts to do is halfway
sensible.  The contributor works on the local 'master' branch,
publishes the result to 'for-linus' in its 'origin' repository, and
asks his state to be pulled, with:

	git push origin master:for-linus
        git request-pull initial origin

The contributor could be more explicit in his request-pull and say 

        git request-pull initial origin master

but there is no 'master' on the publishing repository in this case
(or even if there is, it does not match what is being pushed out),
and there is no 'for-linus' branch locally, so there is no way for
him to say

        git request-pull initial origin for-linus

unless he creates it locally first.

I am starting to wonder if it is a better fix to check potentially
ambiguous cases (e.g. the publishing repository does have 'master'
that does not point at the commit local 'master' points at, and
'for-linus' that points at the same commit, and the user asks for
'master' to be pulled) or clearly broken cases (e.g. the user gave
something other than HEAD explicitly from the command line, but we
ended up computing blank) and die loudly, without breaking cases
this test tries to protect.

On the other hand, I tend to think what 5150.5 wants is convoluted
and expects a broken behaviour.  Its publishing repository has
'master' and 'for-upstream', and also has 'tags/full' that is an
annotated tag that points at the commit, runs request-pull with its
local 'master', and expects the resulting message to ask 'tags/full'
to be pulled.  If the contributor wants such a non-commit to be
pulled, I think it should be made more explicit, i.e., not with

	git request-pull initial $origin_url

but with

	git request-pull initial $origin_url tags/full

or something.
