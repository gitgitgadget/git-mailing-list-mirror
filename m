Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984C1E287C
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606427; cv=none; b=n00s64+sQ9aq1rTNSNvH1lkj7GdGBSHvBkk+UN/yNGVbz1zZoiQyeHGFudJ9pfM+0rojbvfL1NfiqVVVuiFE4yN04FLpiwAWYnZXFbt3tBLcHJmJbwd5lSmldeqBwjL4/3+NrTj00VjpdHLF8tZWFuip5JdSPqi37KuSLUMIi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606427; c=relaxed/simple;
	bh=fJtMTiMIPA+xMKMXWC7W+Y25jHost/rZN/KWkJmDAEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i0KumLFBi2JS6mkaENbADGPumC1stw4dkZnXiFLCwa+WvkKhaxg5Cwqsm/CZrPy1Hb0dGLvVH4L18DrzURts5EIw5rovZMK0IdHvsHlYlAPMqTl7ZewWwsW/iIlZ0Ovn9tQ+TTqGl3jERyrlx6r4haRBBynovpJC0E8rQNqv1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=t9VTgqm+; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="t9VTgqm+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1722606418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ycVn5E9Ue7HblmHw9Jn9wTnhSZM2PrzS90R3UBC6dc=;
	b=t9VTgqm+0PrTw+jQy/VytO1Ynn0e0OPUPOj9ZV0Obb2vzKYBHgCi67l4JGXEYhuXpZajCj
	Wz0WgWKdIjVT/DTsR+W9/49NibRFc3wvDfj3jwSbNgCmNeuxr4bQICKA8NWDufQ9tZQt20
	ZsT8zBQBNvNeLcL6MkZl35liboZbeoE=
From: Toon claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] fetch: use bundle URIs when having creationToken
 heuristic
In-Reply-To: <ZqObobw8FsDMkllm@tanuki>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-4-toon@iotcl.com> <ZqObobw8FsDMkllm@tanuki>
Date: Fri, 02 Aug 2024 15:46:39 +0200
Message-ID: <87a5hv9gw0.fsf@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> I think Junio essentially asked this already, but I'm still missing the
> bigger picture here. When the "creationToken" heuristic is applied, the
> effect of your change is that we'll always favor bundle URIs now over
> performing proper fetches, right?

Yes, sort of. Bundle URIs are a step before "proper" fetches. A "proper"
fetch might still happen after downloading bundles.
(I would rather call them "negotiated fetches" or something, but let's
just stick with "proper" fetch for now)

> Now suppose that the server creates new bundled whenever somebody pushes
> a new change to the default branch. We do not really have information
> how this bundle is structured. It _could_ be an incremental bundle, and
> in that case it might be sensible to fetch that bundle. But it could
> also be that the server generates a full bundle including all objects
> transitively reachable from that default branch. Now if we started to
> rely on the "creationToken" heuristic, we would basically end up
> re-downloading the complete repository, which is a strict regression.
>
> Now that scenario is of course hypothetical. But the problem is that the
> strategy for how bundle URIs are generated are determined by the hosting
> provider. So ultimately, I expect that the reality will lie somewhere in
> between and be different depending on which hosting solution you use.

That is true. The mechanism of bundle URIs is mostly outside the control
of Git itself. It's up to the Git hosting provider how they use it. This
gives them a lot of flexibility, like where to store bundles, how
incremental bundles are used, and how often bundles are regenerated. But
this also comes with a huge responsibility, due to the scenario you
describe above.

At GitLab we want to do an initial roll-out of bundle URIs with just one
bundle advertised to the client. This bundle is generated every week,
and only contains the whole history of default branch (up to the newest
commit). But, we'll advertise this bundle with creationToken "1",
always. This will cause the client to fetch any bundle for the
repository only once. Even when the bundle is updated by the server, the
client will not fetch it because the creationToken did not change.

> All of this to me means that the "creationToken" heuristic is not really
> a good signal, unless I'm missing something about the way it works. Is
> there any additional signal provided by the server except for the time
> when the bundle was created?

The Git hosting provider can use the "creationToken" however they want,
at the moment it's up to them to decide on a good strategy.

For example, assume you decide to create bundle URIs only for the
default branch, then you can choose to use the committer date of the
topmost commit of that branch as the creationToken.

Imagine you have the following example commit history (committer date of
some commits are indicated with a caret below those commits):


  A --- B --- C --- D --- E --- F --- G
              ^           ^           ^
      2024-08-02     2024-08-04     2024-08-09

Today (on 2024-08-02, at this point commits D to G don't exist yet) the
Git host decides to create a bundle:

- git bundle create first.bundle main

The server will advertise this bundle with the creationToken being the
Unix timestamp of the topmost commit in the bundle:

- first.bundle  = 2024-08-02  or in Unix 1722549600

When the client clones/fetches, it will download this bundle and store
creationToken 1722549600 (= 2024-08-02) in the repo config as
`fetch.bundleCreationToken`.

A few days later (on 2024-08-04, now D & E are added) the client fetches
again, and there are no new bundles, so a "proper" fetch happens.

A week after the first bundle (on 2024-08-09, D to G were added since)
the Git host decides to create a new (incremental) bundle:

- git bundle create second.bundle C..main

The server then advertises the following bundles:

- first.bundle  = 2024-08-02  or in Unix 1722549600
- second.bundle = 2024-08-09             1723154400

Now when the client fetches again, it sees a new bundle "second.bundle",
and will download it. This bundle contains the history from C..G. And
you might have noticed, the client already has C..E, while it only needs
E..G. This is a slight inefficiency, it's a pitfall of bundle URI I
don't think we can avoid. By design bundle URIs are used to pre-generate
files for clients to use, so they are never built-to-order. It's almost
impossible to avoid clients to download bundles that have objects they
already have.

Well, maybe it is possible. But then the question arises, if the current
main branch is at G, do you want the client to download a bundle which
has a little bit too much objects, or do you want to have the client do
a "proper" fetch and skip any bundle?

But all the above assumes there's only one branch in the bundle. With
more branches another strategy might be required.

> If so, is that information sufficient to determine whether it makes
> sense for a client to fetch a bundle instead of performing a "proper"
> fetch? If not, what is the additional info that we would need to make
> this schema work properly?

I think my example above indicates the "creationToken" _can_ be
sufficient information for the client to determine if downloading a
bundle makes sense, but it depends on a well-though-out strategy of the
Git host. So one the hand it gives the host the flexibility of using a
strategy, on the other hand it puts a lot of responsibility on them.

> So unless I'm missing something, I feel like we need to think bigger and
> design a heuristic that gives us the information needed. Without such a
> heuristic, default-enabling may or may not do the right thing, and we
> have no way to really argue whether it will do as we now depend on
> server operators to do the right thing.

I think we're absolutely not ready to default-enabling the bundle URI
feature in Git. Here at GitLab we're trying pilot bundle URI to figure
out how it should/can work. Roll-out to CI runners is our first target
and because we have the flexibility to toggle use of bundle URI on the
client side, we can test things safely, without affecting any other
user.

Talking about heuristics, any heuristic will be a _hack_ if you ask me.
If you think about it, the bundles them self should be the single source
of truth. In fact, a bundle is a packfile with a header prepended that
contains refs and their OID in git-show-ref(1) format, and includes
which prerequisite OIDs it has.

So another approach I think of is to have the client partially download
bundles (so it pauses the download once they have received the complete
header) and make them parse the header to determine if they continue the
download. But this approach feels quite complicated to me.

Luckily, with the bundle.heuristic config we can always introduce new
values if we discover there is a flaw in the "creationToken" heuristic.


-- 
Toon
