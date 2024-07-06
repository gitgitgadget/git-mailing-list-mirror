Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E9179BD
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246267; cv=none; b=iDrHrgpsrMyGtMQLm8FuB5jQMTCQ2N3/7RMYjkJJLe6q0e84R5kNre591bGhYUBM8yXp+AvxRLw300ADetklnKVrL6ztW6oIML1GIpl8jiki5SH+gbh1u0v5oomA0/0YvY4+iHt+wtDmQECa5TK+LdCiOuUkfJITkTN2QuKpvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246267; c=relaxed/simple;
	bh=22AOBeBxmNDuA3iJBX12PBjGc99DQKj3myigAibLPNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7eHdS6MqHUaXk2CvmirXxVJCnBu3tbzWx3OokE0iHQQOwhz04fR+AC+D/NfUEwLNbVUUm+N7fNhNYdnvdpQ/PW2mKsHhbh6icm0Inxlh2Kpo4VA1uwGuvKdtY4VunknIDZ/YpSCXa0aZ9JfR1Z7HWr6goKCqDdkr3mAn+6uq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23461 invoked by uid 109); 6 Jul 2024 06:11:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:11:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31248 invoked by uid 111); 6 Jul 2024 06:11:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:11:03 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:11:04 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 7/7] merge-ort: convert more error() cases to
 path_msg()
Message-ID: <20240706061104.GA700645@coredump.intra.peff.net>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
 <500433edf49a4df448b330e4ed9201cfac83cecf.1718766019.git.gitgitgadget@gmail.com>
 <20240702213326.GA591768@coredump.intra.peff.net>
 <CABPp-BEkh4K1156FWUdB9wSjSQcdeUF0dcTJ3CS_b8yvz5Vffg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEkh4K1156FWUdB9wSjSQcdeUF0dcTJ3CS_b8yvz5Vffg@mail.gmail.com>

On Wed, Jul 03, 2024 at 08:48:59AM -0700, Elijah Newren wrote:

> > >       if (type != OBJ_BLOB) {
> > >               free(buf);
> > > -             return error(_("object %s is not a blob"), oid_to_hex(oid));
> > > +             path_msg(opt, ERROR_OBJECT_NOT_A_BLOB, 0,
> > > +                      path, NULL, NULL, NULL,
> > > +                      _("error: object %s is not a blob"), oid_to_hex(oid));
> > >       }
> > >       strbuf_attach(dst, buf, size, size + 1);
> > >       return 0;
> >
> > This loses the early return in the "type != OBJ_BLOB" code path. So we
> > free(buf), but then continue on to the strbuf_attach() call on the
> > dangling pointer. Should it "return -1" like the earlier conditional?
> 
> Oops!  That's embarrassing.  Thanks for catching; I'll send in a patch
> on top since this is already in next.

Yeah, I only caught it because Coverity flagged it when it hit 'next'.
It is quite subtle. :)

-Peff
