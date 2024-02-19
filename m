Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA111C2AD
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326094; cv=none; b=gSOczvgZCiGJPmt1vUbY80KgjsPfYha61sNwoBmyfmUbfKbgCKJC3IDvpnJUqZo6p/t99vo5hVqzVvprQoJFqNnZtwWrfBJKvSF9HVbtaDpAg65MjUWQ+sTPVNERXSupaGaKPENzKo7RjmxjnGyiCWGwuPCw2aw7ZQsNM6Mr05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326094; c=relaxed/simple;
	bh=jJlDXeBcLtztb40ZhiF6sHOWbXAoPR8X/fXKAVrHdYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZvMEV3Eh4NCzLFJ7zT1JZcV5iOmVWoDXw8GcyBc+ZMjhBO0gcsigvOn/5MZcqtDmEb/2mdMmIdM6N6ObYA0TWiyZCYeWs9uTPt1dDXACNpDyd55kr/OSnbRcxnV2Z9CqGUDXqF0hqHsHG5fbNY+4nuv5AyUDDBZnBfNL1e8wgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=esbsUmkT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="esbsUmkT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 666DD1DC238;
	Mon, 19 Feb 2024 02:01:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jJlDXeBcLtztb40ZhiF6sHOWbXAoPR8X/fXKAV
	rHdYk=; b=esbsUmkTewYrGJ03eKatOMW0glrQlrAcoQHwAGw/7k/Oh9RB2ofWtK
	Ryz5la97+rg3IMt+NDvlJX1MLv5DT3kdiwt3BM8xaTwP8shFb4jU5ej+u+odi94F
	33gvBGii+n8r9yPuzTzl3q5X4cSUCEudjmMfEjnSOcJs/s6A75lBA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C7581DC237;
	Mon, 19 Feb 2024 02:01:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C18751DC236;
	Mon, 19 Feb 2024 02:01:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH] diff.c: use utf8_strwidth() instead of strlen() for
 display width
In-Reply-To: <ZdLzxYpY-klokgpI@tanuki> (Patrick Steinhardt's message of "Mon,
	19 Feb 2024 07:23:01 +0100")
References: <pull.1668.git.1708281443289.gitgitgadget@gmail.com>
	<ZdLzxYpY-klokgpI@tanuki>
Date: Sun, 18 Feb 2024 23:01:24 -0800
Message-ID: <xmqqh6i5ey4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B28E58BC-CEF4-11EE-8791-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Also, do you know why we didn't use `utf8_strwidth()` right from the
> start? It would have saved the writer some time to just use
> `utf8_strwidth()` instead of writing a whole paragraph explaining that
> we should do it eventually. Makes me wonder whether there is anything
> else going on here.

I suspect that it is because it is not just that single strlen()
call.  The code assumed that byte count and display width were
interchangeable, and use of strlen() there was merely an example.
Starting there, the value returned by strlen() is treated as if it
were interchangeable with a display width, and then later used to
count how many bytes to trim from either end of the string so that
the trimmed string would eventually fit a given display width, which
means that the code to compute how much to trim (which is not that
strlen() the patch in question is touching) would have to compute
the reverse, i.e. "if we need to recover N display columns, how many
bytes do we need to trim from that string?"


