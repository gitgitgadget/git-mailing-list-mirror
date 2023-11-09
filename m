Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521010F3
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="chmiXkN5"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B172684
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 17:23:48 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 923BB1C807B;
	Wed,  8 Nov 2023 20:23:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hba+39W8yIIn/MXEDEcgJ3HeTgA2TvlRnHkdPx
	9pGn0=; b=chmiXkN5w2LKDgMpgKwsM69035L2Vad0er5RuF3LOYUZZsSVcjyzH4
	2kMnJuyFt3rUMSrkhPq5GNIXHzRYSnsky2qFoF0iyAbZFWbzo4jBVRb+gxkq+ehU
	FU4HPi7SEtzvwEDx6jnzio1hFvi5P2L41TRiZv/TBEYmup4W/zruo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 887B11C807A;
	Wed,  8 Nov 2023 20:23:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB6AE1C8076;
	Wed,  8 Nov 2023 20:23:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Victoria Dye via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
In-Reply-To: <898d3850-b0ca-485e-9489-320eee3121e4@github.com> (Victoria Dye's
	message of "Wed, 8 Nov 2023 10:02:55 -0800")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
	<ZUoWWo7IEKsiSx-C@tanuki>
	<cf691b7c-288f-4cc9-a2ac-1a43972ae446@github.com>
	<xmqq4jhx7x8l.fsf@gitster.g>
	<898d3850-b0ca-485e-9489-320eee3121e4@github.com>
Date: Thu, 09 Nov 2023 10:23:45 +0900
Message-ID: <xmqqfs1f3eji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A12E517C-7E9E-11EE-94C1-25B3960A682E-77302942!pb-smtp2.pobox.com

Victoria Dye <vdye@github.com> writes:

> I'd certainly prefer that from a technical standpoint; it simplifies this
> patch if I can just replace 'get_tagged_oid' with 'peel_iterated_oid'. The
> two things that make me hesitate are:
>
> 1. There isn't a straightforward 1:1 substitute available for getting info
>    on the immediate target of a list of tags. 
> 2. The performance of a recursive peel can be worse than that of a single
>    tag dereference, since (unless the formatting is done in a ref_iterator
>    iteration *and* the tag is a packed ref) the dereferenced object needs to
>    be resolved to determine whether it's another tag or not.
>
> #1 may not be an issue in practice, but I don't have enough information on
> how applications use that formatting atom to say for sure. #2 is a bigger
> issue, IMO, since one of the goals of this series was to improve performance
> for some cases of 'for-each-ref' without hurting it in others.

In a repository without any tag-to-tag at tips of refs, would #2
above still be an issue?  My assumption when I raised "isn't this
simply a bug?" question was that the use of tag-to-tag is a mere
intellectual curiosity, there is no serious use case, and they are
not heavily used.  Hence I was envisioning that #1 below (i.e., a
mention in the Release Notes' backward compatibility notes section)
would be sufficient.

If it weren't the case, then I do not think any "transition" would
work, either.

And stepping back a bit, even though "peel only once" is how
for-each-ref works, I do not think anybody who really cares about
tag-to-tag and inspecting each level of peeled tag is helped by it
all that much.  Yes, you can get the result of single level peeling
via "git format-patch --format=%(*objectname)", but then what would
you do to dig further from that point?  You cannot ask rev-parse to
peel the result with "^{}", as that will peel all the way down.

You have to feed it to "git cat-file tag" and parse the contents of
the tag obbject yourself to manually peel further levels of onion.
Anybody who do care must already have such a machinery, and such a
machinery does not depend on "git for-each-ref --format='%(*field)'"
peeling just once, I would say.  They would most likely learn the
"%(objectname) %(objecttype) %(refname)" from the command, and for
those that are tags, they would manually peel the object with such a
machinery, because they have to do that for second and further
levels anyway.

And that is why I am not so worried about "breaking" existing users
in this particular case.  Our existing support with tag-to-tag is so
poor that those who truly need it would have invented necessary
support without relying on for-each-ref's peeling (if such people
did exist, that is).

But perhaps I am so overly optimistic against Hyrum's law.

> I can (and would like to) deprecate the "peel once" behavior and replace it
> with "peel all", but with how long it's been around and the potential
> performance impact, such a change should probably be clearly communicated.
> How that happens depends on how aggressively we want to cut over. We could:
>
> 1. Change the behavior of '*' from single dereference to recursive
>    dereference, make a note of it in the documentation.
> 2. Same as #1, but also add an option like '--no-recursive-dereference' or
>    something to use the old behavior. Remove the option after 1-2 release
>    cycles?
> 3. Add a new format specifier '^{}', note that '*' is deprecated in the
>    docs.
> 4. Same as #3, but also show a warning/advice if '*' is used.
> 5. Same as #3, but die() if '*' is used.
>
> I'm open to other options, those were just the first few I could think of. 
