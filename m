Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146011755C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 16:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986916; cv=none; b=LFIW4PI1canNkF9os+Oksa/VBq8Ydj88Pwrp+c4x71LRI1MSZLsgxVEqVYNfC3HhYmLjwWIIk/aXJ3lhA5DdGOSQxbQemULnINUIWZIG42TpY+I4LP5MLwB7VxeJDA2VqDEbIbcAUuQvqrYpp0zthg7LxeuMDIHRUVb67zgo4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986916; c=relaxed/simple;
	bh=mQXFdnUN69UU15R7ISXHDocmX3RARrsLngQmw4FBSRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DT7tjjMPwSqVMbzoBNFOUpWOE34VRfC82XaKl05jrpNbO/fH2ecZvEfSxpce1/CX4xWjT5rUm+XG6CUO7/RoCSVin7Tz086PzFzk+7K1UUFTeF65mV9af3+ewPdgV3Gtil8bDd40aV/nb7jKwozsWjmiGQiHdHRZe5DNNzD+HIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTDeNYB+; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTDeNYB+"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 142593949A;
	Tue, 10 Sep 2024 12:48:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mQXFdnUN69UU15R7ISXHDocmX3RARrsLngQmw4
	FBSRU=; b=KTDeNYB+LWAhPUTODilU1xxpZrhF6NLfyHa68M2uVjnSBlKOJe/rr9
	tTBogjf7r34+oO9lz6Ieq9Aq/yZ+YAtcJ9t4YqToSusbVBXivOL5Hclh2HlxL710
	1Q96DXfxCOruYgepA3CLjqF/Z3l85hh5TCT4gmmIZB3XMq6RDOG3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AEA239499;
	Tue, 10 Sep 2024 12:48:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 60B1A39498;
	Tue, 10 Sep 2024 12:48:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
In-Reply-To: <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Sep 2024 08:57:15 +0200")
References: <20240909230758.GA921697@coredump.intra.peff.net>
	<4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
Date: Tue, 10 Sep 2024 09:48:32 -0700
Message-ID: <xmqqseu7jvz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 841CF6BE-6F94-11EF-8334-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> When parsing `%(if)` atoms we expect a few other atoms to exist to
> complete it, like `%(then)` and `%(end)`. Whether or not we have seen
> these other atoms is tracked in an allocated `if_then_else` structure,
> which gets free'd by the `if_then_else_handler()` once we have parsed
> the complete conditional expression.
>
> This results in a memory leak when the `%(if)` atom is not terminated
> correctly and thus incomplete. We never end up executing its handler and
> thus don't end up freeing the structure.
>
> Plug this memory leak by introducing a new `at_end_data_free` callback
> function. If set, we'll execute it in `pop_stack_element()` and pass it
> the `at_end_data` variable with the intent to free its state. Wire it up
> for the `%(if)` atom accordingly.

Sounds good.  We diagnose unclosed "%(if)", report mismatch, and
die() soon, so plugging this may more about "let's silence leak
checker so that it can be more effective to help us find real leaks
that matter", not "this is leaking proportionally to the size of the
user data, and must be plugged".

I see this code snippet (not touched by your patch):

	if (state.stack->prev) {
		pop_stack_element(&state.stack);
		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
	}

and wonder how this handles the case where state.stack->prev->prev
is also not NULL.  Shouldn't it be looping while .prev is not NULL?

e.g.

diff --git c/ref-filter.c w/ref-filter.c
index b06e18a569..d2040f5047 100644
--- c/ref-filter.c
+++ w/ref-filter.c
@@ -3471,7 +3471,8 @@ int format_ref_array_item(struct ref_array_item *info,
 		}
 	}
 	if (state.stack->prev) {
-		pop_stack_element(&state.stack);
+		while (state.stack->prev)
+			pop_stack_element(&state.stack);
 		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
 	}
 	strbuf_addbuf(final_buf, &state.stack->output);

