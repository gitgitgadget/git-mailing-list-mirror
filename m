Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268792F260F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681021; cv=none; b=R2jh0qF8277lg3s/IPPqXphWMVPFHV9NPKmiZgAPgyBjZfv/pJWsCcpns0cAMrO0+9Ir+9P+nXDoldeaMFmaMak47RsD0AQm6sT+QAL0+AQ5G1Q7Ll7qyVvhDxKkpD4t9ckme12KTWckbDliQBjeuiRp2kwszaLywKDi3bT8XXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681021; c=relaxed/simple;
	bh=NIzcSYFEJw9OsYE1HW3UCIwc7JglJB53HSOl1Z7ABbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvbSOoxPz6Wr9bC5sC/RsxIvIpt+qtd1WXj7WkAIEe+52jqXoBaueDmIV/J6uCC4WHQq3CGYMh6Yt2OBhee/x52QfqDKMLBW6iI2VveyZGAJDbv3aJa+ubVFZ+wA+xfqtzJJwUks2TAFxGpL95mVpbkdDLkwadJF1/C0F0JVWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=iE+ntdMZ; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="iE+ntdMZ"
Date: Mon, 20 Apr 2026 12:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776681017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=thr7j+m+Hs5OFGhDgAFBXKumLHYjzOoV65L/s6BQFgA=;
	b=iE+ntdMZCHoMfaA4nC9khhCga1zcvKqH2e6BjrAVThPcTYJ1iel+13wI9I8vZ9t/wsYRDX
	fDetSMgOMIkilkxTA8Q6+wcH3v3XDf97EBcuHkoADStmMchkkXFJAC+IvcY+CONUlDSust
	2TlrUEEIWbok6BKdQGpByWl5o2GigD4FgXEhZljI/A20hm5mkhBEHb4TQ1/ODCC9dsSzx1
	7uYXgSqAlfcUUdneuAy/u5IuV2BJTfvN0oZNnxS/Fk+kUX7Ih9reKCxMZmMBu8XeuXU9kv
	W14S5vXnJQ8lAXfMQSC+PDufIYqj1oWhC+fPvnMzi2M8Ls6QgshRvrwjP/nmkw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <aeX_3tJicFsmDfCX@exploit>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
 <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
 <aeUqSltEWIWaPDh3@exploit>
 <20260420002118.GB1238475@coredump.intra.peff.net>
 <aeXxC8eR0Mn3dGEn@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeXxC8eR0Mn3dGEn@exploit>
X-Spamd-Bar: -----

On Mon, Apr 20, 2026 at 11:33:25AM +0200, Mirko Faina wrote:
> > diff --git a/revision.c b/revision.c
> > index 599b3a66c3..89a58a65b7 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -2686,7 +2686,20 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
> >  			git_log_output_encoding = xstrdup("");
> >  		return argcount;
> >  	} else if (!strcmp(arg, "--reverse")) {
> > -		revs->reverse ^= 1;
> > +		/*
> > +		 * This relies on "do not reverse" being the 0 value for our
> > +		 * enum, and historical "reverse after" having value 1.
> > +		 */
> > +		revs->reverse = !revs->reverse;
> > +	} else if (!strcmp(arg, "--no-reverse")) {
> > +		revs->reverse = 0;
> > +	} else if (skip_prefix(arg, "--reverse=", &optarg)) {
> > +		if (!strcmp(optarg, "after"))
> > +			revs->reverse = REVS_REVERSE_AFTER;
> > +		else if (!strcmp(optarg, "before"))
> > +			revs->reverse = REVS_REVERSE_BEFORE;
> > +		else
> > +			die(_("unknown value for --reverse: %s"), optarg);
> >  	} else if (!strcmp(arg, "--children")) {
> >  		revs->children.name = "children";
> >  		revs->limited = 1;
> 
> This unfortunately wouldn't work as the first condition is a prefix of
> the third, so no free copy-paste for me.
> 
> Will have separate parsing for omitted and explicit forms in v2.

Just realized it's a strcmp and not start_with, so this should work
fine.

Thank you
