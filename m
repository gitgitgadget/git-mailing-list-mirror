Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179E337BA6
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826995; cv=none; b=NodWH5+uv79BC043rnIi9LHG8tI42vhYZ5JQBTffthb+JaCt4/xNWqyzp7wIq6tbIy8mZsg7O/VvoPXCKthVAEovS4P74foOgBuhz2Q6e6FlWmi8x0ZISmlEPm19yud7tS/QowcI25cLxTxdj/K6KKktZLMfDeb8N7T2NrbsMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826995; c=relaxed/simple;
	bh=tlI6xeDsQWpv3JjKvg/Py2C0QUrtTeQiw5BEkGyuTaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pabCHztOO7LpdK1hjCSXyNE3W4D6wl2vRqay2M//Oe7wImDFASHMmq1huBpm09Mo0fwkvQylz1HNv9JX5tICZbRsGdl2oOI4bAdJxHRdvc1hQW7kO+NakUWYDYyKFA2TRsspRpThnJ+3SUGLtkjckhwjkTkyWvrEWCViBV8hoHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=HfBQ5w+x; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="HfBQ5w+x"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782826989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTUxYEadYknZAHp3CtCdpnohw3qiAgduA3TVw3sODLw=;
	b=HfBQ5w+xbrlF20Xy1rxWJttb0AO27oBdu5RPg0Q8sxqcVAqLkCHEm7HQIzhq2SjG8smDKQ
	MH0Q7SRDXg1RWsuab/7gt/WO8iaBGbauyaCKRM9iCIFS2QcGGnUsRIeuuaRmZvYdlJfGIc
	h9GtpxYkWVa1s0q62ZMJcel8Qgu4vZ8=
From: Toon Claes <toon@iotcl.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/3] Teach git-replay(1) to linearize merge commits
In-Reply-To: <f8b520d1-edeb-9e45-c503-025c8b5833c3@gmx.de>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
 <f8b520d1-edeb-9e45-c503-025c8b5833c3@gmx.de>
Date: Tue, 30 Jun 2026 15:42:59 +0200
Message-ID: <87a4sc400s.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I fear that the `replayed_base` design _is_ needed, and the only way
> `git replay --linearize` can work with multiple branches is by linearizing
> all of the replayed commits into one single, linear commit topology.

Well, I'm getting the feeling you're right here. But then this change is
no longer related to merge commits only. Replaying multiple branches
with --onto and --linearize would always replay them into a single line
hiearchy?

Personally, I would be totally fine with that. We need to lay that out
very clearly in the docs, but that is in my humble opinion also a strong
argument to name it `--linearize` and not `--replay-merge=linearize` or
whatever we've been discussing.

> Obviously, there are ways one could _try_ to rescue the previous idea, so
> that at least replaying just branches A and B would keep the replayed
> commits non-reachable from each other, but I strongly suspect that any
> such design will invariably surprise users in nasty ways when the logic
> has to fall back to the simple idea I outlined anyway.

I don't like the "try" in there. I think it's better to have predictable
behavior. Users always have the choice to replay branches in separate
git-replay(1) calls, although that comes with a downside that commits
shared by those branches will be replayed separately and will get
duplicated, unless they fiddle with the COMMITTER_DATE.

-- 
Cheers,
Toon
