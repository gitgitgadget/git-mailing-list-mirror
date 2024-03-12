Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB563A48
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202439; cv=none; b=UYmJbIuL9pRQeJIhBHIDXQqidNtwPdqMLJIy3/1jMc31a83D8KlsgYM16fRXCOMA33MC1KRImmNSovpYI2p4LnDLosqcD5dpX+vj8DfxUzvFTaf+rs2yFHSucUVhtPKCVGb6Fjlt+cH1CpqW4x8djDCWZop2lKqsyEq1bVcYauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202439; c=relaxed/simple;
	bh=p/IfnATaPynlErhCP8/ruT0nZV6OEbLc8jQ3ZpQGPww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivmBlTZAxxgQEiVXskp1LpiAF1mK9OzS88QmhkGIiZrSZGv4NXwNblXq1LBAHzme2pZyEKyW22bbIzGJIrzc/RpabFd+ieOJ7kulbHKYfQb2qyOidW7U7zPV/grO7i/I9SatkFhZ9LhBk5wIw5gzGwTsa8oVN55ls2zcPS+3ahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yHdWX+j+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yHdWX+j+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F2A8128F28;
	Mon, 11 Mar 2024 20:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=p/IfnATaPynlErhCP8/ruT0nZV6OEbLc8jQ3Zp
	QGPww=; b=yHdWX+j+z0E0RVHLMBzGsZ4nOtLaOVP7z4qkjjaLomC1ULC+Px+LDs
	d/Ds2ClMSmOfRWz9MZ6PmcQ7A0Q0V02vD8/NBuSzug0LadlUsd9cw3ljKIbz9Jnv
	dioCB+cN5lZV/yWiN3wD9n61TMxETa9EPQlhIeNw8xED29wp2pvqk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EB80728F27;
	Mon, 11 Mar 2024 20:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94E7428F26;
	Mon, 11 Mar 2024 20:13:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] MyFirstObjectWalk: add stderr to pipe processing
In-Reply-To: <a2d30eff217e560873c49fe45116c784dc12fd32.1710192973.git.dirk@gouders.net>
	(Dirk Gouders's message of "Mon, 11 Mar 2024 22:00:12 +0100")
References: <cover.1710192973.git.dirk@gouders.net>
	<a2d30eff217e560873c49fe45116c784dc12fd32.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 17:13:45 -0700
Message-ID: <xmqqh6hcmhmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 656E0D4E-E005-11EE-A366-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> In the last chapter of this document, pipes are used in commands to
> filter out the first/last trace messages.  But according to git(1),
> trace messages are sent to stderr if GIT_TRACE is set to '1', so those
> commands do not produce the described results.
>
> Fix this by using the operator '|&' to additionally connect stderr to
> stdin of the latter command.

Isn't |& a bash-ism?

    upstream command >&2 | downstream command

is how you would do the same more portably.
