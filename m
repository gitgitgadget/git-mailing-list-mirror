Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048431339AB
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050377; cv=none; b=Rd3Xk7X83pFSR28CA/9DqIEoTmMlxJdAEU1UnqMVvE43y/la/OFtwhrWqJbzB39Ba4icRfeO8MvLCbVWDIlMJb++CkGyFdjjb/dg/2yr5B7YfnfCR6mXl0rcVEVDFFmj06v+QjK/vC7b9V5Nj28rnTGi7oTCV9WTMHU6vvLHKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050377; c=relaxed/simple;
	bh=tzDjQVcPm4/l77y2mk/p9qGlRKVnlagHurXDSk71fbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rrFnBT3trCYoAoiQsFcGPdCNQ3EGQMgdMIrMnrn5OiBsMnL483K43eClqmFEkaTJgwxGUGE4qa5GVA4RMcr9MkFpA0d3MyBSAS9tooKhVXZlRf3EA0aJfE1Bemgdx1Kw8Tz0x0940XnJUFy2UV54gr+4MXs0VGmY6i1rRtkpzok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=lRWXKcTI; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="lRWXKcTI"
Received: from localhost (ip-109-42-178-162.web.vodafone.de [109.42.178.162])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42LJk34J025974
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 Mar 2024 20:46:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711050364; bh=tzDjQVcPm4/l77y2mk/p9qGlRKVnlagHurXDSk71fbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lRWXKcTIgDjKf9SbrkXrGIrnA0E0DuSoxcqoEbr2/NKTAA/a0Xanugv2GGRgCcotr
	 8Q1PQzP+l1j1kEmvTatZJigeJsmZ6yWhcbjrvjkzUoR95h3jvAI641nJtrgxYBJZ59
	 JZMPB6Pk1ENsUDc/MeiJfs3JdrVpmL4OSGXocxy8=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org, newren@gmail.com,
        me@ttaylorr.com, phillip.wood123@gmail.com,
        Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 4/7] sequencer: handle unborn branch with
 `--allow-empty`
In-Reply-To: <xmqqh6gzblmc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	21 Mar 2024 09:22:35 -0700")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240320233724.214369-5-brianmlyles@gmail.com>
	<ghttkzykru.fsf@gouders.net> <xmqqh6gzblmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 21 Mar 2024 20:45:58 +0100
Message-ID: <ghh6gzz7ux.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> Brian Lyles <brianmlyles@gmail.com> writes:
>>
>>> +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
>>> +		/*
>>> +		 * Check to see if this is an unborn branch
>>> +		 */
>> In the above example, there is a short but outstanding comment that
>> announces a check (and if I understood correctly by [1] it is a kind of
>> trick that could deserve some more information) and it does _not_
>> comment on the result.  Of course, I have an idea where the correct
>> place for a comment /* This is an unborn branch -- handle it as if... */
>> could be, but I'm not sure.
>
> You mean "Check to see if this is an unborn branch, and if so, use
> an empty tree to compare against, instead of the tree of the HEAD
> that does not yet exist"?
>
> I think that is possible, but the use of the_hash_algo->empty_tree
> indicates that clearly enough.  But we need to stop somewhere and
> what we see above may be a reasonable place to do so.
>
> If anything, we may want to say why we want to continue as if we had
> an empty tree (as opposed to fail and return with an error()), or
> the tree to compare with is computed here for what purpose.  But the
> name of the function may tell what this whole computation and
> comparison is for, so it probably is not needed, either.

Thank you for the reply.

I guess, the hidden question in my comment was: "Do experienced
Git developers understand the code as something obvious?".
And I read your answer as a "Yes, no problem.".

Now, I can put this subject aside and later, after more reading, check
if my understanding improved sufficiently to now understand that code
without additional comments, as you already do.

Dirk
