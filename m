Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AB3FB00
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sZXlBXI5"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1601B9
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 16:24:58 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FB371C214A;
	Fri, 27 Oct 2023 19:24:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VB1M3I3BI49M2UYnDdqY+TUc+RILuokOT9NfYK
	Y7CwE=; b=sZXlBXI5zXLuurC6kqxSVICYpPYgDeNUau7FnMa3JI3C7KAx3JfE0z
	H/12jwkK/ZmahG/C3uB06gKR4G3R11RcpyFwpT5MsVSb0Ge8INh+cwTaVpGFuh0m
	Gvb7Pa1N2NN0NYZrUC1RvucjEALHbkvwFRsf7nT9BBBslwoLwWXMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06DE01C2149;
	Fri, 27 Oct 2023 19:24:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 708C01C2148;
	Fri, 27 Oct 2023 19:24:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  Phillip Wood <phillip.wood123@gmail.com>,
  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org
Subject: Re: using oldest date when squashing commits
In-Reply-To: <70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com> (Marc
	Branchaud's message of "Fri, 27 Oct 2023 08:34:40 -0400")
References: <YjXRM5HiRizZ035p@ugly>
	<9fae5292-d58f-95da-245b-6e205383cb50@kdbg.org>
	<a99b16a8-a06c-4d38-bb78-46ce17411597@gmail.com>
	<ZTeZ3KEQLIVU/sq2@ugly>
	<138631cd-ead3-4f22-95ce-61afccfa409f@gmail.com>
	<xmqqpm143p46.fsf@gitster.g>
	<59731c05-c3f6-4815-8411-783bb1c2aac4@kdbg.org>
	<70b8d4d8-f4b5-4cd7-b73a-1d7393d84266@xiplink.com>
Date: Sat, 28 Oct 2023 08:24:53 +0900
Message-ID: <xmqqlebnodh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 08F56D6E-7520-11EE-9DAC-25B3960A682E-77302942!pb-smtp2.pobox.com

Marc Branchaud <marcnarc@xiplink.com> writes:

> I never use "fixup -C" (or -c), but I do use squash/fixup a lot.  I
> find that I would prefer it if Git used the most recent Author date
> from the set of commits being combined, rather than preserving the
> picked commit's Author date.  Sometimes it takes quite a while for me
> to get a piece of work sorted out, and I would rather have the Author
> date in the end-result commit reflect the work's completion time than
> its initiation time.

Yeah, I can sympathize but with both positions, as I can see why
most people would want "minor fixups and typofixes" to retain the
original authorship date, and when concluding a "combining the whole
steps together to reach this final single patch" development, they
would want to record the completion date.  The "take the one's
authorship and apply only the effects and not metadata from the
fixups" is a good match for the former.  To support the latter, we
can just ignore the timestamp of any commits that were involved in
the end result, and record the time "rebase -i" was concluded
instead, but the tool is not set up for doing so.

> The current behaviour means that when scanning through commits with
> tools like gitk (which shows just the Author date in its list of
> commits) I'll often see what I feel are inaccurate or confusing dates
> there,...

Yup, exactly.  Two opposing worldviews, which is not even per-user,
but depends on why the "fixup/squash" was used, exists, but the tool
was designed to support the "small fixup for work that was mostly
done already" use case, so the other usecase is left for people to
say "Yes, I know how to force my desired author date on commits,
thanks." ;-)

> Anyway, this is a minor itch for me that I've never felt the need to
> scratch.  I just thought I'd mention it since the topic is being
> discussed.

Yup, it is a very good observation.  Giving it a good UI to support
both worldviews would be a good exercise, as we all need both
behaviour from time to time.

Thanks.
