Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01071CD01
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427484; cv=none; b=i7UCwsv8jEJ+fsIg6/zdg7ipJM9zjIN4GuLzEPIoXtx+/AId3k7TxQD0JvgMVuoRLvNZsog+qjPXHNT9UfI6m2Xf+RN7QirJCO3gL+7/ymMLyOl27fSLHSZK3/9mvORgNBfkqad6Rrfy/rfyydhRACqvpNI6JZd+NnVjZsiR0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427484; c=relaxed/simple;
	bh=W6VqZ8n0kxu/P5JmpZ7hFDsYGGfwzEzGbq0tw9y51qk=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=SEjl77Ac66lv57Fd0FNycKd4Nej030MzgijPmPd1QqPEPDlLZAejq46xCF5aJEzODZ51ZmgdbcEzrDrMMOFybWObqzH2gURr3F4PMei8K24RJWmMPaNzKA9cCsTFGlDhYLnTI9lCCtFQcXDqAoUlS2PjlqYiBADqlYFHWCNpXVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oafRORYl; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oafRORYl"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 231271876D;
	Tue, 16 Jan 2024 12:51:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W6VqZ8n0kxu/P5JmpZ7hFDsYGGfwzEzGbq0tw9
	y51qk=; b=oafRORYl0Gb4n8+p7fdBhdX0Us9xmKJBmxp66D4w5+q//pF+mZbvYI
	AsX441RZHYgsFftq1gDelRkAmrBaYXbCBRdVJbPQSOzj51pJtZ8utU+FC4AINoRM
	72XcKExzhvYDhsZLCl/UE5wpS8bR0V0JsotpchT9a6Ap8s+74YVIg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B6FD1876C;
	Tue, 16 Jan 2024 12:51:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDBD41876B;
	Tue, 16 Jan 2024 12:51:18 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: git@vger.kernel.org
Subject: Re: Custom merge drivers: accessing the pathnames and revisions of
 the files being merged
In-Reply-To: <8bb5e41e-4db9-4527-8492-3aca6a0f40bf@delpeuch.eu> (Antonin
	Delpeuch's message of "Tue, 16 Jan 2024 09:44:02 +0100")
References: <8bb5e41e-4db9-4527-8492-3aca6a0f40bf@delpeuch.eu>
Date: Tue, 16 Jan 2024 09:51:17 -0800
Message-ID: <xmqqedeh1816.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA241D66-B497-11EE-8191-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> So, I wonder: would people be open to exposing additional parameters
> to merge drivers? For instance we could add parameters "%X", "%Y" "%Z"
> to expose those "revision:pathname" strings for each part. (I think
> colons cannot be part of revision names, so this can be parsed
> unambiguously by the custom merge driver to recover the revision and
> pathname independently, if needed.)

The last time this changed was in ef45bb1f (ll-merge: pass the
original path to external drivers, 2015-06-04).  

I may not necessarily endorse the choice of XYZ [*], but I do not
fundamentally oppose to such a new feature existing.  The mechanism
to define a custom merge driver is designed to be future-proof in
that only the parameters it uses is given as the value of
merge.*.driver variable, so it is not a problem that existing merge
drivers will not know what to do with "pathname in the common
ancestor", "pathname on our side", and "pathname on their side".


[Footnote]

 * Whatever letters we choose, they must have mnemonic value that
   signals two of them are the both sides of the merge that are
   equal participants, and the other one is the old-file, their
   common ancestor that plays quite a different from these two in
   the merge.  I cannot tell which one of the XYZ would be the more
   special than other two, which is the primary reason why I do not
   know if XYZ is a good idea.


