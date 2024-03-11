Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356647A52
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176067; cv=none; b=Q0VlNmwVxwMEqVexGYQKTtPWt5R2kVcreHJ6YqmH6Fyx0X5OFcEiVG12OExi98J47Bh0SPB2a+YoADZ3TPCmSzdlAMtXZ08j+zuXnkU+lBcMZlB4yQfRpgOhHk8fuKpbWtZ74ZQXfEAPp0hsz5Qx5ukZBc04rzWLQajBXayGfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176067; c=relaxed/simple;
	bh=Xo9ugTpnj6NwCWvJBwkjmqJmWOJuUaklGKtbOdFpDeI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OFFBLOjpgVhHOFwU/yrrg59MzBuTwPh5T240gN0IkNpm9qru47yuUoSTbj2PTQkWiyEl4CtsHb8gDcyDy9a7dZADsNgqNXdl8P/ItArC+M5x1aCzCZowe6zwrlHdW9RJMSRRAMwHfHMCyr1xPuAJl+WwUq9rIhiI7YzkCXJsCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IZ0Ngb5d; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IZ0Ngb5d"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ECF3025B32;
	Mon, 11 Mar 2024 12:54:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xo9ugTpnj6NwCWvJBwkjmqJmWOJuUaklGKtbOd
	FpDeI=; b=IZ0Ngb5dsKsetYL1q8BuZuAguNo0vzmMhB3G41UYG2Rli17718d947
	iohV/VAheGeixcFG0bWD4BKAUXLKBDtoO4V6vcJp0XJzcAyjXjf2HWiiAuNq2Vca
	z1lTo5myc6bP4lLpO76NU2ox3ABoKjZ/8lVP8M4ezMFIgioaAIBOM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E4CFC25B31;
	Mon, 11 Mar 2024 12:54:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EE4225B2C;
	Mon, 11 Mar 2024 12:54:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn
 branch
In-Reply-To: <xmqq4jddwrzr.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	10 Mar 2024 17:07:36 -0700")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240310184602.539656-5-brianmlyles@gmail.com>
	<xmqq4jddwrzr.fsf@gitster.g>
Date: Mon, 11 Mar 2024 09:54:19 -0700
Message-ID: <xmqqh6hcu2tg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 02048BE4-DFC8-11EE-B93B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> It is not a good code hygiene to assume that a failure to read HEAD
> always means we are on an unborn branch, even if that is the most
> likely cause of the failure.  We may instead want to positively
> determine that we are on an unborn state, by seeing if the HEAD is a
> symbolic ref that points at a ref in refs/heads/* hierarchy, and
> that ref does not exist.

I suspect that you are almost there.

+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
+		/*
+		 * Treat an error reading HEAD as an unborn branch.
+		 */

After we see this error, if we make a call to resolve_ref_unsafe()
with RESOLVE_REF_NO_RECURSE, the call should return the branch that
we are on but is not yet born, and &oid will get the null_oid.  I am
not sure if there is a way to combine the two calls into one, but
because the failure case (i.e. doing anything on an unborn branch)
is a rare case that happens only once before actually giving birth
to a new branch, it probably is not worth spending extra brain
cycles on it and just use a simple and stupid "when resolving fails,
see if we are in a rare salvageable case with extra code" approach.

