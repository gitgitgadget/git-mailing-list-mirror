Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429B10A1C
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008184; cv=none; b=rR5wvQ0eYBG8BRdrCXjTNauol+WKzzi1UwjTiVMcVtgoBi0ecVTA/B/lYjPL1+5fF99UFbR8rhiYljzuhVinFtrfNLDnoyMli3PZGkTSnuG/ju15d5XqWSXqgvK4q+T/u9WXAAhjNzcNXIW5vYQMapXvqgBW/zqaWKAqG8+d4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008184; c=relaxed/simple;
	bh=ARdIOwkgIKXqQZxPBnte+e632YYuWvoe3XhjyIPOBGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MAfqYIRh8DQS3f6hw3tU0vd9HV85wXwrf+iq51qE+q7RA25n7tipT9Rp8mJqHljrbS+ZoNLRzLiuv1Zgz2ZFPmwohiO371fyVxGya8cwXGUrck/j620lPC4vfn3BCiKVEvVoAT3KmxCMThOy3G032yV6k0jIkq38TM3LWDXLUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X0IOLn7w; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X0IOLn7w"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CC022617A;
	Fri, 26 Jul 2024 11:36:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ARdIOwkgIKXqQZxPBnte+e632YYuWvoe3XhjyI
	POBGg=; b=X0IOLn7w+w27nQTM3f9UccPXgPEe/4HF7N+8FkKMR3kIyZ/OtbOeSP
	K4iplVeU8gKApTlWP5RdsRfBnxZnkBPlky5WNJ+bAmVs1UITfT+4aHlo3bB1X472
	gPJOitAN6pwG3uG8UbuYnxcKn3NtWY4B0vdBQcsF3oDsZlhPUg+zU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 659A926179;
	Fri, 26 Jul 2024 11:36:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E509E26178;
	Fri, 26 Jul 2024 11:36:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] csum-file: introduce discard_hashfile()
In-Reply-To: <ZqORDmTj4GT0Eeqq@tanuki> (Patrick Steinhardt's message of "Fri,
	26 Jul 2024 14:05:45 +0200")
References: <xmqqle1p1367.fsf@gitster.g>
	<20240726044216.GA642208@coredump.intra.peff.net>
	<ZqORDmTj4GT0Eeqq@tanuki>
Date: Fri, 26 Jul 2024 08:36:17 -0700
Message-ID: <xmqqplr0xj0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CD92CA20-4B64-11EF-B293-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jul 26, 2024 at 12:42:16AM -0400, Jeff King wrote:
>> On Thu, Jul 25, 2024 at 04:07:28PM -0700, Junio C Hamano wrote:
>> 
>> > Introduce discard_hashfile() API function to allow them to release
>> > the resources held by a hashfile structure the callers want to
>> > dispose of, and use that in read-cache.c:do_write_index(), which is
>> > a central place that writes the index file.
>> 
>> Nicely explained, and the patch looks good to me.
>> 
>> A few small comments (that probably do not need any changes):
>> 
>> > +void discard_hashfile(struct hashfile *f)
>> > +{
>> > +	if (0 <= f->check_fd)
>> > +		close(f->check_fd);
>> > +	if (0 <= f->fd)
>> > +		close(f->fd);
>> > +	free_hashfile(f);
>> > +}
>
> Are we sure that this is always correct? A valid file descriptor may
> have a zero value, and we wouldn't end up closing it here.

I thought that these two fd members use -1 for their "zero value"
for that exact reason.
