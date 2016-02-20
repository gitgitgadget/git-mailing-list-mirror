From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Fri, 19 Feb 2016 16:11:55 -0800
Message-ID: <xmqqvb5k9r5g.fsf@gitster.mtv.corp.google.com>
References: <1455908253-1136-1-git-send-email-sbeller@google.com>
	<xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOQTGEY6akKgz695nPdG4cG4SsYKLcJkKr1im+RQjK5A@mail.gmail.com>
	<xmqqbn7cbahb.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaL8T72Fcy1kzuRrYagX9biRTscA4q=xBc7JaUXv5msVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Dave Borowitz <dborowitz@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 01:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWv9X-0002Vs-83
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 01:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426516AbcBTAL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 19:11:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1424220AbcBTAL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 19:11:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C37146579;
	Fri, 19 Feb 2016 19:11:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zQNPPfuDtZd+YUofCRvZt7qCNx8=; b=eeHevJ
	+1yzEx5jBq4xAShz7G4YLKg1S46ku4LGHd+RoXK2JTc3RSX6Se6Wst6UEHRrHvci
	5Iy4pOjBXBYfzAHZbgM7Tq3hdl+nLnXCqEeWbjD+qCpqycOmbLK6Vr7Ca5si8uc5
	MnHYt9Ajty1TB34wXp0OgW7KNyyaeAq7OEMuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0Js9Hhg/g74UaPmIxFxMbaL9J+hQ8j0
	6lKzxk9NK9y4pIoSzmpP1xRhF/KpePDoQy2Q3HtPwqcY9VOKGwZKxrbxqXkJjYBF
	IFWSNmWXNG/WNKt3ffL8SLCR9nzUn8nlny5pVcsukZgE2M8+aN0xPzEgRbzacldt
	hu58cc7E6WY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 324B946578;
	Fri, 19 Feb 2016 19:11:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A669E46577;
	Fri, 19 Feb 2016 19:11:56 -0500 (EST)
In-Reply-To: <CAGZ79kaL8T72Fcy1kzuRrYagX9biRTscA4q=xBc7JaUXv5msVg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 19 Feb 2016 15:40:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D9957B6-D766-11E5-9603-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286762>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 19, 2016 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Doing a 'git fetch' only and not the fetch for the specific sha1 would be
>>> incorrect?
>>
>> I thought that was what you are attempting to address.
>
> Yep. In an ideal world I would imagine it would look like
>
>     if $sha1 doesn't exist:
>         fetch $sha1
>         if server did not support fetching direct sha1:
>             fallback to fetch <no args>

It should look more like this:

	if $sha1's history and objects are incomplete:
		fetch ;# normally just like we have done before
                if $sha1's history and objects are still incomplete:
			fetch $sha1

as existing users already expect that commits and objects that are
reachable from tips of refs configured to be fetched in the
submodule via its configured refspecs are available after this part
of the code runs, regardless of this "Gerrit reviews may not have
arrived to branches yet" issue.  The first "normal" fetch ensures
that the expectation is met.

> Would it make sense in case of broken histories to not fetch
> (specially if the user asked to not fetch) and rather repair by
> making it a shallow repository?

Commits whose ancestors, trees and/or blobs are incomplete can and
do exist in a perfectly healthy repository and there is no breakage
in the history as long as such commits are not reachable from any of
the refs.

You can for example make a small fetch from 'pu' today, that results
in unpack-objects to be run instead of index-pack, and then make
another fetch from 'pu', making these loose objects unreachable from
anywhere.  Maybe there were 5 commits worth of objects in the
original transfer, and the objects necessary for the bottom 2 were
pruned away while the tip one still in the repository [*1*].

"cat-file -e" may find that the tip commit is there, but "rev-list
--objects $oldtip --not --all" will find that the old tip of pu that
is left behind is incomplete and cannot be safely used (e.g. "git
log -p" would fail).  The "$sha1's history and objects are
incomplete" check aka "quickfetch()" test is a way to avoid getting
fooled by an object that passes "cat-file -e" test.

I am not sure if it is feasible, given such an island of commits and
associated objects, to craft a proper "shallow" boundary after the
fact.  It should be doable with extra code, but I do not think there
is a canned support at the plumbing level (you can obviously
construct it with "cat-file -e" and following the inter object links
yourself).

This "fetch" is in a cmd_update() codepath, whose purpose is "Update
each submodule path to correct revision, using clone and checkout as
needed", so I am not sure "to not fetch, specically if the user
asked to not fetch" makes much sense in the first place.


[Footnote]

*1* A canonical example used to be a commit walker that fetches from
    the tip of a branch that is ahead of us by 5 commits, gets
    killed after fetching and storing the tip commit object and some
    of its trees and blobs, and before successfully fetching and
    storing all the necessary objects, e.g. the parent commits and
    its trees and blobs.  That would leave a disconnected island of
    objects that are not anchored by any ref.
