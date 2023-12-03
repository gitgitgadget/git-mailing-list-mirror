Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yMAolUUG"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F8FC
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:15:17 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 781B61A585;
	Sun,  3 Dec 2023 08:15:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QGOUOjqvdWJLQmVojoZoghv4oDttQ8qnAb1gGc
	Zb53w=; b=yMAolUUGVlYf3ZugPYBylt014evXKbT8Y19G3lPoUnq7iGcdp3cA8M
	KggQ8ueoytZh72TG0IoXcf2GirFlu5CNGXYfjLoOAwXf+uF1HQWarUVhoGDGlQzV
	ljPhIiwbckVzs8EomSXaVwc3LXIGJV49I/1w4qfYJsMJX+S76kuT4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FD4F1A584;
	Sun,  3 Dec 2023 08:15:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C5881A583;
	Sun,  3 Dec 2023 08:15:12 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 05/24] midx: implement `DISP` chunk
In-Reply-To: <c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 28 Nov 2023 14:08:08 -0500")
References: <cover.1701198172.git.me@ttaylorr.com>
	<c52d7e7b27a9add4f58b8334db4fe4498af1c90f.1701198172.git.me@ttaylorr.com>
Date: Sun, 03 Dec 2023 22:15:11 +0900
Message-ID: <xmqqjzpv4ecg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FDC7736C-91DD-11EE-A718-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index 3696506eb3..d130e65b28 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -49,6 +49,10 @@ write::
>  	--stdin-packs::
>  		Write a multi-pack index containing only the set of
>  		line-delimited pack index basenames provided over stdin.
> +		Lines beginning with a '+' character (followed by the
> +		pack index basename as before) have their pack marked as
> +		"disjoint". See the "`DISP` chunk and disjoint packs"
> +		section in linkgit:gitformat-pack[5] for more.

Makes one wonder who computes the set of packfiles, decides to
prefix '+' to which ones, and how it does so, none of which appear
in this step (which is understandable).  As the flow of information
is from the producer of individual "disjoint" packs (not in this
step) to this new logic in "--stdin-packs" to the new "DISP" chunk
writer (the primary focus of this step) to the final consumer of
"DISP" chunk (not in this step), we are digging from the middle
(hopefully to both directions in other steps).  It is probably the
easiest way to explain the idea to start from the primary data
structures and "DISP" seems to be a good place to start.

> +	    Two packs are "disjoint" with respect to one another when they have
> +	    disjoint sets of objects.
> + In other words, any object found in a pack
> +	    contained in the set of disjoint packfiles is guaranteed to be
> +	    uniquely located among those packs.

I often advise people to rethink what they wrote _before_ "In other
words", because the use of that phrase is a sign that the author
considers the statement is hard to grok and needs rephrasing, in
which case, the rephrased version may be a better way to explain the
concept being presented without the harder-to-grok version.

But I do not think this one is a good example to apply the advice.
It is because "In other words," is somewhat misused in the sentence.
Two "disjoint" packs do not store any common object (which is how
you defined the adjective "disjoint" in the first sentence).  "As a
consequence"/"Hence", an object found in one pack among many
"disjoint" packs will not appear in others.

By the way, how strict does this disjointness have to be?

Let's examine an extreme case.  When you have two packs that are
"mostly" disjoint, but have one single object in common, how would
that object interfere with the bulk streaming of existing packdata
out of these two packs?  Would we be able to, say, safely pretend
that the problematic single object lives only in one but not in the
other (in other words, can we safely "ignore" the presence of the
copy in the other pack)?  I think it would break down if that
ignored copy is used as a delta base of another object in the same
pack, and the base object for the delta is recorded as OFS_DELTA
(which most likely every delta is these days), because we no longer
can stream out such deltified object without re-pointing its base to
the other copy, which will in turn screw up the relative offset of
other objects in the same stream.

OK, so it seems they really need to be strictly disjoint in order to
participate in the reuse of the existing packdata.  

> +When a chunk of bytes are reused from an existing pack, any objects
> +contained therein do not need to be added to the packing list, saving
> +memory and CPU time. But a chunk from an existing packfile can only be
> +reused when the following conditions are met:
> +
> +  - The chunk contains only objects which were requested by the caller
> +    (i.e. does not contain any objects which the caller didn't ask for
> +    explicitly or implicitly).

OK.

> +  - All objects stored as offset- or reference-deltas also include their
> +    base object in the resulting pack.

Are thin packs obsolete?

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index c4c6060cee..fd24e0c952 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -1157,4 +1157,62 @@ test_expect_success 'reader notices too-small revindex chunk' '
>  	test_cmp expect.err err
>  '
>  
> +test_expect_success 'disjoint packs are stored via the DISP chunk' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		for i in 1 2 3 4 5
> +		do
> +			test_commit "$i" &&
> +			git repack -d || return 1
> +		done &&
> +
> +		find $objdir/pack -type f -name "*.idx" | xargs -n 1 basename | sort >packs &&

That is an overly-long line.

> +test_expect_success 'non-disjoint packs are detected' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		test_commit base &&
> +		git repack -d &&
> +		test_commit other &&
> +		git repack -a &&
> +
> +		ls -la .git/objects/pack/ &&

Is this line a leftover debugging aid?

> +		find $objdir/pack -type f -name "*.idx" |
> +			sed -e "s/.*\/\(.*\)$/+\1/g" >in &&

Lose "g"; it adds unnecessary cognitive burden to the readers if the
patterh is expected to match multiple times, and you know that is
not possible (your pattern is right anchored at the end).  This may
apply equally to other uses of "sed" in this patch.

> +		test_must_fail git multi-pack-index write --stdin-packs \
> +			--bitmap <in 2>err &&
> +		grep "duplicate object.* among disjoint packs" err
> +	)
> +'
> +
>  test_done
