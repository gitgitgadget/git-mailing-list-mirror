Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0F033A028
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627372; cv=none; b=VSTROamXnQ9LjjNqRe646TBxLAH2CXBWpIqLb2ftGlE+/OH09dW8Qh6sj4115MC+5CGykxQ291mcHzBKD5XQvQEup+hUzwrRMPvGyjkIX6o+5mIcTw7K06pixB2Iyh+IH3Pv473dZXhMEwNHGFA/S+MnG5vzfWz8ZcwjBtIvMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627372; c=relaxed/simple;
	bh=iah1RVbss6M6aZHf+Nx2wCKxosgyTldpgBznCSLG99Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O3mTAHxF65tu+/V3g1pa3jVtnyciwsbkOAqjABwQgwY18zZr5GMtjNhMBwOmC/gisjGJBX33Sopldt/+eP8U3Lz8WlXSjXCzyHSrKgW6REICSlV4wRd0E6qoMlpXkIUXmkldevLhQ04d54BhO1h33KEgizdvEDcd+oyb6xpLrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=bPZxNkL7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="bPZxNkL7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1767627364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfMtOHWFHRmZj99HN1rGxEAn4DTsps2bjGNTEQGXM7U=;
	b=bPZxNkL7xWefIimQsJC04tucrbFqwdMptgzh/FfQW+WzUWD8uph8AsJ5pjPcbZkgQWMPPb
	ldBstFk2Pkj8ADBRGlBx9xiPhwZ+zLktVaKlGm1P83vkmNbm6N2e7ltB/Hlsg5yP52UK4b
	sV+JDF48t5wi5vwYuONY+bSTAQhGApE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH v2 3/7] packfile: extend `is_delta` field to allow for
 "unknown" state
In-Reply-To: <20251218-b4-pks-odb-read-object-info-improvements-v2-3-62e3e49072bc@pks.im>
References: <20251218-b4-pks-odb-read-object-info-improvements-v2-0-62e3e49072bc@pks.im>
 <20251218-b4-pks-odb-read-object-info-improvements-v2-3-62e3e49072bc@pks.im>
Date: Mon, 05 Jan 2026 16:35:57 +0100
Message-ID: <87o6n8oyw2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `struct object_info::u::packed::is_delta` field determines whether
> or not a specific object is stored as a delta. It only stores whether or
> not the object is stored as delta, so it is treated as a boolean value.
>
> This boolean is insufficient though: when reading a packed object via
> `packfile_store_read_object_info()` we know to skip parsing the actual
> object when the user didn't request any object-specific data. In that
> case we won't read the object itself, but will only look up its position
> in the packfile. Consequently, we do not know whether it is a delta or
> not.

This explains why you're introducing "unknown", but I'm having trouble
understanding why we need distinction between ofs-delta and ref-delta?

(To any other reader: If you want to know what those two are, check
"Deltified representation" in Documentation/gitformat-pack.adoc)

> This isn't really an issue right now, as the check for an empty request
> is broken. But a subsequent commit will fix it, and once we do we will
> have the need to also represent an "unknown" delta state.
>
> Prepare for this change by introducing a new enum that encodes the
> object type. We don't use the "unknown" state just yet, but will start
> to do so in the next commit.

A little bit confusing this "next commit" is [PATCH 6/7], but that's a
note to any other reader and not so much a nitpick worth addressing.

-- 
Cheers,
Toon
