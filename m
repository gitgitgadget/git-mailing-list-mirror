Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFA3D988
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060878; cv=none; b=Jn1skrM2v8M4Di6xiXjPWLMhP4/uzOrWAz1cm4ZHXJ27KiVrB6OCopjOMFaoSxFDQFeFYw8v8lcGkIXGEO1b7fPPjIeD3g04EsFH9LixpTf2GqQGmZ6SN2btlkPU4Bxjf+3DWH5ke7gje1UZylbAcPV4b7D9/1UPWr7pzlzicr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060878; c=relaxed/simple;
	bh=M/LRMYRuasY3iC33oUCwEFCM6Rk3SOljQW/1HhJ/WRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DjN+f6T7ytXOTUVOVTDYFN2u7aiX7S1FUmcCAbJR6v0d9J5FrUP3s7MfxnZmW7JpKR7pYkWYL5acfVsMMEsPYLPycCsZ7hqU5U69SYXm+35EJD2rlU15Mgl9QjlSyDY6NThY9PTjZFbB29dNMjhkjWuzlqiuY9q2D6JJ1y1SZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=Z0bejCzV; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="Z0bejCzV"
Received: from localhost (ip-109-42-179-115.web.vodafone.de [109.42.179.115])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 41RJ7jSA013768
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 27 Feb 2024 20:07:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709060866; bh=M/LRMYRuasY3iC33oUCwEFCM6Rk3SOljQW/1HhJ/WRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Z0bejCzVFF5AabjtRgchNcPu7JGRp0/fIS8Cr1GnVvnkb7IBpy3gIo2EvDCzeT28w
	 JY4qsJ444htKWCkVxtEbZ3Jw15i1plf5FnHGws0aZvnt0IONdqUBeZhxbmhBAl+9aC
	 cXIYunTimAXzMonpWqPMCxOG73Fh8+DYfBY/nMHE=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin
 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 04/11] Prepare `paint_down_to_common()` for handling
 shallow commits
In-Reply-To: <xmqqcyshu6es.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 Feb 2024 10:08:11 -0800")
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<84e7fbc07e08956e6c493baf499fee455887b16c.1709040499.git.gitgitgadget@gmail.com>
	<gha5nmnex4.fsf@gouders.net>
	<79914d16-f58d-7ab0-5c25-f29870a73402@gmx.de>
	<xmqqcyshu6es.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 27 Feb 2024 20:07:40 +0100
Message-ID: <gha5nlbu9v.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> 	Currently, that logic pretends that a commit whose parent
>> 	commit is missing is a root commit (and likewise merge commits
>> 	with missing parent commits are handled incorrectly, too).
>> 	However, for the purpose of `--update-shallow` that is exactly
>> 	what we need to do (and only then).
>
> I suspect that what made it harder to follow in the original
> construct is that we called the behaviour "incorrect" upfront and
> then come back with "that incorrectness is what we want".  I wonder
> if it makes it easier to follow by flipping them around.
>
>     For the purpose of `--update-shallow`, when some of the parent
>     commits of a commit are missing from the repository, we need to
>     treat as if the parents of the commit are only the ones that do
>     exist in the repository and these missing commits have no
>     ancestry relationship with it.  If all its parent commits are
>     missing, the commit needs to be treated as if it were a root
>     commit.
>
>     Add a flag to optionally ask for such a behaviour, while
>     detecting missing objects as a repository corruption error by
>     default ...
>
> or something?

At least to me this is more understandable.

Dirk
