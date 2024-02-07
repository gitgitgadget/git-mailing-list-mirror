Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD901D697
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339337; cv=none; b=Ew3I8//54FUfB+K9Wpjo+v2ooFfaaa7RJ4JgkN7mTj/IfpRGNXF3osIWMtFSpCW3d9gtVhF1zuA8SG5YiBuSMwSfLSChjse80oy1cHif7ZkrCZvYoK9tBVinq+fLgicZBEZrDG6gv+QY34AgKpS3wCi84t1cx4c0hJiAUR7IHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339337; c=relaxed/simple;
	bh=NhFq/IUjpj5c9QbXRMcQn0+xak7wRLYztoznEiTW9fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLqDKT+X8JTN5BZKYL2om++SH3RStlJMFrQ8WlH1c9C+EEBK6U2rDaamfqGGywuVed9Azq3l4j8yCa9vP5INMD9RvWM0pRRsjzvcnjIb+aIQAAK7MAQoFtsiIxxpMAc0lTGTCbSxF5uvbfJ+Sy+z5ErA6X1sLuKzYQkegJBoPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=c+FEVO2b; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c+FEVO2b"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CF0682B899;
	Wed,  7 Feb 2024 15:55:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NhFq/IUjpj5c9QbXRMcQn0+xak7wRLYztoznEi
	TW9fY=; b=c+FEVO2bCWfe44oMVmu+6ab+FHuI5uouLb8AraURm/cMuRjTC+8LbL
	7bmthyIUQo3rX8pK3Dd4jhEZYQMEoFb5XOX8ihPTp0jG/UgFPmfMyo7Abcq+W3bm
	1287mw/qnfZZXArqv/6ImAqCSXnr89CXxDJdswRvljJyxthjmlKKA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C7A472B898;
	Wed,  7 Feb 2024 15:55:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 83CAE2B897;
	Wed,  7 Feb 2024 15:55:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 2/6] test-tool run-command testsuite: get shell
 from env
In-Reply-To: <c8448406d71151714e89893208c46b8a4c369cb5.1706921262.git.steadmon@google.com>
	(Josh Steadmon's message of "Fri, 2 Feb 2024 16:50:27 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1706921262.git.steadmon@google.com>
	<c8448406d71151714e89893208c46b8a4c369cb5.1706921262.git.steadmon@google.com>
Date: Wed, 07 Feb 2024 12:55:30 -0800
Message-ID: <xmqqle7w6lkt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3B30AA42-C5FB-11EE-96D7-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> When running tests through `test-tool run-command testsuite`, we
> currently hardcode `sh` as the command interpreter. As discussed in [1],
> this is incorrect, and we should be using the shell set in
> TEST_SHELL_PATH instead.
>
> Add a shell_path field in struct testsuite so that we can pass this to
> the task runner callback. If this is non-null, we'll use it as the
> argv[0] of the subprocess. Otherwise, we'll just execute the test
> program directly.

That sounds nice in theory, but ...

> When setting up the struct testsuite in testsuite(), use the value
> of TEST_SHELL_PATH if it's set, otherwise default to `sh`.

... this done in the testsuite() function, doesn't suite.shell_path
always gets some non-NULL value?  Perhaps in a later step we will
add a mechanism to allow suite.shell_path to be NULL when we know
we are running an executable, or something?

Leaving readers in a bit of suspense may, especially in a series
that is short like this, be a good technique to entice them to keep
reading, perhaps, but anyway, if that is what is intended, a simple
"this feature is not used in this step, but we will take advantage
of it soon in a later step" would be a good idea.
