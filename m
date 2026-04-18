Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DA31985C
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776537742; cv=none; b=P1BIZswQ868tEuem9ctH5TVRX+6qwDRiTXKaDjvxoC8tIAgdJABz2QLkyeJtrPqAaHEBypwfAJh5XtKggpvy5iXRhJax/iK9+f5S2eS9vDZ74ny/ASFnQP6PRtU2GKeonksH9+kK9yKKR3qMXGTn0WdP2aP6loMGDmmLYJRxYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776537742; c=relaxed/simple;
	bh=rA9fmMBCD401J0UfWAX5QylKtVHean/o7JoLlhes+kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N963yxtQra5LYw2T++JoEuA1UxUcYmYfnbLF1GyaCYubCus2KGvb/WmU5uwSvCyIKyIg2+Z0tQEHmZLQ90Oye0YfD2iosVBrg9EFOmagJBCQ6l9BzDlKqqDeVfGtEfMg5gUVkM1aHMDsT7+2qcACnJ8W1Wctz1FRTxYUCR8+1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=jQegl9Ug; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="jQegl9Ug"
Date: Sat, 18 Apr 2026 20:42:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776537737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JecljGek/cIX0LUyvFqmEyU74fprl6j9dbgcoK0G+/o=;
	b=jQegl9UgoNUPvEc+3htNmbNkHTxvxL7+ocEYL6+MuuhDIfCNV/REayfJAszrjszmS0qcTu
	NK3h5NqWzfPGLfe7b8X9ZU7sepE+PKpEVLN1uB8EZlNHjZ1HEENHOPoLP2e36u8ABueyuf
	3+KnX7WYLudaBFQecaCmqCbNIcFFyVrtAehR885vDd2xg2fL1qmcrXs4lRUQ/+r7t6YvmB
	FKe2y9vR/3MfqISmP0rtA70ZvVtC36SeLe5iPz0nhDogG1j+dLa68rL6xzfNznctc53MCc
	nPTONR5P2wAjNHK4NssSdCBIhi01q6ZovyGM19JEY1+TRUskhTqfFYZdprm0Mg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aePNILp-yB_8gfiY@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=mroik@delayed.space;
 h=from:subject:message-id; bh=rA9fmMBCD401J0UfWAX5QylKtVHean/o7JoLlhes+kE=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp49BxlNIbNB0wb6nL/YX61iV5jeF9AV2unZVs5
 OBs8JgUxkSJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaePQcQAKCRBIeX6hnBm+
 0dMcD/0Yp3gZ8ju3aISmjWsI2amOo8JUqa3iPmxzAgImTodr9IH8nlviNwGR3mTAzFdC5nhdV14
 j5nxQcsJDZvUvUuG2Eh0jzIwMgr7jmPp2i0hHJtSJK91x0/Og4Q8tdrfqLRVRT3hF8NNIRzHJ4o
 /NNj4GFMvKBFTMqaz+KJzMNNnPIso7aDO+qZRcIdWLMY6EjdSzeht8IieOB787U3xd7RfT573Xj
 74PFPW52Ltb4uZpGkd7TXDmZl3yswFNaat5q/YXer7gXk8d/h8WE2O4I/9uaO2FAJuH8JfJ07ze
 hhBTF/eS2jzlSXjuBdZ3tBMTuoVIu/0F2Okgs3z7K73wg3ABiaaDh0iLCP107itN/s8IP5KWQlO
 Ki8bRYHooclgYNRsKI25mezd/u/GTCL2Kt6+nVlBmMmNEsFteWPvoWIfs2u45p4DmOQE+jXSaWC
 hNV1ERGT53x0fMCyr6SGEvZqLRzA7YZnB5DvUz1HkOq20JmRGG0NKKL6s46iFNkxFlZlfVpSHRc
 Thmu1upD3B+on1uKpBuBx/FyEvLJFNGH7uRWq/Uhvy/K5UuX/7KK/J5Ghim58GDOToswx3l8nuh
 D+4FBlMmoVcl89eBWwZIVzOLMDqydqbHRE2G8U82FmpDlRiHP+kTMEbdKKmuSMfrUVVxFrzp99Q
 md7zx9gnxoqNGSQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260418164736.2367523-2-mroik@delayed.space>
 <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbea5f1c-946b-400e-a9a2-2c6d7b088d46@malon.dev>
X-Spamd-Bar: --

On Sun, Apr 19, 2026 at 02:20:41AM +0800, Tian Yuchen wrote:
> Hi Mirco,

Unfortunate miss spell T_T

> On 4/19/26 00:47, Mirko Faina wrote:
> > In a revision walk `--reverse` can only be applied after any commit
> > limiting option. This makes getting a limited amount of commits from the
> > tail impossible. E.g.
> > 
> >      git log --reverse --max-count=3
> > 
> > Some would expect this to give back the first 3 commits of the project.
> > Instead it returns the last 3 but in reversed order.
> > 
> > Teach `get_revision()` to accpet an argument `(after|before)` from the
> > CLI, and apply the reversal before or after the commit limiting options
> > based on this argument. If no argument is provided default to the
> > current behaviour, applying `--reverse` after the commit limiting
> > options.
> 
> Reasoning looks good to me.
> 
> Nit: I think we could gather more feedback on the naming. If I were a user
> unfamiliar with how Git works, the most natural and intuitive operation for
> me would be: "Show me the three *oldest* commits" (to be more precise,
> *oldest* in the sense of topological order, rather than the commit date or
> author date order. It’s really annoying. ), rather than "reverse the entire
> list and then select the three most recent ones". I think the confusion
> arises because users do not (and should not) know that '--max-count' only
> returns the most recent commits; consequently, they might wonder: "Well, the
> 'after' and 'before' parameters do make a difference, but why?". I believe
> it is best not to lead users to this point.

The rest of the flags do apply during traversal, and since git goes
through the whole history the relative order should be preserved, so
depending on the flags that are passed the user can order topologically
or chronologically (tho some flags are forbidden together).

I'm up to change the naming tho (and if someone has better phrasing for
the docs please tell).

> > @@ -4525,19 +4543,35 @@ struct commit *get_revision(struct rev_info *revs)
> >   {
> >   	struct commit *c;
> >   	struct commit_list *reversed;
> > +	int max_count = revs->max_count;
> > +
> > +	if (revs->reverse && !revs->reverse_output_stage) {
> > +		if (revs->reverse == 3) {
> > +			BUG("allowed values for reverse are 0, 1 and 2");
> > +			revs->reverse = 1;
> > +		}
> > +
> > +		if (revs->reverse == 2)
> > +			revs->max_count = -1;
> 
> I think the space complexity here could be reduced a little. After all,
> since we’re only retrieving a few commits, there’s no need to load the
> entire reversed commit history into memory.
> 
> Perhaps we could maintain a window (or perhaps max heap) of finite length?

Unfortunately since the underlying data structure is a linked list we
have to traverse the whole tree to get the first one from the tail. The
way get_revision() loads the next commit is through process_parents().
Even if we were able to start from the tail we wouldn't have any
reference to the children.

I suspect reducing space complexity would require to change a lot of
inner workings of git to make the history traversable both ways.

Thank you
