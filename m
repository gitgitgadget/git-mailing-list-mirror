From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 12:12:40 -0700
Message-ID: <7vsj1c8a53.fsf@alter.siamese.dyndns.org>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
	<1369321970-7759-8-git-send-email-artagnon@gmail.com>
	<CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
	<CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com>
	<CACsJy8AHX0181uON5Aa7oJzX8j3qAA26Ymh5G3YEGidD4O5zvA@mail.gmail.com>
	<CALkWK0=LXNRaWz0vN_FwmJKbXT+W11mHABqzSJnbm_izQ0Ttrw@mail.gmail.com>
	<7vehcw9s0k.fsf@alter.siamese.dyndns.org>
	<CALkWK0mmJE3Q2WU3pmhWdcrxv=jFXb8oVhPCRW+Zc6yLdDmfUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 21:12:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfxQ0-0006RA-L7
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 21:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab3EXTMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 15:12:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935Ab3EXTMn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 15:12:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2344B1F074;
	Fri, 24 May 2013 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mch9yW0BjBlGsdCs6pPX00WJj38=; b=HDLXgp
	VuNGO4ZkVEcs8Wd3iXvIckluiWWP9RhAtwDio8lP1+JjIyHukSf5BU0mkpbZo94m
	9IxlRSYd4eU1VZTKArXyZD/NPJsAMQIJOPzsfsa5AdjTdWdmxPIdIlWEYSTBAw/z
	SgOUfTn/igOl+24hQXDYPnsSVeVL6LrWvi/Xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cNRGf82af30KPDxFcyuMtXH93hP1TgNE
	V5kv+NIlxKdmFM6JHXJ2acirdexVtDy/6886FWCyE9xfnjtwEiXLlPqRoxJHNgNn
	7CBhEM+p6fFjiNzBTGNpmvgOOlVPxMyyJwgUZ5FfQwK0z6oSZSuD1ejiEaJ/pGKl
	M2bW8N0Yy9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18E721F073;
	Fri, 24 May 2013 19:12:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20BD51F070;
	Fri, 24 May 2013 19:12:42 +0000 (UTC)
In-Reply-To: <CALkWK0mmJE3Q2WU3pmhWdcrxv=jFXb8oVhPCRW+Zc6yLdDmfUg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 24 May 2013 23:51:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E85A774C-C4A5-11E2-98BA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225396>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>>> rev-parse (with an option, maybe) may be a better place for
>>>> this.
>>>
>>> Er, no.  I actually want things like diff @{p}..HEAD.  I want it to be
>>> a first-class revision, just like @{u}.
>>
>> I think Duy's suggestion makes perfect sense; rev-parse already has
>> a mechanism to expand @{u} to the full name, so if you are hooking
>> into the same codepath as @{u} to implement the "I publish there"
>> information, which I think you should, you already should have it
>> for free.
>
> *scratches head*
>
> Okay, I'm not understanding this.
> ...  How do I get "I publish
> there" information for free?

That is not what I said.

Let's step back a bit and think what it means that @{u} can be used
to name "The latest, as best of my knowledge, of the possibly moving
ref that my work is based on".  You can do so by

 (1) having a ref that points at such commit and having a mechanism
     to keep the ref up to date;

 (2) having a mechansim to turn @{u} to such a ref; and

 (3) letting get_sha1() machinery to read from that ref when an
     object name is needed for @{u}.

None of the above is what rev-parse does, but because you have (2),
rev-parse --symbolic-full-name can just ask (2) for a refname.

That is what I meant by "for free", and "which I think you should"
refers to all of these three things you would do to keep track of
"The latest, as best of my knowledge, of the possibly moving ref
that points at the commit I pushed the last time" for your @{p} in a
way similar to how @{u} works.

If I understand correctly the discussion so far, for a given branch
B, "git push" (no arguments to specify to which repository to push
nor what branch to update) would decide what the user did not say by
looking at:

    - branch.B.pushremote (and using remote.pushdefault and
      branch.B.remote as fallbacks) to find what repository R to
      push to;

    - branch.B.push (or mapping B through remote.R.push refspecs as
      a fallback logic) to find what destination branch D at R is
      updated by B.

Then after "git push" succeeds, it would look at remote.R.fetch
refspecs to pretend as if we fetched immediately from R, which is
how we keep track of the "last pushed" state, which is (1) of the
necessary three.

It follows that for B@{p} to be "The last pushed" for B, it has to
resolve to a remote tracking branch for D from R.  That (i.e. find R
and D and then map it through R's fetch refspec) is the logic we
need for (2).  That is very similar for B@{u}, which should be to
find the repository O it comes from by looking at branch.B.remote
(or 'origin'), and then where branch.B.merge from O is stored in our
ref namespace (e.g. refs/remotes/origin/topic) by mapping it through
the remote.O.fetch refspec.

Once you have (2), the implementation of (3) is quite obvious.  We
know where in the codeflow @{u} is turned into a ref; we can do the
same for @{p} by calling the logic (2) from the same place to turn
@{p} into a ref.

It is worth noting that @{p} has one error case that @{u} does not,
whose only error case is essentially that the branch you are asking
for @{u} does not have "upstream" configured.

For "git push" to work, you only need to be able to compute R and D
for B.  But R does not necessarily need to have fetch refspec for a
triangular pushing to work, hence we may not be recording what we
pushed the last time, violating (1), which in turn means (2) may not
have an answer.
