Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5017E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VTp+UTo0"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F1DB
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 17:21:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E833393BF;
	Sun, 22 Oct 2023 20:21:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lnt8c4yVGHGDn91D1/Vc9vn778Cj0JUDRW9eBc
	4ZZB0=; b=VTp+UTo0ur6862STcvjTCWi+jstIYmvB4PEN4+Q0CRSvv/1q3AqG45
	KO6RpcYfUiZZWt93o9ydruHsNkN+6pd6cS7nXQdpHJazZE78ObFxb6sxbqxpl+YH
	y5WGuatqX9+vJQKdtyL2otiJmguGTb9Wzn7Qv7o3r0xdFxNWtv/2w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B384393BE;
	Sun, 22 Oct 2023 20:21:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DA4F7393BC;
	Sun, 22 Oct 2023 20:20:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] log: decorate pseudorefs and other refs
In-Reply-To: <fe3abed8-6be0-4d77-9057-79c9b7c0795c@gmail.com> (Andy Koppe's
	message of "Sun, 22 Oct 2023 22:49:48 +0100")
References: <20231003205442.22963-1-andy.koppe@gmail.com>
	<20231019193911.1669705-1-andy.koppe@gmail.com>
	<xmqq1qdnseed.fsf@gitster.g>
	<fe3abed8-6be0-4d77-9057-79c9b7c0795c@gmail.com>
Date: Sun, 22 Oct 2023 17:20:56 -0700
Message-ID: <xmqqpm16p4t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 09A7BB70-713A-11EE-852C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

>>   [2/7] is a trivial readability improvement.  It obviously should be
>>         left outside the scope of this series, but we should notice
>>         the same pattern in similar color tables (e.g., wt-status.c
>>         has one, diff.c has another) and perform the same clean-up as
>>         a #leftoverbits item.
>
> Okay, I've removed that commit in v2. (I should have mentioned in the
> commit message that it was triggered by the inconsistency with the
> immediately following color_decorate_slots array, which uses
> designated initializers.)

Sorry, that is not what I meant.  [2/7] as a preliminary clean-up to
work in the same area does make very much sense.  What I meant to be
"outside the scope" was to make similar fixes to other color tables
that this series does not care about.

>>         .ref = "refs/", the implementation of the search must know
>>         that it is a fallback position (i.e. if it found a match with
>>         the fallback .ref = "refs/" , unless it looked at all other
>>         entries that could begin with "refs/" and are more specific,
>>         it needs to keep going).
>
> Fair points. I've rewritten things to not touch the ref_namespace array.

Well, the namespace_info mechanism still may be a good place to have
the necessary information; it may be that the current implementation
detail of how a given ref is classified to one of the namespaces is
too limiting---it essentially allows the string match with the .ref
member.  But we can imagine that it could be extended a bit, e.g.

	struct ref_namespace_info {
		char *ref;
		int (*membership)(const char *, const struct ref_namespace_info *);
		... other members ...;
	};

where the .membership member is used in add_ref_decoration() to
determine the membership of a given "refname" to the namespace "i"
perhaps like so:

	struct ref_namespace_info *info = &ref_namespace[i];

	if (!info->decoration)
		continue;
+	if (info->membership) {
+		if (info->membership(refname, info)) {
+			deco_type = info->decoration;
+			break;
+		}
+	} else if (info->exact) {
-	if (info->exact) {
		if (!strcmp(refname, info->ref)) {
			deco_type = info_decoration;
			break;
	}

Then you can arrange the pseudoref class to use .membership function
perhaps like this:

	static int pseudoref_namespace_membership(
		const char *refname, const struct ref_namespace_info *info UNUSED
	)
	{
		return is_pseudoref(refname);
	}

and make them all into a single class.

What I called a bad design was to reuse the namespace_info code
without extending it to suit our needs.

This comment will probably affect everything below.

>>   [6/7] This is pretty straight-forward, assuming that the existing
>>         is_pseudoref_syntax() function does the right thing.  I am
>>         not sure about that, though.  A refname with '-' is allowed
>>         to be called a pseudoref???
>>         Also, not a fault of this patch, but the "_syntax" in its
>>         name is totally unnecessary, I would think.  At first glance,
>>         I suspected that the excuse to append _syntax may have been
>>         to signal the fact that the helper function does not check if
>>         there actually is such a ref, but examining a few helpers
>>         defined nearby tells us that such an excuse does not make
>>         sense:
>
> I've dropped the use of that function from the change, checking
> against the actual pseudoref names instead.
>
>>   [7/7] Allowing pseudorefs to optionally used when decorating might
>>         be a good idea, but I do not think it is particularly a good
>>         design decision to enable it by default.
>
> Okay!
>
>>         Each of them forming a separate "namespace" also looks like a
>>         poor design, as being able to group multiple things into one
>>         family and treat them the same way is the primary point of
>>         "namespace", I would think.
>
> Fair enough, although the array already contains HEAD and refs/stash
> as singletons.

But these deserve to be singletons, don't they?  There is no other
thing that behaves like HEAD; there is no other thing that behaves
like stash; and they do not behave like each other.

Having said that, I do not think it makes much sense to decorate a
commit off of refs/stash, as the true richeness of the stash is not
in its history but in its reflog, which the decoration code does not
dig into.  But obviously it is not a part of the topic we are
discussing (unless, of course, we are not "adding" new decoration
sources and colors, but we are improving the decoration sources and
colors by adding new useful ones while retiring existing useless
ones).

Thanks.
