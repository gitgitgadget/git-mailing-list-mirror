Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC8C36CE01
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755717612; cv=none; b=tl4M586qr//HVjkAwfr5UI9Cr+cT0PPJ1SlrSwlm388pvwzcbZCUanmioulidu2kYarcWnRuCeKHPTOnHjphOhPtv5w0TbQUr7vXL02CKZtK+4VBORO0ph+YsXHkiSdgCFh7cngFNJI261xr5F8JVw+Vq6h7qNKarEicsluJB7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755717612; c=relaxed/simple;
	bh=cd8Qr61xp6pmT34r8UvvHNM1M0D8JbRLJOuuZ18QQwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLa9fU9zAO1anQAD0/zZH0EFCKBLMPWa8zzzFdvTEv+QvJkRPT3bVu7MCrxa7p43yGAgSV02orE4R4syytwNgtmwLi3zTaUnKk0lGZOSndjAcrqIHQ++57tyA9fNgtrHU3LfASmTwf3NqC0IPSrD7YqxbC36sp1p0JHADlCeOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PZHzI2Xg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PZHzI2Xg"
Received: (qmail 38242 invoked by uid 109); 20 Aug 2025 19:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cd8Qr61xp6pmT34r8UvvHNM1M0D8JbRLJOuuZ18QQwU=; b=PZHzI2XgyrlOGjpHAD6HfZhHY1KzeHwsg4jJcZ/ZHvDSbtS1v+ZJhtbMTwTZyWgfrkDQC5IljNhfwdXrYo/+hJsVavTj6C4DMR7qoRTeVnDCPf9SvE13ugRK+ykFQj16NqEj6E8HQFYste8aHPcdbO2/PEIVtfuAXTfCIDgknRFW3e5+205IaedoexsFVAvGp46WpjJm1Y6t7/A0d4V3yZ9/KI2bxE3gH0L7aEE/FEAH0h6FTTZFNmuubZqAltdKZWlJakICewoSNQxaVHLaZNS74o3ZNKJDBshPcjwLSC3wijwAtxLe7VXlD7OeTcG61C2+VggiweUlShgChQIE6A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Aug 2025 19:20:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 63161 invoked by uid 111); 20 Aug 2025 19:20:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Aug 2025 15:20:09 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Aug 2025 15:20:08 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 05/16] odb: move MRU list of packfiles into `struct
 packfile_store`
Message-ID: <20250820192008.GA1662788@coredump.intra.peff.net>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-5-1660842e125a@pks.im>
 <CAOLa=ZRfWamERa_tKenhnxaGnH096p8hGYjauzfw1UzzjA_T_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRfWamERa_tKenhnxaGnH096p8hGYjauzfw1UzzjA_T_g@mail.gmail.com>

On Wed, Aug 20, 2025 at 05:44:36AM -0700, Karthik Nayak wrote:

> Question: for my understanding, so we maintain a list of `packed_git`
> packfiles in `packfile_store.packs` and then the same list is
> available in a MRU form in `packfile_store.mru`?
> 
> I assume this is to optimize searches to use the mru form? Is there a
> reason to not pick the mru list?

Yeah, I believe you should find the same packfiles in the linked list
currently formed by packed_git.next and the MRU list. When I introduced
the MRU list long ago, I cowardly did not want to take the risk that
somebody depended on the order of the original list, and left it in
place.

I think it would _probably_ be OK to just keep a single list (and
manipulate it to keep the MRU property). But whoever does should take a
close look and make sure that is true. The biggest risk I can think of
is that there could be some code iterating over the packfiles, coupled
with object lookups in their loop body. If those lookups reorder the
list, that would screw up the iteration.

IMHO it is probably better to do a change like that outside of Patrick's
series. There already is a lot going on with moving fields around, and
consolidating the lists can happen on top (and would be made easier for
having pulled it out into two adjacent lists).

-Peff
