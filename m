Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A58482D3
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717845636; cv=none; b=VDPm+49KaWODwYiX9g1zDzsOFUCTclWRjrNbBnHhAGSlPo2Vqyr0HltIdt3iDray48MHi6OK0Po4usI+BeANc/xkrq6ZKEpAVDVeEyIcnAWoRQO6SoWDjbR+tOA4z1vB/TR8WbZVNDU7ERf3tLTdYnuk/agFUByLKnBx5Ky5XlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717845636; c=relaxed/simple;
	bh=U161xa7m//U+QGTvb4Fi9C0Bv6as/SCMqGpTg2lqMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9/jr7U5fvapll43fUqYSBuzO2B5UnUA/uff0XVEzLELnwy6FtEa6Z0SuTaI27ZMwVdyqztQWVmKcT4D2nCKowTnmUjsYgYmda8LmO3aY4Pko21UnDVOMUvjVkd5vC3vO/t/UXC82qoO9VSRmEK2eWG8hCLJTeS8gtOUrZpwe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8929 invoked by uid 109); 8 Jun 2024 11:20:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 11:20:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29788 invoked by uid 111); 8 Jun 2024 11:20:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 07:20:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 07:20:33 -0400
From: Jeff King <peff@peff.net>
To: Fred Long <fred_long@fastmail.fm>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
	git@vger.kernel.org
Subject: Re: git fetch --prune fails with "fatal: bad object"
Message-ID: <20240608112033.GB2966571@coredump.intra.peff.net>
References: <16919-1717194882-875013@sneakemail.com>
 <xmqqplt1d0k0.fsf@gitster.g>
 <000501dab3b3$51779400$f466bc00$@nexbridge.com>
 <xmqqo78kbqwo.fsf@gitster.g>
 <20240604104437.GD1781455@coredump.intra.peff.net>
 <876fbb07-210e-128e-5289-57ab01761750@fastmail.fm>
 <20240605084718.GD2345232@coredump.intra.peff.net>
 <c2a02982-40a9-6629-05c2-c8de3335f35b@fastmail.fm>
 <20240606011453.GA623737@coredump.intra.peff.net>
 <5469592f-69eb-b1da-1218-abeae88f7303@fastmail.fm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5469592f-69eb-b1da-1218-abeae88f7303@fastmail.fm>

On Thu, Jun 06, 2024 at 01:12:31PM -0700, Fred Long wrote:

> Yeah, I saw that, and I think I know what's causing the problem. First I
> create a bare mirror of AOSP with "repo init --mirror" and "repo sync", then
> for all my different source trees I use "repo init --reference" to share
> objects with the mirror using alternates files. Running "repo sync" on the
> bare mirror works fine. The problem occurs when I run "repo sync" in one of
> my source trees. Commits and refs have been deleted from the mirror, but the
> refs are not deleted from the repos that point to the mirror. So it all
> makes sense now. Still, I wish there were a simple command I could run to
> remove the dangling refs.

Yep, that all makes sense.

As I said before, I don't think auto-deleting corrupted refs is great in
general, just because it can make a bad situation worse. But if you want
the foot-gun, here's a more complete script that you could run. It
_just_ looks in refs/remotes/, which is perhaps a bit safer.

  git for-each-ref --format='%(refname)' refs/remotes/ |
  git cat-file --batch-check='%(objectname)' |
  perl -alne 'print "delete $F[0]" if $F[1] eq "missing"' |
  tee /dev/stderr |
  git update-ref --stdin

-Peff
