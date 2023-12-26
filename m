Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48754F880
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JnQYb+O/"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D2FB189F1;
	Tue, 26 Dec 2023 12:01:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zzaSpnv1v0lDv1wfIfwpyYixKk+1OgziS1MFMU
	9UWDE=; b=JnQYb+O/S4lo9cxejBond/h8z95HyKy6BE5ZuU7eeQwPVOicE/YflC
	IxgY5KsLofSnZbJwlt99zxvzwCT3BPKcc4NAfheDo3usV1z6V17XsbaLc02HW/Yc
	bCYSLMbfj4p5VxhgPV+Zmr8JPEzrSzYIFo8QcLxM1gj8qF1TYFvks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 459BA189F0;
	Tue, 26 Dec 2023 12:01:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC203189EF;
	Tue, 26 Dec 2023 12:01:04 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 22 Dec 2023 06:05:08 -0800")
References: <20231221170715.110565-1-karthik.188@gmail.com>
	<20231221170715.110565-3-karthik.188@gmail.com>
	<xmqqzfy3l270.fsf@gitster.g>
	<CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
Date: Tue, 26 Dec 2023 09:01:03 -0800
Message-ID: <xmqqsf3oj3u8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5B0EA164-A410-11EE-BB82-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Thanks for that, I did play around with trying to find files which
> could be refs in the $GIT_DIR, but the issue is that there will be
> false positives. e.g. `COMMIT_EDITMSG` could be confused for a
> pseudoref (passes is_pseudoref_syntax()) and it could potentially also
> contain a commit-ish value.

It would not begin with 40-hex, though.  If I were doing this,
perhaps I'd say we should first split is_pseudoref_syntax() that is
overly loose into to classes (e.g. "caps with underscores that ends
with HEAD" and everything else), silently reject false positives
among the latter class.  Then we rename those that are misnamed
(there should be only few, like AUTO_MERGE that should be a
pseudoref but named without _HEAD; I do not think of anything that
ends with _HEAD that is not a ref) over time and drop the latter
class.

> While you're here, I wonder if you have any thoughts on the last block
> of my first mail.
>
>> Over this, I'm also curious on what the mailing list thinks about
>> exposing this to the client side. Would an `--all` option for
>> git-for-each-ref(1) be sufficient?

"list pseudorefs in addition to things below refs/"?  Sounds OK to
me as a feature.

However, "--all" does not mean that in the context of "git log"
family of commands.  Over there, it means "not just --branches,
--tags, and --remotes, but everything" which is still limited below
"refs/".

As "git for-each-ref" takes pattern that is prefix match, e.g.,

    $ git for-each-ref refs/remotes/

shows everything like refs/remotes/origin/main that begins with
refs/remotes/, I wonder if

    $ git for-each-ref ""

should mean what you are asking for.  After all, "git for-each-ref"
does *not* take "--branches" and others like "git log" family to
limit its operation to subhierarchy of "refs/" to begin with.




