Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDD52E62BB
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716764; cv=none; b=gBOswio3F7dovzEwc9J6K4K69Uo+mFrId9N2ENntSFp9pQWCaMwYJ/xyNqmNZuTKubxqE+ZJxajPp41S7Ht8MovUrA9EbMEZjKOzEcv5PQEFLwnyD0ywH1UGQWxaj0bm0NxBD6KOaRTak6tkPNDIe0Z6OBUjGuFY+x6AhxnmvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716764; c=relaxed/simple;
	bh=SbZ2xgCRNG1/Hyh3xvWe3zWT4FAKaoAoDgq+Qv9O164=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UgVcgx0UBCZf/qnHalyJHh8n4TzdCQkgEZ6uB1iV8X+p+oz4uYjyn6D2hnF954VQ/7YOf3xKaLJka09pacZdywAYoWxh+k6DjhPdAwA62iQIoXsidykPFa5T7vVmLk3OBH1CnSCjrbiGUC3lc1RdclpxkstXx6ri41KiCgYl7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZTFfY4x5Wz9tC4;
	Thu,  3 Apr 2025 23:45:57 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 23:45:55 +0200
Message-Id: <D8XC02N85O7W.2LQY7B8Q2Z98G@buenzli.dev>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Nico Williams" <nico@cryptonector.com>, "Elijah Newren"
 <newren@gmail.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com> <Z+7PDi5y4wXJBK4r@ubby>
In-Reply-To: <Z+7PDi5y4wXJBK4r@ubby>
X-Rspamd-Queue-Id: 4ZTFfY4x5Wz9tC4

On Thu Apr 3, 2025 at 8:10 PM CEST, Nico Williams wrote:
> On Thu, Apr 03, 2025 at 08:39:31AM -0700, Elijah Newren wrote:

> Also, maybe commits need to support multiple change IDs.  For example,
> one might want one change ID for a set of commits (eg implementing a
> feature), and each commit in the set having a second and more unique
> change ID for just that commit (and all edits/rewrites of it).

Semantically grouping a set of commits is an intersting idea, but not
really related to the proposed change-id? Mercurial has "topics", which
I don't know too much about. Even if such a "topic-identifier" were
to be stored in the commit header, it probably shouldn't be called the
same thing as the change-id header. Otherwise it becomes impossible to
determine if a change-id header is supposed to identify an individual
patch across its versions or associate it semantically with others.

>> cherry-pick & rebase preserve author name, email & time, while
>> creating a new committer name, email, & time.  To me, the change-id is
>> about the authorship, and since these commands already preserve
>> authorship, it'd seem weird to me to have cherry-pick not preserve the
>> change-id by default.
>
> +1.  Besides, rebase is just a a bunch of cherry-picks, so cherry-pick
> is the fundamental operation here.  If rebase is to preserver change-id
> then so is cherry-pick.

Well, if rebase is just a bunch of cherry-picks, that sounds like an
implementation detail. The ways rebase and cherry-pick are most often
used are semantically very different from each other. (interactive)
rebase is often used to amend commits that already have descendants. In
that case, it makes sense for the change-id to be preserved. cherry-pick
on the other hand is often used to create a dublicate of a patch at a
different location in the commit tree, e.g. for backporting purposes.
The equivalent of cherry-pick in Jujutsu is called "duplicate" and
doesn't preserve the change-id for that reason. So if cherry-pick
retains the change-id, that would lead to more duplicate change-ids in
the tree, degrading their usefulness in those cases for little benefit.
But again, if Git decides to go that route it's still better for the
other projects than not supporting the header at all.

Remo
