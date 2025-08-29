Received: from dcvr.yhbt.net (public-inbox.org [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85184224B09
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497078; cv=none; b=BJC5qanykc8aNxeMNArP6qak2lEmRGpg/KEHYzwg2bVnCDquU2xPoJ4Xr4qi6YccfXuJ9HdLmt77SQ08TUx3QDhGgqXnr33UYfwjS+hIZXDAC+sptK5ZkskaebrTKTMjrp54BaiMVXXgX2bBgBF69WLupIIwovMdijBN8AQJSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497078; c=relaxed/simple;
	bh=kNo8B/T6Ydnd/2gliAU5mPqBv8wKiT5xR9vj+kBdK4g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSQKWnRoxhS+xbwrXFNrAQ2K3bQuLXvmUF1cFCl2lHj5SqAtyKSQgAXzXCeSem8TMMa09u2WcpEBrMjfBDG7RQtpO66RdqxBQ6/KbKLF2reudCkzdtr+O+D4/CMRXX43cAKH0wJUX5H7uZoNfVXh+8D5KgPtA28HDdD4WBVICGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=MkVqAOvg; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="MkVqAOvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1756497069;
	bh=kNo8B/T6Ydnd/2gliAU5mPqBv8wKiT5xR9vj+kBdK4g=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=MkVqAOvg2CckMykvklCk+RBbxkuko4Y8aSBdpAjyjH33BGhSZ333udpVJvU4jStB/
	 VHLpC5hzbcuBrBXqmEw2+5FsdfQhPNJxNyulptYXXNsUQ93/tGAbuDDjy7l11Q4XY9
	 Y9Xm0E0w2/lbNE9WkloWu+Ypg0pQj4doGVYm7leE=
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998D51F4EF;
	Fri, 29 Aug 2025 19:51:09 +0000 (UTC)
Date: Fri, 29 Aug 2025 19:51:09 +0000
From: Eric Wong <e@80x24.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing =?utf-8?Q?SHA-1_?= =?utf-8?B?4oaU?= SHA-256
 mappings in compatibility mode
Message-ID: <20250829195109.M344703@dcvr>
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
 <20250827190817.M36986@dcvr>
 <aLDNj5GPYA9nR3xR@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLDNj5GPYA9nR3xR@fruit.crustytoothpaste.net>

"brian m. carlson" <sandals@crustytoothpaste.net> wrote:
> SQLite is not an option because it performs poorly with Java and we want
> our formats to work with other implementations, like JGit.  That's why
> we created reftable instead of using SQLite.

Interesting.  I would've thought it'd be a solved problem by now
given the popularity of both SQLite and Java.  I actually
expected choosing a more common/standard file format would make
life easier for hackers of alternative git implementations.

Searching for `pure java sqlite' reveals some projects, but
I'm not a Java user at all so can't comment on the quality of
implementations:
https://html.duckduckgo.com/html/?q=pure+java+sqlite

Fwiw, the US Library of Congress has SQLite as a recommended
data format for several years, now:
https://www.loc.gov/preservation/digital/formats/fdd/fdd000461.shtml
Nowadays I'm more concerned about the continued relevance or
even existence of the LoC than SQLite.

> Also, in general, I'm not interested in being tied to a single
> implementation.  If the developers of SQLite decide to dramatically
> change the license of all their code like Oracle did with Berkeley DB,
> we're going to have a problem.  Yes, we can use the older versions, but
> we'd still need people to maintain the library and update it.

Whereas we'd be implementing and maintaining yet another one-off
data format from day one instead of waiting for an eventuality
which may never come.  SQLite 3 has far surpassed the stability
and use of Berkeley DB; there's not a lot of similar formats
that might replace it (e.g. GDBM, LMDB).  So I'd expect there'd
be no shortage of hackers able to maintain a usable fork if push
comes to shove.


Fwiw, I consider the proliferation of data formats and protocols
the biggest threat to digital freedom and security.  Even when
the implementations are open source it feels like a huge drain
to have to constantly deal reviewing/porting code to deal with
more formats.
