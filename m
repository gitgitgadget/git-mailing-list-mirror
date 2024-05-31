Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA738C06
	for <git@vger.kernel.org>; Fri, 31 May 2024 23:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717198069; cv=none; b=anv21Gj5+uwBYXXXNVGDCWDMIVc09uESnNcVtMAFbYEqnUDEdrOmZayyH5gXB9Q7GYOMc+hksV3qKgIMwx943qBvAbpei/3GHbrBCtyIxAm2jS7UKxIxrX9gr4aiZPfPz/iP+DInmMUtd1ATfEISKH+jo3ZIF7F1t+zPrNd2048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717198069; c=relaxed/simple;
	bh=9BmNIjzKAZGbmsutt4Ijys3/Q2bxuUvu8WSLpavobkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R6vMu69s45SRT9fkn3gC6nzhdknbnHFsrOXRvPCX3nBJKe+zETRPQVOcqiXlnSdNJpOesE3rgVouYNbJQFr2mH8f7xjlezDG829/NPyta2Em0yB+A790WQ6uucwBjLt4R1hhGeBSe3eB3ANmtyuC0DCB+qzA1KulnJqb0P5MwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnu7C70b; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnu7C70b"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6D3D83E4D0;
	Fri, 31 May 2024 19:27:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9BmNIjzKAZGb
	msutt4Ijys3/Q2bxuUvu8WSLpavobkE=; b=gnu7C70brIeqYCqDzcHN/7c+G04I
	qbsEUilMN2SdUKt0cbRsv+ZquEAUfI2PGzaa9+EI8nmIT9QTDQjL93OpsLSXx57K
	Thg5JoyATbjsBP07Vopwgb1h8GfxT0av0ePgB7G0nNP2UvQt36S8YL+M1iBtKe6z
	c9rtE/dRcDTAqDI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6593D3E4CF;
	Fri, 31 May 2024 19:27:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 757773E4CE;
	Fri, 31 May 2024 19:27:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Curley Joe" <m48cv7wg9w@liamekaens.com>
Cc: git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
In-Reply-To: <16919-1717194882-875013@sneakemail.com> (Curley Joe's message of
	"Fri, 31 May 2024 22:34:42 +0000")
References: <16919-1717194882-875013@sneakemail.com>
Date: Fri, 31 May 2024 16:27:43 -0700
Message-ID: <xmqqplt1d0k0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 61EFDE2E-1FA5-11EF-BFA6-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

"Curley Joe" <m48cv7wg9w@liamekaens.com> writes:

> git fetch --prune fails with "fatal: bad object" for refs that
> have an invalid sha1 pointer. It would be nice if "git fetch
> --prune" could prune these refs, because it is a hassle to do it
> manually. ("git fetch --prune" only shows the first invalid ref,
> and you have to run "git fsck" and parse it to find the rest.) If
> it seems like adding this functionality to --prune is a bad idea,
> then how about adding an option like "--prune-invalid" ?

A question and a comment.

 - Why did the repository got into this state in the first place?
   It seems that it would be much better solution to prevent refs
   from having garbage values in them or to prevent objects that are
   necessary from going away than any "prune invalid refs" feature.

 - "fetch" still feels a wrong place to have the feature, if it is
   about fixing a local repository corruption.  You should be able
   to recover from such a broken ref even if you are only working
   locally without fetching from anybody.

If you can somehow _enumerate_ such broken refs, you could drive
update-ref to remove them.  Na=C3=AFvely, an obvious place to add such a
feature might be the "for-each-ref" command that is used to list
refs with various criteria, so it might look like:

   $ git for-each-ref --format=3D'%(refname)' --broken |
     xargs git update-ref -d

or something?
