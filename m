Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD44502F
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616048; cv=none; b=FApDf1QI7TrxNouiCZXc+OMBkh48u4RsNEIQlynGQ/2Y496XyoHJoFIdfBqKEPkiv6QU2+hmI7rZS21ni/t646xww3aWJ0D53/TLHaN7dxSLWhq+Hf5HswKNV37WXP2LRoK7uc1tc/JkwHRlwv6LSfoB5tS2ETejt5Kk6vDXz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616048; c=relaxed/simple;
	bh=8O08var39CmrtuARCwZh7UqT0JF0QflouxKajblDit4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfBsAKUogq4smk1mvtLRbgyueP3dYuaWxXZrA2DxRl6HaICnD6/igNXEjpa2hw//KTGkVT95KHcLFI7g/PbGSZkdGFaycesovyOD1FpM/N5qCO/y3fCIsGqyIeqMj1sF9UtuQ22vSzkbWBUx8N9KVMKG7Wh6VqeHWt6PWTciBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lsdM0bye; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lsdM0bye"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AF4BD1F7DF7;
	Tue,  5 Mar 2024 00:20:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8O08var39CmrtuARCwZh7UqT0JF0QflouxKajb
	lDit4=; b=lsdM0byeWi1k54Ed18+Z9HKzdR/wGlbwGFmzud7oaQE4JPXHMwLYLO
	9VWnxGjZxolOW+1R37XqVltLqy00qGNDD1xUkVuVP72UclLIXB9o8DXXH7hUzsXT
	mvPUi2gvr4ukVrTM+/p5iTXhmM8GnY5ZHyXe7jUD6FqQ3997RPPXg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A72BB1F7DF6;
	Tue,  5 Mar 2024 00:20:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E8F21F7DF5;
	Tue,  5 Mar 2024 00:20:45 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marco Sirabella <marco@sirabella.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Look up signing keys with only email
 address
In-Reply-To: <20240305020815.2980-1-marco@sirabella.org> (Marco Sirabella's
	message of "Mon, 4 Mar 2024 18:08:15 -0800")
References: <20240305020815.2980-1-marco@sirabella.org>
Date: Mon, 04 Mar 2024 21:20:43 -0800
Message-ID: <xmqqy1ax5k5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E3C2F96-DAB0-11EE-ADD0-25B3960A682E-77302942!pb-smtp2.pobox.com

Marco Sirabella <marco@sirabella.org> writes:

> Sometimes gpg signing key UIDs include a comment between the name and
> parenthesis in the form of:
>
>   John Smith (example) jsmith@example.com
>
> There's no way for git to find signing keys associated with just these
> UIDs, so look up a partial match on the email only.

This codepath is about finding the key for the current user who is
in control of what committer is found by the git_committer_info()
call, no?  It is not like we are finding the key that corresponds to
a random name and e-mail address on "From:" line, right?

Assuming that it is the case, it is unclear where the claim "There's
no way for git to find" comes from.  It isn't a statement that is so
obviously true, at least to me, without some explanation.

> -	return git_committer_info(IDENT_STRICT | IDENT_NO_DATE);
> +	return git_committer_info(IDENT_NO_NAME | IDENT_STRICT | IDENT_NO_DATE);

With this change, those who use more than one identities associated
with the same e-mail address, but different human-readable names,
will get their workflow broken, won't they?

They may be using "Will <a@dd.re.ss>" when they work on a project,
while using "Bill <a@dd.re.ss>" for another project, configured via
their .git/config in the repositories used for these two projects.
And each name+address combination they have may map to a distinct
GPG key, used to sign for each project.  With this change, since the
call no longer returns the name they were using to differentiate the
two keys, one of the projects they manage would lose out, no?

In general, there may be more than one signing keys that correspond
to a given human user, and the user may choose a specific key based
on what project the signatures are made for, and in such a case,
with or without the proposed change, the fallback code based on the
git_committer_info() is an unreliable way to specify the key to be
used, especially for an action as important as cryptographic
signing.  I have always assumed that people use something like this
in practice:

    $ git config user.signingkey = 955980DA!

that can be used to more reliably identify a specific key in their
keyring, among the ones associated with similar identifiers meant
for human consumption such as name/e-mail pairs.

So, I am not convinced that the patch is trying to address the right
problem, and I have a mild suspicion that the proposed solution to
tweak NO_NAME may simply be robbing Peter to pay Paul.  If you have
named your GPG key in your keyring with a name-email pair that is
different from how you configured your committer identity, the right
solution for such a case already exists in the form of user.signingkey
configuration variable already.

Thanks.
