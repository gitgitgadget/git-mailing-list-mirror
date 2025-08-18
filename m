Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109521A83F7
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755558443; cv=none; b=fO0pJ11+E7Yy0YVdHvJ5/JzOveV5QoqOIoUQpn+Cx1ZJXDKlnbwl3QFmXYSiAc+sfTpYnc5a/d4z6sMlnfuZ+sKTnr1C1U9au7KgW+nlIaCFFK8nABPJAVsEnC31Erg1APYRmu86KCFSf46ZP+3bgtkdOUXdfEXosMXEwZnAxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755558443; c=relaxed/simple;
	bh=S5KUVJt9fyCCvYK5EenEmxD+V/gWzumVMlIn8LLjueI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4b1P2YAHM6VmE01E1G630iKRNp0jwu579CPGYk1RKX7jbmO0DUM7ABbI9dnhnO8rdw88IBLBeSyZLqZmovnZXRydZWo5/kqhcsmpEGB5zgYQXu3XsxFucwqD2SjMoQby8nhTMVDeC9NOezP5VvNVwHhJGC5Wd550sy6Qkq3i3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fZdboUox; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fZdboUox"
Received: (qmail 23923 invoked by uid 109); 18 Aug 2025 23:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S5KUVJt9fyCCvYK5EenEmxD+V/gWzumVMlIn8LLjueI=; b=fZdboUoxJJm/2TFXl/u/diI5GTvmtoNfT9St/EVHgBz4RBBQ7tf777C9kiMoueYfKgSKTcm4DLHFOXb37Ke+xEOUck0tyPMuvgMYW5spzajjopUOpm5lAJEDPka1CW3lS0cLZb5K2F+CzjOQvlNRh+c2gNTeHjMphy0VrsMkmZJCZTZZWjHvkXMxWf6KjdykLJvipv9G8n+fsyo5ZyASmjZrLyXREbJpiKYCG2VtJq6Ea7iUlRV8Y9Y3Ufh8IypGaso6nKawn0kj4JQIVy4Cs/eyr8OBSfN7akVNfF5MIB+AdqxZIOpoRjj56Wc3790vW1v7wbK56LUEkRo6LJmHCw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 23:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31935 invoked by uid 111); 18 Aug 2025 23:07:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 19:07:17 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 19:07:17 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] describe: catch unborn branch in describe_blob()
Message-ID: <20250818230717.GA1027509@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210154.GC1024556@coredump.intra.peff.net>
 <xmqqy0rggwep.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0rggwep.fsf@gitster.g>

On Mon, Aug 18, 2025 at 02:19:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > --- a/builtin/describe.c
> > +++ b/builtin/describe.c
> > @@ -518,10 +518,16 @@ static void describe_blob(const struct object_id *oid, struct strbuf *dst)
> >  {
> >  	struct rev_info revs;
> >  	struct strvec args = STRVEC_INIT;
> > +	struct object_id head_oid;
> >  	struct process_commit_data pcd = { *null_oid(the_hash_algo), oid, dst, &revs};
> 
> An unrelated tangent, but it seems that we are copying the object
> name for the first member of this struct, even though 1/5 changed
> the second one.

Yep, agreed. It goes away in the final patch, though.

> > +	if (repo_get_oid(the_repository, "HEAD", &head_oid))
> > +		die(_("cannot search for blob '%s' on an unborn branch"),
> > +		    oid_to_hex(oid));
> 
> Makes sense.  I briefly wondered if there is really a point in doing
> the traversal only from HEAD, but this topic is not about enhancing
> and making the "describe <blob>" more useful, but it is a strict
> improvement.

Yeah. We do document the traversal from HEAD, so I wondered if anybody
would be upset at being more inclusive. So it might need a new option.
Somebody who is more interested in the option is welcome to pick up that
topic. :)

> When you first mentioned "resolve HEAD ourselves", I somehow expected
> you to ask the ref subsystem to resolve HEAD, but this should do fine,
> thanks to ref_rev_parse_rules[].

I hadn't really thought about the distinction. If you grep for '"HEAD"',
looks like we have a mix of both types. I don't think it should matter
much in practice.

Some even call lookup_commit_reference_by_name(). So we could perhaps do
that, in which case the segfault fix in patch 4 just happens naturally,
because we know we are always traversing from at least one commit. I
don't see any difference between the approaches compelling enough to
switch, though.

-Peff
