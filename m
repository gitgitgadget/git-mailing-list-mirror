Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4F15A843
	for <git@vger.kernel.org>; Sat,  7 Sep 2024 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725728387; cv=none; b=jWbjfKP7c7V0Zp4CUuRY0XqfkR+4n86Dg8jgeG5NQhEZU1c0UcTbR45IXNiGRyDpSg5RU2W6wPsYy5z2R6vWPmlJMwHQ8/C6bwwFFOKNv1BJrvlc/eUrcY4g+SIW8V+it/hy/pQWaImbm5EFBziZpdYF62r2V9NIie/jeViVqI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725728387; c=relaxed/simple;
	bh=wz10fB/F5BiSBJZeQ3uXPmkvvtFiBk3swuXMZjZu9ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E3cMXTSsNUxZXIG8m3WlsG1yy1cJAjp4ZhNVIwCmt1Arf7rURTvQUtJi/1drCbPGWbMcUJ7RTJojoYvhcZiNF1eBpl6z/QEaFFLWRODpYhW99P9GVmwmw4vB6bx/ETPJAS/kFbj6sh627U5GTt+251ygna2oAmiir3+Q+98UCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dsoTnUcS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dsoTnUcS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B9FCD2AB1E;
	Sat,  7 Sep 2024 12:59:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wz10fB/F5BiSBJZeQ3uXPmkvvtFiBk3swuXMZj
	Zu9ek=; b=dsoTnUcST6oy9Bmetj1dHnvnoJa1c2TrDyxbJxhaYm1MQuLQOhXiMs
	fGkLIKRXXcEx4b/4enoNQYI8K9ct99y8Co2pl614oIAMuV27Y39FIqWwVGyZT3qh
	7DPwLxjcffGrKlZt/CeFcTfZ5jrDmIuYi2oXTh2pzq83SCjQzhPUQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B296F2AB1D;
	Sat,  7 Sep 2024 12:59:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 286DA2AB1C;
	Sat,  7 Sep 2024 12:59:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: git@vger.kernel.org
Subject: Re: Thoughts on the "branch <b> is not fully merged" error of
 "git-branch -d"
In-Reply-To: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de> (Stefan
	Haller's message of "Sat, 7 Sep 2024 18:28:38 +0200")
References: <bf6308ce-3914-4b85-a04b-4a9716bac538@haller-berlin.de>
Date: Sat, 07 Sep 2024 09:59:43 -0700
Message-ID: <xmqqy143wgao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 94AF3124-6D3A-11EF-A394-9B0F950A682E-77302942!pb-smtp2.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

> I frequently get this error when trying to delete a branch that was
> merged on github, and the remote branch was deleted through github's UI too.
>
> When I then fetch and see that "git branch -v" shows it as "[gone]"), I
> will want to delete it, but at that time it is pretty random which
> branch I happen to have checked out. If it's some other unrelated branch
> that I didn't rebase onto origin/main yet, or if it is main but I didn't
> pull yet, then I get the error; but if I'm on main and I have pulled, or
> I'm on an unrelated branch and I have rebased onto origin/main, then I
> don't.
>
> This feels arbitrary to me. It would seem more useful to me if the error
> only appeared if the branch is not contained in any of my local or
> remote branches, because only then do I lose commits. Any thoughts on that?

I think we check against the @{upstream} as well as HEAD these days.
The very original design was geared towards folks who do

    $ git checkout integration-branch
    $ git merge topic
    $ git branch -d topic

and that was why HEAD is a sensible thing to use as a reference
point.  What makes the choice _appear_ arbitrary is your being on a
random unrelated branch when you think of using "branch -d" ;-)

"merged to any other branch" is an absolute no-no.  Imagine that I
have a branch A, and then tentatively build a wip branch B that I am
less sure about than branch A on top:

    ---o---o---a---a   A
                    \
                     b---b---b   B

The reason why I said "tentatively" is because I fully intend to
rebase B (these three 'b' commits) on top of an updated A after I
polish branch A.

                           b'--b'--b' B
                          /
                     a---a   A
                    /
    ---o---o---a---a   (old)A
                    \
                     b---b---b   (old)B

The tip of branch A deserves the same protection as the tip of
branch B from "git branch -d", until the whole thing is integrated.
Granted, you may find A's tip from "git log B", but that should not
be a reason to allow a mistaken "git branch -d A" merely because I
happen to have started exploring another idea that may not work at
all on branch B.

Having said all that, I do not mind if somebody wanted to further
extend builtin/branch.c:branch_merged() so that users can explicitly
configure a set of reference branches.  "The 'master' and 'maint'
are the integration branches that are used in this repository.
Unless the history of a local branch is fully merged to one of
these, 'git branch -d' of such a local branch will stop." may be a
reasonable thing to do.

Thanks.
