Received: from mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71B41F94F
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788243003; cv=none; b=hZAdnZis9rZ6FPnRohpB+CpEh7lZWrEWWT/PQFkCuTlLrd+OtOEte63K0RQ7cD2b6gt+TeG8HrLWZUCL3NSkvLNq3RRBCz9qGMoj83vXtySeoQBXPwmh0Z4Ug90dk640Rf0yrmxY9X8E/yFek/mOB9p7Lh66G4/eUuvUnZvxP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788243003; c=relaxed/simple;
	bh=C4XJXUXoFpXS4QEnMNqgsro00BAOevUSsk+ri719Dxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWW5BmF4m4TsmhupFCcVvp5Z6Ge6Y/19H2nYGcolciz677obWwUkIpDgDElC90ZW+F5kvFBHI1fs6tphrbDq6O/mjT52UHbuITsxNP6BcIcPG7PzMQSalXz4bYzczyO9Pm2GkbwQsUv2Cp56Izzg4+C2nP+O/fEJ7FwYH0wB9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=SEnaXvPo; arc=none smtp.client-ip=95.215.58.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="SEnaXvPo"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C4XJXUXoFpXS4QEnMNqgsro00BAOevUSsk+ri719Dxk=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788242997; v=1; x=1788847797;
 b=SEnaXvPoIZb/Xpq/NvbI72vdH91P2lAJu8ddIRUCqOFvNAEBMMGna6bVllZ7bC5p1py115K6
 lumNzhWBuf7sNaJ1eozX9mW+GMzaRGd4peTQ7nvhLQAHdoQaLrmvIzzYwe6BX0UMB4AHZfyT2jC
 Qvbs228rag1BVJnOihFlh+s4=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id c7a82e746b1c8015;
	Tue, 01 Sep 2026 06:09:47 +0000
X-Mizu-Trace-ID: c7a82e746b1c8015
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/8] odb: write alternates at creation time
In-Reply-To: <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
 <20260831-pks-odb-write-alternates-at-creation-time-v2-0-aecd2382ba1c@pks.im>
Date: Tue, 01 Sep 2026 08:09:39 +0200
Message-ID: <87se3twli4.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> writing alternates into the object database currently happens via
> `odb_source_write_alternate()`. But while that creates the ability to
> create alternates at arbitrary points of a source's lifetime, we don't
> use that functionality in the first place. Instead, we only ever write
> alternates when creating a new repository.
>
> This design is suboptimal due to a couple of reasons:
>
>   - It requires us to have a `write_alternates()` callback, which is
>     overblown as we never even write alternates to an object database
>     after it has been created.
>
>   - We're about to make alternates an implementation detail of the
>     object database's backend in a future patch series, so alternate
>     implementations may not even support them.
>
>   - The backend has more flexibility with how exactly alternates are
>     configured when it itself is in full control over their setup at the
>     time where it creates the object database itself.
>
> This patch series thus refactors how we handle alternates so that we
> don't write them ad-hoc anymore. Instead, the series introduces a new
> option for `odb_source_create_on_disk()` that makes it handle those
> alternates at creation time.
>
> This is part of the bigger goal of moving handling of alternates into
> the "files" backend.
>
> This series is built on top of 2c3adbb2c4 (The 18th batch, 2026-08-24)
> with ps/odb-eagerly-load-alternates at 0076dc9f81 (odb: drop
> `alternates_db` field, 2026-08-17) merged into it.
>
> Changes in v2:
>   - Use a lockfile to write "info/alternates" during creation time.
>   - Remove useless "strvec.h" include by reordering declarations a bit.
>   - Link to v1: https://patch.msgid.link/20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im

This version looks good to me!

-- 
Laters,
Toon
