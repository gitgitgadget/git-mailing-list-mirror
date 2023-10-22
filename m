Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3F363
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 00:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bdSktEVT"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149E2E8
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 17:13:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D3DD1AF86A;
	Sat, 21 Oct 2023 20:13:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i1aCvtsu+vPvsTO+8gXsJ3Z6rRkptXxndZtzDi
	gY9Dk=; b=bdSktEVTZqFq2eEZHPgg1Fi/lbjLt218tQv/ZH8lHfp6IZiYMvfT6q
	9extGviBS6xRZG4A86tv/nAXPV0+YBcxJrU4QvyVM4RWTqHOMxuD/BTJ4Ie1aJdh
	2JbqbA3cjdwCyWNkwer1Kgy2TvdWWwooqM4ncxiNk7O0x+MmOe0qA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60AC91AF869;
	Sat, 21 Oct 2023 20:13:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B60FF1AF866;
	Sat, 21 Oct 2023 20:13:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] log: decorate pseudorefs and other refs
In-Reply-To: <20231019193911.1669705-1-andy.koppe@gmail.com> (Andy Koppe's
	message of "Thu, 19 Oct 2023 20:39:04 +0100")
References: <20231003205442.22963-1-andy.koppe@gmail.com>
	<20231019193911.1669705-1-andy.koppe@gmail.com>
Date: Sat, 21 Oct 2023 17:13:14 -0700
Message-ID: <xmqq1qdnseed.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBC77E28-706F-11EE-BF37-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Andy Koppe <andy.koppe@gmail.com> writes:

> This patch series adds three slots to the color.decorate.<slot> config
> option:
> - 'symbol' for coloring the punctuation symbols used around the refs in
>   decorations, which currently use the same color as the commit hash.
> - 'ref' for coloring refs other than branches, remote-tracking branches,
>   tags and the stash, which currently are not colored when included in
>   decorations through custom decoration filter options.
> - 'pseudoref' for coloring pseudorefs such as ORIG_HEAD or MERGE_HEAD.
>   Include them in decorations by default.
>
> This series is to replace the 'decorate: add color.decorate.symbols
> config option' patch proposed at:
> https://lore.kernel.org/git/20231003205442.22963-1-andy.koppe@gmail.com

If that is the case, it probably would have been nicer to mark the
series as [PATCH v2].

Also, can you make messages [1/7]..[7/7] replies to [0/7] when you
send them out?  It seems that all 8 of them (including the cover
letter) are replies to the previous round, which looked a bit
unusual.


As to the contents of the series:

 [1/7] nicely lays out the color documentation; I do not think the
       extra verbosity was absolutely needed for existing ones
       (e.g., when a reader sees 'tag', the reader knows the color
       will be applied to tags), but the more exotic ones the series
       will be adding may deserve extra explanation on what they
       are, so I guess it is OK.

 [2/7] is a trivial readability improvement.  It obviously should be
       left outside the scope of this series, but we should notice
       the same pattern in similar color tables (e.g., wt-status.c
       has one, diff.c has another) and perform the same clean-up as
       a #leftoverbits item.

 [3/7] They way _NIL color is used to control the defaulting looked
       a bit unusual, but clever way to use a non-constant color
       defined elsewhere as its default.  A similar trick is used in
       wt-status.c:color() for STATUS_ONBRANCH, so this is nothing
       new.

 [4/7] The name of new member .include added to ref_namespace_info
       will not be understood by anybody unless they are too deeply
       obsessed by decoration mechansim.  As the namespace_info
       covers far wider interest, so a name that *shouts* that it is
       about decoration filter must be used to be understood by
       readers of the code.

       To be quite honest, "decoration filter" is probably a name
       that will not be understood by anybody, but coming up with a
       better name for it is probably outside the scope of this
       series.

 [5/7] I am not sure if "other refs" should be an item in the
       namespace_info array.  If it is truly "catch-all", then
       shouldn't the refs in other namespaces without their own
       decoration (e.g. ones in refs/notes/ and refs/prefetch/) be
       colored in the same way as this new class?  And if so, having
       it as an independent element that sits next to these other
       classes smells like a strange design.

       Another more worrying thing is that existing .ref members are
       designed to never overlap with each other, but this one
       obviously does.  When a caller with a ref (or a pseudoref)
       asks "which namespace does this one belong to", does the
       existing code still do the right thing with this new element?
       Without it, because there was no overlap, an implementation
       can randomly search in the namespace_info table and stop at
       the first hit, but now with the overlapping and widely open
       .ref = "refs/", the implementation of the search must know
       that it is a fallback position (i.e. if it found a match with
       the fallback .ref = "refs/" , unless it looked at all other
       entries that could begin with "refs/" and are more specific,
       it needs to keep going).

 [6/7] This is pretty straight-forward, assuming that the existing
       is_pseudoref_syntax() function does the right thing.  I am
       not sure about that, though.  A refname with '-' is allowed
       to be called a pseudoref???

       Also, not a fault of this patch, but the "_syntax" in its
       name is totally unnecessary, I would think.  At first glance,
       I suspected that the excuse to append _syntax may have been
       to signal the fact that the helper function does not check if
       there actually is such a ref, but examining a few helpers
       defined nearby tells us that such an excuse does not make
       sense:

           int is_per_worktree_ref(const char *) {
		   return starts_with(refname, "refs/worktree/") ||
			  starts_with(refname, "refs/bisect/") ||
			  starts_with(refname, "refs/rewritten/");
	   }
           int is_pseudoref_syntax(const char *);
           int is_current_worktree_ref(const char *ref) {
                   return is_pseudoref_syntax(ref) || is_per_worktree_ref(ref);
           }

       All these three work on the refname and based on what is in
       that refname string, decides what kind of ref it is.  There
       is nothing especially "syntax" about the second one, and we
       should rename it as part of #leftoverbits clean-up effort.

       Another unrelated tangent is that is_per_worktree_ref() shown
       above and the namespace_info array we saw earlier are not
       even aware of each other, which is maintenance nightmare
       waiting to happen.

 [7/7] Allowing pseudorefs to optionally used when decorating might
       be a good idea, but I do not think it is particularly a good
       design decision to enable it by default.  

       Each of them forming a separate "namespace" also looks like a
       poor design, as being able to group multiple things into one
       family and treat them the same way is the primary point of
       "namespace", I would think.  You do not want to say "I want
       to decorate off of ORIG_HEAD and FETCH_HEAD"; instead you
       would want to say "I want to decorate off of any pseudoref".


